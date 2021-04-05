function init()
    m.categoryList = m.top.findNode("categoryList")
    m.categoryList.setFocus(true)
    m.categoryList.vertFocusAnimationStyle = "floatingFocus"
    m.top.observeField("visible", "onVisibleChange")
end function

sub onVisibleChange ()
    if m.top.visible = true then
        m.categoryList.setFocus(true)
    end if
end sub
