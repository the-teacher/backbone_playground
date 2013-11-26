# http://backbonejs.org/#Events-catalog

# Models

# post.sync("GET", post, { dataType: 'json', url: "/posts/#{post.id}" }).complete (response, status) ->
#   log response

Post = Backbone.Model.extend
  urlRoot: "/posts/"

  defaults:
    content: "Default content"

  initialize: (params) ->
    @attributes.test_attr = params?.test_attr || "Test Attr is undefined"
    do @validations_init

  validations_init: ->
    @validate = -> "invalid Post"

    @on 'invalid', (model, error) ->
      log "Validation Error", model, error

  show_content: -> @attributes.content

  # sync: ->
  #   $.ajax
  #     dataType: 'json'
  #     url: "/posts/" + @get('id')
  #     success: (data, status) ->
  #       log data
  #       log status

# Collections
Posts = Backbone.Collection.extend
  model: Post
  url: '/posts'

  initialize: ->
    @on 'request', (collection, xhr, req_opts) ->
      log "Collection uploading"
      
      xhr.complete ->
        log "XHR completed"

    @on 'sync', (collection, ary, req_opts) ->
      log "Collection was changed"

$ -> 
  # Model
  # post = new Post { id: 1 }

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
  posts = new Posts
  
  # log posts
  posts.fetch()