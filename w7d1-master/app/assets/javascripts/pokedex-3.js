Pokedex.RootView.prototype.reassignToy = function (event) {
  event.preventDefault();
  var pokeId = $(event.currentTarget).data("pokemon-id");
  var pokemon = this.pokes.get({id: pokeId});
  var toyId = $(event.currentTarget).data("toy-id");
  var toy = pokemon.toys().get({id: toyId});
  var newPoke = $(event.currentTarget).val();
  toy.save({ pokemon_id:newPoke },{
    success: function(model, response, options){
      pokemon.toys().remove(toy);
      this.renderToysList(pokemon.toys());
      this.$toyDetail.empty();
    }.bind(this)
  });
};

Pokedex.RootView.prototype.renderToysList = function (toys) {
  $(this.$pokeDetail.find(".toys")).empty();
  toys.each(function(toy){
    this.addToyToList(toy);
  }.bind(this));
};
