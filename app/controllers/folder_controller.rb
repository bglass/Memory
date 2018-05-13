class FolderController < TreeController

  def top()    Folder.top;  end

  def data_fields()
    [:path]
  end

end
