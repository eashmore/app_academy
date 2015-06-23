$.Thumbnails = function (el) {
  var that = this;
  this.$el = $(el);
  this.$activeImage = this.$el.find('.gutter-images').children().first();
  this.activate(this.$activeImage);

  this.$el.on('click', 'img', function (event) {
    that.$activeImage = $(event.currentTarget);
    that.activate(that.$activeImage);
  });

  this.$el.on("mouseenter", 'img', function (event) {
    var $image = $(event.currentTarget);
    that.activate($image);
  });

  this.$el.on("mouseleave", 'img', function () {
    that.activate(that.$activeImage);
  });
};

$.Thumbnails.prototype.activate = function ($img) {
  $('.active').html($img.clone());
};

$.fn.thumbnails = function() {
  return this.each(function() {
    new $.Thumbnails(this);
  });
};
