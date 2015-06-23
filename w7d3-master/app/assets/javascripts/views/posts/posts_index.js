JournalApp.Views.PostsIndex = Backbone.View.extend({

  initialize: function(options) {
    this.collection = new JournalApp.Collections.Posts();
    this.listenTo(this.collection, "sync remove reset add", this.render);
  },

  template: JST['posts/index'],

  tagName: 'ul',

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.collection.each(function (post) {
      var item = new JournalApp.Views.PostsIndexItem( { model: post } );
      this.$el.append(item.render().$el);
    }.bind(this));
    return this;
  }

});
