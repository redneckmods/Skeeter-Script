local lastTruck = 0
local vehs = {}

Citizen.CreateThread(function()
    for k,v in ipairs(config.skeeter_vehicle) do
        table.insert(vehs, GetHashKey(v))
    end
    while true do
        Citizen.Wait(0)
        local letSleep = true
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, true)
        local pos = GetEntityCoords(ped)
        local vehLast = GetPlayersLastVehicle()
        local distanceToVeh = #(pos - GetEntityCoords(lastTruck))

        if veh and has_value(vehs, GetEntityModel(veh)) then
           lastTruck = veh
        end

        if not IsPedInAnyVehicle(ped, true) then
            if distanceToVeh < 6 then
                letSleep = false
                ShowHelpText(config.label)
                if IsControlJustPressed(0, 51) then 
                    if GetVehicleDoorAngleRatio(lastTruck, 5) > 0 and GetVehicleDoorAngleRatio(lastTruck, 4) > 0 then
                        SetVehicleDoorShut(lastTruck, 5, false)
                        SetVehicleDoorShut(lastTruck, 4, false)
                        ShowText("[Vehicle] Trunk Closed.")
                    else
                        SetVehicleDoorOpen(lastTruck, 5, false, false)
                        SetVehicleDoorOpen(lastTruck, 4, false, false)
                        ShowText("[Vehicle] Trunk Opened.")
                    end
                end

                if IsControlJustPressed(0, 47) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 11) then
                        SetVehicleExtra(lastTruck, 11, 1)
                        ShowText("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 11, 0)
                        ShowText("[Vehicle] Extra On.")
                    end
                end

                if IsControlJustPressed(0, 73) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 8) then
                        SetVehicleExtra(lastTruck, 8, 1)
                        ShowText("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 8, 0)
                        ShowText("[Vehicle] Extra On.")
                    end
                end

                if IsControlJustPressed(0, 74) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 9) then
                        SetVehicleExtra(lastTruck, 9, 1)
                        ShowText("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 9, 0)
                        ShowText("[Vehicle] Extra On.")
                    end
                end

                if IsControlJustPressed(0, 183) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 10) then
                        SetVehicleExtra(lastTruck, 10, 1)
                        ShowText("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 10, 0)
                        ShowText("[Vehicle] Extra On.")
                    end
                end

                if IsControlJustPressed(0, 305) then 
                    if IsVehicleExtraTurnedOn(lastTruck, 12) then
                        SetVehicleExtra(lastTruck, 12, 1)
                        ShowText("[Vehicle] Extra Off.")
                    else
                        SetVehicleExtra(lastTruck, 12, 0)
                        ShowText("[Vehicle] Extra On.")
                    end
                end
            end
        end
        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

function ShowText(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(true, true)
end

function ShowHelpText(text)
    AddTextEntry("REDNECK_HELP", text)
    BeginTextCommandDisplayHelp("REDNECK_HELP")
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
