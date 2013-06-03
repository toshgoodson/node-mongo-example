postForm = $ '#post-form'
responseView = $ '#response'

# function called on completion of ajax post
postComplete = (jqXHR, status) ->
	if status == 'error' 
		postFailure jqXHR status
		return
	responseView.addClass 'success'
	responseView.text 'Posted!'
	postForm[0].reset()
	postForm.find('input').first().focus()

# function called if completion is an error
postFailure = (jqXHR, status, error) ->
	responseView.addClass 'error'
	responseView.text 'Unable to post message.'

# change submit behavior
postForm.on 'submit', (e) ->
	e.preventDefault()

	# get data from form
	formData = $(e.target).serialize()
	
	# submit form via ajax
	$.ajax {
        type: 'POST',
        url: '/post',
    	data: formData,
    	complete: postComplete,
    	error: postFailure
    }



listForm = $ '#list-form'
messageView = $ '#message-list'

buildMessageHtml = (message) ->
	# date = new Date(Date.parse message.date) 
	# dateTimeString = date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()
	return '<div class="row-fluid btn"><div class="span2">'+message.author+'</div><div class="span6">'+message.body+'</div><div class="span4">'+Date(message.date)+'</div></div>'

buildEmptyHtml = ->
	# date = new Date(Date.parse message.date) 
	# dateTimeString = date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()
	return '<div class="row-fluid btn btn-warning"><div class="span12">No entries exist for this name.</div></div>'


# function called on completion of ajax post
listComplete = (jqXHR, status) ->
	if status == 'error' 
		listFailure jqXHR status
		return
	# parse the json from the server to get message objects
	messages = $.parseJSON jqXHR.responseText
	# display the list of messages
	messageView.empty()
	if messages.length == 0 then messageView.append buildEmptyHtml
	for message in messages
		messageView.append buildMessageHtml message

# function called if completion is an error
listFailure = (jqXHR, status, error) ->

listForm.on 'submit', (e) ->
	e.preventDefault()

	# get data from form
	formData = $(e.target).serialize()

	# submit form via ajax
	$.ajax {
        type: 'POST',
        url: '/list',
    	data: formData,
    	complete: listComplete,
    	error: listFailure
    }

