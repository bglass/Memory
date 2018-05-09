class Eins
  constructor: (@x) ->
    x = @x
    func3()

  func3 = ->
    console.log x



t1 = new Eins("bla")
t2 = new Eins("bla")
