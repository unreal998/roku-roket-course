function init()
  m.categoryList = m.top.findNode("categoryList")
  m.categoryList.setFocus(true)
  m.top.observeField("visible", "onVisibleChange")
  m.categoryList.vertFocusAnimationStyle = "floatingFocus"
end function

sub onVisibleChange()
if m.top.visible = true then
  m.categoryList.setFocus(true)
end if
end sub
