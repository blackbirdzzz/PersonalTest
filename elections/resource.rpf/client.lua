local Menu = false
local Menu1 = false
local choix = {}
local VoteAutor = false
local voteActif = false
local aftervote = false
local beforevote = false
local voted = {}
local voteRes = {}
local blipadded = false

function ajouterblip(item)
	local point = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(point, 419)
    SetBlipAsShortRange(point, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bureau de vote")
    EndTextCommandSetBlipName(point)
end

Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1), 0)
		for _, item in pairs(Points) do
			if not blipadded then
				ajouterblip(item)
				blipadded = true
			end
			local distance = (GetDistanceBetweenCoords(item.x, item.y, item.z, playerCoords["x"], playerCoords["y"], playerCoords["z"], true))
			if distance <= 10 then
				DrawMarker(1, item.x, item.y, item.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 0, 155, 255, 200, 0, 0, 0, 0)
			end
			if distance <= 1 then
				BeginTextCommandDisplayHelp("STRING")
    			AddTextComponentSubstringPlayerName("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir/fermer le bureau de vote")
    			EndTextCommandDisplayHelp(0, 0, 1, -1)
				if IsControlJustPressed(1, 51) then
					Menu = not Menu
					if Menu1 then
						Menu1 = false
					end
				end
				if Menu then
					if IsControlJustPressed(1, 177) then
						Menu = false
					end
					TriggerEvent("GUI:Title", "Elections")
					TriggerServerEvent('vote:voteactif')
					TriggerServerEvent('vote:Autor')
					if voteActif==true and VoteAutor then
						for _, item in pairs(CandidatList) do
							TriggerEvent("GUI:Option", item.nom, function(cb)
								if(cb) then
									Menu = false
									Menu1 = true
									choix.nom = item.nom
									choix.id = item.id
								end
							end)
						end
					elseif voteActif==true and not VoteAutor then
						TriggerEvent("GUI:Option", "Vous avez déjà voté, resultats le " .. votefini.day .. "/" .. votefini.month .. "/" .. votefini.year .. " à " .. votefini.hour .. "h", function(cb)
							if(cb) then
								Menu = false
							end
						end)
					elseif aftervote==true then
						local nbvoies = 0
						if voteRes == {} then
							TriggerServerEvent('vote:res')
							while voteRes == {} do
								Wait(1)
							end
						end
						for _, item in pairs(CandidatList) do
								nbvoies = 0
							for k,v in ipairs(voteRes) do
								if v.vote == item.id then
									nbvoies = v.compte
								end
							end
							TriggerEvent("GUI:Option", item.nom .. " - " .. nbvoies .. " Voie(s)", function(cb)
								if(cb) then
									Menu = false
								end
							end)
						end
					elseif beforevote==true then
						TriggerEvent("GUI:Option", "Les élections commencent le " .. votedebu.day .. "/".. votedebu.month .. "/" .. votedebu.year .. " à " .. votedebu.hour .. "h", function(cb)
							if(cb) then
								Menu = false
							end
						end)
					end
					TriggerEvent("GUI:Update")
				end
				if Menu1 then
					local pour = "pour "
					if IsControlJustPressed(1, 177) then
						Menu1 = false
						Menu = true
					end
					if choix.id == 10 or choix.id == 11 then
						pour = ""
					end
					TriggerEvent("GUI:Title", "Elections")
					TriggerEvent("GUI:Option", "Voulez-vous vraiment voter ".. pour .. choix.nom .. " ?", function(cb) end)
					TriggerEvent("GUI:Option", "Oui", function(cb)
						if(cb) then
							Menu1 = false
							TriggerServerEvent('vote:setVote', choix.id)
						end
					end)
					TriggerEvent("GUI:Option", "Non", function(cb)
						if(cb) then
							Menu1 = false
							Menu = true
						end
					end)
					TriggerEvent("GUI:Update")
				end
			end
		end
	end
end)

RegisterNetEvent('vote:isautorize')
AddEventHandler('vote:isautorize', function(voteAutori)
	VoteAutor = voteAutori
end)

RegisterNetEvent('vote:isactif')
AddEventHandler('vote:isactif', function(voteactif, beforevotei, aftervotei, votedi)
	voteActif = voteactif
	beforevote = beforevotei
	aftervote = aftervotei
	if aftervote == true then
		TriggerServerEvent('vote:res')
	end
end)

RegisterNetEvent('vote:ok')
AddEventHandler('vote:ok', function()
	SetNotificationTextEntry("STRING")
    AddTextComponentString('~g~A voté !')
    DrawNotification(true, false)
end)

RegisterNetEvent('vote:result')
AddEventHandler('vote:result', function(voteres)
	if not candidatstat then
		candidatstat = true
		voteRes = voteres
	end
end)