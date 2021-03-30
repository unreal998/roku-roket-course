sub init()
  'm.top.id = "contentmakupgriditem"
  m.image = m.top.findNode("image") 
  m.titleLabel = m.top.findNode("title") 
  m.yearLabel = m.top.findNode("year") 
  m.ratingLabel = m.top.findNode("rating") 
  m.langLabel = m.top.findNode("lang")
  m.movieId = ""
end sub

sub showcontent()
  itemcontent = m.top.itemContent
  m.image.uri = itemcontent.hdposterurl
  m.titleLabel.text = itemContent.title 
  m.yearLabel.text = itemContent.year
  m.ratingLabel.text = itemContent.rating
  m.langLabel.text = itemContent.lang
  m.movieId = itemContent.movieid
end sub