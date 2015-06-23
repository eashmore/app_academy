JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST["posts/post_form"],

  events: {
    'submit form': 'save'
  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  save: function (event) {
    event.preventDefault();
    var $form = $(event.currentTarget);
    var data = $form.serializeJSON();
    this.model.save(data, {
      success: function() {
        wait: true;
        Backbone.history.navigate("/posts/" + this.model.get("id"), { trigger: true });
      }.bind(this),

      error: function(model, response) {
        debugger;
        this.$el.empty();
        this.render();
        response.responseJSON.forEach(function(errorMessage) {
          this.$el.prepend(errorMessage);
          this.$el.prepend($("<br>"));
        }.bind(this));
      }.bind(this)
    });


  }



});
