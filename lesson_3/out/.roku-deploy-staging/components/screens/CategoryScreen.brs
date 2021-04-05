function init()
    m.categoryList = m.top.findNode("categoryList")
    m.categoryList.setFocus(true)
    m.categoryList.vertFocusAnimationStyle = "floatingFocus"
    m.categoryList.observeField("itemSelected", "onCategorySelected")
end function

sub onCategorySelected(obj)
    ? "onCategorySelected field: ";obj.getField()
    ? "onCategorySelected data: ";obj.getData()
    ? "onCategorySelected checkedItem: ";m.categoryList.checkedItem
    ? "onCategorySelected selected ContentNode: ";m.categoryList.content.getChild(obj.getData())
    item = m.categoryList.content.getChild(obj.getData())
    loadFeed(item.feedUrl)
end sub

sub loadFeed(url)
  m.feedTask = createObject("roSGNode", "LoadFeedTask")
  m.feedTask.observeField("response", "onFeedResponse")
  m.feedTask.url = url
  m.feedTask.control = "RUN"
end sub

sub onFeedResponse(obj)
  ? "onFeedResponse: "; obj.getData()
end sub
