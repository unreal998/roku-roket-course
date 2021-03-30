    function init()
        m.theRect  = m.top.findNode("theRect")
        m.theLabel = m.top.findNode("theLabel")
        m.focusColorInterp = m.top.findNode("focusColorInterp")
        m.focusColorInterp.fieldToInterp = "theRect.color"
    end function

    function itemContentChanged()
        m.theLabel.text = m.top.itemContent.title
    end function

    function currRectChanged()
	      m.theRect.width       = m.top.currRect.width
	      m.theRect.height      = m.top.currRect.height
    end function

    function focusPercentChanged()
        if (m.top.groupHasFocus)
            m.focusColorInterp.fraction = m.top.focusPercent
        else
            m.focusColorInterp.fraction = 0
        end if
    end function