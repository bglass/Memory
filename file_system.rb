module FileSystem

  def child_files
    child_node_paths.select do |n|
      n.file?
    end
  end

  def child_dirs
    child_node_paths.select do |n|
      n.directory? && !dotfile?(n)
    end
  end

  def child_node_paths
    fs_path.children.map {|p| p}
  end

  def dotfile?(fname)
    fname.basename.to_s[0] == '.'
  end

  def stem
    filename.basename extension
  end

  def extension
    filename.extname
  end

  def resource
    folder.path/filename
  end

  def path
    folder.path
  end



end
