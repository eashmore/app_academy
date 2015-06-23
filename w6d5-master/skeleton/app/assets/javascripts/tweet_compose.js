$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$allInputs = $(":input");

  this.$textarea = this.$el.find('textarea');
  this.$textarea.on("input", this.characterCount.bind(this));
  this.$el.on('submit', this.submit.bind(this));

  this.$mentionedUsers = this.$el.find('.add-mentioned-user');
  this.$mentionedUsers.on('click', this.addMentionedUser.bind(this));

  this.$removeButton = $('a.remove-mentioned-user')
  this.$removeButton.on('click', this.removeMentionedUser.bind(this));
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault(); // TA: SO IMPORTANT!!!!!

  var formData = this.$el.serialize();
  this.$allInputs.prop('disabled', true);

  $.ajax({
    url: "/tweets",
    type: "POST",
    data: formData,
    dataType: 'JSON',
    success: this.handleSuccess.bind(this),
    error: function () {
      console.log("error");
    }
  });
};

$.TweetCompose.prototype.removeMentionedUser = function (event) {
  console.log($(event.currentTarget).parent());
  $(event.currentTarget).parent().remove();
};

$.TweetCompose.prototype.clearInputs = function () {
  this.$textarea.val('');
  this.characterCount();
};

$.TweetCompose.prototype.handleSuccess = function (tweet) {
  this.clearInputs();
  this.$allInputs.prop('disabled', false);
  var newTweet = JSON.stringify(tweet);
  var $newTweet = $('<li>').text(newTweet);
  $(this.$el.data('tweets-ul')).prepend($newTweet);
};

$.TweetCompose.prototype.characterCount = function () {
  var remainingChars = 140 - this.$textarea.val().length;
  $('.chars-left').text(remainingChars);
  // if (remainingChars <= 0) {
  //   this.$textarea.prop('disabled', true);
  // } else {
  //   this.$textarea.prop('disabled', false);
  // }
};

$.TweetCompose.prototype.addMentionedUser = function(event) {
  event.preventDefault();
  var $script = $('.form-script').html();
  $('.mentioned-users').append($script);
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};


$(function () {
  $(".tweet-compose").tweetCompose();
});
