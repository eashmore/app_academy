Array.prototype.myUniq = function() {
  var result = [];
  for (var i = 0; i < this.length; i++){
    var skip = false;
    for (var j = 0; j <= result.length; j++){
      if (this[i] === result[j]) {
        skip = true;
      }
    }
    if (skip === false) {
      result.push(this[i]);
    }
  }
  return result;
};

function bubbleSort(array) {
  var sorted = false;
  while (sorted === false) {
    sorted = true;
    for (var i = 0; i < array.length - 1; i++) {
      if (array[i] > array[i + 1]) {
        var temp = array[i + 1];
        array[i + 1] = array[i];
        array[i] = temp;
        sorted = false;
      }
    }
  }
  return array;
}

console.log(bubbleSort([4, 3, 5, 1, 2]));


String.prototype.substrings = function() {
  var subs = [];
  for(var i = 0; i < this.length; i++) {
    for(var j = i + 1; j < this.length + 1; j++) {
      subs.push(this.slice(i, j));
    }
  }

  return subs.myUniq();
};

console.log('bubble'.substrings());
