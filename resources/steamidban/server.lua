--[[
Add SteamIDs in the blacklist

Example:
local blacklist = {
    "1100001000ee0",
    "1100001000e0e"
}
]]

local blacklist = {
}


RegisterServerEvent("rlPlayerActivated")
AddEventHandler("rlPlayerActivated", function()

    playersteamid = stringSplit(GetPlayerIdentifiers(source)[1], ":")[2]
	
	for _, steamid in pairs(blacklist) do
		if steamid == playersteamid then
			print("ID: " .. playersteamid .. " a été blacklisté du serveur.")
			DropPlayer(source, "Tu as été banni définitivement du serveur.")
		end
	end
	
end)

function stringSplit(self, delimiter)

  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
  
end