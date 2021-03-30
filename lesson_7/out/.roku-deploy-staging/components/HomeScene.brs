function init()
	? "[HomeScene] init"
	m.categoryScreen = m.top.findNode("categoryScreen")
	m.contentScreen = m.top.findNode("contentScreen")
	m.detailsScreen = m.top.findNode("detailsScreen")
	m.errorDialog = m.top.findNode("errorDialog")
	m.videoplayer = m.top.findNode("videoplayer")
	initializeVideoPlayer()

	m.categoryScreen.observeField("selectedCategory", "onCategorySelected")
	m.contentScreen.observeField("contentSelected", "onContentSelected")
	m.detailsScreen.observeField("playButtonPressed", "onPlayButtonPressed")

	m.categoryScreen.setFocus(true)
	loadConfig()
end function

sub initializeVideoPlayer()
	m.videoplayer.EnableCookies()
	m.videoplayer.setCertificatesFile("common:/certs/ca-bundle.crt")
	m.videoplayer.InitClientCertificates()
	'set position notification to 1 second
	m.videoplayer.notificationInterval=1
	m.videoplayer.observeFieldScoped("position", "onPlayerPositionChanged")
	m.videoplayer.observeFieldScoped("state", "onPlayerStateChanged")
end sub

sub loadConfig()
    m.configTask = createObject("roSGNode", "LoadConfigTask")
    m.configTask.observeField("filedata", "onConfigResponse")
    m.configTask.observeField("error", "onConfigError")
    m.configTask.filepath = "components/resources/config.json"
    m.configTask.control="RUN"
end sub

sub onConfigResponse(obj)
	params = {config:obj.getData()}
	m.categoryScreen.callFunc("updateConfig",params)
	m.contentScreen.callFunc("updateConfig",params)

end sub

sub onConfigError(obj)
	showErrorDialog(obj.getData())
end sub

sub onCategorySelected(obj)
  ' note that you do NOT get the content node you want, just an index.
  selectedObj = obj.getData()
  ?"Selected object"selectedObj
  m.contentScreen.setField("selectedCategory",selectedObj.text)
  loadFeed(selectedObj.feedUrl)
end sub

sub onContentSelected(obj)
  ' note that you do NOT get the content node you want, just an index.
  selectedIndex = obj.getData()
  ' look up the media item using this verbose, dumb technique.
   m.selectedMedia = m.contentScreen.findNode("markupgrid").content.getChild(selectedIndex)
	 m.detailsScreen.content = m.selectedMedia
	 m.contentScreen.visible = false
	 m.detailsScreen.visible = true
	id = m.selectedMedia.movieId
	if  id <> invalid and id.Len() > 0
	  url = "https://api.themoviedb.org/3/movie/" + id + ":?api_key=4bc08ab955f501a524c27210af4c49f3"
	  loadFeed(url)
	end if
end sub

sub onPlayButtonPressed(obj)
	? "PLAY!!!",m.selectedMedia
	m.detailsScreen.visible = false
	m.videoplayer.visible = true
	m.videoplayer.setFocus(true)
	m.videoplayer.content = m.selectedMedia
	m.videoplayer.control = "play"
end sub

sub loadFeed(url)
	m.feedTask = createObject("roSGNode", "LoadFeedTask")
	m.feedTask.observeField("response", "onFeedResponse")
	m.feedTask.observeField("error", "onFeedError")
	m.feedTask.url = url
	m.feedTask.control = "RUN"
end sub

sub onFeedResponse(obj)
	response = obj.getData() 'this is a string from the http response
	'turn the string (JSON) into an Associative Array
	data = parseJSON(response)
	? "Data from API " data
	if data <> invalid and data.results <> invalid
		'hide the CategoryScreen, show the ContentScreen
		m.categoryScreen.visible = false
		m.contentScreen.visible = true
		' assign data to content screen
		m.contentScreen.feedData = data
	else if (data <> invalid and data.results = invalid)
		?"DETAILS "data
		m.detailsScreen.additionalData = data
	else 
		showErrorDialog("Feed data malformed.")
	end if
end sub

sub onFeedError(obj)
	showErrorDialog(obj.getData())
end sub

sub onPlayerStateChanged(obj)
  state = obj.getData()
	? "onPlayerStateChanged: ";state
	if state="error"
    	showErrorDialog(m.videoplayer.errorMsg+ chr(10) + "Error Code: "+m.videoplayer.errorCode.toStr())
	else if state = "finished"
		closeVideo()
	end if
end sub

sub closeVideo()
	m.videoplayer.control = "stop"
	m.videoplayer.visible=false
	m.detailsScreen.visible=true
end sub

sub showErrorDialog(message)
	m.errorDialog.title = "ERROR"
	m.errorDialog.message = message
	m.errorDialog.visible=true
	'tell the home scene to own the dialog so the remote behaves'
	m.top.dialog = m.errorDialog
end sub

' Main Remote keypress handler
function onKeyEvent(key, press) as Boolean
	? "[HomeScene] onKeyEvent", key, press
	? "Content "m.contentScreen.visible
	? "Category " m.categoryScreen.visible
	' we must capture the 'true' for press, it comes first (true=down,false=up) to keep the firmware from handling the event
	if key = "back" and press
		if m.contentScreen.visible
			m.contentScreen.visible=false
			m.categoryScreen.visible=true
			return true
		else if m.detailsScreen.visible
			m.detailsScreen.visible=false
			m.contentScreen.visible=true
			return true
		else if m.videoplayer.visible
			closeVideo()
			return true
		end if
	end if
  return false
end function
