local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_petrolier")
vRPCpetrolier = Tunnel.getInterface("vRP_petrolier","vRP_petrolier")

vRPpetrolier = {}
Tunnel.bindInterface("vRP_petrolier",vRPpetrolier)
Proxy.addInterface("vRP_petrolier",vRPpetrolier)


function vRPpetrolier.muiesyndicate(cursatermianta)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local bani = math.random(250,500)
    if cursatermianta then
        vRP.giveMoney({user_id,bani})
        vRPclient.notify(player,{"Ai primit "..bani})
    end
end