function myUniq(array) {
  var result = [];
  for (var i = 0; i < array.length; i++){
    var skip = false;
    for (var j = 0; j <= result.length; j++){
      if (array[i] === result[j]) {
        skip = true;
      }
    }
    if (skip === false) {
      result.push(array[i]);
    }
  }
  return result;
}
// a = []
// a.indexOf("target") // index || -1
console.log(myUniq([1,2,3,1,2,4]));

function twoSum(array) {
  var results = [];
  for (var i = 0; i < array.length; i++) {
    for (var j = i + 1; j < array.length; j++) {
      if (array[i] + array[j] === 0) {
        results.push([i, j]);
      }
    }
  }

  return results;
}

console.log(twoSum([-1, 0, 2, -2, 1]));


function myTranspose(matrix) {
  var result = [];
  for (var i = 0; i < matrix.length; i++) {
    var subResult = [];
    matrix.forEach (function(array) {
      subResult.push(array[i]);
    })
    result.push(subResult);
  }

  return result;
}

console.log(myTranspose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]));
