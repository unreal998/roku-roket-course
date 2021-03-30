sub init()
        m.top.observeField("focusedChild", "focusedChildChanged")
	      m.hadFocus = false
        m.currTargetSetIndex = 0
        m.currItemIndex = 0
	      m.top.wrap = true
        m.keypressed = "none"
	      m.top.observeField("itemFocused", "itemFocusedChanged")
    end sub

function focusedChildChanged()
    hasFocus = m.top.hasFocus()
    print m.top.id " focusedChildChanged to "; hasFocus; " hadFocus "; m.hadFocus
    if (m.hadFocus and not hasFocus)
        m.hadFocus = false
        if not m.top.targetSet.isSameNode(m.top.unfocusedTargetSet)
            m.top.animateToTargetSet = m.top.unfocusedTargetSet
        end if
    else if (not m.hadFocus and hasFocus)
        m.hadFocus = true
        if not m.top.targetSet.isSameNode(m.top.focusedTargetSet)
            m.top.animateToTargetSet = m.top.focusedTargetSet[m.currTargetSetIndex]
        end if
    end if
end function

function advance()
    m.top.advancing = true
	m.currItemIndex = m.currItemIndex + 1
    if m.currItemIndex >= m.top.content.getChildCount()
        m.currItemIndex = m.currItemIndex - m.top.content.getChildCount()
    end if
    print "right key currItemIndex is "; m.currItemIndex
    if m.currTargetSetIndex < m.top.focusedTargetSet.count() - 1
        print "animating target set from ";m.currTargetSetIndex;" to ";m.currTargetSetIndex + 1
        m.currTargetSetIndex = m.currTargetSetIndex + 1
        m.top.animateToTargetSet = m.top.focusedTargetSet[m.currTargetSetIndex]
    else
        print "animating just the items"
    end if
        m.top.animateToItem = m.currItemIndex
    end function

function reverse()
    m.top.reversing = true
    m.currItemIndex = m.currItemIndex - 1
    if m.currItemIndex < 0
        m.currItemIndex = m.currItemIndex + m.top.content.getChildCount()
    end if
    print "left key currItemIndex is "; m.currItemIndex
    if m.currTargetSetIndex > 0
        print "animating target set from ";m.currTargetSetIndex;" to ";m.currTargetSetIndex - 1
        m.currTargetSetIndex = m.currTargetSetIndex - 1
        m.top.animateToTargetSet = m.top.focusedTargetSet[m.currTargetSetIndex]
    else
        print "animating just the items"
    end if
    m.top.animateToItem = m.currItemIndex
end function

function itemFocusedChanged()
    if m.keypressed = "left"
	    reverse()
    else if m.keypressed = "right"
        advance()
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if key = "left"
        if press
            m.keypressed = "left"
            reverse()
        else
            m.keypressed = "none"
            m.top.reversing = false
        end if
        handled = true
    end if
    if key = "right"
        if press
            m.keypressed = "right"
            advance()
        else
            m.keypressed = "none"
            m.top.advancing = false
        end if
        handled = true
    end if
    return handled
end function
