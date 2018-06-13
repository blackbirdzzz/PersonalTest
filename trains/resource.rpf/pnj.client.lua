Citizen.CreateThread(function()

	function LoadTrainModels() -- f*ck your rails, too!
		tempmodel = GetHashKey("freight")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightcar")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightgrain")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightcont1")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freightcont2")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("freighttrailer")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("tankercar")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("metrotrain")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

		tempmodel = GetHashKey("s_m_m_lsmetro_01")
		RequestModel(tempmodel)
		while not HasModelLoaded(tempmodel) do
			RequestModel(tempmodel)
			Citizen.Wait(0)
		end

	end

	LoadTrainModels()


	TrainLocations = {
		{ 2533.0, 2833.0, 38.0},
		{ 2606.0, 2927.0, 40.0 },
		{ 2463.0, 3872.0, 38.8 },
		{ 1164.0, 6433.0, 32.0 },
		{ 537.0, -1324.1, 29.1 },
		{ 219.1, -2487.7, 6.0 }
	}

	function StartTrain()
		Citizen.Trace("a train has arrived") -- whee i must be host, lucky me
		local randomSpawn = math.random(#TrainLocations)
		local x, y, z = TrainLocations[randomSpawn][1], TrainLocations[randomSpawn][2], TrainLocations[randomSpawn][3] -- get some random locations for our spawn

		DeleteAllTrains()
		local type = math.random(1, 22)
		local train =  CreateMissionTrain(type, x, y, z, true)
		CreatePedInsideVehicle(train, 26, GetHashKey("s_m_m_lsmetro_01"), -1, 1, true)
		SetEntityAsMissionEntity(train, true, false)

		MetroTrain = CreateMissionTrain(24, 40.2, -1201.3, 31.0, true) -- these ones have pre-defined spawns since they are a pain to set up
		CreatePedInsideVehicle(MetroTrain, 26, GetHashKey("s_m_m_lsmetro_01"), -1, 1, true)
		SetEntityAsMissionEntity(MetroTrain,true,true)

		MetroTrain2 = CreateMissionTrain(24, -618.0, -1476.8, 16.2, true)
		CreatePedInsideVehicle(MetroTrain2, 26, GetHashKey("s_m_m_lsmetro_01"), -1, 1, true) -- create peds for the trains
		SetEntityAsMissionEntity(MetroTrain2,true,true)

	end

	RegisterNetEvent("StartTrain")
	AddEventHandler("StartTrain", StartTrain)

end)
