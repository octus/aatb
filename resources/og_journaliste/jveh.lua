local jveh = {
	opened = false,
	title = "Garage journalistes",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Rumpo", costs = 0, description = {}, model = "rumpo"},
				--{name = "Ford Cruiser", costs = 0, description = {}, model = "j3"},
				--{name = "Mitsubishi Lancer", costs = 0, description = {}, model = "j2"},
				--{name = "BMW Patrouille", costs = 0, description = {}, model = "j"},
				--{name = "BMW j", costs = 0, description = {}, model = "jones1"},
				--{name = "Moto de j", costs = 0, description = {}, model = "jb"},			
			}
		},
	}
}

local fakecar = {model = '', car = nil}
local boughtcar = false
local vehicle_price = 0

function LocalPed()
return GetPlayerPed(-1)
end
-------------------------------------------------
----------------CONFIG SELECTION----------------
-------------------------------------------------
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = jveh.currentmenu
	if this == "main" then
		TriggerServerEvent('CheckJVeh',button.model)
	end
end
-------------------------------------------------
------------------FINISH AND CLOSE---------------
-------------------------------------------------
RegisterNetEvent('FinishJCheckForVeh')
AddEventHandler('FinishJCheckForVeh', function()
	boughtcar = true
	CloseVeh()
end)
-------------------------------------------------
-------------------PLAYER HAVE VEH---------------
-------------------------------------------------
function DoesPlayerHaveVehicle(model,button,y,selected)
		local t = false
		--TODO:check if player own car
		if t then
			drawMenuRight("OWNED",jveh.menu.x,y,selected)
		end
end
-------------------------------------------------
----------------CONFIG OPEN MENU-----------------
-------------------------------------------------
function OpenMenuVeh(menu)
	fakecar = {model = '', car = nil}
	jveh.lastmenu = jveh.currentmenu
	if menu == "main" then
		jveh.lastmenu = "main"
	end
	jveh.menu.from = 1
	jveh.menu.to = 10
	jveh.selectedbutton = 0
	jveh.currentmenu = menu
end
-------------------------------------------------
------------------DRAW NOTIFY--------------------
-------------------------------------------------
function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
-------------------------------------------------
------------------DRAW TITLE MENU----------------
-------------------------------------------------
function drawMenuTitle(txt,x,y)
local menu = jveh.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
------------------DRAW MENU BOUTON---------------
-------------------------------------------------
function drawMenuButton(button,x,y,selected)
	local menu = jveh.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
------------------DRAW MENU INFO-----------------
-------------------------------------------------
function drawMenuInfo(text)
	local menu = jveh.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end
-------------------------------------------------
----------------DRAW MENU DROIT------------------
-------------------------------------------------
function drawMenuRight(txt,x,y,selected)
	local menu = jveh.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end
-------------------------------------------------
-------------------DRAW TEXT---------------------
-------------------------------------------------
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
-------------------------------------------------
----------------CONFIG BACK MENU-----------------
-------------------------------------------------
function Back()
	if backlock then
		return
	end
	backlock = true
	if jveh.currentmenu == "main" then
		CloseVeh()
	elseif vehshop.currentmenu == "main" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
	else
		OpenMenuVeh(jveh.lastmenu)
	end
end
-------------------------------------------------
----------------FONCTION ???????-----------------
-------------------------------------------------
function f(n)
return n + 0.0001
end

function LocalPed()
return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end
-------------------------------------------------
----------------FONCTION OPEN--------------------
-------------------------------------------------
function OpenVeh() --OpenCreator
	boughtcar = false
	local ped = LocalPed()
	local pos = {452.115,-1018.106,28.478}
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	jveh.currentmenu = "main"
	jveh.opened = true
	jveh.selectedbutton = 0
end
-------------------------------------------------
----------------FONCTION CLOSE-------------------
-------------------------------------------------
function CloseVeh() -- Close Creator
	Citizen.CreateThread(function()
		local ped = LocalPed()
		if not boughtcar then
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))
			local plyCoords = GetEntityCoords(ped, 0)

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			jvehicle = CreateVehicle(model, plyCoords["x"], plyCoords["y"], plyCoords["z"],90.0,true,false)
			SetModelAsNoLongerNeeded(model)
			--[[for i,mod in pairs(mods) do
				SetVehicleModKit(jvehicle,0)
				SetVehicleMod(jvehicle,i,mod)
			end]]
			
			SetVehicleMod(jvehicle, 11, 2)
			SetVehicleMod(jvehicle, 12, 2)
			SetVehicleMod(jvehicle, 13, 2)
			SetVehicleEnginePowerMultiplier(jvehicle, 35.0)
			
			SetVehicleOnGroundProperly(jvehicle)
			SetVehicleHasBeenOwnedByPlayer(jvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(jvehicle)
			SetNetworkIdCanMigrate(id, true)
			Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(jvehicle))
			SetVehicleColours(jvehicle,colors[1],colors[2])
			SetVehicleExtraColours(jvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),jvehicle,-1)
			SetEntityVisible(ped,true)
			
			if DoesEntityExist(fakecar.car) then
				Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
			end
		end
		
		jveh.opened = false
		jveh.menu.from = 1
		jveh.menu.to = 10
	end)
end
-------------------------------------------------
----------------FONCTION OPEN MENU---------------
-------------------------------------------------
local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if GetDistanceBetweenCoords(-1099.238, -256.956, 37.687,GetEntityCoords(GetPlayerPed(-1))) > 5 then
			if jveh.opened then
				CloseVeh()
			end
		end
		if jveh.opened then
			local ped = LocalPed()
			local menu = jveh.menu[jveh.currentmenu]
			drawTxt(jveh.title,1,1,jveh.menu.x,jveh.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, jveh.menu.x,jveh.menu.y + 0.08)
			drawTxt(jveh.selectedbutton.."/"..tablelength(menu.buttons),0,0,jveh.menu.x + jveh.menu.width/2 - 0.0385,jveh.menu.y + 0.067,0.4, 255,255,255,255)
			local y = jveh.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= jveh.menu.from and i <= jveh.menu.to then

					if i == jveh.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,jveh.menu.x,y,selected)
					--if button.distance ~= nil then
						--drawMenuRight(button.distance.."m",jveh.menu.x,y,selected)
					--end
					y = y + 0.04
					if jveh.currentmenu == "main" then
						if selected then
								if fakecar.model ~= button.model then
									if DoesEntityExist(fakecar.car) then
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
									end
									local ped = LocalPed()
									local plyCoords = GetEntityCoords(ped, 0)
									local hash = GetHashKey(button.model)
									RequestModel(hash)
									while not HasModelLoaded(hash) do
										Citizen.Wait(0)
										drawTxt("~b~Chargement...",0,1,0.5,0.5,1.5,255,255,255,255)

									end
									local veh = CreateVehicle(hash,plyCoords["x"], plyCoords["y"], plyCoords["z"],90.0,false,false)
									while not DoesEntityExist(veh) do
										Citizen.Wait(0)
										drawTxt("~b~Chargement...",0,1,0.5,0.5,1.5,255,255,255,255)
									end
									FreezeEntityPosition(veh,true)
									SetEntityInvincible(veh,true)
									SetVehicleDoorsLocked(veh,4)
									--SetEntityCollision(veh,false,false)
									TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
									for i = 0,24 do
										SetVehicleModKit(veh,0)
										RemoveVehicleMod(veh,i)
									end
									fakecar = { model = button.model, car = veh}
								end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if jveh.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if jveh.selectedbutton > 1 then
					jveh.selectedbutton = jveh.selectedbutton -1
					if buttoncount > 10 and jveh.selectedbutton < jveh.menu.from then
						jveh.menu.from = jveh.menu.from -1
						jveh.menu.to = jveh.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if jveh.selectedbutton < buttoncount then
					jveh.selectedbutton = jveh.selectedbutton +1
					if buttoncount > 10 and jveh.selectedbutton > jveh.menu.to then
						jveh.menu.to = jveh.menu.to + 1
						jveh.menu.from = jveh.menu.from + 1
					end
				end
			end
		end

	end
end)
---------------------------------------------------
------------------EVENT SPAWN VEH------------------
---------------------------------------------------
RegisterNetEvent('jveh:spawnVehicle')
AddEventHandler('jveh:spawnVehicle', function(v)
	local car = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(car)
		while not HasModelLoaded(car) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)

		veh = CreateVehicle(car, playerCoords, 0.0, true, false)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
		SetEntityInvincible(veh, false)
	end
end)