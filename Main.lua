--==================================================================
-- SM1LE HUB v2.0 — Shrink or Hide
-- RightCtrl hides, — minimizes, ✕ closes.
--==================================================================

local AllowedPlaceId = 137541498231955
if game.PlaceId ~= AllowedPlaceId then return end
if _G.Sm1leHub and _G.Sm1leHub.Destroy then pcall(_G.Sm1leHub.Destroy) end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local lp = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==================================================================
-- ИНТРО
-- ==================================================================
local introGui = Instance.new("ScreenGui")
introGui.Name = "Sm1leIntro"
introGui.ResetOnSpawn = false
introGui.IgnoreGuiInset = true
introGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundColor3 = Color3.fromRGB(10, 2, 2)
introFrame.BorderSizePixel = 0
introFrame.Parent = introGui

local introTitle = Instance.new("TextLabel")
introTitle.Size = UDim2.new(0, 500, 0, 100)
introTitle.Position = UDim2.new(0.5, -250, 0.5, -50)
introTitle.BackgroundTransparency = 1
introTitle.Text = "SM1LE HUB"
introTitle.Font = Enum.Font.GothamBlack
introTitle.TextSize = 60
introTitle.TextColor3 = Color3.fromRGB(220, 20, 20)
introTitle.TextTransparency = 1
introTitle.Parent = introFrame

local introSubtitle = Instance.new("TextLabel")
introSubtitle.Size = UDim2.new(0, 300, 0, 40)
introSubtitle.Position = UDim2.new(0.5, -150, 0.5, 60)
introSubtitle.BackgroundTransparency = 1
introSubtitle.Text = "Shrink or Hide"
introSubtitle.Font = Enum.Font.Gotham
introSubtitle.TextSize = 24
introSubtitle.TextColor3 = Color3.fromRGB(200, 140, 140)
introSubtitle.TextTransparency = 1
introSubtitle.Parent = introFrame

local introVersion = Instance.new("TextLabel")
introVersion.Size = UDim2.new(0, 200, 0, 25)
introVersion.Position = UDim2.new(0.5, -100, 0.5, 95)
introVersion.BackgroundTransparency = 1
introVersion.Text = "by SM1LER"
introVersion.Font = Enum.Font.GothamMedium
introVersion.TextSize = 16
introVersion.TextColor3 = Color3.fromRGB(255, 70, 70)
introVersion.TextTransparency = 1
introVersion.Parent = introFrame

local fadeIn = TweenService:Create(introTitle, TweenInfo.new(1, Enum.EasingStyle.Quint), {TextTransparency = 0})
local fadeInSub = TweenService:Create(introSubtitle, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0.4), {TextTransparency = 0})
local fadeInVer = TweenService:Create(introVersion, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0.7), {TextTransparency = 0})
local scaleUp = TweenService:Create(introTitle, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 70})
local fadeOut = TweenService:Create(introFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})

fadeIn:Play()
fadeInSub:Play()
fadeInVer:Play()
fadeIn.Completed:Wait()
scaleUp:Play()
scaleUp.Completed:Wait()
task.wait(0.3)
fadeOut:Play()
fadeOut.Completed:Wait()
introGui:Destroy()

-- ==================================================================
-- ОСНОВНОЙ СКРИПТ
-- ==================================================================

local S = {
    autofarm = false, autohide = false, speed = false, jump = false,
    hitbox = false, fullbright = false, noclip = false, antiafk = false,
    invisible = false, besthidev2 = false, seekerFollow = false,
    aimbot = false, showfov = false, aimbotTeamCheck = false, aimbotVisibleCheck = false,
    esp = false, box = false, name = false, tracer = false, dist = false,
    espEggs = false, espCoins = false, espItemsBox = true, espItemsName = true, espItemsDist = true,
    spinbot = false, bighead = false, bouncy = false, lowgrav = false,
    dodge = false, attach = false, thirdperson = false, dodgeOnHit = false,
    safehide = false, xray = false, farmEgg = false, farmEggV2 = false,
    autoClick = true, resetTarget = false,
    theme = "Phantom", bgTransparency = 7,
    speedVal = 150, jumpVal = 200, hitboxVal = 2, aimbotFOV = 75,
    aimbotSmoothing = 1, aimbotTargetPart = "Head", teleTarget = "",
    dodgeIntensity = 5, safeHideType = "Behind", safeHidePart = "Head",
    seekerFollowDir = "Behind", farmV2Mode = "Pull", clickDelay = 0.2,
    teleportSpeed = "Instant", attachBodyPart = "Head"
}

local Themes = {
    Phantom = {
        ACCENT = Color3.fromRGB(180,180,180), ACCENT2 = Color3.fromRGB(0,0,0),
        BG = Color3.fromRGB(8,8,8), BG2 = Color3.fromRGB(16,16,16), BG3 = Color3.fromRGB(28,28,28),
        TXT = Color3.fromRGB(240,240,240), SUB = Color3.fromRGB(160,160,160),
        Stroke = Color3.fromRGB(50,50,50), SwitchOff = Color3.fromRGB(28,28,28),
        TitleGrad1 = Color3.fromRGB(255,255,255), TitleGrad2 = Color3.fromRGB(0,0,0),
        ByGrad1 = Color3.fromRGB(220,220,220), ByGrad2 = Color3.fromRGB(0,0,0)
    },
    Crimson = {
        ACCENT = Color3.fromRGB(220,20,20), ACCENT2 = Color3.fromRGB(0,0,0),
        BG = Color3.fromRGB(18,4,4), BG2 = Color3.fromRGB(28,6,6), BG3 = Color3.fromRGB(42,10,10),
        TXT = Color3.fromRGB(255,235,235), SUB = Color3.fromRGB(190,140,140),
        Stroke = Color3.fromRGB(100,10,10), SwitchOff = Color3.fromRGB(42,10,10),
        TitleGrad1 = Color3.fromRGB(255,30,30), TitleGrad2 = Color3.fromRGB(0,0,0),
        ByGrad1 = Color3.fromRGB(255,70,70), ByGrad2 = Color3.fromRGB(0,0,0)
    },
    Neon = {
        ACCENT = Color3.fromRGB(0,255,150), ACCENT2 = Color3.fromRGB(0,15,5),
        BG = Color3.fromRGB(3,10,5), BG2 = Color3.fromRGB(5,16,8), BG3 = Color3.fromRGB(8,24,12),
        TXT = Color3.fromRGB(220,255,235), SUB = Color3.fromRGB(120,200,150),
        Stroke = Color3.fromRGB(10,70,30), SwitchOff = Color3.fromRGB(8,24,12),
        TitleGrad1 = Color3.fromRGB(0,255,170), TitleGrad2 = Color3.fromRGB(0,20,5),
        ByGrad1 = Color3.fromRGB(50,255,180), ByGrad2 = Color3.fromRGB(0,20,5)
    },
    Royal = {
        ACCENT = Color3.fromRGB(255,200,0), ACCENT2 = Color3.fromRGB(15,5,0),
        BG = Color3.fromRGB(12,6,2), BG2 = Color3.fromRGB(20,10,3), BG3 = Color3.fromRGB(32,16,5),
        TXT = Color3.fromRGB(255,250,235), SUB = Color3.fromRGB(200,170,100),
        Stroke = Color3.fromRGB(90,40,5), SwitchOff = Color3.fromRGB(32,16,5),
        TitleGrad1 = Color3.fromRGB(255,220,30), TitleGrad2 = Color3.fromRGB(20,5,0),
        ByGrad1 = Color3.fromRGB(255,230,60), ByGrad2 = Color3.fromRGB(20,5,0)
    },
    Arctic = {
        ACCENT = Color3.fromRGB(100,200,255), ACCENT2 = Color3.fromRGB(0,10,30),
        BG = Color3.fromRGB(3,8,18), BG2 = Color3.fromRGB(5,14,28), BG3 = Color3.fromRGB(8,20,42),
        TXT = Color3.fromRGB(230,245,255), SUB = Color3.fromRGB(130,180,220),
        Stroke = Color3.fromRGB(10,50,100), SwitchOff = Color3.fromRGB(8,20,42),
        TitleGrad1 = Color3.fromRGB(130,220,255), TitleGrad2 = Color3.fromRGB(0,15,40),
        ByGrad1 = Color3.fromRGB(160,230,255), ByGrad2 = Color3.fromRGB(0,15,40)
    },
    Sakura = {
        ACCENT = Color3.fromRGB(255,150,180), ACCENT2 = Color3.fromRGB(20,3,8),
        BG = Color3.fromRGB(15,4,6), BG2 = Color3.fromRGB(24,6,10), BG3 = Color3.fromRGB(36,10,16),
        TXT = Color3.fromRGB(255,240,245), SUB = Color3.fromRGB(210,150,165),
        Stroke = Color3.fromRGB(100,20,35), SwitchOff = Color3.fromRGB(36,10,16),
        TitleGrad1 = Color3.fromRGB(255,170,195), TitleGrad2 = Color3.fromRGB(25,3,10),
        ByGrad1 = Color3.fromRGB(255,185,205), ByGrad2 = Color3.fromRGB(25,3,10)
    }
}

local currentTheme = Themes[S.theme]
local ACCENT = currentTheme.ACCENT; local ACCENT2 = currentTheme.ACCENT2
local BG = currentTheme.BG; local BG2 = currentTheme.BG2; local BG3 = currentTheme.BG3
local TXT = currentTheme.TXT; local SUB = currentTheme.SUB

local function corner(p,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r) c.Parent=p return c end
local function pad(p,t,b,l,r) local u=Instance.new("UIPadding") u.PaddingTop=UDim.new(0,t) u.PaddingBottom=UDim.new(0,b) u.PaddingLeft=UDim.new(0,l) u.PaddingRight=UDim.new(0,r) u.Parent=p return u end
local function gradient(p,c1,c2,rot) local g=Instance.new("UIGradient") g.Color=ColorSequence.new(c1,c2) g.Rotation=rot or 0 g.Parent=p return g end

local parent = (gethui and gethui()) or game:GetService("CoreGui")
local gui = Instance.new("ScreenGui")
gui.Name = "Sm1leHub"; gui.ResetOnSpawn = false; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.IgnoreGuiInset = true; gui.Parent = parent

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(520,440); main.Position = UDim2.fromScale(0.5,0.5); main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = BG; main.BorderSizePixel = 0; main.ClipsDescendants = true; main.Parent = gui; corner(main,16)
main.BackgroundTransparency = 0.07

local mst = Instance.new("UIStroke",main); mst.Color = currentTheme.Stroke; mst.Thickness = 1.5; mst.Transparency = 0

local header = Instance.new("Frame"); header.Size = UDim2.new(1,0,0,56); header.BackgroundColor3 = BG2; header.BorderSizePixel = 0; header.Parent = main; corner(header,16)
header.BackgroundTransparency = 0.07
local hfix = Instance.new("Frame"); hfix.Size = UDim2.new(1,0,0,16); hfix.Position = UDim2.new(0,0,1,-16); hfix.BackgroundColor3 = BG2; hfix.BorderSizePixel = 0; hfix.Parent = header
hfix.BackgroundTransparency = 0.07

local logo = Instance.new("TextLabel"); logo.Size = UDim2.fromOffset(40,40); logo.Position = UDim2.fromOffset(14,8)
logo.BackgroundTransparency = 1; logo.Font = Enum.Font.GothamBold; logo.Text = "❄️"; logo.TextSize = 28; logo.Parent = header

local titleC = Instance.new("TextLabel"); titleC.Size = UDim2.fromOffset(200,22); titleC.Position = UDim2.fromOffset(58,11)
titleC.BackgroundTransparency = 1; titleC.Font = Enum.Font.GothamBold; titleC.TextSize = 19; titleC.TextColor3 = TXT
titleC.Text = "SM1LE HUB v2.0"; titleC.TextXAlignment = Enum.TextXAlignment.Left; titleC.Parent = header
gradient(titleC, currentTheme.TitleGrad1, currentTheme.TitleGrad2, 0)

local byLabel = Instance.new("TextLabel"); byLabel.Size = UDim2.fromOffset(100,16); byLabel.Position = UDim2.fromOffset(58,29)
byLabel.BackgroundTransparency = 1; byLabel.Font = Enum.Font.GothamBlack; byLabel.TextSize = 11; byLabel.TextColor3 = TXT
byLabel.Text = "by SM1LER"; byLabel.TextXAlignment = Enum.TextXAlignment.Left; byLabel.Parent = header
gradient(byLabel, currentTheme.ByGrad1, currentTheme.ByGrad2, 0)

local statusL = Instance.new("TextLabel"); statusL.Size = UDim2.fromOffset(280,14); statusL.Position = UDim2.fromOffset(58,44)
statusL.BackgroundTransparency = 1; statusL.Font = Enum.Font.GothamMedium; statusL.TextSize = 9; statusL.TextColor3 = SUB
statusL.Text = "❄️ Shrink or Hide"; statusL.TextXAlignment = Enum.TextXAlignment.Left; statusL.Parent = header

local function hbtn(txt,x) local b=Instance.new("TextButton"); b.Size=UDim2.fromOffset(28,28); b.Position=UDim2.new(1,x,0,14)
b.BackgroundColor3=BG3; b.Text=txt; b.TextColor3=TXT; b.Font=Enum.Font.GothamBold; b.TextSize=15; b.AutoButtonColor=true; b.Parent=header; corner(b,8); return b end
local closeB = hbtn("✕",-40); local minB = hbtn("—",-74)

local body = Instance.new("Frame"); body.Size = UDim2.new(1,0,1,-56); body.Position = UDim2.fromOffset(0,56); body.BackgroundTransparency = 1; body.Parent = main
local side = Instance.new("Frame"); side.Size = UDim2.new(0,140,1,0); side.BackgroundColor3 = BG2; side.BorderSizePixel = 0; side.Parent = body; pad(side,12,12,10,10)
side.BackgroundTransparency = 0.07
local sl = Instance.new("UIListLayout",side); sl.Padding = UDim.new(0,6); sl.SortOrder = Enum.SortOrder.LayoutOrder
local content = Instance.new("Frame"); content.Size = UDim2.new(1,-140,1,0); content.Position = UDim2.fromOffset(140,0); content.BackgroundTransparency = 1; content.Parent = body

local tabs = {}; local pages = {}; local activeTab = nil

local function selectTab(name)
    activeTab = name
    for n,m in pairs(tabs) do 
        local on=(n==name)
        TweenService:Create(m.btn,TweenInfo.new(0.18),{BackgroundColor3=on and BG3 or BG2}):Play()
        m.accent.Visible=on; m.lbl.TextColor3=on and TXT or SUB
    end
    for n,p in pairs(pages) do p.Visible=(n==name); if p.Visible then p.CanvasPosition = Vector2.new(0, 0) end end
end

local tabOrder = 0
local function makeTab(name,icon)
    tabOrder+=1; local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,40); b.BackgroundColor3=BG2; b.AutoButtonColor=false; b.Text=""; b.LayoutOrder=tabOrder; b.Parent=side; corner(b,10)
    b.BackgroundTransparency = 0.07
    local acc=Instance.new("Frame"); acc.Size=UDim2.fromOffset(3,20); acc.Position=UDim2.fromOffset(0,10); acc.BackgroundColor3=ACCENT; acc.BorderSizePixel=0; acc.Visible=false; acc.Parent=b; corner(acc,2)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-16,1,0); lbl.Position=UDim2.fromOffset(14,0); lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.GothamMedium; lbl.TextSize=13.5; lbl.TextColor3=SUB; lbl.Text=icon.."  "..name; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=b
    tabs[name]={btn=b,accent=acc,lbl=lbl}
    b.MouseEnter:Connect(function() if activeTab~=name then b.BackgroundColor3=BG3 end end)
    b.MouseLeave:Connect(function() if activeTab~=name then b.BackgroundColor3=BG2 end end)
    b.MouseButton1Click:Connect(function() selectTab(name) end)
    local page=Instance.new("ScrollingFrame"); page.Size=UDim2.new(1,0,1,0); page.BackgroundTransparency=1; page.BorderSizePixel=0; page.ScrollBarThickness=3; page.ScrollBarImageColor3=ACCENT; page.CanvasSize=UDim2.new(0,0,0,0); page.AutomaticCanvasSize=Enum.AutomaticSize.Y; page.ScrollingDirection=Enum.ScrollingDirection.Y; page.Visible=false; page.Parent=content; pad(page,14,50,16,14)
    page.BottomImage = ""; page.TopImage = ""; page.ScrollBarImageTransparency = 0
    local pl=Instance.new("UIListLayout",page); pl.Padding=UDim.new(0,9); pl.SortOrder=Enum.SortOrder.LayoutOrder
    pages[name]=page; return page
end

local rowOrder = 0
local allRows = {}

local function makeToggle(page,label,desc,key,callback)
    rowOrder+=1; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,46); row.BackgroundColor3=BG2; row.BorderSizePixel=0; row.LayoutOrder=rowOrder; row.Parent=page; corner(row,10)
    row.BackgroundTransparency = 0.07
    local st=Instance.new("UIStroke",row); st.Color=currentTheme.Stroke; st.Thickness=1; st.Transparency=0.3
    local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-70,0,18); t.Position=UDim2.fromOffset(12,6); t.BackgroundTransparency=1; t.Font=Enum.Font.GothamMedium; t.TextSize=13.5; t.TextColor3=TXT; t.Text=label; t.TextXAlignment=Enum.TextXAlignment.Left; t.Parent=row
    local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,-70,0,13); d.Position=UDim2.fromOffset(12,25); d.BackgroundTransparency=1; d.Font=Enum.Font.Gotham; d.TextSize=10.5; d.TextColor3=SUB; d.Text=desc; d.TextXAlignment=Enum.TextXAlignment.Left; d.Parent=row
    local sw=Instance.new("Frame"); sw.Size=UDim2.fromOffset(44,24); sw.Position=UDim2.new(1,-56,0.5,-12); sw.BackgroundColor3=currentTheme.SwitchOff; sw.BorderSizePixel=0; sw.Parent=row; corner(sw,12)
    local knob=Instance.new("Frame"); knob.Size=UDim2.fromOffset(18,18); knob.Position=UDim2.fromOffset(3,3); knob.BackgroundColor3=TXT; knob.BorderSizePixel=0; knob.Parent=sw; corner(knob,9)
    local btn=Instance.new("TextButton"); btn.Size=UDim2.fromScale(1,1); btn.BackgroundTransparency=1; btn.Text=""; btn.Parent=row
    local function render() 
        local on=S[key]
        TweenService:Create(sw,TweenInfo.new(0.18),{BackgroundColor3=on and ACCENT or currentTheme.SwitchOff}):Play()
        TweenService:Create(knob,TweenInfo.new(0.18,Enum.EasingStyle.Back),{Position=on and UDim2.fromOffset(23,3) or UDim2.fromOffset(3,3)}):Play()
        TweenService:Create(st,TweenInfo.new(0.18),{Color=on and ACCENT or currentTheme.Stroke}):Play()
    end
    btn.MouseButton1Click:Connect(function() S[key]=not S[key]; render(); if callback then callback(S[key]) end end)
    render()
    table.insert(allRows, {type="toggle", row=row, st=st, t=t, d=d, sw=sw, knob=knob, key=key, page=page})
end

local function makeSlider(page,label,desc,key,min,max,default,callback)
    S[key]=S[key] or default; rowOrder+=1; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,70); row.BackgroundColor3=BG2; row.BorderSizePixel=0; row.LayoutOrder=rowOrder; row.Parent=page; corner(row,10)
    row.BackgroundTransparency = 0.07
    local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-70,0,18); t.Position=UDim2.fromOffset(12,8); t.BackgroundTransparency=1; t.Font=Enum.Font.GothamMedium; t.TextSize=13.5; t.TextColor3=TXT; t.Text=label; t.TextXAlignment=Enum.TextXAlignment.Left; t.Parent=row
    local valLabel=Instance.new("TextLabel"); valLabel.Size=UDim2.fromOffset(60,18); valLabel.Position=UDim2.new(1,-72,0,8); valLabel.BackgroundTransparency=1; valLabel.Font=Enum.Font.GothamBold; valLabel.TextSize=13; valLabel.TextColor3=ACCENT; valLabel.Text=tostring(S[key] or default); valLabel.TextXAlignment=Enum.TextXAlignment.Right; valLabel.Parent=row
    local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,-24,0,13); d.Position=UDim2.fromOffset(12,28); d.BackgroundTransparency=1; d.Font=Enum.Font.Gotham; d.TextSize=10.5; d.TextColor3=SUB; d.Text=desc; d.TextXAlignment=Enum.TextXAlignment.Left; d.Parent=row
    local bar=Instance.new("Frame"); bar.Size=UDim2.new(1,-24,0,8); bar.Position=UDim2.fromOffset(12,48); bar.BackgroundColor3=BG3; bar.BorderSizePixel=0; bar.Parent=row; corner(bar,4)
    local fill=Instance.new("Frame"); local ratio=((S[key] or default)-min)/(max-min); fill.Size=UDim2.fromScale(ratio,1); fill.BackgroundColor3=ACCENT; fill.BorderSizePixel=0; fill.Parent=bar; corner(fill,4)
    local dot=Instance.new("TextButton"); dot.Size=UDim2.fromOffset(16,16); dot.Position=UDim2.new(ratio,-8,0.5,-8); dot.BackgroundColor3=TXT; dot.Text=""; dot.Parent=bar; corner(dot,8); dot.ZIndex=2
    local hitArea=Instance.new("TextButton"); hitArea.Size=UDim2.new(1,0,1,0); hitArea.BackgroundTransparency=1; hitArea.Text=""; hitArea.Parent=bar
    local dragging=false; local inputConnection
    local function updateSlider(input) local relX=math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1); local val=min+math.floor((max-min)*relX+0.5); S[key]=val; fill.Size=UDim2.fromScale(relX,1); dot.Position=UDim2.new(relX,-8,0.5,-8); valLabel.Text=tostring(val); if callback then callback(val) end end
    local function startDrag(input) dragging=true; if inputConnection then inputConnection:Disconnect() end; inputConnection=UserInputService.InputChanged:Connect(function(input2) if dragging and (input2.UserInputType==Enum.UserInputType.MouseMovement or input2.UserInputType==Enum.UserInputType.Touch) then updateSlider(input2) end end); updateSlider(input) end
    local function stopDrag() dragging=false; if inputConnection then inputConnection:Disconnect(); inputConnection=nil end end
    hitArea.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then startDrag(input) end end)
    hitArea.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then stopDrag() end end)
    dot.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then startDrag(input) end end)
    dot.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then stopDrag() end end)
    UserInputService.InputEnded:Connect(function(input) if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.TouchEnded) and dragging then stopDrag() end end)
    table.insert(allRows, {type="slider", row=row, t=t, valLabel=valLabel, d=d, bar=bar, fill=fill, dot=dot, key=key, page=page})
end

local function makeTextbox(page,label,desc,key,default)
    rowOrder+=1; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,60); row.BackgroundColor3=BG2; row.BorderSizePixel=0; row.LayoutOrder=rowOrder; row.Parent=page; corner(row,10)
    row.BackgroundTransparency = 0.07
    local t=Instance.new("TextLabel"); t.Size=UDim2.new(1,-24,0,18); t.Position=UDim2.fromOffset(12,6); t.BackgroundTransparency=1; t.Font=Enum.Font.GothamMedium; t.TextSize=13.5; t.TextColor3=TXT; t.Text=label; t.TextXAlignment=Enum.TextXAlignment.Left; t.Parent=row
    local d=Instance.new("TextLabel"); d.Size=UDim2.new(1,-24,0,13); d.Position=UDim2.fromOffset(12,24); d.BackgroundTransparency=1; d.Font=Enum.Font.Gotham; d.TextSize=10.5; d.TextColor3=SUB; d.Text=desc; d.TextXAlignment=Enum.TextXAlignment.Left; d.Parent=row
    local box=Instance.new("TextBox"); box.Size=UDim2.new(1,-24,0,24); box.Position=UDim2.fromOffset(12,38); box.BackgroundColor3=BG3; box.TextColor3=TXT; box.Font=Enum.Font.GothamBold; box.TextSize=12; box.Text=S[key] or default; box.PlaceholderText="Enter text..."; box.PlaceholderColor3=SUB; box.Parent=row; corner(box,8)
    box.FocusLost:Connect(function(ep) S[key]=box.Text; if ep then box.Text=S[key] end end)
    table.insert(allRows, {type="textbox", row=row, t=t, d=d, box=box, key=key, page=page})
end

local function sectionInfo(page,text)
    rowOrder+=1; local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,0,0,0); l.AutomaticSize=Enum.AutomaticSize.Y; l.BackgroundTransparency=1; l.Font=Enum.Font.Gotham; l.TextSize=11.5; l.TextColor3=SUB; l.TextWrapped=true; l.RichText=true; l.TextXAlignment=Enum.TextXAlignment.Left; l.Text=text; l.LayoutOrder=rowOrder; l.Parent=page
    table.insert(allRows, {type="section", label=l, page=page})
end

local function applyTransparency(transp)
    main.BackgroundTransparency = transp; header.BackgroundTransparency = transp
    hfix.BackgroundTransparency = transp; side.BackgroundTransparency = transp
    for _, data in ipairs(allRows) do
        if data.type == "toggle" or data.type == "slider" or data.type == "textbox" then
            data.row.BackgroundTransparency = transp
        end
    end
end

local function applyTheme(themeName)
    S.theme = themeName; currentTheme = Themes[themeName]
    ACCENT = currentTheme.ACCENT; ACCENT2 = currentTheme.ACCENT2
    BG = currentTheme.BG; BG2 = currentTheme.BG2; BG3 = currentTheme.BG3
    TXT = currentTheme.TXT; SUB = currentTheme.SUB
    local transp = S.bgTransparency / 100
    main.BackgroundColor3 = BG; main.BackgroundTransparency = transp; mst.Color = currentTheme.Stroke
    header.BackgroundColor3 = BG2; header.BackgroundTransparency = transp
    hfix.BackgroundColor3 = BG2; hfix.BackgroundTransparency = transp
    side.BackgroundColor3 = BG2; side.BackgroundTransparency = transp
    if titleC:FindFirstChildOfClass("UIGradient") then titleC:FindFirstChildOfClass("UIGradient"):Destroy() end
    gradient(titleC, currentTheme.TitleGrad1, currentTheme.TitleGrad2, 0); titleC.TextColor3 = TXT
    if byLabel:FindFirstChildOfClass("UIGradient") then byLabel:FindFirstChildOfClass("UIGradient"):Destroy() end
    gradient(byLabel, currentTheme.ByGrad1, currentTheme.ByGrad2, 0); byLabel.TextColor3 = TXT
    statusL.TextColor3 = SUB; closeB.BackgroundColor3 = BG3; closeB.TextColor3 = TXT; minB.BackgroundColor3 = BG3; minB.TextColor3 = TXT
    for name, tabData in pairs(tabs) do
        local on = (activeTab == name)
        tabData.btn.BackgroundColor3 = on and BG3 or BG2; tabData.btn.BackgroundTransparency = transp
        tabData.accent.BackgroundColor3 = ACCENT; tabData.lbl.TextColor3 = on and TXT or SUB
    end
    for _, page in pairs(pages) do page.ScrollBarImageColor3 = ACCENT end
    for _, data in ipairs(allRows) do
        if data.type == "toggle" then
            data.row.BackgroundColor3 = BG2; data.row.BackgroundTransparency = transp
            data.st.Color = currentTheme.Stroke; data.t.TextColor3 = TXT; data.d.TextColor3 = SUB
            data.sw.BackgroundColor3 = S[data.key] and ACCENT or currentTheme.SwitchOff; data.knob.BackgroundColor3 = TXT
        elseif data.type == "slider" then
            data.row.BackgroundColor3 = BG2; data.row.BackgroundTransparency = transp
            data.t.TextColor3 = TXT; data.valLabel.TextColor3 = ACCENT; data.d.TextColor3 = SUB
            data.bar.BackgroundColor3 = BG3; data.fill.BackgroundColor3 = ACCENT; data.dot.BackgroundColor3 = TXT
        elseif data.type == "textbox" then
            data.row.BackgroundColor3 = BG2; data.row.BackgroundTransparency = transp
            data.t.TextColor3 = TXT; data.d.TextColor3 = SUB
            data.box.BackgroundColor3 = BG3; data.box.TextColor3 = TXT; data.box.PlaceholderColor3 = SUB
        elseif data.type == "section" then data.label.TextColor3 = SUB end
    end
end

applyTransparency(0.07)

-- ========== УТИЛИТЫ ==========
local function getChar(p) return p.Character or p.CharacterAdded:Wait() end
local function getRoot(p) return getChar(p):FindFirstChild("HumanoidRootPart") end
local function getHum(p) return getChar(p):FindFirstChildOfClass("Humanoid") end

local function isSeeker(p)
    local char = getChar(p)
    if not char then return false end
    local hl = char:FindFirstChild("Highlight")
    if hl then return hl.FillColor == Color3.fromRGB(255,0,0) end
    return p.TeamColor == BrickColor.new("Really red") or p.TeamColor == BrickColor.new("Bright red")
end
local function isHider(p)
    local char = getChar(p)
    if not char then return false end
    local hl = char:FindFirstChild("Highlight")
    if hl then return hl.FillColor == Color3.fromRGB(0,0,255) or hl.FillColor == Color3.fromRGB(0,255,0) end
    return p.TeamColor == BrickColor.new("Bright blue") or p.TeamColor == BrickColor.new("Cyan")
end

local function getWeapon()
    for _, t in ipairs(lp.Backpack:GetChildren()) do if t:IsA("Tool") then return t end end
    return getChar(lp):FindFirstChildOfClass("Tool")
end

local function getPlatforms()
    local plats = {}
    for _, v in ipairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Size.Y < 10 and v.Position.Y > -30 then
            if v.Size.X > 2 or v.Size.Z > 2 then table.insert(plats, v) end
        end
    end
    return plats
end

local function findSafeSpot()
    local myPos = getRoot(lp) and getRoot(lp).Position or Vector3.zero
    local plats = getPlatforms()
    if #plats == 0 then return myPos + Vector3.new(0, 10, 0) end
    for i = #plats, 2, -1 do local j = math.random(i); plats[i], plats[j] = plats[j], plats[i] end
    for _, block in ipairs(plats) do
        if block.Position.Y > -10 then
            local near = false
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= lp and isSeeker(p) and getRoot(p) then
                    if (block.Position - getRoot(p).Position).Magnitude < 50 then near = true break end
                end
            end
            if not near then return Vector3.new(block.Position.X, block.Position.Y + block.Size.Y/2 + 3, block.Position.Z) end
        end
    end
    local fb = plats[math.random(#plats)]
    return Vector3.new(fb.Position.X, fb.Position.Y + fb.Size.Y/2 + 3, fb.Position.Z)
end

local function getSafeUnderMapPos()
    local minY = math.huge
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then if v.Position.Y < minY then minY = v.Position.Y end end
    end
    local root = getRoot(lp)
    local x, z = root and root.Position.X or 0, root and root.Position.Z or 0
    return Vector3.new(x, minY - 10, z)
end

local function lockHover()
    local root = getRoot(lp) if not root then return end
    local existing = root:FindFirstChild("FarmHover") if existing then existing:Destroy() end
    local bv = Instance.new("BodyVelocity") bv.Name = "FarmHover" bv.Velocity = Vector3.new(0, 0, 0) bv.MaxForce = Vector3.new(1e6, 1e6, 1e6) bv.Parent = root
end
local function unlockHover()
    local root = getRoot(lp) if root then local bv = root:FindFirstChild("FarmHover") if bv then bv:Destroy() end end
end

-- ========== ПРОВЕРКА НА LOBBY ==========
local function isInLobby(obj)
    local current = obj
    while current do
        if current.Name == "Lobby" then return true end
        current = current.Parent
    end
    return false
end

-- ========== X-RAY ==========
local xrayHighlights = {}
local function enableXray()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lp and player.Character then
            local hl = Instance.new("Highlight")
            hl.Adornee = player.Character; hl.FillTransparency = 1; hl.OutlineTransparency = 0
            hl.OutlineColor = Color3.new(1, 0, 0); hl.Parent = player.Character
            table.insert(xrayHighlights, hl)
        end
    end
end
local function disableXray()
    for _, hl in ipairs(xrayHighlights) do if hl then hl:Destroy() end end
    xrayHighlights = {}
end

-- ========== CHARACTER ADDED ==========
lp.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if S.speed then local h = char:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = S.speedVal end end
    if S.jump then local h = char:FindFirstChildOfClass("Humanoid") if h then h.JumpPower = S.jumpVal end end
    if S.noclip then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    if S.invisible then for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.Transparency = 1 end end end
    if S.bighead then local head = char:FindFirstChild("Head") if head and head:IsA("BasePart") then head.Size = Vector3.new(6,6,6) end end
    if S.thirdperson then local h = char:FindFirstChildOfClass("Humanoid") if h then Camera.CameraSubject = h; Camera.CameraType = Enum.CameraType.Follow end end
end)

-- TABS
local pMain = makeTab("Main","🏠")
local pFarm = makeTab("Farm","🤖")
local pAimbot = makeTab("Aimbot","🎯")
local pESP = makeTab("ESP","👁️")
local pTeleport = makeTab("Teleport","📍")
local pFun = makeTab("Fun","🎪")
local pSettings = makeTab("Settings","⚙️")

-- Main
makeToggle(pMain,"X-Ray","Player highlight",false,function(v) S.xray=v if v then enableXray() else disableXray() end end)
makeToggle(pMain,"Auto Hide","Super hide mode",false,function(v) S.autohide=v if v then local safePos=findSafeSpot() task.spawn(function() while S.autohide do local myRoot=getRoot(lp) if myRoot and (myRoot.Position-safePos).Magnitude>5 then myRoot.CFrame=CFrame.new(safePos) end task.wait(0.5) end end) end end)
makeToggle(pMain,"Safe Hide","Hide near seeker",false,function(v) S.safehide=v if v then S.noclip=true local char=lp.Character if char then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end task.spawn(function() while S.safehide do local myRoot=getRoot(lp) if not myRoot then task.wait(0.5) continue end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=lp and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if not closestSeeker then task.wait(0.5) continue end local targetChar=getChar(closestSeeker) if targetChar then local targetPart=targetChar:FindFirstChild(S.safeHidePart) or targetChar:FindFirstChild("HumanoidRootPart") if targetPart then local offset=Vector3.zero if S.safeHideType=="Behind" then offset=targetPart.CFrame.LookVector*-3 elseif S.safeHideType=="Front" then offset=targetPart.CFrame.LookVector*3 elseif S.safeHideType=="Left" then offset=targetPart.CFrame.RightVector*-3 elseif S.safeHideType=="Right" then offset=targetPart.CFrame.RightVector*3 elseif S.safeHideType=="Above" then offset=Vector3.new(0,3,0) elseif S.safeHideType=="Below" then offset=Vector3.new(0,-3,0) elseif S.safeHideType=="Inside" then myRoot.CFrame=targetPart.CFrame myRoot.Velocity=Vector3.zero task.wait() continue end myRoot.CFrame=CFrame.new(targetPart.Position+offset) myRoot.Velocity=Vector3.zero end end task.wait() end end) else S.noclip=false local char=lp.Character if char then for _,p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end end end)
makeToggle(pMain,"Speed Boost","Move faster",false,function(v) S.speed=v; local h=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed=v and S.speedVal or 16 end end)
makeSlider(pMain,"Speed Value","Walk speed","speedVal",50,300,150)
makeToggle(pMain,"Jump Power","Super jumps",false,function(v) S.jump=v; local h=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") if h then h.JumpPower=v and S.jumpVal or 50 end end)
makeSlider(pMain,"Jump Value","Jump power","jumpVal",50,300,200)
makeToggle(pMain,"Hitbox Expander","Bigger hitbox",false,function(v) S.hitbox=v; local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.Size=v and p.Size*S.hitboxVal or p.Size/S.hitboxVal end end end end)
makeSlider(pMain,"Hitbox Size","Expander multiplier","hitboxVal",1.5,5,2)
makeToggle(pMain,"Fullbright","Max brightness",false,function(v) S.fullbright=v; Lighting.Brightness=v and 3 or 1 end)
makeToggle(pMain,"Noclip","Walk through walls",false,function(v) S.noclip=v; local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=not v end end end end)
makeToggle(pMain,"Anti AFK","Auto jump every 30s",false,function(v) S.antiafk=v end)
makeToggle(pMain,"Invisible","Become invisible",false,function(v) S.invisible=v; local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=v and 1 or 0 end end end end)
makeToggle(pMain,"Best Hide V2","Hide under seeker",false,function(v) S.besthidev2=v if v then S.noclip=true task.spawn(function() while S.besthidev2 do if not isHider(lp) then task.wait(0.5) continue end local myRoot=getRoot(lp) if not myRoot then task.wait(0.5) continue end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=lp and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if closestSeeker and getRoot(closestSeeker) then local seekerRoot=getRoot(closestSeeker) local targetPos=seekerRoot.Position-Vector3.new(0,10,0) myRoot.CFrame=CFrame.new(targetPos) myRoot.Velocity=Vector3.zero local bv=Instance.new("BodyVelocity") bv.Velocity=Vector3.zero bv.MaxForce=Vector3.new(1e6,1e6,1e6) bv.Parent=myRoot game.Debris:AddItem(bv,0.1) end task.wait(0.3) end end) else S.noclip=false end end)
makeToggle(pMain,"Seeker Follow","Follow seeker",false,function(v) S.seekerFollow=v if v then task.spawn(function() while S.seekerFollow do if not isHider(lp) then task.wait(0.5) continue end local myRoot=getRoot(lp) if not myRoot then task.wait(0.5) continue end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=lp and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if closestSeeker and getRoot(closestSeeker) then local seekerRoot=getRoot(closestSeeker) local dir=S.seekerFollowDir local offset=Vector3.zero local look=seekerRoot.CFrame.LookVector local right=seekerRoot.CFrame.RightVector if dir=="Behind" then offset=-look*5 elseif dir=="Front" then offset=look*5 elseif dir=="Left" then offset=-right*5 elseif dir=="Right" then offset=right*5 end local targetPos=seekerRoot.Position+offset+Vector3.new(0,2,0) myRoot.CFrame=CFrame.new(targetPos) myRoot.Velocity=Vector3.zero local bv=Instance.new("BodyVelocity") bv.Velocity=Vector3.zero bv.MaxForce=Vector3.new(1e6,1e6,1e6) bv.Parent=myRoot game.Debris:AddItem(bv,0.1) end task.wait(0.1) end end) end end)

-- Farm
makeToggle(pFarm,"Auto Farm","Main farm toggle",false,function(v) S.autofarm=v if v then task.spawn(function() while S.autofarm do local weapon=getWeapon() if not weapon then local targetPos=findSafeSpot() local myRoot=getRoot(lp) if myRoot then if S.teleportSpeed=="Instant" then myRoot.CFrame=CFrame.new(targetPos) elseif S.teleportSpeed=="Fast" then local tween=TweenService:Create(myRoot,TweenInfo.new(0.15),{CFrame=CFrame.new(targetPos)}); tween:Play(); task.wait(0.15) elseif S.teleportSpeed=="Medium" then local tween=TweenService:Create(myRoot,TweenInfo.new(0.3),{CFrame=CFrame.new(targetPos)}); tween:Play(); task.wait(0.3) elseif S.teleportSpeed=="Slow" then local tween=TweenService:Create(myRoot,TweenInfo.new(0.6),{CFrame=CFrame.new(targetPos)}); tween:Play(); task.wait(0.6) end end else if S.autoClick then local closest,minDist=nil,math.huge local myRoot=getRoot(lp) if myRoot then for _,p in ipairs(Players:GetPlayers()) do if p~=lp and isHider(p) then local root=getRoot(p); local hum=getHum(p) if root and hum and hum.Health>0 then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist; closest=p end end end end end if closest and getRoot(closest) then local targetChar=getChar(closest) local targetPart=targetChar:FindFirstChild("Head") or getRoot(closest) if targetPart then local myRoot=getRoot(lp) if myRoot then myRoot.CFrame=targetPart.CFrame*CFrame.new(0,0,0.5) myRoot.Velocity=Vector3.zero end local tool=getWeapon() local char=getChar(lp) if tool and tool.Parent~=char then local hum=getHum(lp) if hum then hum:EquipTool(tool) end end if tool and tool:FindFirstChild("Handle") then local handle=tool.Handle if handle:IsA("BasePart") then handle.CFrame=targetPart.CFrame end end pcall(function() VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,0) task.wait(0.01) VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,0) end) pcall(function() tool:Activate() end) end end end end task.wait(S.clickDelay) end end) end end)
makeToggle(pFarm,"Auto Click","Auto attack with weapon",true,function(v) S.autoClick=v end)
makeSlider(pFarm,"Click Delay","Delay between clicks","clickDelay",0.001,0.5,0.2)
makeToggle(pFarm,"Farm Eggs","Collect eggs/coins",false,function(v) S.farmEgg=v if v then local wasNoclip=S.noclip if not wasNoclip then S.noclip=true local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end local safePos=getSafeUnderMapPos() local root=getRoot(lp) if root then root.CFrame=CFrame.new(safePos) end lockHover() task.spawn(function() while S.farmEgg do local root=getRoot(lp) if not root then break end local closest=nil for _,obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and not isInLobby(obj) then local n=obj.Name:lower() if n:find("egg") or n:find("coin") or n:find("money") or n:find("gem") or n:find("crystal") or n:find("chest") then closest=obj break end end end if closest and root and root.Parent then root.CFrame=CFrame.new(closest.Position+Vector3.new(0,3,0)) task.wait(0.1) if root and root.Parent then root.CFrame=CFrame.new(safePos) lockHover() end end task.wait(0.2) end unlockHover() if not wasNoclip then S.noclip=false local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end end end) end end)
makeToggle(pFarm,"Farm V2","Instant collect all",false,function(v) S.farmEggV2=v if v then local wasNoclip=S.noclip if not wasNoclip then S.noclip=true local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end local safePos=getSafeUnderMapPos() local root=getRoot(lp) if root then root.CFrame=CFrame.new(safePos) end lockHover() task.spawn(function() while S.farmEggV2 do local root=getRoot(lp) if not root then break end local allItems={} for _,obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and not isInLobby(obj) then local n=obj.Name:lower() if n:find("egg") or n:find("coin") or n:find("money") or n:find("gem") or n:find("crystal") or n:find("chest") then table.insert(allItems,obj) end end end if S.farmV2Mode=="Pull" then for _,obj in ipairs(allItems) do if obj and obj:IsA("BasePart") then obj.CFrame=root.CFrame*CFrame.new(0,5,0) obj.Velocity=Vector3.zero end end else for _,obj in ipairs(allItems) do if not root or not root.Parent then break end unlockHover() local targetPos=obj.Position+Vector3.new(0,-2,0) root.CFrame=CFrame.new(targetPos) lockHover() task.wait() end end task.wait(0.01) end unlockHover() if not wasNoclip then S.noclip=false local c=lp.Character if c then for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=true end end end end end) end end)

-- Aimbot
makeToggle(pAimbot,"Aimbot","Auto aim",false,function(v) S.aimbot=v end)
makeToggle(pAimbot,"Team Check","Ignore teammates",false,function(v) S.aimbotTeamCheck=v end)
makeToggle(pAimbot,"Visible Check","Only visible targets",false,function(v) S.aimbotVisibleCheck=v end)
makeSlider(pAimbot,"FOV","Aimbot field of view","aimbotFOV",50,300,75)
makeSlider(pAimbot,"Smoothing","Aim smoothing","aimbotSmoothing",0.05,1,1)
makeToggle(pAimbot,"FOV Circle","Show aim circle",false,function(v) S.showfov=v end)

-- ESP
makeToggle(pESP,"ESP","Enable ESP",false,function(v) S.esp=v end)
makeToggle(pESP,"Box","Player boxes",false,function(v) S.box=v end)
makeToggle(pESP,"Name","Player names",false,function(v) S.name=v end)
makeToggle(pESP,"Tracer","Lines to players",false,function(v) S.tracer=v end)
makeToggle(pESP,"Distance","Player distance",false,function(v) S.dist=v end)
makeToggle(pESP,"ESP Eggs","Highlight eggs",false,function(v) S.espEggs=v end)
makeToggle(pESP,"ESP Coins","Highlight coins",false,function(v) S.espCoins=v end)
makeToggle(pESP,"Items Box","Item boxes",true,function(v) S.espItemsBox=v end)
makeToggle(pESP,"Items Name","Item names",true,function(v) S.espItemsName=v end)
makeToggle(pESP,"Items Dist","Item distance",true,function(v) S.espItemsDist=v end)

-- Teleport
makeTextbox(pTeleport,"Target Name","Player name","teleTarget","")
makeToggle(pTeleport,"Teleport to Target","",false,function(v) if v and S.teleTarget~="" then for _,p in ipairs(Players:GetPlayers()) do if p.Name:lower():find(S.teleTarget:lower()) and p~=lp then local root=getRoot(p) if root then local myRoot=getRoot(lp) if myRoot then myRoot.CFrame=root.CFrame*CFrame.new(0,3,0) end break end end end S.teleTarget="" task.wait(0.1) end end)

-- Fun
makeToggle(pFun,"Spinbot","Spin around",false,function(v) S.spinbot=v local root=getRoot(lp) if not root then return end local av=root:FindFirstChild("SpinAV") if v then if not av then av=Instance.new("BodyAngularVelocity",root) av.Name="SpinAV" av.MaxTorque=Vector3.new(9e9,9e9,9e9) end av.AngularVelocity=Vector3.new(0,30,0) else if av then av:Destroy() end end end)
makeToggle(pFun,"Big Head","Huge head",false,function(v) S.bighead=v; local c=lp.Character if c then local h=c:FindFirstChild("Head") if h and h:IsA("BasePart") then h.Size=v and Vector3.new(6,6,6) or Vector3.new(2,1,2) end end end)
makeToggle(pFun,"Bouncy","Jump constantly",false,function(v) S.bouncy=v local root=getRoot(lp) if not root then return end local bv=root:FindFirstChild("BouncyVel") if v then if not bv then bv=Instance.new("BodyVelocity",root) bv.Name="BouncyVel" bv.MaxForce=Vector3.new(0,1e6,0) end bv.Velocity=Vector3.new(0,50,0) task.spawn(function() while S.bouncy do if root and bv then bv.Velocity=Vector3.new(0,50,0) end task.wait(0.1) end if bv then bv:Destroy() end end) else if bv then bv:Destroy() end end end)
makeToggle(pFun,"Low Gravity","Moon gravity",false,function(v) S.lowgrav=v; workspace.Gravity=v and 20 or 196.2 end)
makeToggle(pFun,"Dodge","Auto dodge",false,function(v) S.dodge=v if v then task.spawn(function() while S.dodge do local root=getRoot(lp) if not root then task.wait(0.1) continue end local dir=Vector3.new(math.random(-1,1),0,math.random(-1,1)).Unit local offset=dir*S.dodgeIntensity local newPos=root.Position+offset local safe=false for _,pl in ipairs(getPlatforms()) do if pl.Position.Y+pl.Size.Y/2>=newPos.Y-3 and pl.Position.Y-pl.Size.Y/2<=newPos.Y+3 and math.abs(pl.Position.X-newPos.X)<pl.Size.X/2+2 and math.abs(pl.Position.Z-newPos.Z)<pl.Size.Z/2+2 then safe=true break end end if safe then root.CFrame=CFrame.new(newPos) end task.wait(0.1) end end) end end)
makeToggle(pFun,"Dodge on Hit","Dodge when hit",false,function(v) S.dodgeOnHit=v if v then local hum=getHum(lp) if not hum then return end local prevHealth=hum.Health hum.HealthChanged:Connect(function(newHealth) if not S.dodgeOnHit then return end if newHealth<prevHealth then local myRoot=getRoot(lp) if not myRoot then return end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=lp and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if not closestSeeker then return end local targetRoot=getRoot(closestSeeker) if not targetRoot then return end local awayDir=(myRoot.Position-targetRoot.Position).Unit local safePos=myRoot.Position+awayDir*10 myRoot.CFrame=CFrame.new(safePos) task.spawn(function() task.wait(0.5) if not S.dodgeOnHit then return end if myRoot and targetRoot.Parent then myRoot.CFrame=targetRoot.CFrame end end) end prevHealth=newHealth end) end end)
makeToggle(pFun,"Attach to Seeker","Stick to seeker",false,function(v) S.attach=v if v then task.spawn(function() while S.attach do local myRoot=getRoot(lp) if not myRoot then task.wait(0.5) continue end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=lp and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if not closestSeeker then task.wait(0.5) continue end local targetChar=getChar(closestSeeker) if targetChar then local targetPart=targetChar:FindFirstChild(S.attachBodyPart) or targetChar:FindFirstChild("HumanoidRootPart") if targetPart then myRoot.CFrame=targetPart.CFrame end end task.wait() end end) end end)
makeToggle(pFun,"3rd Person","Third person view",false,function(v) S.thirdperson=v; local h=lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") if h then Camera.CameraSubject=v and h or h; Camera.CameraType=v and Enum.CameraType.Follow or Enum.CameraType.Custom end end)

-- Settings
sectionInfo(pSettings,"Choose UI Theme:")
for themeName,_ in pairs(Themes) do 
    makeToggle(pSettings, themeName, "Apply "..themeName.." theme", "theme_"..themeName:lower(), function(on)
        if on then
            applyTheme(themeName)
            for otherName,_ in pairs(Themes) do
                if otherName ~= themeName then S["theme_"..otherName:lower()] = false end
            end
        end
    end)
end
sectionInfo(pSettings,"Background Transparency:")
makeSlider(pSettings,"BG Transparency","0 = solid, 100 = invisible","bgTransparency",0,90,7, function(val) applyTransparency(val / 100) end)

S["theme_phantom"] = true
selectTab("Main")

-- Dragging
do local drag,sp,si; header.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true; sp=main.Position; si=i.Position; i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end) end end)
UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local dd=i.Position-si; main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dd.X,sp.Y.Scale,sp.Y.Offset+dd.Y) end end) end

local mini=false; minB.MouseButton1Click:Connect(function() mini=not mini; TweenService:Create(main,TweenInfo.new(0.2,Enum.EasingStyle.Quad),{Size=mini and UDim2.fromOffset(520,56) or UDim2.fromOffset(520,440)}):Play(); body.Visible=not mini end)
UserInputService.InputBegan:Connect(function(i,gpe) if gpe then return end; if i.KeyCode==Enum.KeyCode.RightControl then main.Visible=not main.Visible end end)

-- Noclip loop
RunService.Stepped:Connect(function()
    if S.noclip and lp.Character then
        for _,p in ipairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end
end)

-- Anti AFK
local afkRunning = false
task.spawn(function()
    while true do
        if S.antiafk and not afkRunning then afkRunning = true
            while S.antiafk do pcall(function() VirtualInputManager:SendKeyEvent(true,Enum.KeyCode.Space,false,game) task.wait(0.1) VirtualInputManager:SendKeyEvent(false,Enum.KeyCode.Space,false,game) end) task.wait(30) end
            afkRunning = false
        end
        task.wait(1)
    end
end)

-- ESP Drawing
local drawings = {}
local function createESP(p)
    pcall(function()
        local box=Drawing.new("Square"); box.Visible=false; box.Color=Color3.fromRGB(255,0,0); box.Thickness=2; box.Filled=false
        local name=Drawing.new("Text"); name.Visible=false; name.Color=Color3.fromRGB(255,255,255); name.Size=14; name.Center=true; name.Outline=true
        local tracer=Drawing.new("Line"); tracer.Visible=false; tracer.Color=Color3.fromRGB(255,0,0); tracer.Thickness=1
        local dist=Drawing.new("Text"); dist.Visible=false; dist.Color=Color3.fromRGB(255,255,255); dist.Size=12; dist.Center=true; dist.Outline=true
        drawings[p]={Box=box,Name=name,Tracer=tracer,Dist=dist}
    end)
end
for _,p in ipairs(Players:GetPlayers()) do if p~=lp then createESP(p) end end
Players.PlayerAdded:Connect(function(p) if p~=lp then createESP(p) end end)
Players.PlayerRemoving:Connect(function(p) if drawings[p] then for _,x in pairs(drawings[p]) do pcall(function() x:Remove() end) end; drawings[p]=nil end end)

-- FOV Circle
local FOVring = Drawing.new("Circle")
FOVring.Visible = false; FOVring.Thickness = 1.5; FOVring.Radius = S.aimbotFOV
FOVring.Color = Color3.fromRGB(255,255,255); FOVring.Filled = false

-- Item ESP
local itemDrawings = {}
local function createItemESP(obj, itemType, color)
    if itemDrawings[obj] then return end
    local box=Drawing.new("Square"); box.Visible=false; box.Color=color; box.Thickness=2; box.Filled=false
    local name=Drawing.new("Text"); name.Visible=false; name.Color=Color3.fromRGB(255,255,255); name.Size=14; name.Center=true; name.Outline=true; name.Text=itemType
    local dist=Drawing.new("Text"); dist.Visible=false; dist.Color=Color3.fromRGB(255,255,255); dist.Size=12; dist.Center=true; dist.Outline=true
    itemDrawings[obj]={Box=box,Name=name,Dist=dist}
end

-- Render loop
RunService.RenderStepped:Connect(function()
    -- FOV
    FOVring.Visible = S.showfov; FOVring.Radius = S.aimbotFOV; FOVring.Position = Camera.ViewportSize/2

    -- Aimbot
    if S.aimbot and getWeapon() and not S.thirdperson then
        local closest=nil; local minWorldDist=math.huge; local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2); local myRoot=getRoot(lp) if not myRoot then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p==lp then continue end
            if S.aimbotTeamCheck and p.Team==lp.Team then continue end
            if not isHider(p) then continue end
            if S.aimbotVisibleCheck then local char=p.Character if char and char:FindFirstChild("Head") then local ray=Ray.new(Camera.CFrame.Position,(char.Head.Position-Camera.CFrame.Position).Unit*500) local hit=workspace:FindPartOnRay(ray,char,false,true) if hit and hit.Parent~=char then continue end end end
            local root=getRoot(p); local hum=getHum(p) if not root or not hum or hum.Health<=0 then continue end
            local targetPart=root
            if S.aimbotTargetPart=="Head" then targetPart=p.Character:FindFirstChild("Head") or root
            elseif S.aimbotTargetPart=="Torso" then targetPart=p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or root
            elseif S.aimbotTargetPart=="Random" then local valid={} for _,partName in ipairs({"Head","UpperTorso","Torso","HumanoidRootPart"}) do local part=p.Character:FindFirstChild(partName) if part then table.insert(valid,part) end end targetPart=valid[math.random(#valid)] or root end
            local pos,onScreen=Camera:WorldToViewportPoint(targetPart.Position) if onScreen then local screenDist=(Vector2.new(pos.X,pos.Y)-center).Magnitude if screenDist<=S.aimbotFOV then local worldDist=(myRoot.Position-targetPart.Position).Magnitude if worldDist<minWorldDist then minWorldDist=worldDist; closest=targetPart end end end
        end
        if closest then local targetCFrame=CFrame.new(Camera.CFrame.Position,closest.Position) Camera.CFrame=Camera.CFrame:Lerp(targetCFrame,S.aimbotSmoothing) end
    end

    -- ESP
    if S.esp and drawings then
        local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        for p,d in pairs(drawings) do pcall(function()
            local char=p.Character; if not char then for _,x in pairs(d) do x.Visible=false end return end
            local root=char:FindFirstChild("HumanoidRootPart"); local hum=char:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health>0 then
                local pos,onScreen=Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local team=isSeeker(p) and "Seeker" or (isHider(p) and "Hider" or "?")
                    local color=team=="Seeker" and Color3.fromRGB(255,0,0) or (team=="Hider" and Color3.fromRGB(0,150,255) or Color3.fromRGB(255,255,255))
                    if S.box and char:FindFirstChild("Head") then
                        local hp=Camera:WorldToViewportPoint(char.Head.Position+Vector3.new(0,0.5,0))
                        local lp2=Camera:WorldToViewportPoint(root.Position-Vector3.new(0,3,0))
                        local h=math.abs(lp2.Y-hp.Y); local w=h*0.65
                        d.Box.Size=Vector2.new(w,h); d.Box.Position=Vector2.new(hp.X-w/2,hp.Y); d.Box.Color=color; d.Box.Visible=true
                    else d.Box.Visible=false end
                    if S.name then d.Name.Text=p.Name.." ["..team.."]"; d.Name.Position=Vector2.new(pos.X,pos.Y-40); d.Name.Visible=true else d.Name.Visible=false end
                    if S.tracer then d.Tracer.Color=color; d.Tracer.From=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y); d.Tracer.To=Vector2.new(pos.X,pos.Y); d.Tracer.Visible=true else d.Tracer.Visible=false end
                    if S.dist and myRoot then local dd=math.floor((myRoot.Position-root.Position).Magnitude); d.Dist.Text=dd.."m"; d.Dist.Position=Vector2.new(pos.X,pos.Y-55); d.Dist.Visible=true else d.Dist.Visible=false end
                else for _,x in pairs(d) do x.Visible=false end end
            else for _,x in pairs(d) do x.Visible=false end end
        end) end
    end

    -- Item ESP
    if (S.espEggs or S.espCoins) then
        local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        local currentItems = {}
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not isInLobby(obj) then
                local n=obj.Name:lower()
                if S.espEggs and n:find("egg") then currentItems[obj]="Egg"
                elseif S.espCoins and (n:find("coin") or n:find("money") or n:find("gem") or n:find("crystal") or n:find("chest")) then currentItems[obj]="Coin" end
            end
        end
        for obj,drawings2 in pairs(itemDrawings) do
            if not currentItems[obj] or not obj.Parent then drawings2.Box:Remove(); drawings2.Name:Remove(); drawings2.Dist:Remove(); itemDrawings[obj]=nil end
        end
        for obj,itemType in pairs(currentItems) do
            if not itemDrawings[obj] then createItemESP(obj,itemType,itemType=="Egg" and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,255,0)) end
        end
        for obj,drawings2 in pairs(itemDrawings) do
            if obj.Parent then
                local pos,onScreen=Camera:WorldToViewportPoint(obj.Position)
                if onScreen then
                    local size=24; drawings2.Box.Size=Vector2.new(size,size); drawings2.Box.Position=Vector2.new(pos.X-size/2,pos.Y-size/2); drawings2.Box.Visible=S.espItemsBox
                    drawings2.Name.Position=Vector2.new(pos.X,pos.Y-30); drawings2.Name.Visible=S.espItemsName
                    if myRoot then local d=math.floor((myRoot.Position-obj.Position).Magnitude); drawings2.Dist.Text=d.."m"; drawings2.Dist.Position=Vector2.new(pos.X,pos.Y-45); drawings2.Dist.Visible=S.espItemsDist end
                else drawings2.Box.Visible=false; drawings2.Name.Visible=false; drawings2.Dist.Visible=false end
            end
        end
    elseif not S.espEggs and not S.espCoins then
        for obj,drawings2 in pairs(itemDrawings) do drawings2.Box:Remove(); drawings2.Name:Remove(); drawings2.Dist:Remove() end
        itemDrawings = {}
    end
end)

closeB.MouseButton1Click:Connect(function() if _G.Sm1leHub then _G.Sm1leHub.Destroy() end end)

_G.Sm1leHub = {
    Destroy = function()
        for _,d in pairs(drawings) do for _,x in pairs(d) do pcall(function() x:Remove() end) end end
        for _,d in pairs(itemDrawings) do d.Box:Remove(); d.Name:Remove(); d.Dist:Remove() end
        FOVring:Remove()
        disableXray()
        if gui then gui:Destroy() end
        _G.Sm1leHub=nil
    end
}
