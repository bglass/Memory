class Note

  def self.all()    @@all;    end
  def raw()         @note;    end    # for development purposes only
  def tags()        [];       end
  def text()        name;     end    # tree display

  def self.reset
    @@all ||= []
  end

  def self.find(id)
    @@all[id.to_i]
  end

  def self.map(ids)
    ids.map{|id| find(id)}
  end

  def self.top
    @@top ||= TopNote.new
    @@top
  end

  def children
    []
  end


end

class TopNote < Note

  @@top = TopNote.new

  def name()  "Notes";   end

  def children
    @@all
  end

  def id()  "topnote"; end


end
