JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["posts/posts_show"],

  events: {
    "click .back-to-index": "backToIndex",
    "click .edit-button": "goToEdit"
  },

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  backToIndex: function() {
    Backbone.history.navigate("/posts", { trigger: true });
  },

  goToEdit: function() {
    Backbone.history.navigate("/posts/" + this.model.get("id") + "/edit", { trigger: true });
  }
});
