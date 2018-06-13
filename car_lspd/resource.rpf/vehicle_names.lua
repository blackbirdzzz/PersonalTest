function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()	

	AddTextEntry('0xAB7C8500', "FIB Oracle")
	AddTextEntry("0x3B014CB2", "HightWay P Bullet")
	AddTextEntry("0x4C3E1AF4", "LSPD Jackal")
	AddTextEntry("0x5E70BF59", "LSPD Oracle XS")
	AddTextEntry("0x8F4D2111", "LSPD Solair")
	AddTextEntry("0x9BD8FD47", "Unmarked Coquette")
	AddTextEntry("0x11AD09D8", "LSPD Coquette")
	AddTextEntry("0x26A5646C", "LSSD Bullet")
	AddTextEntry("0x43CCD9B0", "LSSD Coquette")
	AddTextEntry("0x61F64664", "LSPD Radius")
	AddTextEntry("0x295DBE34", "LSPD Pony")
	AddTextEntry("0x491D292A", "SAHP Coquette")
	AddTextEntry("0xB6C01C9B", "LSPD Infernus")
	AddTextEntry("0xB50FEC96", "FIB Pony")
	AddTextEntry("0xB954B300", "FIB Infernus")
	AddTextEntry("0xDAE169F6", "FIB Bullet")
	AddTextEntry("0xE8B44050", "LSSD Rancher")
	AddTextEntry("0xE37879E1", "LSPD Pinnacle")
	AddTextEntry("0xF6845F02", "Unmarked STD Stanier")
	AddTextEntry("0xFBA86638", "LSSD Interceptor")



end)


