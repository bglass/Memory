class BnRoot < Folder

  def name()
    @folder["location"].name;
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

class BnFolder < BnRoot
  def key()      @folder["key"];       end
  def color()    @folder["color"];     end
  def name()     @folder["name"];      end
end
