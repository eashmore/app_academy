var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame() {
  this.stacks = {
    1: [1,2,3],
    2: [],
    3: []
  };
}

HanoiGame.prototype.isWon = function() {
  if (this.stacks[2].length === 3 || this.stacks[3].length === 3) {
    return true;
  }
  else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function(startTower, endTower) {
  if ((endTower.length === 0 || endTower[0] > startTower[0]) && (startTower !== endTower)) {
    return true;
  }
  else {
    return false;
  }
};

HanoiGame.prototype.move = function(startTower, endTower) {
  if (this.isValidMove(startTower, endTower)) {
    endTower.unshift(startTower.shift());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  var that = this;
  reader.question("start tower? (1-3): ", function(start) {
    reader.question("end tower? (1-3): ", function(end) {
      var endTower = that.stacks[end];
      var startTower = that.stacks[start];
      // that.promptMove(callback(startTower, endTower));

      callback(startTower, endTower);
    });
  });
};

HanoiGame.prototype.run = function(completionCallback) {
  var that = this;
  if (this.isWon()) {
    this.print();
    completionCallback();
  } else {
    this.promptMove( function(start, end) {
      if (that.move(start, end)) {
        that.run(completionCallback);
      } else if (!that.move(start, end)) {
        console.log("Not a valid move.");
        that.run(completionCallback);
      }
    });
  }
};
var game = new HanoiGame();
game.run(function () {
  reader.close();
  console.log("You won!");
});
