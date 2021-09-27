local lastTruck = nil

--
-- Threads
--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerId       = PlayerPedId()
        local currentVehicle = GetVehiclePedIsIn(playerId, true)
        local sleep          = 500

        if currentVehicle and currentVehicle ~= lastTruck then
            if Config.SkeeterVehicles[GetEntityModel(currentVehicle)] then
                lastTruck = currentVehicle
            end
        end

        if lastTruck and DoesEntityExist(lastTruck) and not IsPedInAnyVehicle(playerId, true) then
            local distanceToTruck = #(GetEntityCoords(playerId) - GetEntityCoords(lastTruck))

            if distanceToTruck < 6 then
                sleep = 0

                local currentState = getCurrentTruckState(lastTruck)

                Redneck.GUI.ShowAlert(formatAlertString(currentState))

                if IsControlJustPressed(0, 51) then 
                    if currentState.compartments then
                        SetVehicleDoorShut(lastTruck, 4, false)
                        Citizen.Wait(500)
                        SetVehicleDoorShut(lastTruck, 5, false)
                        
                        

                        Redneck.GUI.ShowNotification('Trunk closed.', nil, true, false)
                    else
                        SetVehicleDoorOpen(lastTruck, 5, false, false)
                        Citizen.Wait(500)
                        SetVehicleDoorOpen(lastTruck, 4, false, false)

                        Redneck.GUI.ShowNotification('Trunk opened.', nil, true, false)
                    end
                end

                if IsControlJustPressed(0, 47) then 
                    if currentState.compartmentLights then
                        updateVehicleExtra(lastTruck, 11, false)

                        Redneck.GUI.ShowNotification('Turned compartment lights off.', nil, true, false)
                    else
                        updateVehicleExtra(lastTruck, 11, true)

                        Redneck.GUI.ShowNotification('Turned compartment lights on.', nil, true, false)
                    end
                end

                if IsControlJustPressed(0, 73) then 
                    if currentState.leftSceneLights then
                        updateVehicleExtra(lastTruck, 8, false)

                        Redneck.GUI.ShowNotification('Turned left scene lights off.', nil, true, false)
                    else
                        updateVehicleExtra(lastTruck, 8, true)

                        Redneck.GUI.ShowNotification('Turned left scene lights on.', nil, true, false)
                    end
                end

                if IsControlJustPressed(0, 74) then 
                    if currentState.rightSceneLights then
                        updateVehicleExtra(lastTruck, 9, false)

                        Redneck.GUI.ShowNotification('Turned right scene lights off.', nil, true, false)
                    else
                        updateVehicleExtra(lastTruck, 9, true)

                        Redneck.GUI.ShowNotification('Turned right scene lights on.', nil, true, false)
                    end
                end

                if IsControlJustPressed(0, 311) then 
                    if currentState.rearSceneLights then
                        updateVehicleExtra(lastTruck, 10, false)

                        Redneck.GUI.ShowNotification('Turned rear scene lights off.', nil, true, false)
                    else
                        updateVehicleExtra(lastTruck, 10, true)

                        Redneck.GUI.ShowNotification('Turned rear scene lights on.', nil, true, false)
                    end
                end

                if IsControlJustPressed(0, 305) then 
                    if currentState.rearGroundLights then
                        updateVehicleExtra(lastTruck, 12, false)

                        Redneck.GUI.ShowNotification('Turned rear ground scene lights off.', nil, true, false)
                    else
                        updateVehicleExtra(lastTruck, 12, true)

                        Redneck.GUI.ShowNotification('Turned rear ground scene lights on.', nil, true, false)
                    end
                end
            end
        end
    end
end)

--
-- Functions
--

-- Returns the state of all relevant components and extras. True means
-- open or on, while false means closed or off.
function getCurrentTruckState(vehicleId)
    return {
        compartments      = (GetVehicleDoorAngleRatio(vehicleId, 5) > 0 or GetVehicleDoorAngleRatio(vehicleId, 4) > 0),
        compartmentLights = IsVehicleExtraTurnedOn(vehicleId, 11),
        leftSceneLights   = IsVehicleExtraTurnedOn(vehicleId, 8),
        rightSceneLights  = IsVehicleExtraTurnedOn(vehicleId, 9),
        rearSceneLights   = IsVehicleExtraTurnedOn(vehicleId, 10),
        rearGroundLights  = IsVehicleExtraTurnedOn(vehicleId, 12),
    }
end

-- Updates a vehicle exta safely, meaning it will check if the compartments
-- are open and, if so, re-open them since changing extras causes
-- the vehicle's doors to shut.
function updateVehicleExtra(vehicleId, extraId, enable)
    local currentState = getCurrentTruckState(vehicleId)
    local disable      = not enable

    SetVehicleExtra(vehicleId, extraId, disable)

    if currentState.compartments then
        SetVehicleDoorOpen(vehicleId, 5, false, false)
        SetVehicleDoorOpen(vehicleId, 4, false, false)
    end    
end

-- Builds up an alert string that shows more relevant information, such as
-- if the extra is currently enabled or not.
function formatAlertString(currentState)
    return ('~INPUT_CONTEXT~ %s compartment doors.~n~~INPUT_DETONATE~ %s compartment lights.~n~~INPUT_VEH_DUCK~ %s left scene lights.~n~~INPUT_VEH_HEADLIGHT~ %s right scene lights.~n~~INPUT_REPLAY_SHOWHOTKEY~ %s rear scene lights.~n~~INPUT_REPLAY_STARTPOINT~ %s rear ground lights.'):format(
        currentState.compartments      and 'Close'    or 'Open',
        currentState.compartmentLights and 'Turn off' or 'Turn on',
        currentState.leftSceneLights   and 'Turn off' or 'Turn on',
        currentState.rightSceneLights  and 'Turn off' or 'Turn on',
        currentState.rearSceneLights   and 'Turn off' or 'Turn on',
        currentState.rearGroundLights  and 'Turn off' or 'Turn on'
    )
end
