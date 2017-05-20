local doingTakeover = false
local enemiesKilled = 0
local enemiesSpawned = {}
local enemiesKilledT = {}
local takingOver = ""

local locations = {
	["SANDY"] = {
		defendPosition = { ['x'] = -1124.87, ['y'] = 4950.85, ['z'] = 219.716 },
		enemies = 30,
		enemyPeds = {
			0x9E08633D
		},
		enemyWeapons = {
			"WEAPON_STUNGUN",
			"WEAPON_PISTOL",
			"WEAPON_MOLOTOV",
			"WEAPON_CARBINERIFLE",
			"WEAPON_ASSAULTSMG"
		},
		enemySpawnPositions = {
			{ ['x'] = -1161.06, ['y'] = 4924.67, ['z'] = 222.798 },
			{ ['x'] = -1137.11, ['y'] = 4896.01, ['z'] = 218.456 },
			{ ['x'] = -1065.47, ['y'] = 4941.36, ['z'] = 211.145 },
			{ ['x'] = 1660.38, ['y'] = 4940.49, ['z'] = 212.285 },
			{ ['x'] = -1035.1, ['y'] = 4912.75, ['z'] = 206.828 },
		},
		taken = false,
		income = 2000
	}
}

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("es_turfwars:loaded")
AddEventHandler("es_turfwars:loaded", function(turfs)
	for k,v in pairs(turfs)do
		if(v == '1')then
			locations[k].taken = true
		end
	end
end)

TriggerEvent("es_turfwars:loaded")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local pos = GetEntityCoords(GetPlayerPed(-1), false)

		--Citizen.Trace("Current zone: " .. GetNameOfZone(pos.x, pos.y, pos.z) .. "\n")

		for k,v in pairs(locations) do
			if not v.taken then
				DrawMarker(1, v.defendPosition.x, v.defendPosition.y, v.defendPosition.z - 1, 0, 0, 0, 0, 0, 0, 2.4001, 2.4001, 0.8001, 0, 75, 255, 165, 0,0, 0,0)
			end

			if(Vdist2(pos.x, pos.y, pos.z, v.defendPosition.x, v.defendPosition.y, v.defendPosition.z) < 2.0 and v.taken == false and doingTakeover == false)then
				DisplayHelpText("Appuie sur ~INPUT_CONTEXT~ pour tenter de controller cette zone.")

				if(IsControlJustReleased(1, 51))then
					takingOver = k
					doingTakeover = true
					enemiesKilled = 0
				end
			end
		end

		if doingTakeover then

			DisplayHelpText("REPOUSSE LA ~HUD_COLOUR_RED~ RACAILLE")
			for k,v in ipairs(enemiesSpawned) do
				if IsPedFatallyInjured(v) and enemiesKilledT[k] == nil then
					enemiesKilledT[k] = true
					enemiesKilled = enemiesKilled + 1
				end
			end

			if (enemiesKilled == locations[takingOver].enemies) then
				Citizen.Wait(2000)
				for k,v in ipairs(enemiesSpawned) do
					Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(v))
				end

				enemiesSpawned = {}
				enemiesKilledT = {}

				locations[takingOver].taken = true
				doingTakeover = false

				TriggerServerEvent("es_turfwars:done", takingOver)
				TriggerEvent("chatMessage", "TURF", {255, 0, 0}, "Tu controles la zone. ( revenus augmentés de ^2^*" .. locations[takingOver].income .. "^0^r )")
			
				takingOver = ""
			end

			-- DEAD
			if IsPedFatallyInjured(GetPlayerPed(-1)) or Vdist(pos.x, pos.y, pos.z, locations[takingOver].defendPosition.x, locations[takingOver].defendPosition.y, locations[takingOver].defendPosition.z) > 100.0 then
				doingTakeover = false
				takingOver = ""
				enemiesKilled = 0
				enemiesKilledT = {}

				for k,v in ipairs(enemiesSpawned) do
					Citizen.InvokeNative(0x9614299DCB53E54B, Citizen.PointerValueIntInitialized(v))
				end

				enemiesSpawned = {}

				TriggerEvent("chatMessage", "TURF", {255, 0, 0}, "Tu as raté le contrôle de la zone, recommence!.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if doingTakeover then
			if(#enemiesSpawned < locations[takingOver].enemies)then
				local ped = locations[takingOver].enemyPeds[math.random(#locations[takingOver].enemyPeds)]
				local weapon = locations[takingOver].enemyWeapons[math.random(#locations[takingOver].enemyWeapons)]
				local spawnPosition = locations[takingOver].enemySpawnPositions[math.random(#locations[takingOver].enemySpawnPositions)]	
			
				local id = #enemiesSpawned + 1
				enemiesSpawned[id] = CreatePed(4, ped, spawnPosition.x, spawnPosition.y, spawnPosition.z, 10.0, false, true)

				local blip = AddBlipForEntity(enemiesSpawned[id])
				GiveDelayedWeaponToPed(enemiesSpawned[id], GetHashKey(weapon), 0, true)
				SetBlipSprite(blip,  270)
				SetBlipColour(blip, 1)
				TaskCombatPed(enemiesSpawned[id], GetPlayerPed(-1), 0, 16)

				if not DoesGroupExist(44) then
					CreateGroup(44)
				end

				SetPedAsGroupMember(enemiesSpawned[id], 44)

				Citizen.Wait(3000)
			end
		end
	end
end)