function init()
  ? "----[HomeScene] init"
  m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"
  m.categoryScreen = m.top.findNode("categoryScreen")
  m.contentScreen = m.top.findNode("contentScreen")
  m.detailsScreen = m.top.findNode("detailsScreen")
  m.videoplayer = m.top.findNode("videoplayer")
	initializeVideoPlayer()

  m.categoryScreen.observeField("categorySelected", "onCategorySelected")
  m.contentScreen.observeField("contentSelected","onContentSelected")
  m.detailsScreen.observeField("playButtonPressed", "onPlayButtonPressed")

  m.categoryScreen.setFocus(true)
end function

sub initializeVideoPlayer()
	m.videoplayer.EnableCookies()
	m.videoplayer.setCertificatesFile("common:/certs/ca-bundle.crt")
	m.videoplayer.InitClientCertificates()
  m.videoplayer.notificationInterval=1
	m.videoplayer.observeFieldScoped("position", "onPlayerPositionChanged")
	m.videoplayer.observeFieldScoped("state", "onPlayerStateChanged")
end sub

sub onPlayerPositionChanged(obj)
	? "Player Position: ", obj.getData()
end sub

sub onPlayerStateChanged(obj)
state = obj.getData()
? "onPlayerStateChanged: ";state
if state="error"
		? "Error Message: ";m.videoplayer.errorMsg
		? "Error Code: ";m.videoplayer.errorCode
	else if state = "finished"
		closeVideo()
	end if
end sub

sub closeVideo()
	m.videoplayer.control = "stop"
	m.videoplayer.visible=false
	m.detailsScreen.visible=true
end sub

sub onPlayButtonPressed(obj)
	m.detailsScreen.visible = false
	m.videoplayer.visible = true
	m.videoplayer.setFocus(true)
	m.videoplayer.content = m.selectedMedia
	m.videoplayer.control = "play"
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

sub loadFeed(url)
  ' create a task
  m.feedTask = createObject("roSGNode", "LoadFeedTask")
  m.feedTask.observeField("response", "onFeedResponse")
  m.feedTask.url = url
  'tasks have a control field with specific values
  m.feedTask.control = "RUN"
end sub

sub onFeedResponse(obj)
  response = obj.getData()
  'turn the JSON string into an Associative Array
  data = parseJSON(response)
  if data <> invalid and data.results <> invalid
    'hide the category screen and show content screen
    m.categoryScreen.visible = false
    m.contentScreen.visible = true

    ' assign data to content screen
    m.contentScreen.feedData = data
  else
    ? "FEED RESPONSE IS EMPTY!"
  end if
end sub


' Main Remote keypress handler
function onKeyEvent(key, press) as boolean
  ? "[HomeScene] onKeyEvent", key, press
  if key = "back" and press then
    if m.contentScreen.visible = true then
      m.contentScreen.visible = false
      m.categoryScreen.visible = true
      m.categoryScreen.setFocus(true)
      return true
    else if m.detailsScreen.visible then
      m.detailsScreen.visible=false
      m.contentScreen.visible=true
      m.contentScreen.setFocus(true)
      return true
    else if m.videoplayer.visible then
      m.videoplayer.visible=false
      m.detailsScreen.visible=true
      m.detailsScreen.setFocus(true)
      return true
    end if
  end if
  return false
end function
