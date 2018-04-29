class Note

  def self.all()    @@all;    end
  def raw()         @note;    end    # for development purposes only

  def self.reset
    @@all = []
  end

  def self.find(id)
    @@all[id.to_i]
  end

end
