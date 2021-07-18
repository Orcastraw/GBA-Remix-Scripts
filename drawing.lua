client.SetGameExtraPadding(60,30,59,10)
--client.SetClientExtraPadding(690,320,70,21)
--69 Left
--32 Top
--70 Right
--21 Bottom

function mainOverlay()
	gui.drawImage("Overlay.png",0,0)
	--gui.drawImage("b.png",190,-5) --bunger
	--gui.drawImage("highResImage.jpg",0,0,nil,nil,true,"client")
end

if gameinfo.getromname() ~= "Harvest Moon - Friends of Mineral Town (USA)" then
	--mainOverlay()
end




function titleCard(selector, tPos, text)
	if tPos == "Center" then
		textX = 186
		textY = 95
		gui.drawRectangle(0,89,400,40,0xC0000E60,0xC0000E60)
		useColor = white
	end
	if tPos == "Top" then
		textX = 186
		textY = -2
		useColor = 0xFF8f3adb
	end

	gui.drawText(textX,textY,text,useColor,nil,18,"Archivo Narrow","Bold","center")

	if selector == 0 then
		gui.drawText(178,96,"Success!",nil,nil,24,"Calamity",nil,"center")
	end
	if selector == 200 then
		gui.drawText(178,96,"Falure!",nil,nil,24,"Calamity",nil,"center")
	end
	if selector == 111 then
		--gui.drawText(textX,textY,"Grab all the coins!",useColor,nil,19,"Archivo Narrow","Bold","center")
	end
	if selector == 1 then
		--gui.drawText(textX,textY,"Get to the bottom, without hitting pink blocks!",useColor,nil,19,"Archivo Narrow","Bold","center")
	end
	--gui.createcanvas(100,100)
end

if gameinfo.getromname() ~= "Harvest Moon - Friends of Mineral Town (USA)" then
	--mainOverlay()
end

if gameinfo.getromname() == "Super Mario Advance 3 - Yoshi's Island (USA)" then
	titleCard()
end

--scrapped function to display level name
function levName(currentGame, levelNumber)
	if currentGame+0 == 2 then
		lev = "M"
	end
	if currentGame+0 == 1 then
		lev = "D"
	end
	gui.drawText(78,96,lev,nil,nil,24,"Calamity",nil,"center")
end

function OSD(valueForOSD)
	gui.drawText(78,96,valueForOSD,nil,nil,24,"Calamity",nil,"center")
end