function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0xDC352B56', 'escalade')
	AddTextEntry('0xB696E17E', 'onebeast')
	AddTextEntry('0xB6D3C89D', 'whitehawk')
	AddTextEntry('0xA95DBC1B', 'luxor3')
end)