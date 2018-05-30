class Note

  attr_accessor :id, :title


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

  def resource_name
    filename
  end

  def self.note_folder
    path_notes = {}
    Note.all.each do |n|
      path_notes[n.path] ||= []
      path_notes[n.path] << n.id.to_s
    end
    folder_notes = {}
    path_notes.each do |p, n|
      id = Folder.find_by_path(p).id.to_s
      folder_notes[id.to_s] = n
    end
    note_folder = []
    folder_notes.each do |k, v|
      v.each do |n|
        note_folder << [n, k]
      end
    end
    note_folder
  end

  def self.note_tag
    tagname_notes = {}
    Note.all.each do |n|
      n.tags.each do |t|
        tagname_notes[t] ||= []
        tagname_notes[t] << n.id.to_s
      end
    end
    tagid_notes = {}
    tagname_notes.each do |t, n|
      id = Tag.find_by_path(t).id.to_s
      tagid_notes[id.to_s] = n
    end
    note_tag = []
    tagid_notes.each do |t, v|
      v.each do |n|
        note_tag << [n, t]
      end
    end
    note_tag
  end

  def self.find_by_paths paths
    paths.map do |p|
      find_by_resource p
    end
  end

  def self.find_by_resource path
    @@all.find do |n|
      (n.path/n.resource_name).to_s == path
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
  def source()    content;              end

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
    ""
  end

  def filename
    ""
  end

  def path
    ""
  end

end
