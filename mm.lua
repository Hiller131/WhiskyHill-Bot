----- DH Farming Script ------
debug = false
immersive = true
scriptDimension = 1920
Settings:setScriptDimension(true, scriptDimension)
Settings:setCompareDimension(true, scriptDimension)
setImmersiveMode(immersive)
local index = 1
waitTimer = 10
farmList = {}
arenaList = {}
MaxLevelList = {}
localPath = scriptPath()
imagePath = localPath .. "/" .. "images"

needResourceRegion = Region(655, 235, 600, 300)
resourceNoRegion = Region(531, 578, 600, 300)
purchaseYesRegion = Region(789, 586, 600, 300)
purchaseOkRegion = Region(662, 773, 600, 300)
refillEnergyRegion = Region(8, 204, 600, 300)
goBackRegion = Region(-50, -50, 600, 300)
commandRegion = Region(25, 50, 250, 250)

MaxLevelList[index] = {target =  "MaxLevel.png", region = Region(680, 530, 120, 80), id = "1", action = 'click'}
index = index + 1
MaxLevelList[index] = {target =  "MaxLevel.png", region = Region(900, 530, 120, 80), id = "2", action = 'click'}
index = index + 1
MaxLevelList[index] = {target =  "MaxLevel.png", region = Region(1120, 530, 120, 80), id = "3", action = 'click'}
index = index + 1
MaxLevelList[index] = {target =  "MaxLevel.png", region = Region(1340, 530, 120, 80), id = "4", action = 'click'}
index = index + 1

index = 1
farmList[index] = {target =  "auto.png", region = Region(200, 940, 200, 100), id = "auto", action = 'click', sleep = 1}
index = index + 1
--farmList[index] = {target =  "victory.png", region = Region(785, 100, 350, 150), id = "victory", action = 'click', sleep = 1}
farmList[index] = {target =  "reward.png", region = Region(755, 609, 400, 200), id = "reward", action = 'click', sleep = 1}
index = index + 1
farmList[index] = {target =  "get.png", region = Region(1027, 865, 250, 250), id = "get", action = 'click', sleep = 1}
index = index + 1
farmList[index] = {target =  "fastbattlemode.png", region = Region(600, 850, 150, 150), id = "fastBattle", action = 'click', sleep = 0}
index = index + 1
farmList[index] = {target =  "replay.png", region = Region(765, 493, 250, 250), id = "replay", action = 'click', sleep = 4}
index = index + 1
farmList[index] = {target =  "start.png", region = Region(772, 673, 250, 250), id = "start", action = 'click', sleep = 60}
index = index + 1
farmList[index] = {target =  "sell.png", region = Region(530, 854, 250, 250), id = "sell", action = 'click', sleep = 1}
index = index + 1
--farmList[index] = {target =  "continue.png", region = Region(777, 841, 250, 250), id = "continue", action = 'click', sleep = 1}
--index = index + 1
farmList[index] = {target =  "next.png", region = Region(786, 637, 250, 250), id = "next", action = 'click', sleep = 4}
index = index + 1
farmList[index] = {target =  "defeated.png", region = Region(785, 100, 350, 150), id = "defeated", action = 'click', sleep = 1}
index = index + 1
--farmList[index] = {target =  "close.png", region = Region(1465, 21, 250, 250), id = "close", action = 'click', sleep = 1}
--index = index + 1
--farmList[index] = {target =  "replaydefeat.png", region = Region(763, 450, 250, 250), id = "replaydefeat", action = 'click', sleep = 1}
--index = index + 1
farmList[index] = {target =  "giveup.png", region = Region(809, 348, 250, 250), id = "giveup", action = 'click', sleep = 1}
index = index + 1

function farm()
	while true do
		local length = table.getn(farmList)
		local MaxLevelLength = table.getn(MaxLevelList)
		
		setImagePath(imagePath)
		
		for i = 1, length do
			local t = farmList[i]
			if (t.action == "click") then
				--Debug
				if (debug and t.region) then 
					toast(t.target)
					t.region:highlight(1)
					wait(1)
				end
				if (t.id == "reward") then
					if (t.region and (t.region):exists(t.target, 0)) then
						for j = 1, MaxLevelLength do
							local x = MaxLevelList[j]
							toast(x.target)
							x.region:highlight(1)
							if (x.region and (x.region):exists(x.target, 0)) then
								if j==1 and maxLevel1==true then
									scriptExit("Max Level Monsters")
								elseif j==2 and maxLevel2==true then
									scriptExit("Max Level Monsters")
								elseif j==3 and maxLevel3==true then
									scriptExit("Max Level Monsters")
								elseif j==4 and maxLevel4==true then
									scriptExit("Max Level Monsters")
								end
							end
						end
					end
				end
				if (t.id == "sell") then
					--ONLY click if farmSellAll = true
					if( farmSellAll == true ) then
						(t.region):existsClick(Pattern(t.target):similar(imgAccuracy), 0)
					end
				elseif (t.id == "get") then
					--ONLY click if farmSellAll = false
					if( farmSellAll == false ) then
						(t.region):existsClick(Pattern(t.target):similar(imgAccuracy), 0)
					end
				elseif (t.id == "fastBattle") then
					--ONLY click if fastBattleMode = true else remove the enable
					if( fastBattleMode == true ) then
						(t.region):existsClick(Pattern(t.target):similar(imgAccuracy), 0)
					else
						(t.region):existsClick(Pattern("fastbattlemodeEnabled.png"):similar(imgAccuracy), 0)
					end	
				elseif (t.id == "next") then
					--ONLY click if farmNextStage = true
					if( farmNextStage == true ) then
						(t.region):existsClick(Pattern(t.target):similar(imgAccuracy), 0)
					end
				elseif (t.id == "replay") then
					--ONLY click if farmNextStage = false
					if( farmNextStage == false ) then
						(t.region):existsClick(Pattern(t.target):similar(imgAccuracy), 0)
					end
				else
					--Default
					if (t.region and (t.region):existsClick(Pattern(t.target):similar(imgAccuracy), 0)) then
						wait(t.sleep)
					end
				end
			end
			if needResourceRegion:exists(Pattern("noResources.png"), 0.1) then
				Refill()
			end
			wait(.5)
		end
	end
end


index = 1

arenaList[index] = {target =  "auto.png", region = Region(200, 940, 200, 100), id = "auto", action = 'click', sleep = 1}
index = index + 1

function arena()
	while true do
		local length = table.getn(arenaList)
		
		setImagePath(imagePath)
		
		for i = 1, length do
			local t = arenaList[i]
			if (t.action == "click") then
				if (debug and t.region) then 
					toast(t.target)
					t.region:highlight(0.2)
					wait(2)
				end
				if (t.region and (t.region):existsClick(t.target, 0)) then
					wait(t.sleep)
				end
			end
			wait(.5)
		end
	end	
end

function Refill()

	if refillEnergy then
		purchaseYesRegion:existsClick(Pattern("purchaseYes.png"), 0.1)
		refillEnergyRegion:existsClick(Pattern("energy.png"), 0.1)
		purchaseYesRegion:existsClick(Pattern("purchaseYes.png"), 0.5)
		purchaseOkRegion:existsClick(Pattern("ok.png"), 0.5)
		goBackRegionRegion:existsClick(Pattern("back.png"), 0.5)
	else
		resourceNoRegion:existsClick(Pattern("no.png"):similar(imgAccuracy), 0)
		while waitTimer > 0 do
			showCommand("Out of Energy.  Waiting " .. waitTimer .. " minutes.")
			wait(60)
			waitTimer = waitTimer - 1
		end
		waitTimer = 10
    end
end
	
function showBattleResult()
	local message = ""
  
	if timeLimitCheckBox then
		timeInMinutes = math.floor(timer:check()/60)
		timeLeft = timeLimit - timeInMinutes
		message = ("Time Left: " .. timeLeft .. " minutes")
		resultRegion:highlightOff()
		resultRegion:highlight(message)
		if timeLeft <= 0 then
			print("Timed Run Complete")
				scriptExit()
		end
	end
end	
function showCommand(command)
  commandRegion:highlightOff()
  commandRegion:highlight(command)	
end
---- Main ----
setHighlightTextStyle(16777215, 4294967295, 12)
dialogInit()
addTextView("Choose your mode:")
newRow()
addRadioGroup("actionSelect", 1)
addRadioButton("Farming", 1)
addRadioButton("Arena - Automatically Turns on Auto", 2)
newRow()
addCheckBox("farmSellAll", "Sell All", false)
newRow()
addCheckBox("farmNextStage", "Next Stage", false)
addCheckBox("fastBattleMode", "Fast Battle Mode", false)
newRow()
addTextView("Image Accuracy (Between 0 and 1): ")
addEditNumber("imgAccuracy", .9)
newRow()
addCheckBox("refillEnergy", "Refill Energy? ", false)
addCheckBox("timeLimitCheckBox", "Time Limit?", false)
addEditNumber("timeLimit", 60)
newRow()
addTextView("Stop on Max Level: ")
addCheckBox("maxLevel1", "Slot 1: ", false)
addCheckBox("maxLevel2", " Slot 2: ", false)
addCheckBox("maxLevel3", " Slot 3: ", false)
addCheckBox("maxLevel4", " Slot 4: ", false)
dialogShowFullScreen("Might and Magic Bot")

timer = Timer()

if (actionSelect == 2) then
	arena()
else
	farm()
end
