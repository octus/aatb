require "resources/essentialmode/lib/MySQL"
MySQL:open("localhost", "gta5_gamemode_essential", "root", "1202")
RegisterServerEvent('cp:spawnplayer')
AddEventHandler('cp:spawnplayer', function()
	TriggerEvent('es:getPlayerFromId', source, function(user)
	local player = user.identifier
	local executed_query = MySQL:executeQuery("UPDATE users SET `Nom` = '@name' WHERE identifier = '@username'",
							{['@name'] = GetPlayerName(source), ['@username'] = player})
	end)
 end)