# srb2kart-wireshark-analyzer
a wireshark analyzer to dissect srb2kart network packages.

Drop the srb2kart.lua file into the plugin directory of wireshark before starting the application. The analyzer only works if srb2kart traffic is send with send or receive port 5029.

## dissected packages
- [x] header
- [ ] nothing
- [ ] servercfg
- [ ] clientcmd
- [ ] clientmis
- [ ] client2cmd
- [ ] client2mis
- [ ] nodekeepalive
- [ ] nodekeepalivemis
- [ ] servertics
- [ ] serverrefuse
- [ ] servershutdown
- [ ] clientquit
- [ ] askinfo
- [ ] serverinfo
- [ ] playerinfo
  - as proof of concept
  - [x] application
  - [x] version
- [ ] requestfile
- [ ] askinfoviams
- [ ] resynchend
- [ ] resynchget
- [ ] client3cmd
- [ ] client3mis
- [ ] client4cmd
- [ ] client4mis
- [ ] basickeepalive
- [ ] filefragment
- [ ] textcmd
- [ ] textcmd2
- [ ] textcmd3
- [ ] textcmd4
- [ ] clientjoin
- [ ] nodetimeout
- [ ] resynching
- [ ] tellfilesneeded
- [ ] morefilesneeded
- [ ] ping

plenty of work to be done ;) 
