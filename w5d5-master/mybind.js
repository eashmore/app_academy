Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    fn.apply(context);
  };
};


var newthing = {
  name: "bane",
  newname: function () {
    this.name = this.name +"son";
    console.log(this.name);
  }
};


function times(num, fun) {
  for (var i = 0; i < num; i++) {
    fun(); // call is made "function-style"
  }
}

times(10, newthing.newname.myBind(newthing));
