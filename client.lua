local job = nil
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('mp_pda:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	TriggerServerEvent('mp_pda:getJob')
end)
TriggerServerEvent('mp_pda:getJob')
RegisterNetEvent('mp_pda:setJob')
AddEventHandler('mp_pda:setJob',function(jobu)
	job = jobu
end)

local ped = PlayerPedId()--PlayerPedId()
local guiEnabled = false
local comiPDA = {x = 442.17, y = -978.94, z = 30.69}


RegisterNetEvent('mp_pda:on')
AddEventHandler('mp_pda:on',function()
    if not(IsPedInAnyVehicle(ped, true)) then
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_MOBILE", 16, true)
    end
    REQUEST_NUI_FOCUS(true)
    guiEnabled = true
end)

RegisterNUICallback('escape', function(data, cb)
    ClearPedTasks(ped)
    REQUEST_NUI_FOCUS(false)
    guiEnabled = false
end)

function EnableGui(enable)
    SetNuiFocus(enable)

    SendNUIMessage({
        type = "on",
        enable = enable
    })
end

function REQUEST_NUI_FOCUS(bool)
    SetNuiFocus(bool, bool) -- focus, cursor
    if bool == true then
        SendNUIMessage({type = "on", enable = true})
    else
        SendNUIMessage({type = "on", enable = false})
    end
    return bool
end


Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlterna
            DisableControlAction(0, 12, guiEnabled) 
            DisableControlAction(0, 13, guiEnabled) 
            DisableControlAction(0, 14, guiEnabled) 
            DisableControlAction(0, 15, guiEnabled) 
            DisableControlAction(0, 16, guiEnabled)
            DisableControlAction(0, 17, guiEnabled)  

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

        end
        if job == "police" then 
        	DrawMarker(1, comiPDA.x, comiPDA.y, comiPDA.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 50, 50, 204, 200, 0, 0, 0, 0)
        	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), comiPDA.x, comiPDA.y, comiPDA.z, true) <= 1 then
        		DisplayHelpText("Presione ~INPUT_CONTEXT~ para abrir la PDA desde el ordenador.")
        		if IsControlJustPressed(0,38) then 
        			TriggerEvent('mp_pda:on')
        		end
        	end
        end
    end
end)

function DisplayHelpText(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end