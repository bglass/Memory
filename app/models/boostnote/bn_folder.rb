class BnFolder < Folder

  attr_accessor :root

  def initialize(meta)
    super
    @@bn_folder ||= {}
    @@bn_folder[key] = self
  end


  def self.find_by_key(key)   @@bn_folder[key];   end

  def key()                   @meta["key"];       end
  def color()                 @meta["color"];     end
  def name()                  @meta["name"];      end

  def path
    @meta["parent"].path + name
  end




  def self.create(data)
    children_data = data.delete "folders"
    root = BnRoot.new(data)

    children_data.each do |child_data|
      child_data["parent"] = root
      child = BnFolder.new(child_data)
      root.add_child child
    end
    root
  end

end

class BnRoot < BnFolder

  def name()
    @meta["location"].name;
  end

  def path
    Pathname(name)
  end


end
