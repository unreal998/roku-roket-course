sub init()
	m.contentGrid = m.top.FindNode("markupgrid")
	m.header = m.top.FindNode("header")
  m.top.observeField("visible","onVisibleChange")
end sub

sub onVisibleChange()
  if m.top.visible then m.contentGrid.setFocus(true)
end sub

sub onScreenTitleUpdate()
  m.header.text = m.top.selectedCategory
end sub

sub onFeedChanged(obj)
	feed = obj.getData()
  ? "ON Feed changed! ", feed
	
  postercontent = createObject("roSGNode","ContentNode")
  'find the host value in the thumbnail url, will be replaced with the m.host value
  regex = createObject("roRegEx", "http://[a-z0-9.:]+", "i")
  
  for each item in feed.results
    node = createObject("roSGNode","ContentGridItemData")
    ?"Item content "item
    parsedItem=parseData(item)
    node.streamformat = "dash"
    node.url = "https://vod-sinclairdivamseastusdev-usea.streaming.media.azure.net/4ee0e52d-0b97-408c-8001-7a179fa550d2/b1b3d9c20cf84fdd972efc609b6d7cd7.ism/manifest(format=mpd-time-csf)"
    node.title = parsedItem.title
    node.description = parsedItem.overview
    node.movieId = parsedItem.id
    node.lang = parsedItem.originalLanguage
    node.rating = parsedItem.voteAverage
    node.year = parsedItem.year
    node.HDPOSTERURL = parsedItem.HDPOSTERURL
    node.FHDPosterUrl = parsedItem.FHDPOSTERURL
    node.SHORTDESCRIPTIONLINE1 = parsedItem.title
    postercontent.appendChild(node)
  end for
  showpostergrid(postercontent)
end sub

function addCorrectPath (path as string) as string
    return "https://image.tmdb.org/t/p/w300" + path
end function

function addCorrectPathforDetails (path as string) as string
    return "https://image.tmdb.org/t/p/w500" + path
end function

sub showpostergrid(content)
	m.contentGrid.content=content
	m.contentGrid.visible=true
	m.contentGrid.setFocus(true)
end sub

function updateConfig(params)
	m.host = params.config.host
end function

function parseData(data as object) as object
  item = {}
  if (data.title <> invalid)
    item.title = data.title
  else 
    item.title = ""
  end if

  if(data.originalLanguage <> invalid) then item.originalLanguage = data.originalLanguage

  if(data.overview <> invalid) then item.overview = data.overview

  if(data.id <> invalid and data.id > 0) then item.id = data.id

  if(data.voteAverage <> invalid) then item.voteAverage = data.voteAverage.toStr()

  if(data.releaseDate <> invalid and data.releaseDate.Len() > 0) then item.year = Left(data.releaseDate,4)

  if(data.posterPath <> invalid and data.posterPath.Len() > 0)
    item.HDPOSTERURL = addCorrectPath(data.posterPath)
    item.FHDPOSTERURL = addCorrectPathforDetails(data.posterPath)
  end if

  return item
end function