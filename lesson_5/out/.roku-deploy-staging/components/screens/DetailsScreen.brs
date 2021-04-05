sub init()
	m.title = m.top.FindNode("title")
	m.description = m.top.FindNode("description")
	m.thumbnail = m.top.FindNode("thumbnail")
	m.playButton = m.top.FindNode("playButton")
	m.top.observeField("visible", "onVisibleChange")
	m.playButton.setFocus(true)
end sub

' set proper focus to button in case if return from Video Screen
sub onVisibleChange()
	if m.top.visible = true then
		m.playButton.setFocus(true)
	end if
end sub

sub OnContentChange(obj)
	item = obj.getData()
	? item
	m.title.text = item.title
	m.description.text = item.description
	m.thumbnail.uri = item.HDGRIDPOSTERURL
end sub
