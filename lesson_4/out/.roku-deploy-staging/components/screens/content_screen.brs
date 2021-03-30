sub init()
    ? "-----[ContentScreen] init "
    m.contentGrid = m.top.FindNode("contentGrid")
    m.header = m.top.FindNode("header")
    m.dialog = m.top.FindNode("infoDialog")
    m.darker = m.top.FindNode("darker")
    m.logo = m.top.findNode("logo")
    m.darker.setFields(getConfig())
    m.selectedItem = -1
    m.contentGrid.observeField("itemSelected","onItemSelected")
    m.top.observeField("visible", "onVisibleChange")

    tList = m.top.findNode("tList")
	      m.tList = tList


    m.rowlist = m.top.findNode("rowList")
    focusedTargetSet1 = createObject("roSGNode", "TargetSet")
    m.rowlist.focusedTargetSet = [ focusedTargetSet1 ]
    
    m.rowList.setFocus(true)
end sub

sub onVisibleChange ()
    if m.top.visible = true then
        m.contentGrid.setFocus(true)
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
			subsubNode.HDGRIDPOSTERURL  = addCorrectPath(item.posterPath)
			subsubNode.SDGRIDPOSTERURL = addCorrectPath(item.posterPath)
			subsubNode.title = item.title
			subNode.appendChild(subsubNode)
		end for
		node.appendChild(subNode)
	return node
end function

sub showPosterGrid(content)
    ? "showPosterGrid"
    m.contentGrid.content=content
    m.contentGrid.visible=true
    m.contentGrid.setFocus(true)
end sub

sub showRowList(content)
    ?"Content rowList "content.getChild(0)
    m.rowlist.content = content
    'm.rowlist.content = createObject("roSGNode","RowListContent")
	'showDialog("Title", "32.13.15")
end sub

function addCorrectPath (path as string) as string
    return "https://image.tmdb.org/t/p/w300" + path
end function

sub showDialog (movieTitle, releaseDate)
    m.darker.visible = true
    m.dialog.title=movieTitle
    m.dialog.message = "Release date: " + releaseDate
    m.dialog.visible = true
    m.dialog.buttons = ["OK"]
    m.dialog.observeField("buttonSelected", "cb")
    m.top.dialog = m.dialog
    m.dialog.setFocus(true)
end sub

sub cb()
    if m.dialog.buttonSelected = 0 then
        closeDialog()
        m.contentGrid.visible=true
        m.contentGrid.setFocus(true)
    end if
end sub

sub closeDialog()
    m.dialog.visible=false
    m.darker.visible=false
end sub

sub onItemSelected ()
    ? "selected item" m.contentGrid.itemSelected
    m.selectedItem = m.contentGrid.itemSelected
    ? "Title items " m.feed.results[m.selectedItem].title ; " Release date   " m.feed.results[m.selectedItem].releaseDate
end sub

sub initTargetList ()
    focusedTargetSet1 = createObject("roSGNode", "TargetSet")
        focusedTargetSet2 = createObject("roSGNode", "TargetSet")
        focusedTargetSet3 = createObject("roSGNode", "TargetSet")
        focusedTargetSet4 = createObject("roSGNode", "TargetSet")
        focusedTargetSet5 = createObject("roSGNode", "TargetSet")
        m.tList.focusedTargetSet = [ focusedTargetSet1, focusedTargetSet2, focusedTargetSet3, focusedTargetSet4, focusedTargetSet5 ]

        focusedTargetSet1.targetRects = [
	                          { x:-192, y:-64, width:100, height:128 },
	                          { x:-192, y:-64, width:100, height:128 },
        	                  { x:-192,  y:-90,  width:144, height:180 },
	                          { x:-192,  y:-125,  width:200, height:250 },
	                          { x:28,  y:-188,   width:300, height:376 }, ' focus
	                          { x:348,  y:-125,  width:200, height:250 },
        	                  { x:568,  y:-90,  width:144, height:180 },
	                          { x:732, y:-64, width:100, height:128 },
	                          { x:852, y:-64, width:100, height:128 },
	                          { x:972, y:-64, width:100, height:128 },
	                          { x:1092, y:-64, width:100, height:128 },
	                          { x:1212, y:-64, width:100, height:128 },
	                          { x:1332, y:-64, width:100, height:128 }
				  ]
        focusedTargetSet1.focusIndex = 4
	      focusedTargetSet1.color = "0x00202020AA"

        focusedTargetSet2.targetRects = [
	                          { x:-164, y:-64, width:100, height:128 },
	                          { x:-164, y:-64, width:100, height:128 },
	                          { x:-164, y:-64, width:100, height:128 },
        	                  { x:-164,  y:-90,  width:144, height:180 },
	                          { x:0,  y:-125,  width:200, height:250 },
	                          { x:220,  y:-188,   width:300, height:376 }, ' focus
	                          { x:540,  y:-125,  width:200, height:250 },
     	                          { x:760, y:-90,  width:144, height:180 },
	                          { x:924, y:-64, width:100, height:128 },
	                          { x:1044, y:-64, width:100, height:128 },
	                          { x:1164, y:-64, width:100, height:128 },
	                          { x:1284, y:-64, width:100, height:128 },
	                          { x:1404,  y:-64, width:100, height:128 }
				  ]
        focusedTargetSet2.focusIndex = 5
	      focusedTargetSet2.color = "0x00202020AA"

        focusedTargetSet3.targetRects = [
	                          { x:-134, y:-64, width:100, height:128 },
	                          { x:-134, y:-64, width:100, height:128 },
	                          { x:-134, y:-64, width:100, height:128 },
	                          { x:-14,  y:-64, width:100, height:128 },
        	                  { x:106,  y:-90,  width:144, height:180 },
	                          { x:270,  y:-125,  width:200, height:250 },
	                          { x:490,  y:-188,   width:300, height:376 }, ' focus
	                          { x:810,  y:-125,  width:200, height:250 },
     	                          { x:1030, y:-90,  width:144, height:180 },
	                          { x:1194, y:-64, width:100, height:128 },
	                          { x:1314, y:-64, width:100, height:128 },
	                          { x:1314, y:-64, width:100, height:128 },
	                          { x:1314, y:-64, width:100, height:128 }
				  ]
        focusedTargetSet3.focusIndex = 6
	      focusedTargetSet3.color = "0x00202020AA"

        focusedTargetSet4.targetRects = [
	                          { x:-204, y:-64, width:100, height:128 }
	                          { x:-204, y:-64, width:100, height:128 },
	                          { x:16, y:-64, width:100, height:128 },
	                          { x:136, y:-64, width:100, height:128 },
	                          { x:256,  y:-64, width:100, height:128 },
        	                  { x:376,  y:-90,  width:144, height:180 },
	                          { x:540,  y:-125,  width:200, height:250 },
	                          { x:760,  y:-188,   width:300, height:376 }, ' focus
	                          { x:1080,  y:-125,  width:200, height:250 },
     	                          { x:1300, y:-90,  width:144, height:180 },
	                          { x:1464, y:-64, width:100, height:128 },
	                          { x:1584, y:-64, width:100, height:128 },
	                          { x:1704, y:-64, width:100, height:128 },
				  ]
        focusedTargetSet4.focusIndex = 7
	      focusedTargetSet4.color = "0x00202020AA"

        focusedTargetSet5.targetRects = [
	                          { x:-152, y:-64, width:100, height:128 },
	                          { x:-32, y:-64, width:100, height:128 }
	                          { x:88, y:-64, width:100, height:128 },
	                          { x:208, y:-64, width:100, height:128 },
	                          { x:328, y:-64, width:100, height:128 },
	                          { x:448,  y:-64, width:100, height:128 },
        	                  { x:568,  y:-90,  width:144, height:180 },
	                          { x:732,  y:-125,  width:200, height:250 },
	                          { x:952,  y:-188,   width:300, height:376 }, ' focus
	                          { x:1272,  y:-125,  width:200, height:250 },
     	                          { x:1272, y:-90,  width:144, height:180 },
	                          { x:1272, y:-64, width:100, height:128 },
	                          { x:1272, y:-64, width:100, height:128 },
				  ]
        focusedTargetSet5.focusIndex = 8
	      focusedTargetSet5.color = "0x00202020AA"

        unfocusedTargetSet = createObject("roSGNode", "TargetSet")
        m.tList.unfocusedTargetSet = unfocusedtargetSet

        unfocusedTargetSet.targetRects = [
	                          { x:-130, y:-64, width:100, height:128 },
	                          { x:-10, y:-64, width:100, height:128 },
	                          { x:110, y:-64, width:100, height:128 },
	                          { x:230,  y:-64, width:100, height:128 },
        	                  { x:350,  y:-64,  width:100, height:128 },
	                          { x:470,  y:-64,  width:100, height:128 },
	                          { x:590,  y:-64, width:100, height:128 }, ' focus
	                          { x:710,  y:-64,  width:100, height:128 },
     	                          { x:830,  y:-64,  width:100, height:128 },
	                          { x:950,  y:-64, width:100, height:128 },
	                          { x:1070, y:-64, width:100, height:128 },
	                          { x:1190, y:-64, width:100, height:128 },
	                          { x:1310, y:-64, width:100, height:128 }
				  ]
        unfocusedTargetSet.focusIndex = 6    ' should not matter?
	      unfocusedTargetSet.color = "0x00202020AA"

        tList.targetSet = m.tList.focusedTargetSet[0]
        tList.showTargetRects = true
	      tList.itemComponentName = "SimpleItemComponent"


end sub 