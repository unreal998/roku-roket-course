function init()
  m.categoryList = m.top.findNode("categoryList")
	m.categoryList.setFocus(true)
	m.top.observeField("visible", "onVisibleChange")
end function

' set proper focus to rowList in case if return from Details Screen
sub onVisibleChange()
  if m.top.visible = true then
    m.categoryList.setFocus(true)
  end if
end sub

function updateConfig(params)
	categories = params.config.categories
	contentNode = createObject("roSGNode","ContentNode")
  for each category in categories
    node = createObject("roSGNode","CategoryNode")
    node.title = category.title
    node.feedUrl = params.config.host + category.feedUrl
    contentNode.appendChild(node)
  end for
	m.categoryList.content = contentNode
end function
