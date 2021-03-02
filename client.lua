local lastTruck = 0

local labels = {
    {"REDNECK_HELP1", "~b~Instructional Buttons: ~w~[~r~Beta Phase~w~]~n~~w~Press ~INPUT_CONTEXT~ to open~w~ compartment doors.~n~Press ~INPUT_DETONATE~ to toggle compartment lights.~n~Press ~INPUT_VEH_DUCK~ to toggle left scene lights.~n~Press ~INPUT_VEH_HEADLIGHT~ to toggle right scene lights.~n~Press ~INPUT_CELLPHONE_CAMERA_GRID~ to toggle rear scene lights.~n~Press ~INPUT_REPLAY_STARTPOINT~ to toggle rear ground lights."}
}

local vehs = {}
for k,v in ipairs(config.skeeter_vehicle) do
    table.insert(vehs, GetHashKey(v))
end

Citizen.CreateThread(function()

    for i = 1, #labels do
		AddTextEntry(labels[i][1], labels[i][2])
	end

    while true do
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, true)
        local pos = GetEntityCoords(ped)
        local vehLast = GetPlayersLastVehicle()
        local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(lastTruck), 1)

        if veh and has_value(vehs, GetEntityModel(veh)) then
           lastTruck = veh
        end

        if IsPedInAnyVehicle(ped,true) == false then

            if distanceToVeh < 6 then
                BeginTextCommandDisplayHelp(labels[1][1]) -- instructional information
                EndTextCommandDisplayHelp(0, 0, 1, -1)
                if IsControlJustPressed(0, 51) then 
                    if GetVehicleDoorAngleRatio(lastTruck, 5) > 0 and GetVehicleDoorAngleRatio(lastTruck, 4) > 0 then
                        SetVehicleDoorShut(lastTruck, 5, false)
                        SetVehicleDoorShut(lastTruck, 4, false)
                        print("[Vehicle] Trunk Closed.")
                    else
                        SetVehicleDoorOpen(lastTruck, 5, false, false)
                        SetVehicleDoorOpen(lastTruck, 4, false, false)
                        print("[Vehicle] Trunk Opened.")
                    end
                end
            end

            if distanceToVeh < 6 then
                if IsControlJustPressed(0, 47) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 11) then
                        SetVehicleExtra(lastTruck, 11, 1)
                        print("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 11, 0)
                        print("[Vehicle] Extra On.")
                    end
                end
            end

            if distanceToVeh < 6 then
                if IsControlJustPressed(0, 73) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 8) then
                        SetVehicleExtra(lastTruck, 8, 1)
                        print("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 8, 0)
                        print("[Vehicle] Extra On.")
                    end
                end
            end

            if distanceToVeh < 6 then
                if IsControlJustPressed(0, 74) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 9) then
                        SetVehicleExtra(lastTruck, 9, 1)
                        print("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 9, 0)
                        print("[Vehicle] Extra On.")
                    end
                end
            end

            if distanceToVeh < 6 then
                if IsControlJustPressed(0, 183) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 10) then
                        SetVehicleExtra(lastTruck, 10, 1)
                        print("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 10, 0)
                        print("[Vehicle] Extra On.")
                    end
                end
            end

            if distanceToVeh < 6 then
                if IsControlJustPressed(0, 305) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 12) then
                        SetVehicleExtra(lastTruck, 12, 1)
                        print("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 12, 0)
                        print("[Vehicle] Extra On.")
                    end
                end
            end
        end
        Wait(0)
    end
end)

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end