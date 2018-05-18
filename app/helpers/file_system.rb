module FileSystem

  def child_file_paths
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

end
