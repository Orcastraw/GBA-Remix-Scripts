savestate.loadslot(1)
start = emu.framecount()
fin = start+120
console.log("moo2")


while true do
	memory.usememorydomain("EWRAM")
	XPos = memory.read_u16_le(0x020650)
	YPos = memory.read_u16_le(0x020652)
	targetX = 120
	targetY = 112
	gui.clearGraphics()
	gui.drawRectangle(0,66,270,30,0xC0000E60,0xC0000E60)
	gui.drawText(46,71,"Enter a house!",nil,nil,20,"Calamity")


	if emu.framecount() > fin then
		gui.clearGraphics()
	end


	if XPos == targetX and YPos == targetY then
		start2 = emu.framecount()
		fin2 = start2+90
		while true do
			if emu.framecount() > fin2 then
			gui.drawRectangle(0,66,270,30,0xC0000E60,0xC0000E60)
			gui.drawText(76,71,"Success!",nil,nil,20,"Calamity")	
			savestate.loadslot(1)
			console.log("moo2")
			end
		emu.frameadvance()
		end

		
	end

	emu.frameadvance()

end

