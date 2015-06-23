$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = $('.users-input');
  this.$searchResults = $('.search-results');
  this.$input.on('input', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  console.log(this.$input.val());
  $.ajax({
    url: "/users/search",
    type: "GET",
    data: { query: this.$input.val() },
    dataType: 'JSON',
    success: function(searchResults) {
      this.renderResults(searchResults);
    }.bind(this),
    error: function () {
      console.log("error");
    }
  });
};

$.UsersSearch.prototype.renderResults = function (searchResults) {
  this.$searchResults.empty();
  searchResults.forEach(function (user) {
  var isFollowing;

  if (user.followed) {
    isFollowing = 'unfollow';
  } else {
    isFollowing = 'follow';
  }
    var userInfo = {
      userId: user.id,
      followState: isFollowing
    };

    var followButton = $('<input>').addClass('follow-toggle')
        .attr('type', 'submit');
    this.$searchResults.append($('<li>').append($('<a>')
    .text(user.username).attr('href', "http://localhost:3000/users/" + user.id))
    .append(followButton.followToggle(userInfo)));
  }.bind(this));
};


$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};


$(function () {
  $(".users-search").usersSearch();
});
