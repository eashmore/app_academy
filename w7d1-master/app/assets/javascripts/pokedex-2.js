Pokedex.RootView.prototype.addToyToList = function (toy) {
  var toyLi = $("<li>").append(toy.get("name") + " ").append(toy.get("happiness") + " ").append(toy.get("price") + " ");
  toyLi.addClass("toy-list-item"); 
  toyLi.data("toy-id",toy.get("id"));
  toyLi.data("pokemon-id",toy.get("pokemon_id"));
  $(this.$pokeDetail.find(".toys")).append(toyLi);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var newDetail = $("<div>").addClass("detail");
  newDetail.append($("<img>").attr("src", toy.get("image_url")));
  newDetail.append($("<br>"));
  newDetail.append($("<strong>").html(toy.get("name")));

  for (var attr in toy.attributes) {
    if (attr === "image_url" || attr === "pokemon_id" || attr === "id" || attr === "name") {
      continue;
    }
    newDetail.append($("<li>").html(attr + ": " + toy.get(attr)));
  }

  var select = $("<select>");
  select.addClass("poke-select");
  select.data("toy-id",toy.get("id"));
  select.data("pokemon-id",toy.get("pokemon_id"));
  this.pokes.each(function(poke){
    if(poke.get("id") === toy.get("pokemon_id")) {
      select.append("<option value=" + poke.get("id") + " selected>" + poke.get("name") + "</option>");
    } else {
      select.append("<option value=" + poke.get("id") + ">" + poke.get("name") + "</option>");
    }
  });
  newDetail.append(($("<label>").html("owner: ").append(select)));
  this.$toyDetail.html(newDetail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  event.preventDefault();
  var pokeId = $(event.currentTarget).data("pokemon-id");
  var pokemon = this.pokes.get({id: pokeId});
  var toyId = $(event.currentTarget).data("toy-id");
  var toy = pokemon.toys().get({id: toyId});
  console.log(pokeId);
  console.log(toyId);
  console.log(toy.get("name"));
  this.renderToyDetail.call(this,toy);
};
