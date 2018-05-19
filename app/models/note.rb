class Note

  attr_accessor :id, :title, :path


  def initialize
    @id = @@all.size
    @@all << self
  end

  def self.all()    @@all;    end
  def raw()         @note;    end    # for development purposes only
  def tags()        [];       end
  def text()        name;     end    # tree display

  def self.reset
    @@all = []
    @@top = TopNote.new
end

  def self.find_by_paths paths
    paths.map do |p|
      @@all.find do |n|
        n.path.to_s == p
      end
    end
  end


  def self.find(id)
    @@all[id.to_i]
  end

  def self.map(ids)
    ids.map{|id| find(id)}
  end

  def self.top
    # @@top ||= TopNote.new
    @@top
  end

  def children
    []
  end

  def markdown()  Markdown.new content; end
  def html()      markdown.to_html;     end

end

class TopNote < Note

  def name()  "Notes";   end
  def id()  "topnote"; end

  def initialize
    @id   = "top"
    @@all = []
  end

  def children
    @@all
  end

  def date
    nil
  end

end
