QBCore = exports['qb-core']:GetCoreObject()
local move = false

RegisterNetEvent('baTu-kiyafetcantasi:moove')
AddEventHandler('baTu-kiyafetcantasi:moove', function()
    local playerPed = PlayerPedId()
    local object = GetClosestObjectOfType(GetEntityCoords(playerPed), 2.5, GetHashKey(baTu.propadi))
    local coords = GetEntityCoords(playerPed)
    coords = coords + vector3(0.0, 0.5, -0.93)
    local heading = GetEntityHeading(playerPed)
    local propModel = GetHashKey(baTu.propadi)

    RequestModel(propModel)
    while not HasModelLoaded(propModel) do
        Citizen.Wait(10)
    end
    
    lib.progressBar({
        duration = 1000,
        label = baTu.Dil.YerdenAl,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            dict = 'random@domestic',
            clip = 'pickup_low',
        },
    }) 

    NetworkRequestControlOfEntity(object)
    while not NetworkHasControlOfEntity(object) do
        Citizen.Wait(10)
    end
    DeleteObject(object)
    move = true
    lib.showTextUI(baTu.Yazietiketi)

    local prop = CreateObject(propModel, 0.0, 0.0, 0.0, true, true, true)
    AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 57005), 0.3900, -0.0600, -0.0600, -100.00, -180.00, -78.00, true, true, false, true, 1, true)
    
    while move do
        Citizen.Wait(0)
        local coords = GetEntityCoords(playerPed)
        coords = coords + vector3(0.0, 0.5, -0.93)
        local heading = GetEntityHeading(playerPed)

        if IsControlPressed(0, 38) then
            lib.hideTextUI()
            if lib.progressBar({
                duration = 1000,
                label = baTu.Dil.yerlestir,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    move = true,
                },
                anim = {
                    dict = 'random@domestic',
                    clip = 'pickup_low',
                },
            }) then
                move = false
                DetachEntity(prop, true, true)
                DeleteEntity(prop)
                lib.hideTextUI()
                QBCore.Functions.SpawnObject(baTu.propadi, coords, function(obj)
                    Wait(50)
                    SetEntityHeading(obj, heading)
                end)
            end
            break
        elseif IsControlPressed(0, 23) then
            lib.hideTextUI()
            TriggerServerEvent('baTu-kiyafetcantasi:addShoppingbag', object)
            move = false
            DetachEntity(prop, true, true)
            DeleteEntity(prop)
            break
        end
    end
end)
