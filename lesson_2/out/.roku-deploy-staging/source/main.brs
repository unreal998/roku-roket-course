sub Main()
	showChannel()
end sub

sub showChannel ()
	screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("HomeScene")
    screen.show()
	'this loop is necessary to keep the application open
	'otherwise the channel will exit when it reaches the end of main()
  while(true)
		' nothing happens in here, yet
		' the HOME and BACK buttons on the remote will nuke the app
		msg = wait(0, m.port)
		msgType = type(msg)
				if msgType = "roSGScreenEvent"
						if msg.isScreenClosed() then return
				end if
  end while
end sub
