require 'gollum_rails/setup/error'
module GollumRails

  # Setup functionality for Rails initializer
  #
  # will be generated by Rails generator: `rails g gollum_rails:install`
  #
  # manually:
  #
  #   GollumRails::Setup.build do |config|
  #     config.repository = '<path_to_your_repository>'
  #     config.wiki = :default
  #     config.startup
  #   end
  #
  #
  module Setup
    autoload :Options, 'gollum_rails/setup/options'
    include Options

    class << self

      # defines block builder for Rails initializer.
      # executes public methods inside own class
      #
      def build(new_attributes = nil, &block)
        if block_given?
          yield self
        else
          if !new_attributes.respond_to?(:stringify_keys)
            raise ArgumentError, "When assigning attributes, you must pass a hash as an argument."
          end
          attributes = new_attributes.stringify_keys
          attributes.each do |k, v|
            begin
              public_send("#{k}=", v)
            rescue NoMethodError
            end
          end

        end
        if self.repository == :application
          raise GollumRailsSetupError, "Rails configuration is not defined.
          Are you in a Rails app?" if Rails.application.nil?

          initialize_wiki Rails.application.config.wiki_repository
        else
          raise GollumRailsSetupError, "Git repository does not exist.
          Was the specified pathname correct?" unless Pathname.new(self.repository).exist?
          initialize_wiki self.repository
        end
      end

      private

      def path_valid?(path)
        return path.exist? if path.is_a?(Pathname)
        return !(path.nil? || path.empty? || ! path.is_a?(String))
      end

      def initialize_wiki(path)
        if path_valid? path
          self.wiki_path = path.to_s
          self.wiki_options = options
          true
        else
          raise GollumRailsSetupError, 'Path to repository is empty or invalid!'
        end

      end

    end
  end
end
