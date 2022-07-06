
util.AddNetworkString("imgur_image_network")
local function RegexGetImage( link , table )
    local base_ = "https://i.imgur.com.*$"
    local ret_ = nil 
    for key, value in ipairs(table) do     
        ret_ = string.match( link, base_ .. "?".. value )   
        if( ret_ != nil ) then      
            return ret_
        end
    end
    return ret_
end

local screentime = 0

 
hook.Remove('PlayerSay',"imgur_image_hook")
hook.Add("PlayerSay","imgur_image_hook",function(ply,msg)
    if not IsValid(ply) then return end
    local link_ = string.Trim(msg) 
    if(string.StartWith(link_, "!")) then 
        local m = RegexGetImage( link_ , {".png" , ".gif" , ".jpeg" , ".jpg"})
        if m != nil  then 
            if screentime > CurTime() then  
                return end
            screentime = CurTime() + 5
             net.Start("imgur_image_network")
             net.WriteString(m)
             net.Broadcast()
         end 
    end
   
end, HOOK_MONITOR_LOW )
 