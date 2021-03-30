function init()
    m.categoryList=m.top.findNode("categoryList")
    m.categoryList.setFocus(true)
	m.top.observeField("visible", "onVisibleChange")
end function

' set proper focus to rowList in case if return from Content Screen
sub onVisibleChange()
	if m.top.visible = true then
		m.categoryList.setFocus(true)
	end if
end sub
