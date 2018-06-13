function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	AddTextEntry('0x80294622', 'helinews')
	AddTextEntry('0x17BAA8EC', 'helinews2')
	AddTextEntry('0xFB966FCA', 'newsvan')
end)