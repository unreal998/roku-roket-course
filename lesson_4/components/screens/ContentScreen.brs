sub init()
    ? "-----[ContentScreen] init "
    m.header = m.top.FindNode("header")
    m.darker = m.top.FindNode("darker")
    m.logo = m.top.findNode("logo")
    m.darker.setFields(getConfig())
    m.selectedItem = -1
    m.top.observeField("visible", "onVisibleChange")

    m.rowlist = m.top.findNode("rowList")
	m.rowlist.observeField("itemSelected", "onItemSelected")
    
    m.rowList.setFocus(true)
end sub

sub onVisibleChange ()
    if m.top.visible = true then
        m.rowlist.setFocus(true)
    end if

end sub

sub onFeedChanged(obj)
    ? "onFeedChanged ContentScreen"
    m.feed = obj.getData()
    m.header.text = "rowList example"
    showRowList(getRowListContentNode(m.feed.results))
end sub

function getRowListContentNode(items)
	node = createObject("roSGNode","ContentNode")
    node.streamformat = "mp4"
	subNode = createObject("roSGNode","ContentNode")
    subNode.title = "Popular Films"
		for each item in items
			subsubNode = createObject("roSGNode","ContentNode")
			if (item <> Invalid AND item.poster_path <> Invalid)
				subsubNode.HDGRIDPOSTERURL  = addCorrectPath(item.poster_path)
				subsubNode.SDGRIDPOSTERURL = addCorrectPath(item.poster_path)
			end if
			node.SHORTDESCRIPTIONLINE1 = item.title
            node.SHORTDESCRIPTIONLINE2 = item.description
			subsubNode.title = item.title
			subNode.appendChild(subsubNode)
		end for
		node.appendChild(subNode)
	return node
end function

sub showRowList(content)
    ?"Content rowList "content.getChild(0)
    m.rowlist.content = content
end sub

function addCorrectPath (path as string) as string
	if (path <> invalid)
		return "https://image.tmdb.org/t/p/w300" + path
	end if	
end function

sub onItemSelected ()
    ? "selected item" m.rowList.itemSelected
    m.selectedItem = m.rowList.rowItemSelected[1]
    ? "Title items " m.feed.results[m.selectedItem].title ; " Release date   " m.feed.results[m.selectedItem].releaseDate
end sub