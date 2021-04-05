ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mp_pda:getJob')
AddEventHandler('mp_pda:getJob',function()
	local source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('mp_pda:setJob',xPlayers[i],xPlayer.job.name)
		end
	end
end)


TriggerEvent('es:addCommand', 'pda', function(source, args, user)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == "police" then 
		TriggerClientEvent('mp_pda:on', source)
	end

end)

