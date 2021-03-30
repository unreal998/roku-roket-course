function init()
	? "[HomeScene] init"
	m.categoryScreen = m.top.findNode("categoryScreen")
	m.contentScreen = m.top.findNode("contentScreen")
	m.detailsScreen = m.top.findNode("detailsScreen")
	m.errorDialog = m.top.findNode("errorDialog")
	m.videoplayer = m.top.findNode("videoplayer")
	initializeVideoPlayer()

	m.categoryScreen.observeField("categorySelected", "onCategorySelected")
	m.contentScreen.observeField("contentSelected", "onContentSelected")
	m.detailsScreen.observeField("playButtonPressed", "onPlayButtonPressed")

	m.categoryScreen.setFocus(true)
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

sub onCategorySelected(obj)
    ? "onCategorySelected field: ";obj.getField()
    ? "onCategorySelected data: ";obj.getData()
    list = m.categoryScreen.findNode("categoryList")
    ? "onCategorySelected checkedItem: ";list.checkedItem
    ? "onCategorySelected selected ContentNode: ";list.content.getChild(obj.getData())
    item = list.content.getChild(obj.getData())
    loadFeed(item.feedUrl)
end sub

sub onContentSelected(obj)
	selectedIndex = obj.getData()
	m.selectedMedia = m.contentScreen.findNode("contentGrid").content.getChild(selectedIndex)
	m.detailsScreen.content = m.selectedMedia
	m.contentScreen.visible = false
	m.detailsScreen.visible = true
end sub

sub onPlayButtonPressed(obj)
	m.detailsScreen.visible = false
	m.videoplayer.visible = true
	m.videoplayer.setFocus(true)
	m.videoplayer.content = m.selectedMedia
	m.videoplayer.control = "play"
end sub

sub loadFeed(url)
  ? "loadFeed! ";url
  m.feedTask = createObject("roSGNode", "LoadFeedTask")
  'should add error field, too
  m.feedTask.observeField("response", "onFeedResponse")
  m.feedTask.url = url
  m.feedTask.control = "RUN"
end sub

sub onFeedResponse(obj)
	response = obj.getData() 'this is a string from the http response
	'turn the string (JSON) into an Associative Array
	data = parseJSON(response)
	if data <> Invalid and data.items <> invalid
		'hide the CategoryScreen, show the ContentScreen
		m.categoryScreen.visible = false
		m.contentScreen.visible = true
		' assign data to content screen
		m.contentScreen.feedData = data
	else
		? "FEED RESPONSE IS EMPTY! LAME."
	end if
end sub

sub onPlayerPositionChanged(obj)
	? "Player Position: ", obj.getData()
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
	m.videoplayer.visible = false
	m.detailsScreen.visible = true
end sub

sub showErrorDialog(message)
	m.errorDialog.title = "ERROR"
	m.errorDialog.message = message
	m.errorDialog.visible = true
	'tell the home scene to own the dialog so the remote behaves'
	m.top.dialog = m.errorDialog
end sub

' Main Remote keypress handler
function onKeyEvent(key, press) as Boolean
	? "[HomeScene] onKeyEvent", key, press
	' we must capture the 'true' for press, it comes first (true=down,false=up) to keep the firmware from handling the event
	if key = "back" and press
		if m.contentScreen.visible
			m.contentScreen.visible = false
			m.categoryScreen.visible = true
			return true
		else if m.detailsScreen.visible
			m.detailsScreen.visible = false
			m.contentScreen.visible = true
			return true
		else if m.videoplayer.visible
			closeVideo()
			return true
		end if
	end if
  return false
end function
