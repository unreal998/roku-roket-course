function init()
  ? "----[HomeScene] init"
  m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"
  m.categoryScreen = m.top.findNode("categoryScreen")
  m.contentScreen = m.top.findNode("contentScreen")

  m.categoryScreen.observeField("categorySelected", "onCategorySelected")

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
