# nb-chat
SA-MP Style Chat with clean codes and classic sa-mp coding style.

## Tap sounds 
You can turn it off in config.lua 

## Features
```
/ooc /o text
/close /c  text
/me text
/whisper id text
/local /l text
/b text --local ooc
/shout text
/do text
```

## colors format 
```
    local COLOR_WHITE   = "#FFFFFF"
    local COLOR_FADE1   = "#E6E6E6"
    local COLOR_FADE2   = "#C8C8C8"
    local COLOR_FADE3   = "#AAAAAA"
    local COLOR_FADE4   = "#8C8C8C"
    local COLOR_FADE5   = "#6E6E6E"
    local COLOR_PURPLE  = "#C2A2DA"
    local COLOR_DBLUE   = "#2641FE"
    local COLOR_ALLDEPT = "#FF8282"
    local COLOR_NEWS    = "#FFA500"
    local COLOR_OOC     = "#E0FFFF"
```

## exports 
```
exports["nb-rpchat"]:ProxDetector(distance,player,message,color1,color2,color3,color4,color5)
exports["nb-rpchat"]:OOCOff(color,message)
```

## example 

```
RegisterNetEvent("serverside:something",function(message)
    local message = message or ""
    local player = tonumber(source)
    local sendername = GetPlayerName(player)
    local str = string.format("(( %s: %s ))", sendername, message)
    exports["nb-rpchat"]:ProxDetector(30.0,player,str,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5)
    local newsmessage = string.format("NR %s: %s ", sendername, message)
    exports["nb-rpchat"]:OOCOff(COLOR_NEWS,newsmessage)
end)
```

![preview](https://github.com/negbook/nb-rpchat/blob/main/preview.png?raw=true)

