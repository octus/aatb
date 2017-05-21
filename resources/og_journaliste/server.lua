require "resources/essentialmode/lib/MySQL"
MySQL:open("127.0.0.1", "gta5_gamemode_essential", "root", "1202")

--local inServiceJous = {}

function addJou(identifier)
	MySQL:executeQuery("INSERT INTO journaliste (`identifier`) VALUES ('@identifier')", { ['@identifier'] = identifier})
end

function remJou(identifier)
	MySQL:executeQuery("DELETE FROM journaliste WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
end

function checkIsJou(identifier)
	local query = MySQL:executeQuery("SELECT * FROM journaliste WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	
	if(not result[1]) then
		TriggerClientEvent('journaliste:receiveIsJou', source, "inconnu")
	else
		TriggerClientEvent('journaliste:receiveIsJou', source, result[1].rank)
	end
end

function s_checkIsJou(identifier)
	local query = MySQL:executeQuery("SELECT * FROM journaliste WHERE identifier = '@identifier'", { ['@identifier'] = identifier})
	local result = MySQL:getResults(query, {'rank'}, "identifier")
	
	if(not result[1]) then
		return "nil"
	else
		return result[1].rank
	end
end

--[[function checkInventory(target)
	local strResult = GetPlayerName(target).." Possède : "
	local identifier = ""
    TriggerEvent("es:getPlayerFromId", target, function(player)
		identifier = player.identifier
		local executed_query = MySQL:executeQuery("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'quantity', 'libelle', 'item_id', 'isIllegal' }, "item_id")
		if (result) then
			for _, v in ipairs(result) do
				if(v.quantity ~= 0) then
					strResult = strResult .. v.quantity .. " de " .. v.libelle .. ", "
				end
				if(v.isIllegal == "True") then
					TriggerClientEvent('police:dropIllegalItem', target, v.item_id)
				end
			end
		end
		
		strResult = strResult .. " / "
		
		local executed_query = MySQL:executeQuery("SELECT * FROM user_weapons WHERE identifier = '@username'", { ['@username'] = identifier })
		local result = MySQL:getResults(executed_query, { 'weapon_model' }, 'identifier' )
		if (result) then
			for _, v in ipairs(result) do
					strResult = strResult .. "possession de " .. v.weapon_model .. ", "
			end
		end
	end)
	
    return strResult
end]]

AddEventHandler('playerDropped', function()
	if(inServiceJous[source]) then
		inServiceJous[source] = nil
		
		for i, c in pairs(inServiceJous) do
			TriggerClientEvent("journaliste:resultAllJousInService", i, inServiceJous)
		end
	end
end)

AddEventHandler('es:playerDropped', function(player)
		local isJou = s_checkIsJou(player.identifier)
		if(isJou ~= "nil") then
			TriggerEvent("jobssystem:disconnectReset", player, 1)
		end
end)

RegisterServerEvent('journaliste:checkIsJou')
AddEventHandler('journaliste:checkIsJou', function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local identifier = user.identifier
		checkIsJou(identifier)
	end)
end)

RegisterServerEvent('journaliste:takeService')
AddEventHandler('journaliste:takeService', function()

	if(not inServiceJous[source]) then
		inServiceJous[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceJous) do
			TriggerClientEvent("journaliste:resultAllJousInService", i, inServiceJous)
		end
	end
end)

RegisterServerEvent('journaliste:breakService')
AddEventHandler('journaliste:breakService', function()

	if(inServiceJous[source]) then
		inServiceJous[source] = nil
		
		for i, c in pairs(inServiceJous) do
			TriggerClientEvent("journaliste:resultAllJousInService", i, inServiceJous)
		end
	end
end)

RegisterServerEvent('journaliste:getAllJousInService')
AddEventHandler('journaliste:getAllJousInService', function()
	TriggerClientEvent("journaliste:resultAllJousInService", source, inServiceJous)
end)

--[[RegisterServerEvent('police:checkingPlate')
AddEventHandler('police:checkingPlate', function(plate)
	local executed_query = MySQL:executeQuery("SELECT Nom FROM user_vehicle JOIN users ON user_vehicle.identifier = users.identifier WHERE vehicle_plate = '@plate'", { ['@plate'] = plate })
	local result = MySQL:getResults(executed_query, { 'Nom' }, "identifier")
	if (result[1]) then
		for _, v in ipairs(result) do
			TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "The vehicle #"..plate.." is the property of " .. v.Nom)
		end
	else
		TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "The vehicle #"..plate.." isn't register !")
	end
end)

RegisterServerEvent('police:confirmUnseat')
AddEventHandler('police:confirmUnseat', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, GetPlayerName(t).. " is out !")
	TriggerClientEvent('police:unseatme', t)
end)

RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, checkInventory(t))
end)

RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(t, amount)
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, GetPlayerName(t).. " paid a $"..amount.." fines.")
	TriggerClientEvent('police:payFines', t, amount)
end)

RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, GetPlayerName(t).. " toggle cuff (except if it's a cop :3 ) !")
	TriggerClientEvent('police:getArrested', t)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(t, v)
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, GetPlayerName(t).. " get to the car ! (if he's cuffed :) )")
	TriggerClientEvent('police:forcedEnteringVeh', t, v)
end)]]

-----------------------------------------------------------------------
----------------------EVENT SPAWN POLICE VEH---------------------------
-----------------------------------------------------------------------
RegisterServerEvent('CheckJouVeh')
AddEventHandler('CheckJouVeh', function(vehicle)
	TriggerEvent('es:getPlayerFromId', source, function(user)

			TriggerClientEvent('FinishJouCheckForVeh',source)
			-- Spawn police vehicle
			TriggerClientEvent('jveh:spawnVehicle', source, vehicle)
	end)
end)

-----------------------------------------------------------------------
---------------------COMMANDE ADMIN AJOUT / SUPP COP-------------------
-----------------------------------------------------------------------
TriggerEvent('es:addGroupCommand', 'jouadd', "admin", function(source, args, user)
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "Usage : /jouadd [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				addJou(target.identifier)
				TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOUVERNRMENT", false, "Congrats, you're now a journaliste !~w~.")
				TriggerClientEvent('journaliste:nowJou', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)

TriggerEvent('es:addGroupCommand', 'jourem', "admin", function(source, args, user) 
     if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "Usage : /jourem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			local player = tonumber(args[2])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				remJou(target.identifier)
				TriggerClientEvent("es_freeroam:notify", player, "CHAR_ANDREAS", 1, "GOUVERNRMENT", false, "You're no longer a journaliste !~w~.")
				TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "Roger that !")
				TriggerClientEvent('chatMessage', player, 'GOUVERNRMENT', {255, 0, 0}, "You're no longer a journaliste !")
				TriggerClientEvent('journaliste:noLongerJou', player)
			end)
		else
			TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "No player with this ID !")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'GOUVERNRMENT', {255, 0, 0}, "You haven't the permission to do that !")
end)