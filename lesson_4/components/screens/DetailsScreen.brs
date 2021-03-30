sub init()
    m.title=m.top.findNode("title")
    m.description = m.top.findNode("description")
    m.thumbnail = m.top.findNode("thumbnail")
    m.releaseDate = m.top.findNode("releaseDate")
    m.rating = m.top.findNode("rating")
    m.playButton= m.top.findNode("playButton")
    m.top.observeField("visible","onVisibleChange")
    m.playButton.setFocus(true)
end sub

sub onVisibleChange()
    if m.top.visible = true then
        m.playButton.setFocus(true)
    end if
end sub

sub OnContentChange (obj)
    item = obj.getData()
    m.top.content = item
    m.title.text = item.title
    m.description.text = item.description
    m.thumbnail.uri = item.HDGRIDPOSTERURL
    m.releaseDate.text = "Relaese Date: " + item.releaseDate
    m.rating.text = "Vote Avarage: "+ item.rating
end sub
