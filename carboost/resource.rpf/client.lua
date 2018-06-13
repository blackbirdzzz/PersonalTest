Citizen.CreateThread( function()
	local ped = GetPlayerPed( -1 )
	while true do 
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
			local veh = GetVehiclePedIsIn( ped, false )
			if( GetPedInVehicleSeat( veh, -1 ) == ped ) then
				if(GetVehicleClass(veh) == 7 or GetVehicleClass(veh) == 8 or GetVehicleClass(veh) == 19 or GetVehicleClass(veh) == 18) then
					SetVehicleEngineTorqueMultiplier( veh, 2 + 0.001 )
					SetVehicleEnginePowerMultiplier(veh, 2)
				end
			end
		end
		Citizen.Wait(1)
	end 
end )


