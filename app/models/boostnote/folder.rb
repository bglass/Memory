class BnFolder < Folder
  def key()      @meta["key"];       end
  def color()    @meta["color"];     end
  def name()     @meta["name"];      end
  def path()     name;                 end

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

end
