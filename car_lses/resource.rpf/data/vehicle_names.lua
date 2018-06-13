function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0x91A6E9DA', 'lguard2')
	AddTextEntry('0xD09E6BCD', 'ambulance2')
	AddTextEntry('0x5B838199', 'ambulance3')
	AddTextEntry('0xD39F2260', 'emscar')
	AddTextEntry('0xA9C5BA34', 'emscar2')
	AddTextEntry('0xAF6D5F1F', 'emssuv')
	AddTextEntry('0xB44363B9', 'emsvan')
end)