


sub init()
  m.title = m.top.FindNode("title")
  m.description = m.top.FindNode("description")
  m.thumbnail = m.top.FindNode("thumbnail")
  m.relisedLabel = m.top.FindNode("relisedate")
  m.taglineLabel = m.top.findNode("tagline")
  m.producedLabel = m.top.findNode("produced")
  m.durationLabel = m.top.findNode("runtime")
  m.ratingLabel = m.top.findNode("rating")
  m.playButton = m.top.FindNode("playButton")
  m.additionalinfo = m.top.findNode("additionalInfo")
  m.top.observeField("visible", "onVisibleChange")
  m.playButton.setFocus(true)
end sub

' set proper focus to rowList in case if return from Details Screen
sub onVisibleChange()
  if m.top.visible = true then
    m.playButton.setFocus(true)
  end if
end sub

sub OnContentChange(obj)
  item = obj.getData()
  ?"Item " item
  m.title.text = item.title
  m.description.text = item.description
  m.thumbnail.uri = item.FHDPOSTERURL
  m.additionalInfo.visible = false
end sub

sub onAdditional(obj)
  data = obj.getData()
  companies =""
  for each item in data.productionCompanies
    companies = companies + item.name +", "
  end for
  m.producedLabel.text = "Relised by: " + companies
  m.durationLabel.text = "Duration: " + data.runtime.toStr() + " mins"
  if (data.tagline <> invalid and data.tagline <> "")
    m.taglineLabel.text = "Tagline: " + data.tagline
    m.taglineLabel.visible = true
  else 
    m.taglineLabel.visible = false
  end if
  m.relisedLabel.text = "Relised: " + data.releaseDate
  m.ratingLabel.text = "Rating: " + data.voteAverage.toStr()
  m.additionalInfo.visible = true
end sub