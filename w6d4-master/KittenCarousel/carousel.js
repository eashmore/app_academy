
$.Carousel = function(el) {
  var that = this;
  this.$el = $(el);
  this.activeIdx = 0;
  $('img:first').addClass('active');
  $('.slide-left').on('click', this.slideLeft.bind(that));
  $('.slide-right').on('click', this.slideRight.bind(that));
  this.$images = $('img');

};

$.fn.carousel = function() {
  return this.each(function() {
    new $.Carousel(this);
  });
};

$.Carousel.prototype.slideLeft = function() {
  this.slide(-1);
};

$.Carousel.prototype.slideRight = function() {
  this.slide(1);
};

$.Carousel.prototype.slide = function(dir) {
  if (this.transitioning) {
    return;
  }
  this.transitioning = true;

  var that = this;
  var $oldImage = this.$images.eq(this.activeIdx);
  if (dir > 0) {
    $oldImage.addClass('left');
  } else {
    $oldImage.addClass('right');
  }

  $oldImage.one('transitionend', function (){
    $('.left').removeClass('left');
    $('.right').removeClass('right');
    $oldImage.removeClass('active');
    that.transitioning = false;
  });

  if (that.activeIdx + dir < 0) {
    that.activeIdx = that.$images.length - 1;
  } else if (that.activeIdx + dir > that.$images.length - 1) {
    that.activeIdx = 0;
  } else {
    that.activeIdx += dir;
  }
  that.$images.eq(that.activeIdx).addClass('active');
  // console.log(that.activeIdx);
  var $newImage = this.$images.eq(this.activeIdx);
  if (dir > 0) {
    $newImage.addClass('right');
  } else {
    $newImage.addClass('left');
  }

  setTimeout(function(){
    $newImage.removeClass('left');
    $newImage.removeClass('right');
  }, 0);

  // console.log($oldImage);
  // console.log($newImage);
};
