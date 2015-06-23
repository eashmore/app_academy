$.FollowToggle = function (el, options) {
  this.$button = $(el);
  this.userId = this.$button.data('user-id') || options.userId;
  this.followState = this.$button.data('follow-state') || options.followState;
  this.render();
  this.$button.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === 'follow') {
    this.$button.attr('value', "Follow!");
    this.$button.prop('disabled', false);
  } else if (this.followState === 'unfollow') {
    this.$button.attr('value', "Unfollow!");
    this.$button.prop('disabled', false);
  } else {
    this.$button.prop('disabled', true);
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  if (this.followState === 'follow') {
    this.followState = 'following';
    this.render();

    $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: "POST",
      dataType: 'JSON',
      success: function() {
        this.followState = 'unfollow';
        this.render();
      }.bind(this),
      error: function () {
        console.log("error");
      }
    });
  }
  else {
    this.followState = 'unfollowing';
    this.render();

    $.ajax({
      url: "/users/" + this.userId + "/follow",
      type: "DELETE",
      dataType: 'JSON',
      success: function() {
        this.followState = 'follow';
        this.render();
      }.bind(this)
    });
  }
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};


$(function () {
  $(".follow-toggle").followToggle();
});
