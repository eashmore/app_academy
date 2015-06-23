$.Tabs = function (el) {
  var that = this;
  this.$el = $(el);
  this.$currentTabPane = $('#corgi');
  this.$currentTabPane.addClass('active');
  $('.tabs li a').on('click', this.clickTab.bind(that));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();
  if (!$(".transitioning").length){
    var $tab = $($(event.currentTarget).attr('href'));
    $('.active-tab').eq(0).removeClass('active-tab');
    $(event.currentTarget).addClass('active-tab');
    this.$currentTabPane.removeClass('active');
    this.$currentTabPane.addClass('transitioning');
    var that = this;
    this.$currentTabPane.one('transitionend', function() {
      that.$currentTabPane.removeClass('transitioning');
      that.$currentTabPane = $tab;
      that.$currentTabPane.addClass('active transitioning');
      setTimeout(function(){
        that.$currentTabPane.removeClass('transitioning');
      }, 0);
    });
  }
};
