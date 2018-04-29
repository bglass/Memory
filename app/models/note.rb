class Note

  def self.reset
    @@all = []
  end

  def self.all
    @@all
  end

  def self.find(id)
    @@all[id.to_i]
  end

  def raw()   @note;   end    # for development purposes only
end
