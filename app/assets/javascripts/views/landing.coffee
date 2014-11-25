class Template.Landing extends Backbone.View

	className:  'landing'

	template: JST['templates/landing']

	initialize: (options) ->
		@app = options.app
		@render()
		@position()
		@page_animation()
		@set_height()
		@resize_window()
		@disable_scroll()
		@start_scroll()	
		@right_div = ""
		@left_div = ""
		@target = ""
		@scroll = false

	events: 
		'mouseenter .project' : 'trigger_hover'
		'mouseleave .project' : 'remove_hover'
		'click .project'	  : 'show_project'
		'click .fa-times'	  : 'close_project'

	close_project: (e)->
		@scroll = false
		classes = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15']
		classname = @target.attr('class')
		number = classname.split(" ")[2]
		index = classes.indexOf(number)
		current_project = $(e.currentTarget).parent()
		current_project.fadeOut(1000)
		target = @target
		right_div = @right_div


		window.setTimeout (->
		  target.animate({'margin-left' : '0'}, 2000)
		  i = 0
		  while i < index
		  	$(".#{classes[i]}").animate({'margin-left': '0px' }, 2000)
		  	i++
		), 100

	    
		window.setTimeout (->
		  $(".#{right_div}").animate({'margin-left' : '0px'}, 2000)
		), 100


	open_project: (project)->	
			$(".#{project}").fadeIn(1000)
			@scroll = true

	show_project: (e)->
		classes = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15']
		target = $(e.currentTarget)
		@target = target
		project_view = target.data('project')
		target.css('z-index', '-1')
		classname = target.attr('class')
		number = classname.split(" ")[2]
		index = classes.indexOf(number)
		right_div = parseInt(number) + 1
		left_div = parseInt(number) - 1
		@right_div = right_div
		console.log @right_div
		@left_div = left_div
		open_project = @open_project

		window.setTimeout (->
		  target.animate({'margin-left' : '-180px'}, 2000)
		  i = 0
		  while i < index
		  	$(".#{classes[i]}").animate({'margin-left': '-180px' }, 2000)
		  	i++
		), 100

	    
		window.setTimeout (->
		  $(".#{right_div}").animate({'margin-left' : '3000px'}, 2000)
		), 100

		window.setTimeout (->
			open_project(project_view)
		), 800


	trigger_hover: (e)->
		target = $(e.currentTarget)
		title = target.find('.title')
		title.addClass('hovered')

	remove_hover: (e)->
		target = $(e.currentTarget)
		title = target.find('.title')
		title.removeClass('hovered')

	start_scroll: ->
		$('.portfolio').scroller()

	disable_scroll: ->
		if @scroll = false
			$(window).on('mousewheel', (e)->
				e.preventDefault()
				)
				
	set_height: ->
		height = $(window).height()
		width = $(window).width() - 300
		$('.navbar').css('height', height)
		$('.portfolio').css('height', height)
		$('.project').css('height', height)
		$('.portfolio').css('width', width)
		$('.proj-class').css({'width' : width, 'height' : height})


	resize_window: ->
		$(window).on('resize', ->
			width = $(window).width() - 300
			height = $(window).height()
			$('.portfolio').css({'width' : width})
			$('.portfolio').css({'height' : height})
			$('.project').css({'height' : height})
			$('.navbar').css('height', height)
			$('.proj-class').css('height' : height)
			$('.proj-class').css('width' : width)
			console.log width
			)

	page_animation: ->
    	$('body').css('display', 'none')
    	$('body').fadeIn(2000)

	render: ->
		@$el.html @template()

	position: ->
		$('body').html @$el
