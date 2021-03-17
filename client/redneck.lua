Redneck = {}

--
-- GUI Helpers
--

Redneck.GUI = {}

Redneck.GUI.ShowNotification = function(message, backgroundColor, flash, saveToBrief)   
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)

    if backgroundColor then
        ThefeedNextPostBackgroundColor(backgroundColor)
    end

    if type(flash) ~= 'boolean' then
        flash = false
    end

    if type(saveToBrief) ~= 'boolean' then
        saveToBrief = false
    end

    EndTextCommandThefeedPostTicker(flash, saveToBrief)
end

Redneck.GUI.ShowAlert = function(message, beep, duration)
    AddTextEntry('REDNECK_SKEETER_ALERT', message)

    if type(beep) ~= 'boolean' then
        beep = false
    end

    if type(duration) ~= 'number' then
        duration = -1
    end

    BeginTextCommandDisplayHelp('REDNECK_SKEETER_ALERT')
    EndTextCommandDisplayHelp(0, false, beep, duration)
end