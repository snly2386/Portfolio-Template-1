class Template.Router extends Backbone.Router

  initialize: ->
    Backbone.history.start()

  routes: ->
  	'' : 'landing'

  landing: ->
  	view = new Template.Landing app: @