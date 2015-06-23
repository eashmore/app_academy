Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var pokemon = new Pokedex.Models.Pokemon();
  var that = this;
  pokemon.save(attrs,{
    success: function(model, response, options){
      that.pokes.add(pokemon);
      that.addPokemonToList(pokemon);
      callback(pokemon);
    }
  });

};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var json = $(event.currentTarget).serializeJSON();
  this.createPokemon(json, this.renderPokemonDetail.bind(this));
};
