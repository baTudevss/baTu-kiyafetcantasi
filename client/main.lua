QBCore = exports['qb-core']:GetCoreObject()

local bag = false

exports.ox_target:addModel(baTu.propadi, {
    {
        event = 'baTu-kiyafetcantasi:pickupShoppingbag',
        icon = 'fas fa-hand-holding',
        label = baTu.Dil.AlCanta,
    },
    {
        event = 'baTu-kiyafetcantasi:CheckForOutfits',
        icon = 'fas fa-shopping-basket',
        label = baTu.Dil.AcCanta,
    },
    {
        event = 'baTu-kiyafetcantasi:moove',
        icon = 'fas fa-shopping-basket',
        label = baTu.Dil.tasiyorsunbrem,
    }
})

RegisterNetEvent('baTu-kiyafetcantasi:PutClotheBagDown')
AddEventHandler('baTu-kiyafetcantasi:PutClotheBagDown', function()
    local coords = GetEntityCoords(PlayerPedId())
    coords = coords + vector3(0.0, 0.5, -0.93)
    local heading = GetEntityHeading(PlayerPedId())

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
        bag = true
        QBCore.Functions.SpawnObject(baTu.propadi, coords, function(obj)
            Wait(50)
            SetEntityHeading(obj, heading)
        end)
    end
end)

RegisterNetEvent('baTu-kiyafetcantasi:CheckForOutfits')
AddEventHandler('baTu-kiyafetcantasi:CheckForOutfits', function()
    if not isTimeoutActive then
        isTimeoutActive = true

        SetTimeout(baTu.BeklemeSuresi * 60 * 1000, function()
            isTimeoutActive = false
        end)
        

        if baTu.Kiyafetmenusu == 'fivem-appearance' then
            exports['fivem-appearance']:openWardrobe(openWardrobe)
        elseif baTu.Kiyafetmenusu == 'illenium-appearance' then
            TriggerEvent('illenium-appearance:client:openOutfitMenu')
        end
    else
        lib.notify({ title = 'Kıyafet Çantası', description = 'Giysi çantasını bir kez açabilirsiniz '..baTu.BeklemeSuresi..' Dakikan Kaldı', type = 'error' })
    end
end)

RegisterNetEvent('baTu-kiyafetcantasi:pickupShoppingbag')
AddEventHandler('baTu-kiyafetcantasi:pickupShoppingbag', function()
    local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.5, GetHashKey(baTu.propadi))
    if object ~= 0 then
        NetworkRequestControlOfEntity(object)
        while not NetworkHasControlOfEntity(object) do
            Wait(10)
        end
        TriggerServerEvent('baTu-kiyafetcantasi:addShoppingbag', object)
        DeleteObject(object)
    else
        lib.notify({ title = 'Kıyafet Çantası', description = 'Yakınlarda çanta bulunamadı.', type = 'error' })
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Script ' .. resourceName .. ' Basladai.')
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    print('Script ' .. resourceName .. ' Script Durdu.')
end)
