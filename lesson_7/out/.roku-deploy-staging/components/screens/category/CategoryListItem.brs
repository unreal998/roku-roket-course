function itemContentChanged() 
    itemData = m.top.itemContent
    m.itemText.text = itemData.labelText
    m.feedUrl = itemData.feedUrl

  end function
  
  function init() 
    m.itemText = m.top.findNode("itemText")
    m.feedUrl ="" 
  end function