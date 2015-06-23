function Clock () {

}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log(this.startTime.getHours() + ":" + this.startTime.getMinutes() + ":" + this.startTime.getSeconds());
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.startTime = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.startTime.setSeconds(this.startTime.getSeconds() + 5);
  this.printTime();
};

var clock = new Clock();
clock.run();
