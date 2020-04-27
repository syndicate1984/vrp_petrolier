vRPpetrolierC = {}
Tunnel.bindInterface("vRP_petrolier",vRPpetrolierC)
Proxy.addInterface("vRP_petrolier",vRPpetrolierC)
vRP = Proxy.getInterface("vRP")
vRPSpetrolier = Tunnel.getInterface("vRP_petrolier","vRP_petrolier")

local hasJob = false
local faza1 = false
local faza2 = false
local incarcat = false
local text = false
local text2 = false
local cursaterminata = false

function CreateCar(x,y,z,heading) -- van
	local hash = GetHashKey("mixer2")
    local n = 0
    while not HasModelLoaded(hash) and n < 500 do
        RequestModel(hash)
        Citizen.Wait(10)
        n = n+1
    end
    -- spawn car
    if HasModelLoaded(hash) then
        veh = CreateVehicle(hash,x,y,z,heading,true,false)
        SetEntityHeading(veh,heading)
        SetEntityInvincible(veh,false)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleLights(veh,2)
        SetVehicleColours(veh,147,41)
        SetVehicleNumberPlateTextIndex(veh,2)
		SetVehicleNumberPlateText(veh,"Petrol")
		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetEntityAsMissionEntity(veh, true, true)
        for i = 0,24 do
            SetVehicleModKit(veh,0)
            RemoveVehicleMod(veh,i)
        end
    end    
end

function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not DoesEntityExist(veh) and hasJob then
            hasJob = false
            faza1 = false
            faza2 = false
            faza3 = false
            incarcat = false
            text = false
            text2 = false
            cursaterminata = false
            DeleteEntity(veh)
        end
        local carPos = GetEntityCoords(veh)
        local metri = math.floor(GetDistanceBetweenCoords(3311.3063964844,5176.2182617188,19.614583969116,GetEntityCoords(GetPlayerPed(-1))))
        local metri2 = math.floor(GetDistanceBetweenCoords(2926.9167480469,4301.8979492188,50.434585571289,GetEntityCoords(GetPlayerPed(-1))))
        local metri3 = math.floor(GetDistanceBetweenCoords(1372.0041503906,3623.0671386719,34.87410736084,GetEntityCoords(GetPlayerPed(-1))))
        local pos = GetEntityCoords(GetPlayerPed(-1))
        if faza1 == true then
            if metri2 <=4 then
                if not text then
                    DrawText3D(2926.9167480469,4301.8979492188,50.434585571289, "Apasa ~y~[E] ~w~pentru a incarca camionul", 1.2)
                    if IsControlJustPressed(1,51) then
                        if (Vdist(pos.x, pos.y, pos.z, carPos.x , carPos.y, carPos.z) <= 50.0) and hasJob and faza1 and DoesEntityExist(veh) then
                            if incarcat == false then   
                                FreezeEntityPosition(veh,true)
                                text = true
                                incarcat = true
                                faza2 = true
                                faza1 = false
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Asteapta"})
                                Wait(10000) 
                                vRP.notify({"Ai incarcat camionul"})
                                vRP.notify({"Du-te si livreaza"})
                                SetNewWaypoint(1373.8408203125,3613.7844238281)
                                FreezeEntityPosition(veh,false)
                            else
                                vRP.notify({"Ai deja camionul incarcat"})
                            end
                        else
                            vRP.notify({"De ce esti marlan"})
                            hasJob = false
                            faza1 = false
                            faza2 = false
                            incarcat = false
                            text = false
                            text2 = false
                            cursaterminata = false
                            DeleteEntity(veh)
                        end
                    end
                elseif text == true then
                    DrawText3D(2926.9167480469,4301.8979492188,50.434585571289, "~y~Du-te si livreaza petrolu", 1.2)
                end
            end
        end
        if faza2 then
            if metri3 <=4 then
                DrawText3D(1372.0041503906,3623.0671386719,34.87410736084, "Apasa ~y~[E] ~w~pentru a descarca", 1.2)
                if IsControlJustPressed(1,51) then         
                    if (Vdist(pos.x, pos.y, pos.z, carPos.x , carPos.y, carPos.z) <= 50.0) and hasJob and faza2 and DoesEntityExist(veh) then 
                        FreezeEntityPosition(veh,true)
                        vRP.notify({"Asteapta, se descarca camionul"})
                        Wait(10000) 
                        vRP.notify({"Asteapta"})
                        Wait(10000) 
                        cursaterminata = true
                        vRPSpetrolier.muiesyndicate({cursaterminata})
                        hasJob = false
                        faza1 = false
                        faza2 = false
                        incarcat = false
                        text = false
                        text2 = false
                        cursaterminata = false
                        DeleteEntity(veh)
                    else
                        vRP.notify({"De ce esti marlan"})
                        hasJob = false
                        faza1 = false
                        faza2 = false
                        incarcat = false
                        text = false
                        text2 = false
                        cursaterminata = false
                        DeleteEntity(veh)
                    end
                end
            end
        end
        if metri <=2 then
            DrawText3D(pos.x,pos.y,pos.z+0.3, "Apasa ~y~[E] ~w~pentru a incepe jobul", 1.2)
            if IsControlJustPressed(1,51) then
                if hasJob == false then
                    vRP.notify({"Du-te si incarca petrolu"})
                    hasJob = true
                    CreateCar(3321.9079589844,5149.1767578125,18.262245178223,150.0)
                    faza1 = true
                    SetNewWaypoint(2933.744140625,4306.7680664063)
                else
                    vRP.notify({"Ai deja jobul"})
                end
            end
        end
    end
end)