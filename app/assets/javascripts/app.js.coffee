Post = Backbone.Model.extend
  urlRoot: "/posts"

  defaults:
    title:   "Default Title"
    content: "Default content"
    errors:  {}

  initialize: ->
    do @validations_init
    
    @on "change:errors", (model, errors) ->
      @errors_block errors

  validations_init: ->
    @validate = ->
      errors = {}

      if @get("title").length is 0
        errors["title"] ||= []
        errors["title"].push "Can't be blank"

      if @get("content").length is 0
        errors["content"] ||= []
        errors["content"].push "Can't be blank"

      valid = (_.map errors, (err) -> err).length is 0
      return errors if !valid

      false

    @on 'invalid', (model, errors) ->
      @errors_block errors

  errors_block: (errors) ->
    for name, error of errors
      log "========================="
      log "Show validation errors: #{name} - #{error}"
      log "========================="

    @set "errors", {}

PostForm = Backbone.View.extend
  el: "#post_form"
  
  events:
    "keyup #post_title":   "update_model"
    "keyup #post_content": "update_model"
    "submit": "submit"

  initialize: ->
    @model = new Post
    @model.on 'change', @render, @
    do @render

  render: ->
    $('[name=post_title]',   @$el).val @model.get 'title'
    $('[name=post_content]', @$el).val @model.get 'content'

  update_model: (e) ->
    input = $ e.target
    field_name = _.last input.attr('id').split('_')
    @model.set field_name, input.val()

  submit: ->
    @model.save()
    false

post_form_init = =>
  @post_form = new PostForm

$ ->
  do post_form_init

####################################################

# post_form.model.set("title", 1111)  
# posts_list = new PostsList

# Post = Backbone.Model.extend
#   urlRoot: "/posts"

#   sync: ->
#     $.ajax
#       method: 'POST'
#       url:    '/posts'
#       dataType: 'json'
#       success: (data, status) ->
#         log data
#         log status

# Collections
# Posts = Backbone.Collection.extend
#   model: Post
#   url: '/posts'

#   initialize: ->
#     do @fetch_callbacks_init

#   fetch_callbacks_init: ->
#     # fetch callbacks
#     @on 'request', (collection, xhr, request_options) ->
#       posts = request_options.posts
#       log "Collection uploading"

#       xhr.success (data, state, xhr) =>
#         log "XHR completed and success"
#         @trigger "posts:success:uploaded", data

#     @on 'sync', (collection, ary, request_options) ->
#       log "Collection was changed"


# PostsList = Backbone.View.extend
#   el: ".posts_list"

#   initialize: ->
#     @posts = new Posts
#     @listenTo @posts, 'posts:success:uploaded', @render
#     @posts.fetch()

#   render: ->
#     @posts.each (post) =>
#       post_item = new PostItem { post: post }
#       @appendPost post_item.render()

#   appendPost: (post_content) ->
#     @$el.append post_content


# PostItem = Backbone.View.extend
#   tagName:   "div"
#   className: "post"

#   template: _.template """
#     <h3><%- title %></h3>
#     <p><%- content %></p>
#   """
  
#   events:
#     click: "click_on_post"

#   click_on_post: -> log "Post was clicked!"

#   initialize: (opts = {}) ->
#     @post = opts.post

#   render: ->
#     @$el.html @template @post.toJSON()

# post = new Post
# item = new PostItem { post: post } 
# item.render()

# http://backbonejs.org/#Events-catalog

# Models

# post.sync("GET", post, { dataType: 'json', url: "/posts/#{post.id}" }).complete (response, status) ->
#   log response

# post.on 'change:content', (model, content) ->
#   log "Content changed!"

# post.on 'change', (data, response) ->
#   log "Post Changed", data, response

# post.set
#   content: "Hello from there! <script>alert(1)</script>"

# log post
# log post.get    'content'
# log post.escape 'content'

# log post.show_content()
# log post.attributes.content
# log post.has 'test_field'
# log post.id
# log post.get 'id'
# log post.toJSON ['id', 'test_attr', 'undefined_var', 'content']

# post.sync()
# post.fetch()

# log post.url()
# log post.urlRoot
# log post.isValid()
# log post.save()

# post2 = new Post { id: 2 }
# post2.save()
# log post2.validationError

# log post.clear

# Collection
# posts = new Posts

# # log posts
# posts.fetch({ posts: posts })