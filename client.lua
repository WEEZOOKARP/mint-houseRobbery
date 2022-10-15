local QBCore = exports['qb-core']:GetCoreObject()

canStart = true
ongoing = false
robberyStarted = false
NeededAttempts = 0
SucceededAttempts = 0
FailedAttemps = 0
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    createentryzones()
end)

function createentryzones()
	for k, v in pairs(Config.Locations) do
	exports['qb-target']:AddBoxZone("enterhouserobbery", v.location, 0.45, 0.35, {
		name = "enterhouserobbery",
		heading = 0,
		debugPoly = false,
		minZ = 0.0,
		maxZ = 300.0,
	    }, {
		options = {
		    {
			type = "client",
			event = "getRandomHouseLoc",
			icon = "far fa-clipboard",
			label = "Enter",
		    },
		},
		distance = 2
	    })
	end
end

RegisterNetEvent("getRandomHouseLoc")
AddEventHandler("getRandomHouseLoc", function()
    local missionTarget
    for k, v in ipairs(Config.Locations) do
        local coords = GetEntityCoords(PlayerPedId())
        local distance = #(v.location - coords)
        if distance < 4 then
            missionTarget = v
        end
    end
    EntryMinigame(missionTarget)
end)

RegisterNetEvent("createBlipAndRoute")
AddEventHandler("createBlipAndRoute", function(missionTarget)
    QBCore.Functions.Notify('You recived an robbery location.', "success")
    targetBlip = AddBlipForCoord(missionTarget.location.x, missionTarget.location.y, missionTarget.location.z)
    SetBlipSprite(targetBlip, 374)
    SetBlipColour(targetBlip, 1)
    SetBlipAlpha(targetBlip, 90)
    SetBlipScale(targetBlip, 0.5)
    SetBlipRoute(targetBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Robbery location")
    EndTextCommandSetBlipName(targetBlip)
end)

RegisterNetEvent("createEntry")
AddEventHandler("createEntry", function(missionTarget)
    Citizen.CreateThread(function()
	    local alreadyEnteredZone = false
	    local text = nil
	    while ongoing do
	        wait = 5
	        local ped = PlayerPedId()
	        local inZone = false
	        local dist = #(GetEntityCoords(ped)-vector3(missionTarget.location.x, missionTarget.location.y, missionTarget.location.z))
	        if dist <= 5.0 then
	            wait = 5
	            inZone  = true
	            text = '<b>Entry</b></p>Press [F] to start the robbery'

	            if IsControlJustReleased(0, 23) then
	                EntryMinigame(missionTarget)
	            end
	        else
	            wait = 2000
	        end

	        if inZone and not alreadyEnteredZone then
	            alreadyEnteredZone = true
	            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
	        end

	        if not inZone and alreadyEnteredZone then
	            alreadyEnteredZone = false
	            TriggerEvent('cd_drawtextui:HideUI')
	        end
	        Citizen.Wait(wait)
	    end
	end)
end)

RegisterNetEvent("goInside")
AddEventHandler("goInside", function(missionTarget)
    robberyStarted = true
    SetEntityCoords(PlayerPedId(), missionTarget.inside.x, missionTarget.inside.y, missionTarget.inside.z)
    TriggerEvent("createExit", missionTarget)
    TriggerEvent("createLoot", missionTarget)
end)

RegisterNetEvent("createExit")
AddEventHandler("createExit", function(missionTarget)
    Citizen.CreateThread(function()
	    local alreadyEnteredZone = false
	    local text = nil
	    while ongoing do
	        wait = 5
	        local ped = PlayerPedId()
	        local inZone = false
	        local dist = #(GetEntityCoords(ped)-vector3(missionTarget.exit.x, missionTarget.exit.y, missionTarget.exit.z))
	        if dist <= 5.0 then
	            wait = 5
	            inZone  = true
	            text = '<b>Exit</b></p>Press [F] to end the robbery and leave the house.'

	            if IsControlJustReleased(0, 23) then
                    Citizen.Wait(1000)
                    ongoing = false
                    SetEntityCoords(PlayerPedId(), missionTarget.location.x, missionTarget.location.y, missionTarget.location.z)
                    cooldownNextRobbery(missionTarget)
                    Citizen.Wait(500)
                    TriggerEvent('cd_drawtextui:HideUI')
	            end
	        else
	            wait = 2000
	        end

	        if inZone and not alreadyEnteredZone then
	            alreadyEnteredZone = true
	            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
	        end

	        if not inZone and alreadyEnteredZone then
	            alreadyEnteredZone = false
	            TriggerEvent('cd_drawtextui:HideUI')
	        end
	        Citizen.Wait(wait)
	    end
	end)
end)

RegisterNetEvent("createLoot")
AddEventHandler("createLoot", function(missionTarget)
    for i,v in ipairs(missionTarget.loot) do
        --print(i, " ", v)
        local looted = false
        Citizen.CreateThread(function()
            while ongoing do
                local wait = 5000
                local ped = PlayerPedId()
                local pedCoords = GetEntityCoords(ped)
                if #(v - pedCoords) < 20 then
                    wait = 1
                    DrawMarker(27, v.x, v.y, v.z - 0.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0001, 0, 50, 255, 150, 0, 1, 2,0)
                    if #(v - pedCoords) < 2 then
                        drawTxt3D(v.x, v.y, v.z, "Press [E] to look for stuff here")
                        if IsControlJustPressed(0, 46) then
                            if not looted then
                                beginLoot()
                                looted = true
                            else
                                QBCore.Functions.Notify('You already cheacked here.', "error")
                            end
                        end
                    end
                end
                Wait(wait)
            end
        end)
    end
end)

function drawTxt3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function beginLoot()
    QBCore.Functions.Progressbar("loot_house", "Looking for stuff...", math.random(6000,12000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("robbery:loot")
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

function cooldownNextRobbery(missionTarget)
    RemoveBlip(targetBlip)
    TriggerEvent('cd_drawtextui:HideUI')
    missionTarget.canrob = false
    Citizen.Wait(Config.Robsuccesscooldown * 1000 * 60) 
    ongoing = false
    missionTarget.canrob = true
end

function cooldownNextRobberyFail(missionTarget)
    RemoveBlip(targetBlip)
    TriggerEvent('cd_drawtextui:HideUI')
    missionTarget.canrob = false
    ongoing = false
    Citizen.Wait(Config.Robfailedcooldown * 1000 * 60)
    missionTarget.canrob = true
end

function EntryMinigame(missionTarget)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
        -- NeededAttempts = 1
    end

    local maxwidth = 30
    local maxduration = 3500
    local hasitem = QBCore.Functions.HasItem(Config.ItemRequired)
    if hasitem and missionTarget.canrob then
        if Config.Shoulduseitem then
            TriggerServerEvent("robbery:removerequireditem")
        end
	    Skillbar.Start({
		duration = math.random(2000, 3000),
		pos = math.random(10, 30),
		width = math.random(20, 30),
	    }, function()
		if SucceededAttempts + 1 >= NeededAttempts then
		    TriggerEvent("goInside", missionTarget)
		    ongoing = true
		    QBCore.Functions.Notify("You got the door open!", "success")
		    FailedAttemps = 0
		    SucceededAttempts = 0
		    NeededAttempts = 0
		else
		    SucceededAttempts = SucceededAttempts + 1
		    Skillbar.Repeat({
			duration = math.random(2000, 3000),
			pos = math.random(10, 30),
			width = math.random(20, 30),
		    })
		end
		end, function()
		QBCore.Functions.Notify("You messed up the lock! Get outa there!", "error")
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 200, 'metaldetected', 0.4)
                if not Config.Dispatch == "" then
                    callPolice(missionTarget)
                end
                FailedAttemps = 0
                SucceededAttempts = 0
                NeededAttempts = 0
                robberyStarted = false
                ongoing = false
                cooldownNextRobberyFail(missionTarget)
                Citizen.Wait(500)
                TriggerEvent('cd_drawtextui:HideUI')
	    end)
	else
		QBCore.Functions.Notify('You are missing something, but what could it be?', 'error', 7500)
	end
end

function callPolice(missionTarget)
    if Config.Dispatch == "ps-dispatch" then
	    exports['ps-dispatch']:HouseRobbery()
    elseif Config.Dispatch == "QBCore" then
        TriggerServerEvent('police:server:policeAlert', 'Attempted House Robbery')
    else end
	PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
end
