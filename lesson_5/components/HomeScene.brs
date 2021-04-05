function init()
	? "[HomeScene] init"
	m.categoryScreen = m.top.findNode("categoryScreen")
	m.contentScreen = m.top.findNode("contentScreen")
	m.detailsScreen = m.top.findNode("detailsScreen")
	m.videoplayer = m.top.findNode("videoplayer")

	m.categoryScreen.observeField("categorySelected", "onCategorySelected")
	m.contentScreen.observeField("contentSelected", "onContentSelected")
	m.detailsScreen.observeField("playButtonPressed", "onPlayButtonPressed")

	m.categoryScreen.setFocus(true)
end function

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
	' note that you do NOT get the content node you want, just an index.
	selectedIndex = obj.getData()
	rowList = m.contentScreen.findNode("rowList")
	rowListContent = rowList.content.getChild(0).getChild(selectedIndex)
	m.detailsScreen.content = rowListContent
	m.contentScreen.visible = false
	m.detailsScreen.visible = true
end sub

sub onPlayButtonPressed(obj)
	m.detailsScreen.visible = false
	m.videoplayer.visible = true
	m.videoplayer.setFocus(true)
end sub

sub loadFeed(url)
  m.feedTask = createObject("roSGNode", "LoadFeedTask")
  m.feedTask.observeField("response", "onFeedResponse")
  m.feedTask.url = url
  m.feedTask.control = "RUN"
end sub

sub onFeedResponse(obj)
	response = obj.getData()
	'turn the JSON string into an Associative Array
	data = parseJSON(response)
	if data <> Invalid and data.results <> invalid
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
function onKeyEvent(key, press) as Boolean
	? "[HomeScene] onKeyEvent", key, press
	' we must capture the 'true' for press, it comes first (true=down,false=up) to keep the firmware from handling the event
	if key = "back" and press
		if m.contentScreen.visible
			m.contentScreen.visible=false
			m.categoryScreen.visible=true
			m.categoryScreen.setFocus(true)
			return true
		else if m.detailsScreen.visible
			m.detailsScreen.visible=false
			m.contentScreen.visible=true
			m.contentScreen.setFocus(true)
			return true
		else if m.videoplayer.visible
			m.videoplayer.visible=false
			m.detailsScreen.visible=true
			m.detailsScreen.setFocus(true)
			return true
		end if
	end if
  return false
end function
