Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  //debugger
  var pokeItem = $("<li>").append(pokemon.get("name")).append($("<br>")).append(pokemon.get("poke_type")).addClass("poke-list-item");
  pokeItem.data("id", pokemon.get("id"));
  this.$pokeList.append(pokeItem);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  this.pokes.fetch({
    success: function(pkmn){
      pkmn.each(function(poke){window.Pokedex.rootView.addPokemonToList(poke);});
    }
  });
};
