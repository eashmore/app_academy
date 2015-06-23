JournalApp.Views.PostsIndexItem = Backbone.View.extend({

  events: {
    "click .delete-button": "delete",
    "click .edit-button": "goToEdit"
  },

  template: JST["posts/index_item"],

  tagName: "li",

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);

    return this;
  },

  delete: function() {
    this.model.destroy();
  },

  goToEdit: function() {
    Backbone.history.navigate("/posts/" + this.model.get("id") + "/edit", { trigger: true });
  }
});
