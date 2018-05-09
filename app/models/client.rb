class Client

  def self.sync_trees
    sync_tree(Folder, '.folder_tree')
    sync_tree(Tag,    '.tag_tree'   )
    sync_tree(Note,   '.note_tree'  )
  end

  private

  def self.sync_tree(treeclass, htmltag)
    tree = (subtree treeclass.top)["children"]
#    ActionCable.server.broadcast('tree', {tag: htmltag, tree: tree})
  end


  def self.subtree(this)
    node = {name: this.name, id: this.id}
    if this.children.any?
      node["children"] = this.children.map{|c| subtree c}
    end
    node
  end

end
