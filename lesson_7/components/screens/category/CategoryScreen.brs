function init()
    ?"INIT CAT SCR"
    m.simpleMarkupList = m.top.findNode("CategoryMarkupList")
    
	m.simpleMarkupList.SetFocus(true)
    m.simpleMarkupList.ObserveField("itemSelected","onItemSelected")
    m.top.ObserveField("visible","onVisibleChange")
end function

function onItemSelected(obj) as void
    ?"CAT "m.simpleMarkupList.content.getChild(obj.getData())
    item = m.simpleMarkupList.content.getChild(obj.getData())
    selected = {}
    selected.feedUrl = item.feedUrl
    selected.text = item.labelText
    m.top.selectedCategory = selected
end function

sub onVisibleChange()
  if m.top.visible then m.simpleMarkupList.setFocus(true)
end sub

function updateConfig(params)
	categories = params.config.categories
	contentNode = createObject("roSGNode","ContentNode")
  for each category in categories
    node = createObject("roSGNode","CategoryListItemData")
    node.labelText = category.title
    node.feedUrl = params.config.host + category.feedUrl
    contentNode.appendChild(node)
  end for
	m.simpleMarkupList.content = contentNode
end function