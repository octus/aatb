local tags = uSettings.chatTags

-- Settings for EssentialMode
TriggerEvent("es:setDefaultSettings", {
	pvpEnabled = uSettings.pvpEnabled,
	debugInformation = false,
	startingCash = uSettings.startingMoney + 0.0,
	enableRankDecorators = true
})

function startswith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-- /help général #test
TriggerEvent('es:addCommand', 'help', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Aides générale", {255, 0, 0}, "^5/discord /forum ^1/report (message aux admins) ^0/help1 /help2")
	TriggerClientEvent("chatMessage", source, "Métiers/Factions", {255, 0, 0}, "/metiers /sysmetiers /factions")
	TriggerClientEvent("chatMessage", source, "Règles HRP du serveur", {255, 0, 0}, "^5/regles /metagame")
end)
-- /metiers
TriggerEvent('es:addCommand', 'metiers', function(source, args, user)
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "Il existe deux sortes de métiers différents:")
	TriggerClientEvent("chatMessage", source, ">>", {255, 0, 0}, "Les métiers ^4légaux ^0sont disponibles au ^1Pole Emploi")
	TriggerClientEvent("chatMessage", source, ">>", {255, 0, 0}, "Il est représenté par une malette sur ^1ta carte")
	TriggerClientEvent("chatMessage", source, ">>>", {255, 0, 0}, "Les métiers ^4illégaux ^0 sont disponible uniquement dans certains lieux")
	TriggerClientEvent("chatMessage", source, ">>>", {255, 0, 0}, "^4Il te faut les trouver ^0avant de pouvoir faire de commencer à travailler")
end)
-- /sysmetiers
TriggerEvent('es:addCommand', 'sysmetiers', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Comment ça fonctionne ?", {255, 0, 0}, "Tous les métiers du ^1Pole Emploi ^0fonctionnent de la même façon:")
	TriggerClientEvent("chatMessage", source, "En 3 étapes", {255, 0, 0}, "^2*1:^0Tu ^4récoltes ^0la matière première, ^2*2:^0Tu la ^4traites^0 en marchandise, ^2*3:^0Tu ^4vends ta marchandise")
	TriggerClientEvent("chatMessage", source, "!-!", {255, 0, 0}, "Certains métiers ne nécessitent pas de ^4traitement")
	TriggerClientEvent("chatMessage", source, "!-!", {255, 0, 0}, "Les métiers ^4illégaux ^0fonctionne de la même manière")
	TriggerClientEvent("chatMessage", source, "Inventaire", {255, 0, 0}, "Touche '^2K^0' pour ouvrir l'inventaire")
end)
-- /regles
TriggerEvent('es:addCommand', 'regles', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Règles (HRP) du serveurs", {255, 0, 0}, "Le respect sous toutes ses formes, envers qui que se soit est obligatoire")
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "Il en va pour tous et envers tous, joueurs ou administrateurs, homme ou femme, TOUS.")
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "^3Pas de : freekill/freeshot/freepunch, spawnkill, troll, exploitation de bug, autres: ^2/metagame")
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "Les sanctions en cas de non respect des règles sont variables")
	TriggerClientEvent("chatMessage", source, "!-!", {255, 0, 0}, "Vous êtes sur un serveur ^2Hard Roleplay^0, ^1le ban est définitif^0.")
	TriggerClientEvent("chatMessage", source, "!-!", {255, 0, 0}, "Plus d'informations sur les règles du serveur sur notre forum: /forum")
end)
-- /metagame
TriggerEvent('es:addCommand', 'metagame', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Pas de", {255, 0, 0}, "^3Metagame^0: Mélanger le RP du HRP (Hors Roleplay)")
	TriggerClientEvent("chatMessage", source, "Pas de", {255, 0, 0}, "^3KO magique^0: Tout abus du système ou se souvenir des actions durant le KO")
	TriggerClientEvent("chatMessage", source, "Pas de", {255, 0, 0}, "^3NLR ^0(^3New Life Rule^0): Revenir sur le lieu (ou la scène RP) de votre mort/coma")
	TriggerClientEvent("chatMessage", source, "Pas de", {255, 0, 0}, "^3Revenge^0: Se venger de celui qui vous a, mis dans le coma ou, tué")
	TriggerClientEvent("chatMessage", source, "Pas de", {255, 0, 0}, "^3Powergame^0: Agir en NO-RP en exploitant le système du jeu de base")
end)
-- /help1
TriggerEvent('es:addCommand', 'help1', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Appeler la police", {255, 0, 0}, "^4/911 MESSAGE^0 pour signaler un crime")
	TriggerClientEvent("chatMessage", source, "Roleplay (RP)", {255, 0, 0}, "^4/me ^0pour ^1signaler ^0une action -seule- RP par écrit")
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "^3Exemple: ^1/me ^0fouille dans son nez")
	TriggerClientEvent("chatMessage", source, "ID", {255, 0, 0}, "^2/id ^0pour connaitre ton ID ou appuies sur la flèche du haut du clavier")
end)
--/help2
TriggerEvent('es:addCommand', 'help2', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Hors Roleplay (HRP)", {255, 0, 0}, "^4/ooc MESSAGE^0 pour envoyer un chat Hors RolePlay")
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "^3Exemple: ^1/ooc ^0Comment on change la touche pour parler ?") 
	TriggerClientEvent("chatMessage", source, "Argent liquide", {255, 0, 0}, "^4/pay ^1ID MONTANT^0 pour donner de l'argent -sur soi- à un joueur")
end)
-- /help3
TriggerEvent('es:addCommand', 'help3', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "A la mort", {255, 0, 0}, "Vous perdez tout votre argent que vous n'avez pas mis en banque ainsi que vos armes")
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "Vous perdez aussi votre statut -En service- (factions)")
	TriggerClientEvent("chatMessage", source, "LS Customs", {255, 0, 0}, "^3Provisoir^0: Aucune modification du véhicule n'est sauvegardée")
	TriggerClientEvent("chatMessage", source, "Contrôles du véhicule", {255, 0, 0}, "Touche '^2M^0' ou '^2?^0' pour ouvrir le menu du véhicule")
end)

--[[ COPIER-COLLER-MODIFIER
TriggerEvent('es:addCommand', '', function(source, args, user)
	TriggerClientEvent("chatMessage", source, ">", {255, 0, 0}, "")
end)]]--

-- Default commands
TriggerEvent('es:addCommand', 'discord', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "HELP", {255, 0, 0}, "https://discord.gg/Hq6tWdu")
end)

--[[ Default commands
TriggerEvent('es:addAdminCommand', 'delveh', 3, function(source, args, user)
	TriggerClientEvent("es_roleplay:deleteVehicle", source)
end, function(source, args, user)

end)
]]
-- Default commands
TriggerEvent('es:addCommand', 'pay', function(source, args, user)
	local amount = args[2]

	if(#args < 2 or #args > 3)then
		TriggerClientEvent('chatMessage', source, "Système", {255, 0, 0}, "Utilisation: ^2/pay (userid) (montant)")
		return
	end

	if(source == tonumber(args[2]))then
		TriggerClientEvent('chatMessage', source, "Système", {255, 0, 0}, "Tu ne peux pas te donner de l'argent à toi même.")
		return
	end

	if(tonumber(args[3]) > 0 and tonumber(args[3]) <= user.money)then
		TriggerEvent('es:getPlayerFromId', tonumber(args[2]), function(target)

			if(target)then
				if(get3DDistance(user.coords.x, user.coords.y, user.coords.z, target.coords.x, target.coords.y, target.coords.z) < 6.0) then
					TriggerClientEvent('chatMessage', source, "Système", {255, 0, 0}, "Payé a ^2" .. GetPlayerName(args[2]) .. ": ^3" .. args[3])
					TriggerClientEvent('chatMessage', tonumber(args[2]), "Système", {255, 0, 0}, "Reçu ^3" .. args[3] .. "^0 de ^2" .. GetPlayerName(source))
					
					user:removeMoney(tonumber(args[3]))
					target:addMoney(tonumber(args[3]))
				else
					TriggerClientEvent('chatMessage', source, "Système", {255, 0, 0}, "Reste proche du joueur.")
				end
			else
				TriggerClientEvent('chatMessage', source, "Système", {255, 0, 0}, "Le joueur n'existe pas.")
			end
		end)
	else
		TriggerClientEvent('chatMessage', source, "Système", {255, 0, 0}, "Tu n'as pas cette somme ou tu as entré un montant négatif.")
	end
end)

-- Default commands
TriggerEvent('es:addCommand', 'discord', function(source, args, user)
	TriggerClientEvent("chatMessage", source, "Discord", {255, 0, 0}, "https://discord.gg/Hq6tWdu")
end)

-- 911
TriggerEvent('es:addCommand', '911', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords
		table.remove(args, 1)
		local message = table.concat(args, " ")
		TriggerClientEvent('chatMessage', source, "POLICE", {255, 255, 0}, "" .. message)
		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(player_jobs[target['identifier']])then
						if(player_jobs[target['identifier']].job == "police" or player_jobs[target['identifier']].job == "ems" or player_jobs[target['identifier']].job == "fireman")then

							TriggerClientEvent('chatMessage', id, "POLICE", {255, 255, 0}, "" .. message)
						end
					end
				end)
			end
		end
	end)
	end)
end)

-- ME
TriggerEvent('es:addCommand', 'me', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6* " .. GetPlayerName(source) .. " (^0"..source.."^6) " .. message)
					end
				end)
			end
		end
	end)
	end)
end)

--[[ ID
TriggerEvent('es:addCommand', 'id', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					TriggerEvent("es_roleplay:getPlayerJob", user.identifier, function(job)
						local dJob = "None"
						if(job)then
							dJob = job.job .. " ^0(^2" .. job.id .. "^0)"
						end

						if(range < 10.0)then
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^2" .. GetPlayerName(source) .. "'s ID")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Name: ^2" .. GetPlayerName(source) .. "")
							TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "Job: ^2" .. dJob)
						end

					end)
				end)
			end
		end
	end)
	end)
end)]]

--[[ DO
TriggerEvent('es:addCommand', 'do', function(source, args, user)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local pos = user.coords

		table.remove(args, 1)
		local message = table.concat(args, " ")

		TriggerEvent('es:getPlayers', function(players)
		for id,_ in pairs(players) do
			if(GetPlayerName(id))then
				TriggerEvent('es:getPlayerFromId', id, function(target)
					local pPos = target.coords

					local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

					local tag = ""
					for k,v in ipairs(tags)do
						if(user.permission_level >= v.rank)then
							tag = v.tag
						end
					end

					if(range < 30.0)then
						TriggerClientEvent('chatMessage', id, "", {0, 0, 200}, "^6* " .. message .. " " .. GetPlayerName(source) .. " (^0"..source.."^6) ")
					end
				end)
			end
		end
	end)
	end)
end)]]

-- OOC
TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	table.remove(args, 1)
	local message = table.concat(args, " ")

	local tag = ""
	for k,v in ipairs(tags)do
		if(user.permission_level >= v.rank)then
			tag = v.tag
		end
	end

	TriggerClientEvent('chatMessage', -1, "OOC", {255, 0, 0}, tag .. "^4 " .. GetPlayerName(source) .. " ^4(^0"..source.."^4): ^0" .. message)
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(not startswith(message, "/"))then
		CancelEvent()
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local pos = user.coords

			TriggerEvent('es:getPlayers', function(players)
			for id,_ in pairs(players) do
				if(GetPlayerName(id))then
					TriggerEvent('es:getPlayerFromId', id, function(target)
						if(target)then
							local pPos = target.coords

							if(user.coords and target.coords)then
								local range = get3DDistance(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

								local tag = ""
								for k,v in ipairs(tags)do
									if(user.permission_level >= v.rank)then
										tag = v.tag
									end
								end

								if(range < 30.0)then
									TriggerClientEvent('chatMessage', id, "", {0, 0, 255}, tag .. "^4 " .. GetPlayerName(source) .. " ^4(^0"..source.."^4): ^0" .. message)
								end
							end
						end
					end)

				end
			end
			end)
		end)
	end
end)

AddEventHandler('es:invalidCommandHandler', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Commande inconnue, tape ^2/help^0 pour voir la liste.")
	CancelEvent()
end)