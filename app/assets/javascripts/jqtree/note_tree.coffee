data = [
  {
    name: 'node1'
    children: [
      { name: 'child1' }
      { name: 'child2' }
    ]
  }
  {
    name: 'node2'
    children: [ { name: 'child3' } ]
  }
]

$ ->
  $('.note_tree').tree data: data
