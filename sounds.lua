local resource = GetCurrentResourceName()
if Config.PlayTagSound then 
    RegisterNetEvent(resource..':playchatsound_tap', function()
      local IsSoundable = not (tonumber(GetExternalKvpString("chat","hideState")  or -1) == 2) 
      if IsSoundable then 
           PlaySoundFrontend(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE",true)
      end
    end)
end 