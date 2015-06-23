function range(start, end) {
  if (end < start) {
    return [];
  }
  return [start].concat(range(start + 1, end));
}


function rangeIt(start, end) {
  var result = [];
  for (var i = start; i <= end; i++) {
    result.push(i);
  }
  return result;
}

function exp(base, power) {
  if (power === 0) {
    return 1;
  }
  return base * exp(base, power - 1);
}

function exp2(base, power) {
  if (power === 0) {
    return 1;
  }
  if (power === 1) {
    return base;
  }
  if (power % 2 === 0) {
    return exp2(base, power / 2) * exp2(base, power / 2);
  }
  else {
    return base * (exp2(base, (power - 1) / 2) * exp2(base, (power - 1) / 2));
  }
}

function fib(num) {
  if (num === 0) {
    return [];
  }
  if (num === 1) {
    return [1];
  }
  if (num === 2) {
    return [1, 1];
  }
  var previous = fib(num - 1);
  var num1 = previous[previous.length - 1];
  var num2 = previous[previous.length - 2];
  previous.push(num1 + num2);
  return previous;
}

function bsearch(array, target) {
  // debugger
  var midpoint = Math.floor(array.length / 2);
  if (array[midpoint] === target) {
    return midpoint;
  }
  if (array.length === 1) {
    return null;
  }
  var left = array.slice(0, midpoint);
  var right = array.slice(midpoint, array.length);

  if (target < array[midpoint]) {
    return bsearch(left, target);
  }
  else {
    if (bsearch(right, target) === null) {
      return null;
    }
    return midpoint + bsearch(right, target);
  }
}

function makeChange(amount, array) {
  // debugger;
  var bestCombo;
  if (amount === 0) {
    return [];
  }
  for(var i = 0; i < array.length; i++) {
    var current;
    var result = [];
    var remainingAmount = amount;
    if (remainingAmount >= array[i]) {
      result.push(array[i]);
      remainingAmount -= array[i];
      current = result.concat(makeChange(remainingAmount, array));
    }
    else {
      current = result.concat(makeChange(remainingAmount, array.slice(1, array.length)));
    }
    if (bestCombo === undefined || current.length < bestCombo.length) {
      bestCombo = current;
    }
  }
  return bestCombo;
}

Array.prototype.mergeSort = function() {
  // debugger
  if (this.length <= 1) {
    return this;
  }

  var left = this.slice(0, Math.floor(this.length/2));
  var right = this.slice(Math.floor(this.length/2), this.length);

  return this.merge(left.mergeSort(), right.mergeSort());
};

Array.prototype.merge = function(array1, array2) {
  var sorted = [];
  while (array1.length > 0 && array2.length > 0) {
    if (array1[0] > array2[0]) {
      sorted.push(array2.shift());
    }
    else {
      sorted.push(array1.shift());
    }
  }

  return sorted.concat(array1).concat(array2);
};

Array.prototype.subsets = function() {
  // debugger;
  if (this.length === 0) {
    return [[]];
  }

  var lastEl = this[this.length - 1];
  var previousSubset = this.slice(0, this.length - 1).subsets();
  var additions = previousSubset.map(function(subset) {
    // console.log(subset);
    return subset.concat([lastEl]);
    // return subset;
  });

  return previousSubset.concat(additions);
};
