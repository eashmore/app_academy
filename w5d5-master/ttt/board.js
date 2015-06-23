function Board() {
  this.grid = [[[],[],[]],
               [[],[],[]],
               [[],[],[]]];
  this.marks = ["X", "O"];
}

Board.prototype.print = function() {
  this.grid.forEach (function(row) {
    console.log(JSON.stringify(row));
  });
};

Board.prototype.isWon = function() {
  this.marks.forEach( function(mark) {
    if ((this.grid[0][0] === mark
        && this.grid[0][1] === mark
        && this.grid[0][2] === mark)
    ||
    (this.grid[1][0] === mark
      && this.grid[1][1] === mark
      && this.grid[1][2]) === mark)
    ||
    (this.grid[2][0] === mark
      && this.grid[2][1] === mark
      && this.grid[2][2] === mark)
    ||
    (this.grid[0][0] === mark
      && this.grid[1][0] === mark
      && this.grid[2][0] === mark)
    ||
    (this.grid[0][1] === mark
      && this.grid[1][1] === mark
      && this.grid[1][2] === mark)
    ||
    (this.grid[0][2] === mark
      && this.grid[1][2] === mark
      && this.grid[2][2] === mark)
    ||
    (this.grid[0][0] === mark
      && this.grid[1][1] === mark
      && this.grid[2][2] === mark)
    ||
    (this.grid[0][2] === mark
      && this.grid[1][1] === mark
      && this.grid[2][0] === mark))
{}
};

Board.prototype.winner = function() {

};


Board.prototype.empty = function (row, col) {
  if (this.grid[row][col] === []) {
    return true;
  } else {
    return false;
  }
};

Board.prototype.placeMark = function(row, col, mark){
  if (this.empty(row,col)) {
    this.grid[row][col] = mark;
  }
};


var board = new Board();
board.print();
console.log(board.grid[0][0]);
module.exports = Board;
