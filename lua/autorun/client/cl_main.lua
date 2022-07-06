
local PANEL = {}
function PANEL:Init()
    self:SetSize( 100, 100 )
    self:SetPos( 0, 0)

    local w_,h_ = self:GetSize()
    self.html = vgui.Create( "DHTML" , self )
    self.html:SetPos( -6, -6 )
    self.html:SetSize( w_,h_ )
   
end
function PANEL:Size(w,h)
    self:SetSize( w,h )
    self.html:SetSize(w,h )
end
function PANEL:Link(link)
    if(IsValid(self.html)) then 
        local w_,h_ = self:GetSize()
        self.html:SetHTML("<body style='overflow: hidden;'><img src='"..link.."' width='"..w_.."' style='max-width: "..h_.."' onload='GearBox.show()'></body>")
    end
end
function PANEL:Paint( w, h )
    
end
vgui.Register( "htmlimage", PANEL, "Panel" )

local imgur_show_bool = CreateClientConVar( "imgur_show_chat_screen", "1", true, false)
IMGUTUI = IMGUTUI or {}

local function DrawImage( link)

    if(IMGUTUI.Screen != nil) then 
        if(IMGUTUI.Screen:IsValid()) then 
            IMGUTUI.Screen:Remove()
        end  
    end
    local w ,h = ScrW() * 0.4,ScrH() * 0.3
    IMGUTUI.Screen = vgui.Create( "DFrame" )
	IMGUTUI.Screen:SetPos( 10, 10)
	IMGUTUI.Screen:SetSize(w , h )
	IMGUTUI.Screen:SetTitle( " " )
	IMGUTUI.Screen:SetVisible( true )
	IMGUTUI.Screen:SetDraggable( false )  
	IMGUTUI.Screen:ShowCloseButton( false )
    IMGUTUI.Screen.Paint = nil
    IMGUTUI.Screen:SetScreenLock(true)

    IMGUTUI.html = vgui.Create( "htmlimage" , IMGUTUI.Screen )
    IMGUTUI.html:Size(w,h)
    IMGUTUI.html:Link(link)
    timer.Simple(10,function() 
        if IsValid(IMGUTUI.Screen) then  
            IMGUTUI.Screen:Remove()  
        end 
    end)
end
 
net.Receive("imgur_image_network",function() 
    if not imgur_show_bool:GetBool() then return end
    local data = net.ReadString()
    DrawImage( data)
end)