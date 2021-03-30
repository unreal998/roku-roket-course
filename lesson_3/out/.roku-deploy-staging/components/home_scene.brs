function init()
	? "[HomeScene] init"
	m.categoryScreen = m.top.findNode("categoryScreen")
	m.categoryScreen.setFocus(true)
end function

' Main Remote keypress handler
function onKeyEvent(key, press) as Boolean
	? "[HomeScene] onKeyEvent", key, press
  return false
end function
