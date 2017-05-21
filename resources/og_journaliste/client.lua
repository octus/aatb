local isJou = false
local isInService = false
local rank = "inconnu"
local checkpoints = {}
local existingVeh = nil
--local handCuffed = false
local isAlreadyDead = false
local allServiceJou = {}
local blipsJou = {}

local takingService = {
  {x=-1049.70629882813, y=-241.964126586914, z=44.0210723876953}
  --{x=457.956909179688, y=-992.72314453125, z=30.6895866394043}
  --{x=371.335, y=-1609.12, z=29.2919},
  --{x=-1109.08, y=-845.603, z=19.3169},
  --{x=825.883, y=-1289.87, z=28.2407},
  --{x=1853.14, y=3687.58, z=34.267},
  --{x=-446.327, y=6014.09, z=31.7164},
  --{x=127.689, y=-758.05, z=242.152}
}

local stationGarage = {
	{x=-1099.23815917969, y=-256.956451416016, z=37.6878509521484}
	--{x=651.766, y=-12.6001, z=82.8436},
	--{x=172.785, y=-688.186, z=33.1262},
	--{x=379.018, y=-1627.8, z=27.7846},
	--{x=-888.041, y=-2372.66, z=14.0244},
	--{x=-1124.47, y=-840.902, z=13.4015},
	--{x=856.259, y=-1279.71, z=26.5434},
	--{x=1858.58, y=3678.21, z=33.7007},
	--{x=-447.844, y=6050.41, z=31.3405}
}

AddEventHandler("playerSpawned", function()
	TriggerServerEvent("journaliste:checkIsJou")
end)

RegisterNetEvent('journaliste:receiveIsJou')
AddEventHandler('journaliste:receiveIsJou', function(result)
	if(result == "inconnu") then
		isJou = false
	else
		isJou = true
		rank = result
	end
end)

RegisterNetEvent('journaliste:nowJou')
AddEventHandler('journaliste:nowJou', function()
	isJou = true
end)

RegisterNetEvent('journaliste:noLongerJou')
AddEventHandler('journaliste:noLongerJou', function()
	isJou = false
	isInService = false
	
	local playerPed = GetPlayerPed(-1)
						
	TriggerServerEvent("skin_customization:SpawnPlayer")
	RemoveAllPedWeapons(playerPed)
	
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
	
	ServiceOff()
end)

--[[RegisterNetEvent('police:getArrested')
AddEventHandler('police:getArrested', function()
	if(isCop == false) then
		handCuffed = not handCuffed
		if(handCuffed) then
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Tu es menotté.")
		else
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Tu es libre !")
		end
	end
end)

RegisterNetEvent('police:payFines')
AddEventHandler('police:payFines', function(amount)
	TriggerServerEvent('bank:withdrawAmende', amount)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Tu as payé $"..amount.." d'amende.")
end)

RegisterNetEvent('police:dropIllegalItem')
AddEventHandler('police:dropIllegalItem', function(id)
	TriggerEvent("player:looseItem", tonumber(id), exports.vdk_inventory:getQuantity(id))
end)

RegisterNetEvent('police:unseatme')
AddEventHandler('police:unseatme', function(t)
	local ped = GetPlayerPed(t)        
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2
   
	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function(veh)
	if(handCuffed) then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local a, b, c, d, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
		end
	end
end)]]

RegisterNetEvent('journaliste:resultAllJouInService')
AddEventHandler('journaliste:resultAllJouInService', function(array)
	allServiceJou = array
	enableJouBlips()
end)

function enableJouBlips()

	for k, existingBlip in pairs(blipsJou) do
        RemoveBlip(existingBlip)
    end
	blipsJou = {}
	
	local localIdJou = {}
	for id = 0, 64 do
		if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			for i,c in pairs(allServiceJou) do
				if(i == GetPlayerServerId(id)) then
					localIdJou[id] = c
					break
				end
			end
		end
	end
	
	for id, c in pairs(localIdJou) do
		local ped = GetPlayerPed(id)
		local blip = GetBlipFromEntity(ped)
		
		if not DoesBlipExist( blip ) then

			blip = AddBlipForEntity( ped )
			SetBlipSprite( blip, 1 )
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			HideNumberOnBlip( blip )
			SetBlipNameToPlayerName( blip, id )
			
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsJou, blip)
		else
			
			blipSprite = GetBlipSprite( blip )
			
			HideNumberOnBlip( blip )
			if blipSprite ~= 1 then
				SetBlipSprite( blip, 1 )
				Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			end
			
			Citizen.Trace("Nom : "..GetPlayerName(id))
			SetBlipNameToPlayerName( blip, id )
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsJou, blip)
		end
	end
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function getIsInService()
	return isInService
end

function isNearTakeService()
	for i = 1, #takingService do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

function isNearStationGarage()
	for i = 1, #stationGarage do
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, 0)
		local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if(distance < 30) then
			DrawMarker(1, stationGarage[i].x, stationGarage[i].y, stationGarage[i].z-1, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.0, 0, 155, 255, 200, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

-function ServiceOn()
	isInService = true
	TriggerServerEvent("jobssystem:jobs", 2)
	TriggerServerEvent("journaliste:takeService")
end

function ServiceOff()
	isInService = false
	TriggerServerEvent("jobssystem:jobs", 1)
	TriggerServerEvent("journaliste:breakService")
	
	allServiceJou = {}
	
	for k, existingBlip in pairs(blipsJou) do
        RemoveBlip(existingBlip)
    end
	blipsJou = {}
end]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isJou) then
			if(isNearTakeService()) then
			
				DisplayHelpText('Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~casier de journaliste',0,1,0.5,0.8,0.6,255,255,255,255) -- ~g~E~s~
				if IsControlJustPressed(1,51) then
					OpenMenuVest()
				end
			end
			if(isInService) then
				if IsControlJustPressed(1,166) then 
					OpenJMenu()
				end
			end
			
			if(isInService) then
				if(isNearStationGarage()) then
					if(jvehicle ~= nil) then --existingVeh
						DisplayHelpText('Appuie sur ~INPUT_CONTEXT~ pour ranger ton ~b~véhicule',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~garage des journalistes',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51) then
						if(jvehicle ~= nil) then
							SetEntityAsMissionEntity(jvehicle, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(jvehicle))
							jvehicle = nil
						else
							OpenVeh()
						end
					end
				end
				
				
			end
		--[[else
			if (handCuffed == true) then
			  RequestAnimDict('mp_arresting')

			  while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			  end

			  local myPed = PlayerPedId()
			  local animation = 'idle'
			  local flags = 16

			  TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
			end
		end
    end
end)]]
---------------------------------------------------------------------------------------
-------------------------------SPAWN HELI AND CHECK DEATH------------------------------
---------------------------------------------------------------------------------------
local alreadyDead = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(isJou) then
			if(isInService) then
			
				if(IsPlayerDead(PlayerId())) then
					if(alreadyDead == false) then
						ServiceOff()
						alreadyDead = true
					end
				else
					alreadyDead = false
				end
			
				DrawMarker(1,-1049.086,-234.364,202.625,0,0,0,0,0,0,2.0,2.0,2.0,0,155,255,200,0,0,0,0)
			
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1049.086,-234.364,202.625, true ) < 5 then
					if(existingVeh ~= nil) then
						DisplayHelpText('Appuie sur ~INPUT_CONTEXT~ pour ranger ~b~ton ~b~hélicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
					else
						DisplayHelpText('Appuie sur ~INPUT_CONTEXT~ pour sortir un hélicoptère',0,1,0.5,0.8,0.6,255,255,255,255)
					end
					
					if IsControlJustPressed(1,51)  then
						if(existingVeh ~= nil) then
							SetEntityAsMissionEntity(existingVeh, true, true)
							Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
							existingVeh = nil
						else
							local car = GetHashKey("maverick")
							local ply = GetPlayerPed(-1)
							local plyCoords = GetEntityCoords(ply, 0)
							
							RequestModel(car)
							while not HasModelLoaded(car) do
									Citizen.Wait(0)
							end
							
							existingVeh = CreateVehicle(car, plyCoords["x"], plyCoords["y"], plyCoords["z"], 90.0, true, false)
							local id = NetworkGetNetworkIdFromEntity(existingVeh)
							SetNetworkIdCanMigrate(id, true)
							TaskWarpPedIntoVehicle(ply, existingVeh, -1)
						end
					end
				end
			end
		end
    end
end)