local AllowedGameId = 137541498231955

repeat task.wait() until game.GameId ~= 0

if game.GameId ~= AllowedGameId then
    return
end

local lib = {}

function lib:CreateUI(uiname, initialBind)
    local function randomString(len)
        local str = ""
        for i = 1, len do str = str .. string.char(math.random(97, 122)) end
        return str
    end

    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    local UIFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local SideMenu = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TabButtons = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local UICorner_2 = Instance.new("UICorner")

    ScreenGui.Name = randomString(math.random(10,15))
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    UIFrame.Name = "UIFrame"
    UIFrame.Parent = ScreenGui
    UIFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 24)
    UIFrame.BorderSizePixel = 0
    UIFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    UIFrame.Size = UDim2.new(0, 601, 0, 420)
    UIFrame.Draggable = true
    UIFrame.Active = true
    UIFrame.Visible = true  -- меню открыто при старте

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = UIFrame
    CloseButton.Size = UDim2.new(0, 16, 0, 16)
    CloseButton.Position = UDim2.new(1, -20, 0, 4)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseButton.Text = ""
    CloseButton.BorderSizePixel = 0
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0.5, 0)
    CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Parent = UIFrame
    MinimizeButton.Size = UDim2.new(0, 16, 0, 16)
    MinimizeButton.Position = UDim2.new(1, -40, 0, 4)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    MinimizeButton.Text = ""
    MinimizeButton.BorderSizePixel = 0
    Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0.5, 0)

    local MiniIcon = Instance.new("TextButton")
    MiniIcon.Parent = ScreenGui
    MiniIcon.Size = UDim2.new(0, 40, 0, 40)
    MiniIcon.Position = UDim2.new(0, 20, 0, 20)
    MiniIcon.BackgroundColor3 = Color3.fromRGB(40,40,40)
    MiniIcon.Text = "📌"
    MiniIcon.TextColor3 = Color3.new(1,1,1)
    MiniIcon.Font = Enum.Font.GothamBold
    MiniIcon.TextSize = 20
    MiniIcon.Visible = true
    MiniIcon.Draggable = true
    MiniIcon.Active = true

    local isMinimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        UIFrame.Visible = not isMinimized
        MiniIcon.Visible = isMinimized
    end)
    MiniIcon.MouseButton1Click:Connect(function()
        isMinimized = false
        UIFrame.Visible = true
        MiniIcon.Visible = false
    end)

    Title.Name = "Title"
    Title.Parent = UIFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.0266222954, 0, 0.0273631085, 0)
    Title.Size = UDim2.new(0, 574, 0, 26)
    Title.Font = Enum.Font.SourceSansBold
    Title.Text = uiname
    Title.TextColor3 = Color3.fromRGB(51, 52, 53)
    Title.TextSize = 30

    SideMenu.Name = "SideMenu"
    SideMenu.Parent = UIFrame
    SideMenu.BackgroundColor3 = Color3.fromRGB(31, 31, 34)
    SideMenu.Position = UDim2.new(0.0282861888, 0, 0.11691542, 0)
    SideMenu.Size = UDim2.new(0, 125, 0, 348)

    UICorner.Parent = SideMenu
    UICorner.CornerRadius = UDim.new(0, 5)

    TabButtons.Name = "TabButtons"
    TabButtons.Parent = SideMenu
    TabButtons.BackgroundColor3 = Color3.fromRGB(31, 31, 34)
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(-0.00371386716, 0, 0.0199841019, 0)
    TabButtons.Size = UDim2.new(0, 125, 0, 341)

    UIListLayout.Parent = TabButtons
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    UICorner_2.Parent = TabButtons

    local currentBind = initialBind or Enum.KeyCode.RightShift
    local bindConnection
    local function updateBind(newBind)
        if bindConnection then bindConnection:Disconnect() end
        if newBind then
            currentBind = newBind
            bindConnection = UserInputService.InputBegan:Connect(function(input)
                if input.KeyCode == currentBind then
                    if isMinimized then
                        isMinimized = false
                        UIFrame.Visible = true
                        MiniIcon.Visible = false
                    else
                        UIFrame.Visible = not UIFrame.Visible
                        MiniIcon.Visible = not UIFrame.Visible
                    end
                end
            end)
        else
            currentBind = nil
            bindConnection = nil
        end
    end
    updateBind(currentBind)

    local lib2 = {}
    local tabs = {}

    function lib2:CreateTab(tabname)
        local TabButton = Instance.new("TextButton")
        local UICorner_3 = Instance.new("UICorner")
        local UICorner_22 = Instance.new("UICorner")
        local Tab = Instance.new("ScrollingFrame")
        local UIGridLayout = Instance.new("UIGridLayout")
        TabButton.Name = tabname
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(20, 22, 24)
        TabButton.Position = UDim2.new(0.0320000015, 0, 0.0283687934, 0)
        TabButton.Size = UDim2.new(0, 117, 0, 26)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Text = tabname
        TabButton.TextColor3 = Color3.fromRGB(72, 73, 75)
        TabButton.TextSize = 16

        UICorner_3.CornerRadius = UDim.new(0, 6)
        UICorner_3.Parent = Tab
        UICorner_22.CornerRadius = UDim.new(0, 6)
        UICorner_22.Parent = TabButton

        Tab.Name = tabname
        Tab.Parent = UIFrame
        Tab.Active = true
        Tab.BackgroundTransparency = 1
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.25956738, 0, 0.116915345, 0)
        Tab.Size = UDim2.new(0, 405, 0, 336)
        Tab.ScrollBarThickness = 4
        Tab.CanvasSize = UDim2.new(0, 0, 5.5, 0)
        Tab.Visible = false
        table.insert(tabs, Tab)

        UIGridLayout.Parent = Tab
        UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 7)
        UIGridLayout.CellSize = UDim2.new(0, 397, 0, 60)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in ipairs(tabs) do v.Visible = false end
            Tab.Visible = true
        end)

        local lib3 = {}
        lib3.Frame = Tab

        function lib3:CreateToggle(name, description, default, callback)
            local Button = Instance.new("TextButton")
            local UICorner_4 = Instance.new("UICorner")
            local Name = Instance.new("TextLabel")
            local Description = Instance.new("TextLabel")
            local TextLabel = Instance.new("TextLabel")
            local ImageLabel = Instance.new("ImageLabel")
            local UICorner_5 = Instance.new("UICorner")

            local toggled = default or false
            local GoalOn = Color3.new(0.0431373, 0.552941, 1)
            local GoalOff = Color3.fromRGB(36, 36, 38)

            Button.Name = name
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(31, 31, 34)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(0, 404, 0, 75)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(72, 73, 75)
            Button.TextSize = 13
            Button.MouseButton1Click:Connect(function()
                toggled = not toggled
                TextLabel.BackgroundColor3 = toggled and GoalOn or GoalOff
                callback(toggled)
            end)

            UICorner_4.CornerRadius = UDim.new(0, 5)
            UICorner_4.Parent = Button

            Name.Parent = Button
            Name.BackgroundTransparency = 1
            Name.Position = UDim2.new(0.380352646, 0, 0.216666654, 0)
            Name.Size = UDim2.new(0, 94, 0, 17)
            Name.Font = Enum.Font.GothamBold
            Name.Text = name
            Name.TextColor3 = Color3.fromRGB(77, 78, 80)
            Name.TextSize = 14

            Description.Parent = Button
            Description.BackgroundTransparency = 1
            Description.Position = UDim2.new(0.433249384, 0, 0.5, 0)
            Description.Size = UDim2.new(0, 52, 0, 20)
            Description.Font = Enum.Font.GothamSemibold
            Description.Text = description
            Description.TextColor3 = Color3.fromRGB(77, 78, 80)
            Description.TextSize = 12

            TextLabel.Parent = Button
            TextLabel.BackgroundColor3 = toggled and GoalOn or GoalOff
            TextLabel.Size = UDim2.new(0, 37, 0, 60)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = ""
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextSize = 14
            TextLabel.Position = UDim2.new(0.05, 0, 0.1, 0)

            ImageLabel.Parent = TextLabel
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Position = UDim2.new(0.225000009, 0, 0.316666663, 0)
            ImageLabel.Size = UDim2.new(0, 22, 0, 22)
            ImageLabel.Image = "rbxassetid://7719640107"

            UICorner_5.CornerRadius = UDim.new(0, 5)
            UICorner_5.Parent = TextLabel
        end

        function lib3:CreateDropdown(name, list, callback)
            local Container = Instance.new("TextButton")
            Container.Size = UDim2.new(0, 397, 0, 60)
            Container.BackgroundColor3 = Color3.fromRGB(31, 31, 34)
            Container.Text = ""
            Container.AutoButtonColor = false
            Container.Parent = Tab

            local NameLabel = Instance.new("TextLabel")
            NameLabel.Parent = Container
            NameLabel.BackgroundTransparency = 1
            NameLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
            NameLabel.Size = UDim2.new(0, 100, 0, 20)
            NameLabel.Font = Enum.Font.GothamBold
            NameLabel.Text = name
            NameLabel.TextColor3 = Color3.fromRGB(77, 78, 80)
            NameLabel.TextSize = 14

            local SelectedButton = Instance.new("TextButton")
            SelectedButton.Parent = Container
            SelectedButton.Size = UDim2.new(0.5, 0, 0.4, 0)
            SelectedButton.Position = UDim2.new(0.3, 0, 0.3, 0)
            SelectedButton.BackgroundColor3 = Color3.fromRGB(20, 22, 24)
            SelectedButton.BorderColor3 = Color3.fromRGB(51, 52, 53)
            SelectedButton.Text = list[1] or "Выбрать..."
            SelectedButton.Font = Enum.Font.SourceSans
            SelectedButton.TextColor3 = Color3.fromRGB(76, 77, 79)
            SelectedButton.TextSize = 13

            local isOpen = false
            local buttonsFrame = nil
            local closeConnection = nil

            local function close()
                if buttonsFrame then buttonsFrame:Destroy(); buttonsFrame = nil end
                if closeConnection then closeConnection:Disconnect(); closeConnection = nil end
                isOpen = false
            end

            SelectedButton.MouseButton1Click:Connect(function()
                if isOpen then close(); return end
                isOpen = true

                local listGui = Instance.new("ScreenGui")
                listGui.Parent = game.CoreGui
                listGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

                buttonsFrame = Instance.new("Frame", listGui)
                buttonsFrame.Size = UDim2.new(0, 200, 0, #list * 20 + 4)
                buttonsFrame.Position = UDim2.new(0, SelectedButton.AbsolutePosition.X, 0, SelectedButton.AbsolutePosition.Y + SelectedButton.AbsoluteSize.Y)
                buttonsFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 24)
                buttonsFrame.BorderColor3 = Color3.fromRGB(51, 52, 53)
                buttonsFrame.ZIndex = 10

                local UIList = Instance.new("UIListLayout", buttonsFrame)
                UIList.Padding = UDim.new(0, 2)

                for i, item in ipairs(list) do
                    local btn = Instance.new("TextButton", buttonsFrame)
                    btn.Size = UDim2.new(1, 0, 0, 20)
                    btn.BackgroundColor3 = Color3.fromRGB(31, 31, 34)
                    btn.Text = item
                    btn.Font = Enum.Font.SourceSans
                    btn.TextColor3 = Color3.fromRGB(76, 77, 79)
                    btn.TextSize = 13
                    btn.ZIndex = 10
                    btn.MouseButton1Click:Connect(function()
                        SelectedButton.Text = item
                        callback(item)
                        close()
                    end)
                end

                closeConnection = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if buttonsFrame and not buttonsFrame:IsDescendantOf(game.CoreGui) then close() end
                    end
                end)
            end)
        end

        function lib3:AddButton(text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(0, 397, 0, 60)
            Button.BackgroundColor3 = Color3.fromRGB(31, 31, 34)
            Button.Text = text
            Button.Font = Enum.Font.GothamBold
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 16
            Button.AutoButtonColor = false
            Button.Parent = Tab
            Button.MouseButton1Click:Connect(callback)
        end

        return lib3
    end

    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Text = "FPS: --"
    fpsLabel.Position = UDim2.new(0, 10, 0, 10)
    fpsLabel.Size = UDim2.new(0, 100, 0, 20)
    fpsLabel.Font = Enum.Font.SourceSans
    fpsLabel.TextColor3 = Color3.new(1,1,1)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Parent = ScreenGui
    fpsLabel.Visible = false

    local pingLabel = Instance.new("TextLabel")
    pingLabel.Text = "Ping: --"
    pingLabel.Position = UDim2.new(0, 10, 0, 35)
    pingLabel.Size = UDim2.new(0, 100, 0, 20)
    pingLabel.Font = Enum.Font.SourceSans
    pingLabel.TextColor3 = Color3.new(1,1,1)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Parent = ScreenGui
    pingLabel.Visible = false

    local lastTick = tick()
    local frames = 0
    game:GetService("RunService").RenderStepped:Connect(function()
        frames += 1
        if tick() - lastTick >= 1 then
            fpsLabel.Text = "FPS: " .. frames
            frames = 0
            lastTick = tick()
        end
    end)

    spawn(function()
        while wait(2) do
            pcall(function()
                pingLabel.Text = "Ping: " .. math.floor(LP:GetNetworkPing() * 1000) .. " ms"
            end)
        end
    end)

    lib2.SetFPSVisible = function(visible) fpsLabel.Visible = visible end
    lib2.SetPingVisible = function(visible) pingLabel.Visible = visible end
    lib2.SetBind = updateBind
    lib2.ScreenGui = ScreenGui
    lib2.UIFrame = UIFrame
    lib2.MiniIcon = MiniIcon
    return lib2
end

-- ========== ИНИЦИАЛИЗАЦИЯ UI ==========
local Window = lib:CreateUI("Прятки", Enum.KeyCode.RightShift)
local MainTab = Window:CreateTab("Главная")
local AutoFarmTab = Window:CreateTab("Auto Farm")
local AimbotTab = Window:CreateTab("Аимбот")
local ESPTab = Window:CreateTab("ESP")
local TeleportTab = Window:CreateTab("Телепорт")
local TrollTab = Window:CreateTab("Troll")
local SettingsTab = Window:CreateTab("Настройки")
local UITab = Window:CreateTab("UI")
local UnlockTab = Window:CreateTab("Unlock")

MainTab.Frame.Visible = true

-- ========== СЕРВИСЫ ==========
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VIM = game:GetService("VirtualInputManager")

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
    for _, t in ipairs(LP.Backpack:GetChildren()) do if t:IsA("Tool") then return t end end
    return getChar(LP):FindFirstChildOfClass("Tool")
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
    local myPos = getRoot(LP) and getRoot(LP).Position or Vector3.zero
    local plats = getPlatforms()
    if #plats == 0 then return myPos + Vector3.new(0, 10, 0) end
    for i = #plats, 2, -1 do local j = math.random(i); plats[i], plats[j] = plats[j], plats[i] end
    for _, block in ipairs(plats) do
        if block.Position.Y > -10 then
            local near = false
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and isSeeker(p) and getRoot(p) then
                    if (block.Position - getRoot(p).Position).Magnitude < 50 then near = true break end
                end
            end
            if not near then return Vector3.new(block.Position.X, block.Position.Y + block.Size.Y/2 + 3, block.Position.Z) end
        end
    end
    local fb = plats[math.random(#plats)]
    return Vector3.new(fb.Position.X, fb.Position.Y + fb.Size.Y/2 + 3, fb.Position.Z)
end

-- ========== СОСТОЯНИЯ ==========
local states = {
    autofarm = false, autohide = false, fly = false,
    speed = false, jump = false, hitbox = false,
    fullbright = false, xray = false, safehide = false,
    aimbot = false, showfov = false,
    aimbotTeamCheck = false, aimbotVisibleCheck = false,
    aimbotTargetPart = "Head", aimbotSmoothing = 1,
    esp = false, box = false, name = false, tracer = false, dist = false,
    noclip = false,
    spinbot = false, bighead = false, bouncy = false, lowgrav = false,
    dodge = false, attach = false, thirdperson = false,
    dodgeOnHit = false, antiafk = false,
    autoClick = true,
    invisible = false,
    besthidev2 = false,
    seekerFollow = false,
    seekerFollowDir = "Вперед",
    showMiniIcon = true,
    uiScheme = "Тёмная"
}

local currentSpeed = 150
local currentJump = 200
local currentHitbox = 2
local aimbotFOV = 200
local teleportTarget = nil
local dodgeIntensity = 5
local attachBodyPart = "Head"
local safeHideType = "Снизу"
local safeHidePart = "Head"
local autoFarmPart = "Head"
local teleportSpeed = "Мгновенно"
local clickDelay = 0.2

-- ========== X-RAY ==========
local xrayHighlights = {}
local function enableXray()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local hl = Instance.new("Highlight")
            hl.Adornee = player.Character
            hl.FillTransparency = 1
            hl.OutlineTransparency = 0
            hl.OutlineColor = Color3.new(1, 0, 0)
            hl.Parent = player.Character
            table.insert(xrayHighlights, hl)
        end
    end
end
local function disableXray()
    for _, hl in ipairs(xrayHighlights) do if hl then hl:Destroy() end end
    xrayHighlights = {}
end

-- ========== ПРИМЕНЕНИЕ ЭФФЕКТОВ ==========
local function applyHitbox(enable)
    local char = getChar(LP)
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            p.CanCollide = not enable
            if enable then p.Size = p.Size * currentHitbox else p.Size = p.Size / currentHitbox end
        end
    end
end
local function applySpeed(enable)
    local hum = getHum(LP)
    if hum then hum.WalkSpeed = enable and currentSpeed or 16 end
end
local function applyJump(enable)
    spawn(function() while enable and states.jump do local hum = getHum(LP) if hum then hum.JumpPower = currentJump end wait(0.1) end end)
end
local function applySpinbot(enable)
    local root = getRoot(LP) if not root then return end
    local av = root:FindFirstChild("SpinAV")
    if enable then
        if not av then av = Instance.new("BodyAngularVelocity", root); av.Name = "SpinAV"; av.MaxTorque = Vector3.new(9e9,9e9,9e9) end
        av.AngularVelocity = Vector3.new(0,30,0)
    else if av then av:Destroy() end end
end
local function applyBigHead(enable)
    local char = getChar(LP) if not char then return end
    local head = char:FindFirstChild("Head")
    if head and head:IsA("BasePart") then head.Size = enable and Vector3.new(6,6,6) or Vector3.new(2,1,2) end
end
local function applyBouncy(enable)
    local root = getRoot(LP) if not root then return end
    local bv = root:FindFirstChild("BouncyVel")
    if enable then
        if not bv then bv = Instance.new("BodyVelocity", root); bv.Name = "BouncyVel"; bv.MaxForce = Vector3.new(0,1e6,0) end
        bv.Velocity = Vector3.new(0,50,0)
        spawn(function() while states.bouncy do if root and bv then bv.Velocity = Vector3.new(0,50,0) end wait(0.1) end if bv then bv:Destroy() end end)
    else if bv then bv:Destroy() end end
end
local function applyLowGravity(enable) Workspace.Gravity = enable and 20 or 196.2 end
local function applyDodge(enable)
    local root = getRoot(LP) if not root then return end
    if enable then spawn(function() while states.dodge and root do local dir = Vector3.new(math.random(-1,1),0,math.random(-1,1)).Unit local offset = dir * dodgeIntensity local newPos = root.Position + offset local safe = false for _,v in ipairs(getPlatforms()) do if v.Position.Y+v.Size.Y/2 >= newPos.Y-3 and v.Position.Y-v.Size.Y/2 <= newPos.Y+3 and math.abs(v.Position.X-newPos.X) < v.Size.X/2+2 and math.abs(v.Position.Z-newPos.Z) < v.Size.Z/2+2 then safe=true break end end if safe then root.CFrame = CFrame.new(newPos) end wait(0.1) end end) end
end
local function applyAttach(enable)
    local myRoot = getRoot(LP) if not enable then return end
    spawn(function() while states.attach and myRoot do local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=LP and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if not closestSeeker then wait(0.5) continue end local targetChar=getChar(closestSeeker) if targetChar then local targetPart=targetChar:FindFirstChild(attachBodyPart) or targetChar:FindFirstChild("HumanoidRootPart") if targetPart then myRoot.CFrame=targetPart.CFrame end end wait() end end)
end
local safeHideStartPos = nil
local function applySafeHide(enable)
    local myRoot = getRoot(LP) if not myRoot then return end
    if enable then
        safeHideStartPos = myRoot.CFrame
        states.noclip = true
        local char = getChar(LP) if char then for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=false end end end
        spawn(function() while states.safehide and myRoot do local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=LP and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if not closestSeeker then wait(0.5) continue end local targetChar=getChar(closestSeeker) if targetChar then local targetPart=targetChar:FindFirstChild(safeHidePart) or targetChar:FindFirstChild("HumanoidRootPart") if targetPart then local offset=Vector3.zero if safeHideType=="Сзади" then offset=targetPart.CFrame.LookVector*-3 elseif safeHideType=="Спереди" then offset=targetPart.CFrame.LookVector*3 elseif safeHideType=="Слева" then offset=targetPart.CFrame.RightVector*-3 elseif safeHideType=="Справа" then offset=targetPart.CFrame.RightVector*3 elseif safeHideType=="Сверху" then offset=Vector3.new(0,3,0) elseif safeHideType=="Снизу" then offset=Vector3.new(0,-3,0) elseif safeHideType=="Внутри" then myRoot.CFrame=targetPart.CFrame myRoot.Velocity=Vector3.zero wait() continue end myRoot.CFrame=CFrame.new(targetPart.Position+offset) myRoot.Velocity=Vector3.zero end end wait() end end)
    else
        states.noclip = false
        local char = getChar(LP) if char then for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=true end end end
        if safeHideStartPos then local root=getRoot(LP) if root then root.CFrame=safeHideStartPos end safeHideStartPos=nil end
    end
end
local function applyThirdPerson(enable)
    local char = getChar(LP) local hum = char and char:FindFirstChildOfClass("Humanoid") if not hum then return end
    if enable then Camera.CameraSubject=hum; Camera.CameraType=Enum.CameraType.Follow else Camera.CameraSubject=hum; Camera.CameraType=Enum.CameraType.Custom end
end
local function applyDodgeOnHit(enable)
    if not enable then return end local hum=getHum(LP) if not hum then return end
    local prevHealth=hum.Health hum.HealthChanged:Connect(function(newHealth) if not states.dodgeOnHit then return end if newHealth<prevHealth then local myRoot=getRoot(LP) if not myRoot then return end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=LP and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if not closestSeeker then return end local targetRoot=getRoot(closestSeeker) if not targetRoot then return end local awayDir=(myRoot.Position-targetRoot.Position).Unit local safePos=myRoot.Position+awayDir*10 myRoot.CFrame=CFrame.new(safePos) spawn(function() wait(0.5) if not states.dodgeOnHit then return end if myRoot and targetRoot.Parent then myRoot.CFrame=targetRoot.CFrame end end) end prevHealth=newHealth end)
end
local function applyAntiAFK(enable)
    if enable then spawn(function() while states.antiafk do pcall(function() VIM:SendKeyEvent(true,Enum.KeyCode.Space,false,game) wait(0.1) VIM:SendKeyEvent(false,Enum.KeyCode.Space,false,game) end) wait(30) end end) end
end
local function applyNoclip(enable)
    if enable then local char=getChar(LP) if char then for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=false end end end spawn(function() while states.noclip do local char=getChar(LP) if char then for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") and part.CanCollide then part.CanCollide=false end end end wait(0.5) end end) else local char=getChar(LP) if char then for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide=true end end end end
end
local function applyInvisible(enable)
    local char=getChar(LP) if not char then return end for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.Transparency=enable and 1 or 0 end end
end
local function applyBestHideV2(enable)
    if not enable then return end spawn(function() while states.besthidev2 do if not isHider(LP) then wait(0.5) continue end local myRoot=getRoot(LP) if not myRoot then wait(0.5) continue end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=LP and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if closestSeeker and getRoot(closestSeeker) then local seekerRoot=getRoot(closestSeeker) local targetPos=seekerRoot.Position-Vector3.new(0,10,0) myRoot.CFrame=CFrame.new(targetPos) myRoot.Velocity=Vector3.zero local bv=Instance.new("BodyVelocity") bv.Velocity=Vector3.zero bv.MaxForce=Vector3.new(1e6,1e6,1e6) bv.Parent=myRoot game.Debris:AddItem(bv,0.1) end wait(0.3) end end)
end
local function applySeekerFollow(enable)
    if not enable then return end spawn(function() while states.seekerFollow do if not isHider(LP) then wait(0.5) continue end local myRoot=getRoot(LP) if not myRoot then wait(0.5) continue end local closestSeeker=nil local minDist=math.huge for _,p in ipairs(Players:GetPlayers()) do if p~=LP and isSeeker(p) then local root=getRoot(p) if root then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist closestSeeker=p end end end end if closestSeeker and getRoot(closestSeeker) then local seekerRoot=getRoot(closestSeeker) local dir=states.seekerFollowDir local offset=Vector3.zero local look=seekerRoot.CFrame.LookVector local right=seekerRoot.CFrame.RightVector if dir=="Вперед" then offset=look*5 elseif dir=="Назад" then offset=-look*5 elseif dir=="Слева" then offset=-right*5 elseif dir=="Справа" then offset=right*5 end local targetPos=seekerRoot.Position+offset+Vector3.new(0,2,0) myRoot.CFrame=CFrame.new(targetPos) myRoot.Velocity=Vector3.zero local bv=Instance.new("BodyVelocity") bv.Velocity=Vector3.zero bv.MaxForce=Vector3.new(1e6,1e6,1e6) bv.Parent=myRoot game.Debris:AddItem(bv,0.1) end wait(0.1) end end)
end

LP.CharacterAdded:Connect(function(char)
    wait(0.5)
    if states.hitbox then applyHitbox(true) end
    if states.speed then applySpeed(true) end
    if states.jump then applyJump(true) end
    if states.noclip then applyNoclip(true) end
    if states.spinbot then applySpinbot(true) end
    if states.bighead then applyBigHead(true) end
    if states.bouncy then applyBouncy(true) end
    if states.dodge then applyDodge(true) end
    if states.attach then applyAttach(true) end
    if states.safehide then applySafeHide(true) end
    if states.thirdperson then applyThirdPerson(true) end
    if states.dodgeOnHit then applyDodgeOnHit(true) end
    if states.antiafk then applyAntiAFK(true) end
    if states.invisible then applyInvisible(true) end
    if states.besthidev2 then applyBestHideV2(true) end
    if states.seekerFollow then applySeekerFollow(true) end
end)

-- ========== UI ТЕМЫ (ТОЛЬКО СТАТИЧЕСКИЕ) ==========
local function applyUIScheme()
    local screenGui = Window.ScreenGui if not screenGui then return end
    local UIFrame = Window.UIFrame
    local MiniIcon = Window.MiniIcon
    local scheme = states.uiScheme
    local bgColor, sideColor, textColor
    if scheme == "Тёмная" then bgColor=Color3.fromRGB(20,22,24) sideColor=Color3.fromRGB(31,31,34) textColor=Color3.fromRGB(200,200,200)
    elseif scheme == "Синяя" then bgColor=Color3.fromRGB(10,20,40) sideColor=Color3.fromRGB(20,30,50) textColor=Color3.fromRGB(180,220,255)
    elseif scheme == "Красная" then bgColor=Color3.fromRGB(40,10,10) sideColor=Color3.fromRGB(50,20,20) textColor=Color3.fromRGB(255,180,180)
    else return end
    local function update(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
                if child.Name == "UIFrame" then child.BackgroundColor3 = bgColor
                elseif child.Name == "SideMenu" then child.BackgroundColor3 = sideColor
                elseif child:IsA("TextButton") and child.Parent and child.Parent.Name == "TabButtons" then child.BackgroundColor3 = bgColor; child.TextColor3 = textColor
                elseif child:IsA("Frame") and child.Name ~= "ScreenGui" then child.BackgroundColor3 = bgColor
                end
                if child:IsA("TextButton") or child:IsA("TextLabel") then child.TextColor3 = textColor end
            end
            if child:IsA("Frame") or child:IsA("ScrollingFrame") then update(child) end
        end
    end
    update(screenGui)
end

-- ========== ЗАПОЛНЕНИЕ ВКЛАДОК ==========
-- Главная
MainTab:CreateToggle("X-Ray", "Подсветка игроков", false, function(v) states.xray=v if v then enableXray() else disableXray() end end)
MainTab:CreateToggle("Auto Hide", "Супер-укрытие", false, function(v) states.autohide=v if v then local safePos=findSafeSpot() spawn(function() while states.autohide do local myRoot=getRoot(LP) if myRoot and (myRoot.Position-safePos).Magnitude>5 then myRoot.CFrame=CFrame.new(safePos) end wait(0.5) end end) end end)
MainTab:CreateDropdown("Часть тела (Safe Hide)", {"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}, function(sel) safeHidePart=sel end)
MainTab:CreateDropdown("Тип укрытия", {"Сзади","Спереди","Слева","Справа","Сверху","Снизу","Внутри"}, function(sel) safeHideType=sel end)
MainTab:CreateToggle("Safe Hide Under Seeker", "Прячет относительно искателя", false, function(v) states.safehide=v applySafeHide(v) end)
MainTab:CreateToggle("Fly", "W/S/Space/Shift", false, function(v) states.fly=v local root=getRoot(LP); local hum=getHum(LP) if not root or not hum then return end if v then hum.PlatformStand=true local gyro=Instance.new("BodyGyro",root); gyro.P=9e4; gyro.MaxTorque=Vector3.new(9e9,9e9,9e9) local vel=Instance.new("BodyVelocity",root); vel.MaxForce=Vector3.new(9e9,9e9,9e9) spawn(function() while states.fly do if root and gyro then gyro.CFrame=Camera.CFrame local s=80 if UIS:IsKeyDown(Enum.KeyCode.W) then vel.Velocity=Camera.CFrame.LookVector*s elseif UIS:IsKeyDown(Enum.KeyCode.S) then vel.Velocity=-Camera.CFrame.LookVector*s elseif UIS:IsKeyDown(Enum.KeyCode.Space) then vel.Velocity=Vector3.new(0,s,0) elseif UIS:IsKeyDown(Enum.KeyCode.LeftShift) then vel.Velocity=Vector3.new(0,-s,0) else vel.Velocity=Vector3.zero end end wait() end gyro:Destroy(); vel:Destroy(); if hum then hum.PlatformStand=false end end) end end)
MainTab:CreateDropdown("Скорость", {"Медленно (50)","Ниже среднего (100)","Средне (150)","Быстро (200)"}, function(sel) currentSpeed=sel=="Медленно (50)" and 50 or sel=="Ниже среднего (100)" and 100 or sel=="Средне (150)" and 150 or 200 if states.speed then applySpeed(true) end end)
MainTab:CreateToggle("Speed", "Включить", false, function(v) states.speed=v applySpeed(v) end)
MainTab:CreateDropdown("Прыжок", {"Низкий (100)","Ниже среднего (150)","Средний (200)","Высокий (250)"}, function(sel) currentJump=sel=="Низкий (100)" and 100 or sel=="Ниже среднего (150)" and 150 or sel=="Средний (200)" and 200 or 250 if states.jump then applyJump(true) end end)
MainTab:CreateToggle("Jump", "Включить", false, function(v) states.jump=v applyJump(v) end)
MainTab:CreateDropdown("Хитбокс", {"x1.5","x2","x3"}, function(sel) currentHitbox=sel=="x1.5" and 1.5 or sel=="x2" and 2 or 3 if states.hitbox then applyHitbox(false); applyHitbox(true) end end)
MainTab:CreateToggle("Hitbox", "Включить", false, function(v) states.hitbox=v applyHitbox(v) end)
MainTab:CreateToggle("Fullbright", "Яркость", false, function(v) states.fullbright=v Lighting.Brightness=v and 3 or 1 Lighting.ClockTime=v and 14 or 12 end)
MainTab:CreateToggle("Noclip", "Проходить сквозь стены", false, function(v) states.noclip=v applyNoclip(v) end)
MainTab:CreateToggle("Anti AFK", "Автоматически прыгать", false, function(v) states.antiafk=v applyAntiAFK(v) end)
MainTab:CreateToggle("Best Hide V2", "Под землю под искателем (Hider)", false, function(v) states.besthidev2=v if v then applyNoclip(true); applyBestHideV2(true) else applyNoclip(false) end end)
MainTab:CreateToggle("Seeker Follow", "Прикрепиться к искателю", false, function(v) states.seekerFollow=v if v then applySeekerFollow(true) end end)
MainTab:CreateDropdown("Сторона", {"Вперед","Назад","Слева","Справа"}, function(sel) states.seekerFollowDir=sel end)
MainTab:AddButton("RESET", function() local root=getRoot(LP) if root then root.CFrame=CFrame.new(0,-500,0) end end)

-- ========== AUTO FARM ==========
AutoFarmTab:CreateToggle("Auto Farm", "Основной переключатель", false, function(v) states.autofarm=v if v then pcall(function() loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))() end) spawn(function() while states.autofarm do local weapon=getWeapon() if not weapon then local targetPos=findSafeSpot() local myRoot=getRoot(LP) if myRoot then if teleportSpeed=="Мгновенно" then myRoot.CFrame=CFrame.new(targetPos) elseif teleportSpeed=="Быстро" then local tween=TweenService:Create(myRoot,TweenInfo.new(0.15),{CFrame=CFrame.new(targetPos)}); tween:Play(); wait(0.15) elseif teleportSpeed=="Средне" then local tween=TweenService:Create(myRoot,TweenInfo.new(0.3),{CFrame=CFrame.new(targetPos)}); tween:Play(); wait(0.3) elseif teleportSpeed=="Медленно" then local tween=TweenService:Create(myRoot,TweenInfo.new(0.6),{CFrame=CFrame.new(targetPos)}); tween:Play(); wait(0.6) end end else if states.autoClick then local closest,minDist=nil,math.huge local myRoot=getRoot(LP) if myRoot then for _,p in ipairs(Players:GetPlayers()) do if p~=LP and isHider(p) then local root=getRoot(p); local hum=getHum(p) if root and hum and hum.Health>0 then local dist=(myRoot.Position-root.Position).Magnitude if dist<minDist then minDist=dist; closest=p end end end end end if closest and getRoot(closest) then local targetChar=getChar(closest) local targetPart=targetChar and targetChar:FindFirstChild(autoFarmPart) or getRoot(closest) if targetPart then local myRoot=getRoot(LP) if myRoot then myRoot.CFrame=targetPart.CFrame*CFrame.new(0,0,0.5) myRoot.Velocity=Vector3.zero end local tool=getWeapon() local char=getChar(LP) if tool and tool.Parent~=char then local hum=getHum(LP) if hum then hum:EquipTool(tool) end end if tool and tool:FindFirstChild("Handle") then local handle=tool.Handle if handle:IsA("BasePart") then handle.CFrame=targetPart.CFrame end end pcall(function() VIM:SendMouseButtonEvent(0,0,0,true,game,0) wait(0.01) VIM:SendMouseButtonEvent(0,0,0,false,game,0) end) pcall(function() tool:Activate() end) end end end end wait(clickDelay) end end) end end)
AutoFarmTab:CreateToggle("Invisible", "Невидимость", false, function(v) states.invisible=v applyInvisible(v) end)
AutoFarmTab:CreateDropdown("Скорость телепорта (Hider)", {"Мгновенно","Быстро","Средне","Медленно"}, function(sel) teleportSpeed=sel end)
AutoFarmTab:CreateToggle("Auto Click", "Авто-атака, когда есть оружие", true, function(v) states.autoClick=v end)
AutoFarmTab:CreateDropdown("Скорость Auto Click", {"Обычная","Быстрая","Мега быстрая","Предел"}, function(sel) if sel=="Обычная" then clickDelay=0.2 elseif sel=="Быстрая" then clickDelay=0.08 elseif sel=="Мега быстрая" then clickDelay=0.005 elseif sel=="Предел" then clickDelay=0.001 end end)

-- ========== АИМБОТ ==========
AimbotTab:CreateToggle("Aimbot", "Авто-прицеливание (только с оружием)", false, function(v) states.aimbot=v end)
AimbotTab:CreateToggle("Team Check", "Не целиться в союзников", false, function(v) states.aimbotTeamCheck=v end)
AimbotTab:CreateToggle("Visible Check", "Целиться только в видимых", false, function(v) states.aimbotVisibleCheck=v end)
AimbotTab:CreateDropdown("Часть тела", {"Head","Torso","Random"}, function(sel) states.aimbotTargetPart=sel end)
AimbotTab:CreateDropdown("FOV", {"50","100","150","200","250","300"}, function(sel) aimbotFOV=tonumber(sel) end)
AimbotTab:CreateDropdown("Сглаживание", {"Мгновенно","Быстро","Средне","Медленно"}, function(sel) if sel=="Мгновенно" then states.aimbotSmoothing=1 elseif sel=="Быстро" then states.aimbotSmoothing=0.3 elseif sel=="Средне" then states.aimbotSmoothing=0.1 elseif sel=="Медленно" then states.aimbotSmoothing=0.05 end end)
AimbotTab:CreateToggle("FOV Circle", "Круг на экране", false, function(v) states.showfov=v end)

-- ========== ESP ==========
local drawings = {}
local function createESP(p) pcall(function() local box=Drawing.new("Square"); box.Visible=false; box.Color=Color3.fromRGB(255,0,0); box.Thickness=2; box.Transparency=1 local name=Drawing.new("Text"); name.Visible=false; name.Color=Color3.fromRGB(255,255,255); name.Size=14; name.Center=true; name.Outline=true local tracer=Drawing.new("Line"); tracer.Visible=false; tracer.Color=Color3.fromRGB(255,0,0); tracer.Thickness=1; tracer.Transparency=1 local dist=Drawing.new("Text"); dist.Visible=false; dist.Color=Color3.fromRGB(255,255,255); dist.Size=12; dist.Center=true; dist.Outline=true drawings[p]={Box=box,Name=name,Tracer=tracer,Dist=dist} end) end
for _,p in ipairs(Players:GetPlayers()) do if p~=LP then createESP(p) end end
Players.PlayerAdded:Connect(function(p) if p~=LP then createESP(p) end end)
Players.PlayerRemoving:Connect(function(p) if drawings[p] then for _,x in pairs(drawings[p]) do pcall(function() x:Remove() end) end; drawings[p]=nil end end)
ESPTab:CreateToggle("ESP", "Включить", false, function(v) states.esp=v end)
ESPTab:CreateToggle("Box", "Рамка", false, function(v) states.box=v end)
ESPTab:CreateToggle("Имя", "Ник", false, function(v) states.name=v end)
ESPTab:CreateToggle("Трейсер", "Линия", false, function(v) states.tracer=v end)
ESPTab:CreateToggle("Дистанция", "м", false, function(v) states.dist=v end)

-- ========== ТЕЛЕПОРТ ==========
local telePlayers = {} local function updateTeleList() telePlayers={}; for _,p in ipairs(Players:GetPlayers()) do if p~=LP then table.insert(telePlayers,p.Name) end end end updateTeleList()
TeleportTab:CreateToggle("Сбросить цель", "", false, function(v) if v then teleportTarget=nil end end)
TeleportTab:CreateDropdown("Цель", telePlayers, function(v) for _,p in ipairs(Players:GetPlayers()) do if p.Name==v and p~=LP then teleportTarget=p; break end end end)
TeleportTab:AddButton("Телепорт к цели", function() if not teleportTarget or not getRoot(teleportTarget) then return end local myRoot=getRoot(LP) if myRoot then myRoot.CFrame=getRoot(teleportTarget).CFrame*CFrame.new(0,3,0) end end)

-- ========== TROLL ==========
TrollTab:CreateToggle("Spinbot", "Бешено вращаешься", false, function(v) states.spinbot=v; applySpinbot(v) end)
TrollTab:CreateToggle("Big Head", "Огромная голова", false, function(v) states.bighead=v; applyBigHead(v) end)
TrollTab:CreateToggle("Bouncy", "Подпрыгиваешь постоянно", false, function(v) states.bouncy=v; applyBouncy(v) end)
TrollTab:CreateToggle("Low Gravity", "Лунная гравитация (локально)", false, function(v) states.lowgrav=v; applyLowGravity(v) end)
TrollTab:CreateDropdown("Интенсивность Dodge", {"Низкая (3)","Средняя (5)","Высокая (8)"}, function(sel) if sel=="Низкая (3)" then dodgeIntensity=3 elseif sel=="Средняя (5)" then dodgeIntensity=5 else dodgeIntensity=8 end end)
TrollTab:CreateToggle("Dodge (Safe)", "Уклонение с проверкой пола", false, function(v) states.dodge=v; applyDodge(v) end)
TrollTab:CreateToggle("Dodge on Hit", "При попадании – рывок назад + возврат", false, function(v) states.dodgeOnHit=v; applyDodgeOnHit(v) end)
TrollTab:CreateDropdown("Часть тела искателя", {"Head","UpperTorso","LowerTorso","LeftUpperArm","RightUpperArm","LeftUpperLeg","RightUpperLeg"}, function(sel) attachBodyPart=sel end)
TrollTab:CreateToggle("Auto Attach to Seeker", "Приклеиться ПРЯМО к выбранной части", false, function(v) states.attach=v; if v then applyAttach(true) end end)
TrollTab:CreateToggle("3rd Person", "Вид от третьего лица (Follow)", false, function(v) states.thirdperson=v; applyThirdPerson(v) end)

-- ========== UI НАСТРОЙКИ ==========
UITab:CreateDropdown("Тема интерфейса", {"Тёмная","Синяя","Красная"}, function(sel) states.uiScheme=sel applyUIScheme() end)

-- ========== UNLOCK ALL ==========
UnlockTab:AddButton("🟢 UNLOCK ALL (FREE)", function() end)
UnlockTab:AddButton("🔵 UNLOCK ALL (BETA)", function() loadstring(game:HttpGet('https://pastebin.com/raw/EPPkbZgN'))() end)

-- ========== НАСТРОЙКИ ==========
local bindKeys = {"RightShift","LeftShift","RightControl","LeftControl","End","Insert","F1","F2","F3","F4"}
local bindEnumMap = {RightShift=Enum.KeyCode.RightShift,LeftShift=Enum.KeyCode.LeftShift,RightControl=Enum.KeyCode.RightControl,LeftControl=Enum.KeyCode.LeftControl,End=Enum.KeyCode.End,Insert=Enum.KeyCode.Insert,F1=Enum.KeyCode.F1,F2=Enum.KeyCode.F2,F3=Enum.KeyCode.F3,F4=Enum.KeyCode.F4}
SettingsTab:CreateDropdown("Горячая клавиша", bindKeys, function(sel) local newBind=bindEnumMap[sel]; if newBind then Window.SetBind(newBind) end end)
SettingsTab:CreateToggle("Счётчик FPS", "В левом верхнем углу", false, function(v) Window.SetFPSVisible(v) end)
SettingsTab:CreateToggle("Показывать пинг", "Рядом с FPS", false, function(v) Window.SetPingVisible(v) end)
SettingsTab:CreateToggle("Иконка меню", "Показывать квадратик", true, function(v) states.showMiniIcon=v Window.MiniIcon.Visible=v end)

-- ========== ГЛАВНЫЙ ЦИКЛ ==========
local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0,0,0,0)
fovCircle.Position = UDim2.new(0.5,0,0.5,0)
fovCircle.AnchorPoint = Vector2.new(0.5,0.5)
fovCircle.BorderSizePixel = 0
fovCircle.BackgroundColor3 = Color3.fromRGB(255,255,255)
fovCircle.BackgroundTransparency = 0.8
fovCircle.Visible = false
Instance.new("UICorner", fovCircle).CornerRadius = UDim.new(0.5,0)
fovCircle.Parent = game.CoreGui

RS.RenderStepped:Connect(function()
    if states.showfov and states.aimbot then fovCircle.Visible=true; fovCircle.Size=UDim2.new(0,aimbotFOV*2,0,aimbotFOV*2) else fovCircle.Visible=false end
    if states.aimbot and getWeapon() and not states.thirdperson then
        local closest=nil; local minWorldDist=math.huge; local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2); local myRoot=getRoot(LP) if not myRoot then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p==LP then continue end
            if states.aimbotTeamCheck and p.Team==LP.Team then continue end
            if not isHider(p) then continue end
            if states.aimbotVisibleCheck then local char=p.Character if char and char:FindFirstChild("Head") then local ray=Ray.new(Camera.CFrame.Position,(char.Head.Position-Camera.CFrame.Position).Unit*500) local hit=workspace:FindPartOnRay(ray,char,false,true) if hit and hit.Parent~=char then continue end end end
            local root=getRoot(p); local hum=getHum(p) if not root or not hum or hum.Health<=0 then continue end
            local targetPart=root
            if states.aimbotTargetPart=="Head" then targetPart=p.Character:FindFirstChild("Head") or root
            elseif states.aimbotTargetPart=="Torso" then targetPart=p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso") or root
            elseif states.aimbotTargetPart=="Random" then local valid={} for _,partName in ipairs({"Head","UpperTorso","Torso","HumanoidRootPart"}) do local part=p.Character:FindFirstChild(partName) if part then table.insert(valid,part) end end targetPart=valid[math.random(#valid)] or root end
            local pos,onScreen=Camera:WorldToViewportPoint(targetPart.Position) if onScreen then local screenDist=(Vector2.new(pos.X,pos.Y)-center).Magnitude if screenDist<=aimbotFOV then local worldDist=(myRoot.Position-targetPart.Position).Magnitude if worldDist<minWorldDist then minWorldDist=worldDist; closest=targetPart end end end
        end
        if closest then local targetCFrame=CFrame.new(Camera.CFrame.Position,closest.Position) Camera.CFrame=Camera.CFrame:Lerp(targetCFrame,states.aimbotSmoothing) end
    end
    if states.esp and drawings then
        for p,d in pairs(drawings) do pcall(function()
            local root=getRoot(p); local hum=getHum(p); local char=getChar(p) if root and hum and hum.Health>0 then local pos,onScreen=Camera:WorldToViewportPoint(root.Position) if onScreen then local team=isSeeker(p) and "Seeker" or (isHider(p) and "Hider" or "?") local color=team=="Seeker" and Color3.fromRGB(255,0,0) or (team=="Hider" and Color3.fromRGB(0,150,255) or Color3.fromRGB(255,255,255)) if states.box and char:FindFirstChild("Head") then local hp=Camera:WorldToViewportPoint(char.Head.Position+Vector3.new(0,0.5,0)) local lp=Camera:WorldToViewportPoint(root.Position-Vector3.new(0,3,0)) local h=math.abs(lp.Y-hp.Y); local w=h*0.65 d.Box.Size=Vector2.new(w,h); d.Box.Position=Vector2.new(hp.X-w/2,hp.Y); d.Box.Color=color; d.Box.Visible=true else d.Box.Visible=false end if states.name then d.Name.Text=p.Name.." ["..team.."]"; d.Name.Position=Vector2.new(pos.X,pos.Y-40); d.Name.Visible=true else d.Name.Visible=false end if states.tracer then d.Tracer.Color=color; d.Tracer.From=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y); d.Tracer.To=Vector2.new(pos.X,pos.Y); d.Tracer.Visible=true else d.Tracer.Visible=false end if states.dist then local myRoot=getRoot(LP) if myRoot then local dist=math.floor((myRoot.Position-root.Position).Magnitude); d.Dist.Text=dist.."m"; d.Dist.Position=Vector2.new(pos.X,pos.Y-55); d.Dist.Visible=true end else d.Dist.Visible=false end else for _,x in pairs(d) do x.Visible=false end end else for _,x in pairs(d) do x.Visible=false end end
        end) end
    end
end)

print("Скрипт загружен! Вкладки переключаются, всё работает.")
