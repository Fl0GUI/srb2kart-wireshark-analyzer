nothing = {
  name= "PT_NOTHING"
}
servercfg = {
  name= "PT_SERVERCFG",
}
clientcmd = {
  name= "PT_CLIENTCMD",
}
clientmis = {
  name = "PT_CLIENTMIS",
}
client2cmd = {
  name = "PT_CLIENT2CMD",
}
client2mis = {
  name = "PT_CLIENT2MIS",
}
nodekeepalive = {
  name = "PT_NODEKEEPALIVE",
}
nodekeepalivemis = {
  name = "PT_NODEKEEPALIVEMIS",
}
servertics = {
  name = "PT_SERVERTICS",
}
serverrefuse = {
  name = "PT_SERVERREFUSE",
}
servershutdown = {
  name = "PT_SERVERSHUTDOWN",
}
clientquit = {
  name = "PT_CLIENTQUIT",
}
askinfo = {
  name = "PT_ASKINFO",
}
serverinfo = {
  name = "PT_SERVERINFO",
  dissector = function (buffer, pinfo, tree)
    tree:add(buffer(2,16), "application: "..buffer(2,16):string())
    tree:add(buffer(18,2), "version: " .. buffer(18,1):uint() ..".".. buffer(19,1):uint())
  end
}
playerinfo = {
  name = "PT_PLAYERINFO",
}
requestfile = {
  name = "PT_REQUESTFILE",
}
askinfoviams = {
  name = "PT_ASKINFOVIAMS",
}
resynchend = {
  name = "PT_RESYNCHEND",
}
resynchget = {
  name = "PT_RESYNCHGET",
}
client3cmd = {
  name = "PT_CLIENT3CMD",
}
client3mis = {
  name = "PT_CLIENT3MIS",
}
client4cmd = {
  name = "PT_CLIENT4CMD",
}
client4mis = {
  name = "PT_CLIENT4MIS",
}
basickeepalive = {
  name = "PT_BASICKEEPALIVE",
}
filefragment = {
  name = "PT_FILEFRAGMENT",
}
textcmd = {
  name = "PT_TEXTCMD",
}
textcmd2 = {
  name = "PT_TEXTCMD2",
}
textcmd3 = {
  name = "PT_TEXTCMD3",
}
textcmd4 = {
  name = "PT_TEXTCMD4",
}
clientjoin = {
  name = "PT_CLIENTJOIN",
}
nodetimeout = {
  name = "PT_NODETIMEOUT",
}
resynching = {
  name = "PT_RESYNCHING",
}
tellfilesneeded = {
  name = "PT_TELLFILESNEEDED",
}
morefilesneeded = {
  name = "PT_MOREFILESNEEDED",
}
ping = {
  name = "PT_PING",
}

types = {
  [0] = nothing,
  servercfg,
  clientcmd,
  clientmis,
  client2cmd,
  client2mis,
  nodekeepalive,
  nodekeepalivemis,
  servertics,
  serverrefuse,
  servershutdown,
  clientquit,
  askinfo,
  serverinfo,
  playerinfo,
  requestfile,
  askinfoviams,
  resynchend,
  resynchget,
  client3cmd,
  client3mis,
  client4cmd,
  client4mis,
  basickeepalive,
  filefragment,
  textcmd,
  textcmd2,
  textcmd3,
  textcmd4,
  clientjoin,
  nodetimeout,
  resynching,
  tellfilesneeded,
  morefilesneeded,
  ping,
}

srb2kart_prot = Proto.new("srb2kart", "Srb2kart Protocol")
srb2kart_prot.fields.type = ProtoField.string("srb2kart.type", "packet type", base.ASCII)

function srb2kart_prot.dissector(buffer, pinfo, tree)
  packetType = types[buffer(6,1):uint()] or {name= "unkown"}

  local subtree = tree:add(srb2kart_prot,buffer(0, -1),"Srb2kart Network Package")
  local headerTree = subtree:add("header", buffer(0,8), "Packet header")

  headerTree:add(buffer(0,4),"checksum: " .. buffer(0,4))
  headerTree:add(buffer(4,1), "ack: "..buffer(4,1))
  headerTree:add(buffer(5,1), "ackret: "..buffer(5,1))
  headerTree:add(srb2kart_prot.fields.type, buffer(6,1), packetType.name)

  if packetType.dissector then
    packetType.dissector(buffer(8,-1), pinfo, subtree)
  else
    subtree:add(buffer(8, -1), "data", buffer(8, -1))
  end
end


udp_table = DissectorTable.get("udp.port")

udp_table:add(5029, srb2kart_prot)
