function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0x375B581D', 'crown6')
	AddTextEntry('0xCE745AED', 'charger6')
	AddTextEntry('0xFEFDC9FF', 'setina6')
end)