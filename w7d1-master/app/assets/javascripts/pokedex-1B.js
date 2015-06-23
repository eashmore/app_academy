Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var newDetail = $("<div>").addClass("detail");
  newDetail.append($("<img>").attr("src", pokemon.get("image_url")));
  var newList = $("<ul>").addClass("details");
  var toyList = $("<ul>").addClass("toys");

  var newForm = $("<form>");

  newList.append($("<strong>").html(pokemon.get("name"))).append($("<br>"));
  for (var attr in pokemon.attributes) {
    if (attr === "image_url" || attr ==="id" || attr === "name") {
      continue;
    }
    newList.append($("<li>").html(attr + ": " + pokemon.get(attr)));
  }
  newDetail.append(newList);
  newDetail.append(toyList);
  this.$pokeDetail.html(newDetail);

  var that = this;
  pokemon.fetch({
    success: function() {
      that.renderToysList(pokemon.toys());
    }
  });
};


Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  event.preventDefault();
  var i = $(event.currentTarget).data("id");
  var pokemon = this.pokes.get({id: i});
  this.renderPokemonDetail(pokemon);
};
