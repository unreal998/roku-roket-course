sub init()
    m.itemPoster = m.top.findNode("itemPoster")
    m.itemMovieTitle = m.top.findNode("movieTitle")
    m.itemmask = m.top.findNode("itemMask")
    m.itemLabel = m.top.findNode("itemlabel")
    m.itemDescription = m.top.findNode("movieDescription")
end sub

sub showContent ()
? "showContent"
itemContent = m.top.itemContent
m.itemposter.uri = itemcontent.HDGRIDPOSTERURL
m.itemlabel.text = itemcontent.SHORTDESCRIPTIONLINE2
m.itemMovieTitle.text = itemContent.SHORTDESCRIPTIONLINE1
m.itemDescription.text = itemContent.description
end sub

sub showFocus ()
    scale = 1+(m.top.focusPercent * 0.1)
    m.itemposter.scale = [scale, scale]
    
end sub

sub showrowfocus ()
    m.itemmask.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
    m.itemlabel.opacity = m.top.fowFocusPercent
   
end sub 

sub focusChanged()
    if m.top.itemHasFocus
        m.itemDescription.visible = true
        m.itemMovieTitle.visible = true
    else 
        m.itemDescription.visible = false
        m.itemMovieTitle.visible = false
    end if 
end sub