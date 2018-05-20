class NcNote < Note

  attr_accessor :relative_path, :root, :filename

  def initialize(this_fs_path, root)
    super()
    @root          = root
    @relative_path = this_fs_path.dirname.relative_path_from root.fs_path
    @filename      = this_fs_path.basename
    @title   = title_of content
  end

  def raw()       {};                         end   # development only
  def content()   (fs_path/filename).read;    end
  def name()      title_of content;           end
  def date()      fs_path.ctime;              end

  def path
    root.path + relative_path
  end


  def tags
    link = NcDbNoteTag.where("note_file_name = '#{nc_note_file_name}'")
    link.map{|l| l.nc_db_tag.name}
  end

  def resource
    path/filename
  end

  private

  def fs_path
    root.fs_path + relative_path rescue binding.pry
  end

  def nc_note_file_name
    # relative_path.basename relative_path.extname
    # binding.pry
    filename.basename filename.extname
  end

  def nc_note_sub_folder_path
    relative_path
  end


  def self.create(node, root)
    case node.extname.downcase
    when ".md", ".txt"
      NcNote.new(node, root)
    end
  end

  def title_of(text)
    headline = text.lines.first
    headline.sub! /^#*\s*/, ""
    headline.chomp
  end

end
