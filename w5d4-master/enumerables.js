Array.prototype.myEach = function(block) {
  for (var i = 0; i < this.length; i++) {
    block(this[i]);
  }
};

[1,2,3,4].myEach(function(num){
  console.log(num);
});

Array.prototype.myMap = function(block) {
  var result = [];
  this.myEach(function(el){
    result.push (block(el));
  });

  return result;
};

var newArray = [1, 2, 3, 4].myMap(function(num){
  return num + 1;
});

console.log(newArray);

Array.prototype.myInject = function(block){
  var sum = this.shift();

  this.myEach(function(el) {
    sum = block(sum, el);
  });
  return sum;
};

var inject = [1, 2, 3, 4].myInject(function(sum, num){
  return sum + num;
});

console.log(inject);
