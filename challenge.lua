function gameMode(gameID, FedChaID)
	initiator = true
	client.SetSoundOn(true)
	console.log("here we are!")
	print("Finding challenge")

	list = io.open("chalList.txt","r"); 
	io.input(list)
	t = io.read("*all")
	io.close(list)
	lines = {}
	for s in t:gmatch("[^\r\n]+") do
    	table.insert(lines, s)
	end
	tempTab = {}
	finalTab = {}
	for e in ipairs(lines) do
		tempTab = {}
		for s in lines[e]:gmatch('([^/]+)') do
    		table.insert(tempTab, s)
		end
		table.insert(finalTab,tempTab)
	end
--Creates a table named finalTab which contains all of the challenges, along with their game index, 
-- challenge index, and text for display.


	for e in ipairs(finalTab) do
		if finalTab[e][1]+0 == gameID and finalTab[e][2]+0 == FedChaID then
			chaID = e
		end
	end
	print("Here is chaID")
	print(chaID)
--- Generates chaID, the challenges individual ID, which is derived from the row number the text is on.

	stateLoader(chaID)
	memory.usememorydomain("IWRAM")
	mainOverlay()
	titleCard(chaID,"Center",finalTab[chaID][3])
	waiter()
	titleCard(chaID,"Top",finalTab[chaID][3])
	tally=0



--housekeeping to make subsequent boots go to Home 
--(make a Value Changer Function & Program to import for easier less messy stuff)

		state5 = io.open("state.txt","w")
		io.output(state5)
		io.write(0)
		io.write("\n")
		io.write(priorChallenge)
		io.write("\n")
		io.write(0)
		io.write("\n")
		io.write(" ")
		io.close(state5)



--end housekeeping

--begin main loop--
	while initiator == true do
	memory.usememorydomain("IWRAM")
	reseter(chaID)
	winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = adrSetter(chaID)
	simpleChallenge(winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5,chaID)
	complexChallenge(chaID)
	mainOverlay(); titleCard(chaID, "Top",finalTab[chaID][3]); --lazy fix to accomodate that the reset code breaks UI currently
	client.SetSoundOn(true)
	memory.usememorydomain("IWRAM")
	emu.frameadvance()
	
	end
	while initiator == false do
		print("End of line")
		emu.frameadvance()
	end

--end main loop




end

function adrSetter(adrID)
	if adrID == 4 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 0
		adr3 = memory.readbyte(0x0000)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 5 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 0
		adr3 = memory.readbyte(0x11A5)
		failVal2 = 0
		adr4 = memory.readbyte(0x0000)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 6 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 0
		adr3 = memory.readbyte(0x11A5)
		failVal2 = 0
		adr4 = memory.readbyte(0x1273)
		winVal1 = 3
		adr1 = memory.readbyte(0x1634)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 9 or adrID== 12 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 1
		adr3 = memory.readbyte(0x1150)
		winVal1 = 100
		adr1 = memory.readbyte(0x113C)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 10 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 1
		adr3 = memory.readbyte(0x1150)
		winVal1 = 5
		adr1 = memory.readbyte(0x4B14)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 11 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 1
		adr3 = memory.readbyte(0x1150)
		--console.log("Air chal firing!")
		winVal2 = 40
		adr2 = memory.readbyte(0x114E)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 13 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 1
		adr3 = memory.readbyte(0x1150)
		--console.log("Air chal firing!")
		winVal2 = 50
		adr2 = memory.readbyte(0x114E)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	elseif adrID == 17 then
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		failVal1 = 1
		adr3 = memory.readbyte(0x1150)
		--console.log("Air chal firing!")
		winVal1 = 244
		adr1 = memory.readbyte(0x113C)
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	
	else 
		winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5 = 1,2,4,3,5,6,7,8,10,9
		--print("No written state!")
		return winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5
	end 
end

function simpleChallenge(winVal1, adr1, winVal2, adr2, failVal1, adr3, failVal2, adr4, failVal3, adr5,chaID)
	if winVal1 == adr1 or winVal2 <= adr2 then
		console.log("Success is real!")
		winner(0)
	end
	if failVal1 == adr3 or failVal2 == adr4 or failVal3 <= adr5 then
		print("Fail Condition Met")
		beginAnew(chaID)
	end
	--console.log(adr1)
	--console.log(winVal1)
end


function stateLoader(localID)
	--error handling
	if localID ~= nil then
console.log("Entering State Loader!")
	savestate.load("state/"..localID..".state")
	end
	
	--if localID == 1 then	
	--		savestate.loadslot(1)
	--end
	--if localID == 2 then	
	--		savestate.loadslot(2)
	--end
end

function reseter(chaID)
	if tostring(joypad.get()["Select"]) == "true" then
			client.openrom("titles/8Moogame.gba")
			emu.frameadvance()
	end
	if tostring(joypad.get()["Start"]) == "true" then
			beginAnew(chaID)
	end
end

function winner(drawName)
	if finalTab[chaID][4] == "true" then
			print("It wants to go again!")
			console.log("gonna change some files!)")
			state5 = io.open("state.txt","w")
			print(finalTab[chaID][1])
			io.output(state5)
			--Hardcoded value, row 1 and 2 should use chaID[1] and chaID[2] instead
			io.write(finalTab[chaID][1])
			io.write("\n")
			io.write(finalTab[chaID][2]+100)
			io.write("\n")
			io.write("2")
			io.write("\n")
			io.write(" ")
			io.close(state5)
			if finalTab[chaID][1]+0 == 2 then
				client.openrom("titles/minish.gba")
			end
			if finalTab[chaID][1]+0 == 1 then
				client.openrom("titles/drill.gba")
			end
			if finalTab[chaID][1]+0 == 3 then
				client.openrom("titles/marioGolf.gba")
			end
			if finalTab[chaID][1]+0 == 4 then
				client.openrom("titles/gunstar.gba")
			end
			if finalTab[chaID][1]+0 == 5 then
				client.openrom("titles/fzero.gba")
			end
			
			emu.frameadvance()
	end
	counter = emu.framecount()
	counterEnd = counter+45
	while true do
		emu.frameadvance()
		if counterEnd == emu.framecount() then
			break
		end
	end
	mainOverlay()
	titleCard(drawName,"Center")
	counter = emu.framecount()
	counterEnd = counter+4
	while true do
		emu.frameadvance()
		if counterEnd == emu.framecount() then
			client.SetSoundOn(false)
			client.sleep(1500)
			client.openrom("titles/8Moogame.gba")
		end
	end
end

function waiter()
	--client.pause()
	console.log("We're gonna Pause!")
	counter = emu.framecount()
	counterEnd = counter+2
	while true do
		emu.frameadvance()
		if counterEnd == emu.framecount() then
			client.sleep(1500)
			print("Percieved load achieved, pausing.")
			break
		end
		
	end
	client.unpause()
	--console.log("We're pausing!")

	gui.clearGraphics()
	mainOverlay()
end

function beginAnew(chaID)
	client.SetSoundOn(false)
	console.log("Welcome! To Reset time!")
	console.log("here is chaID")
	--initiator = false
	-- this is code to make things go out of the main loop upon failure
	
	--if emu.framecount() == target() then
		console.log(chaID)
	mainOverlay()
	titleCard(chaID,"Top")
	stateLoader(chaID)
	waiter()
	print("Waiter has fired.")
	--end

	
end

function complexChallenge(chaID)
	if chaID == 1 then
		drillDozer1(chaID)
	end
	if chaID == 2 then
		TodosAIR(chaID)
	end
	if chaID == 4 then
		grassCut(chaID)
	end
	if chaID == 5 then
		floorFriends(chaID)
	end
	if chaID == 7 then
		bubblePoppers()
	end
	if chaID == 8 then
		drillClearer(chaID)
	end
	if chaID == 14 then
		drillCombo(chaID)
	end
	if chaID == 15 then
		drillCombo2(chaID)
	end
	if chaID == 16 then
		boxBreaker(chaID)
	end
end



function drillDozer1(chaID)
	memory.write_u8(0x1151,3)
	if memory.readbyte(0x113c) == 100 then
		winner(0)
	end
	snack = chotto()
	if snack == "bunger" then
		--print("We're reading memory now!")
		e = memory.readbyterange(0x23C0,7952)
		for i, v in ipairs(e) do
      		if i % 32 then
      			if e[i] == 8 or e[i] == 9 then
      				f=i+14
      				if e[f] == 14 then
      					if memory.readbyte(0x1150) == 0 and memory.readbyte(0x113c) < 93 then
      					print("YOu broke a pink block!")
      					beginAnew(chaID)
      					return
      					end
      				end
      				
      			end
      	--print("Here is the block state for block ")
      	--print(i)
      	--print(e[i])
      		end
    	end
    --ipairs rundown: v = e[i]
	end

	
-- Every 16 steps in the table is a row. Every block on-screen is two rows. 
-- Each row begins with a value containing the state. The state defaults to 4
-- however, the state will change from 4 to 6 if broken in a combo.
-- The state will change from 4 to 9 if broken by the drill.
-- Additionally, pink blocks have an ID, on the 15th step. The ID is 14.
-- Build code to iterate every 32, grabbing the 1st value and 15th value, and check them each frame.
-- If a block at ID 14/0E contains a state ID higher than 6, aka, at 7, then it's been drilled into.
end

function chotto()
	tally = tally+1
-- this slows down beefy things to only happen every now and then (once a second)
-- a smarter person way to handle this would be to look into "couroutines"
	if tally % 10 == 0 then
		--tally=0
		--print(tally)
		return "bunger"
	--else
	--	return "not-bunger" 
	end
end


function grassCut(chaID)
	memory.write_u8(0x0B88,2)
	memory.write_u8(0x0B87, 2)
	snack = chotto()
	memory.usememorydomain("EWRAM")
	if snack == "bunger" then
		--print("We're reading memory now!")
		p=0
		e = memory.readbyterange(0x01F108,9514)
		for i, v in ipairs(e) do
      			if e[i] == 128 then
      				p=p+1
      			end
      			
    	end
    	if p > 327 then
    		print("It's all gone!!")
    		winner(0)

    	end
    	--print("Here's p!!", p)
	end
end

function floorFriends()
	if memory.readbyte(0x1EED) == 0 and memory.readbyte(0x1F75) == 0 and memory.readbyte(0x1FFD) == 0 then
		winner(0)
	end
end

function bubblePoppers()
	bubbleTotal=0
	tableau = {memory.readbyte(0x2A94),memory.readbyte(0x2AEC),memory.readbyte(0x2B18),memory.readbyte(0x2B44),memory.readbyte(0x2B70),memory.readbyte(0x2B9C),memory.readbyte(0x2BC8),memory.readbyte(0x2BF4),memory.readbyte(0x2C20),memory.readbyte(0x2C4C),memory.readbyte(0x2C78),memory.readbyte(0x2CA4),memory.readbyte(0x2CD0),memory.readbyte(0x2CFC),memory.readbyte(0x2D28),memory.readbyte(0x2D54),memory.readbyte(0x2D80),memory.readbyte(0x2DAC),memory.readbyte(0x2DD8),memory.readbyte(0x2E04),memory.readbyte(0x2E30),memory.readbyte(0x2E5C),memory.readbyte(0x2E88),memory.readbyte(0x2EB4),memory.readbyte(0x2EE0),memory.readbyte(0x2F0C),memory.readbyte(0x2F38),memory.readbyte(0x2F64),memory.readbyte(0x2F90),memory.readbyte(0x2FBC),memory.readbyte(0x2FE8),memory.readbyte(0x3014),memory.readbyte(0x3040),memory.readbyte(0x306C),memory.readbyte(0x3098),memory.readbyte(0x30C4),memory.readbyte(0x30F0),memory.readbyte(0x311C),memory.readbyte(0x3148),memory.readbyte(0x3174),memory.readbyte(0x31A0),memory.readbyte(0x31CC),memory.readbyte(0x31F8),memory.readbyte(0x3224),memory.readbyte(0x3250),memory.readbyte(0x327C),memory.readbyte(0x32A8),memory.readbyte(0x32D4),memory.readbyte(0x3300),memory.readbyte(0x332C),memory.readbyte(0x3358),memory.readbyte(0x3384),memory.readbyte(0x33B0),memory.readbyte(0x33DC),memory.readbyte(0x3408),memory.readbyte(0x3434),memory.readbyte(0x3460),memory.readbyte(0x348C),memory.readbyte(0x34B8),memory.readbyte(0x34E4),memory.readbyte(0x3510),memory.readbyte(0x353C),memory.readbyte(0x3568),memory.readbyte(0x3594),memory.readbyte(0x35C0),memory.readbyte(0x35EC),memory.readbyte(0x3618),memory.readbyte(0x3644),memory.readbyte(0x3670),memory.readbyte(0x369C),memory.readbyte(0x36C8),memory.readbyte(0x36F4),memory.readbyte(0x3720),memory.readbyte(0x374C),memory.readbyte(0x3778),memory.readbyte(0x37A4),memory.readbyte(0x37D0),memory.readbyte(0x37FC),memory.readbyte(0x3828),memory.readbyte(0x3854),memory.readbyte(0x3880),memory.readbyte(0x38AC),memory.readbyte(0x38D8),memory.readbyte(0x3904),memory.readbyte(0x3930),memory.readbyte(0x395C),memory.readbyte(0x3988)}
	for i, v in ipairs(tableau) do
      	if tableau[i] == 0 then
      		bubbleTotal=bubbleTotal+1
      	end
      			
    end

	if bubbleTotal > 70 then
		winner(0)
	end
end

function drillClearer(chaID)
	if memory.readbyte(0x3140) == 0 and memory.readbyte(0x3160) == 0 and memory.readbyte(0x3180) == 0 and memory.readbyte(0x31A0) == 0 and memory.readbyte(0x31C0) and memory.readbyte(0x31E0) == 0 and memory.readbyte(0x3200) == 0 and memory.readbyte(0x3220) == 0 and memory.readbyte(0x3240) == 0 then
		if counter99 == nil or counter99 == "nil" then
			counter99 = 0
		end
		if counter99 >= 0 then
			counter99 = counter99 + 1
		end 
		if counter99 == 150 then
			winner(0)
		end
	end
	if memory.readbyte(0x3140) == 4 or memory.readbyte(0x3160) == 4 and memory.readbyte(0x3180) == 4 or memory.readbyte(0x31A0) == 4 or memory.readbyte(0x31C0) == 4 or memory.readbyte(0x31E0) == 4 or memory.readbyte(0x3200) == 4 or memory.readbyte(0x3220) == 4 or memory.readbyte(0x3240) == 4 then
		counter99 = "nil"
	end
    if memory.readbyte(0x113C) == 100 or memory.readbyte(0x1150) == 1 then
    	beginAnew(chaID)
    end
    print(counter99)
end

function TodosAIR(chaID)
	if tallor == nil then
		tallor = 0
	end
	if memory.readbyte(0x113C) == 200 then
		tallor = 0
	end
	if memory.readbyte(0x1180) == 69 then
		tallor = tallor + 1
		print("AIR grabbed!")
	end
	if memory.readbyte(0x1151) == 0 or memory.readbyte(0x113C) == 44 then
		beginAnew(chaID)
	end
	if tallor == 10 then
		winner(0)
	end
	OSD(tallor)
end

function drillCombo(chaID)
	if comboTallor == nil then
		comboTallor = 0
	end
	if memory.readbyte(0x4B0C) == 17 then
		comboTallor = 0
	end
	if memory.readbyte(0x0948) == 116 then
		print("You just drilled!")
		memory.writebyte(0x0948,118)
		comboTallor = comboTallor + 1
	end
	--if memory.readbyte(0x4B0C) > 17 and comboTallor == 0 then
	--	comboTallor = 1
	--end
	if comboTallor >= 11 or memory.readbyte(0x1150) == 1 then
		comboTallor = 0
		beginAnew(chaID)
	end
	if comboTallor <= 10 and memory.readbyte(0x113C) == 98 then
		winner(0)
	end
	OSD(comboTallor)
end

function drillCombo2(chaID)
	if comboTallor == nil then
		comboTallor = 0
	end
	if memory.readbyte(0x4B0C) == 202 then
		comboTallor = 0
	end
	if memory.readbyte(0x0948) == 116 then
		print("You just drilled!")
		memory.writebyte(0x0948,118)
		comboTallor = comboTallor + 1
	end
	--if memory.readbyte(0x4B0C) > 17 and comboTallor == 0 then
	--	comboTallor = 1
	--end
	if comboTallor >= 11 or memory.readbyte(0x1150) == 1 then
		comboTallor = 0
		beginAnew(chaID)
	end
	if comboTallor <= 10 and memory.readbyte(0x113C) == 198 then
		winner(0)
	end
	OSD(comboTallor)
end

function boxBreaker(chaID)
	if boxTaller == nil then
		boxTaller = 0
	end
	if memory.readbyte(0x090D) == 86 then
		print("Box was broken!")
		boxTaller = boxTaller + 1
		memory.writebyte(0x090D,83)
	end
	if memory.readbyte(0x1150) == 1 then
		beginAnew(chaID)
		boxTaller = 0
	end
	if boxTaller == 5 then
		winner(0)
	end
	if memory.readbyte(0x113C) == 100 then
		boxTaller = 0
	end
	OSD(boxTaller)
end
function target()

end
