function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0x36F2D2CF', 'buffalo6')
	AddTextEntry('0x19CDD80A', 'mesa6')
end)