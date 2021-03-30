sub init()
    m.contentGrid = m.top.FindNode("contentGrid")
    m.header = m.top.FindNode("header")
	m.top.observeField("visible", "onVisibleChange")
end sub

sub onFeedChanged(obj)
    feed = obj.getData()
    m.header.text = feed.title
    postercontent = createObject("roSGNode","ContentNode")
    for each item in feed.items
		node = createObject("roSGNode","ContentNode")
	    node.streamformat = item.streamformat
	    node.title = item.title
	    node.url = item.url
	    node.description = item.description
	    node.HDGRIDPOSTERURL = item.thumbnail
	    node.SHORTDESCRIPTIONLINE1 = item.title
		node.SHORTDESCRIPTIONLINE2 = item.description
	    postercontent.appendChild(node)
    end for
    showpostergrid(postercontent)
end sub

sub showpostergrid(content)
  m.contentGrid.content=content
  m.contentGrid.visible=true
  m.contentGrid.setFocus(true)
end sub

' set proper focus to contentGrid when we return from Details Screen
sub onVisibleChange()
	if m.top.visible = true then
		m.contentGrid.setFocus(true)
	end if
end sub