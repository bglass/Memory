class Selection

  @@list = {}

  attr_reader :name, :selection

  def initialize(name)
    @name        = name
    @@list[name] = self
    self.set([])
  end

  def self.reset
    Selection.new("note")
    Selection.new("tag")
    Selection.new("folder")
  end

  def self.set(name, selection)
    @@list[name].set(selection)
  end

  def self.get(name)
    @@list[name].get
  end

  def set(selection)
    @selected = selection
    client_sync
    client_state_display
  end

  def client_sync
    # ActionCable.server.broadcast('selection', {name: name, selection: @selected})
  end

  def client_state_display
    msg = "#{name} selection: #{@selected.to_s}"
    # ActionCable.server.broadcast('content', msg: msg)
  end


  def get
    @selected
  end

end
