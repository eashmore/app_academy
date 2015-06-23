function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
};

var markov = new Cat("Markov", "Ned");
var lulu = new Cat("Lulu", "Dan");
var ludwig = new Cat("Ludwig", "Eric");
var curie = new Cat("Curie", "Ned");

console.log(markov.cuteStatement());
console.log(lulu.cuteStatement());
console.log(ludwig.cuteStatement());
console.log(curie.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return "Everybody loves " + this.name +"!";
};

console.log(markov.cuteStatement());
console.log(lulu.cuteStatement());
console.log(ludwig.cuteStatement());
console.log(curie.cuteStatement());

Cat.prototype.meow = function() {
  return "Meow";
};

console.log(markov.meow());
console.log(lulu.meow());
console.log(ludwig.meow());
console.log(curie.meow());

markov.meow = function() {
  return "Moo!";
};

console.log(markov.meow());
console.log(lulu.meow());
console.log(ludwig.meow());
console.log(curie.meow());
