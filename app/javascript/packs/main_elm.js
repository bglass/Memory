import Elm from '../elm-src/Main'

document.addEventListener('DOMContentLoaded', () =>
{
  const target = document.createElement('div');

  document.body.appendChild(target);

  var app = Elm.Main.embed(target);

  app.ports.elm2js.subscribe(function (str) {  main.event.elm2js(str) })
})
