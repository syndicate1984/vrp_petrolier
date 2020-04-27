resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "Made it by KreXaNu & Rares"

dependency "vrp"

client_scripts{ 
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
 	"client.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
  	"server.lua"
}