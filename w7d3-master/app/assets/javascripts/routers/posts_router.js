JournalApp.Routers.Posts = Backbone.Router.extend({
  routes: {
    "posts(/)": "index",
    "posts/new(/)": "new",
    "posts/:id/edit(/)": "edit",
    "posts/:id(/)": "show"
  },

  // initialize: function (options) {
  //   this._posts = new JournalApp.Collections.Posts();
  //   // var $rootPage = $("div.main");
  //   // $rootPage.html(postsView.$el);    this.$el = $("div.main");
  // },

  index: function(callback) {
    $("div.main").empty();
    this._postsIndex && this._postsIndex.remove();
    this._postsIndex = new JournalApp.Views.PostsIndex();
    $("div.sidebar").html(this._postsIndex.$el);
    this._postsIndex.collection.fetch({
      reset: true,
      success: function() {
        callback && callback();
      }
    });
  },

  show: function (id, callback) {
    if (!this._postsIndex) {
      this.index(this.show.bind(this, id));
      return;
    }
    var post = this._postsIndex.collection.getOrFetch(id);
    this._show && this._show.remove();
    this._show = new JournalApp.Views.PostShow({ model: post });
    $("div.main").html(this._show.render().$el);
  },

  edit: function(id) {
    if (!this._postsIndex) {
      this.index(this.edit.bind(this, id));
      return;
    }
    var post = this._postsIndex.collection.getOrFetch(id);
    this._edit && this._edit.remove();
    this._edit = new JournalApp.Views.PostForm({ model: post });
    $("div.main").html(this._edit.render().$el);
  },

  new: function() {
    if (!this._postsIndex) {
      this.index(this.new.bind(this));
      return;
    }
    this._new && this._new.remove();
    var post = this._postsIndex.collection.getOrFetch();
    this._new = new JournalApp.Views.PostForm({ model: post });
    $("div.main").html(this._new.render().$el);

  }
});
