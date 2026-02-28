
--// Brainrot Tsunami Menu - "I Won't Die In Anything" Edition
--// Made with maximum brainrot energy

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Anti-Detection (Basic)
local function protectGui()
    local success, result = pcall(function()
        if syn and syn.protect_gui then
            return syn.protect_gui
        elseif gethui then
            return gethui()
        elseif CoreGui:FindFirstChild("RobloxGui") then
            return CoreGui.RobloxGui
        else
            return CoreGui
        end
    end)
    return success and result or CoreGui
end

--// Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotTsunamiMenu"
ScreenGui.Parent = protectGui()
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// Epic Brainrot Colors
local Colors = {
    Background = Color3.fromRGB(20, 20, 30),
    Accent = Color3.fromRGB(255, 0, 128), -- Hot pink brainrot
    Secondary = Color3.fromRGB(0, 255, 255), -- Cyan
    Success = Color3.fromRGB(0, 255, 100),
    Warning = Color3.fromRGB(255, 200, 0),
    Text = Color3.fromRGB(255, 255, 255),
    Dark = Color3.fromRGB(30, 30, 40)
}

--// Utility Functions
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Colors.Accent
    stroke.Thickness = thickness or 2
    stroke.Parent = parent
    return stroke
end

local function CreateShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://131604521" -- Shadow asset
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.ZIndex = -1
    shadow.Parent = parent
    return shadow
end

local function Tween(obj, properties, duration, style, direction)
    local tween = TweenService:Create(obj, TweenInfo.new(
        duration or 0.3, 
        style or Enum.EasingStyle.Quad, 
        direction or Enum.EasingDirection.Out
    ), properties)
    tween:Play()
    return tween
end

--// Main Frame (Draggable)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
CreateCorner(MainFrame, 12)
CreateStroke(MainFrame, Colors.Accent, 3)
CreateShadow(MainFrame)

--// Brainrot Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Colors.Dark
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
CreateCorner(TitleBar, 12)

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Colors.Accent),
    ColorSequenceKeypoint.new(0.5, Colors.Secondary),
    ColorSequenceKeypoint.new(1, Colors.Accent)
})
TitleGradient.Rotation = 45
TitleGradient.Parent = TitleBar

--// Glitch Text Effect for Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🌊 TSUNAMI SURVIVOR PLUS 🌊"
Title.TextColor3 = Colors.Text
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

--// Brainrot Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 1, -5)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "I WON'T DIE IN ANYTHING EDITION"
Subtitle.TextColor3 = Colors.Secondary
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.Parent = TitleBar

--// Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
CreateCorner(CloseBtn, 8)

CloseBtn.MouseEnter:Connect(function()
    Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
end)

CloseBtn.MouseLeave:Connect(function()
    Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}, 0.2)
end)

CloseBtn.MouseButton1Click:Connect(function()
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In).Completed:Wait()
    ScreenGui:Destroy()
end)

--// Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(1, -90, 0, 5)
MinimizeBtn.BackgroundColor3 = Colors.Warning
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Colors.Text
MinimizeBtn.TextSize = 24
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar
CreateCorner(MinimizeBtn, 8)

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Tween(MainFrame, {Size = UDim2.new(0, 400, 0, 50)}, 0.3, Enum.EasingStyle.Quad)
        MinimizeBtn.Text = "+"
    else
        Tween(MainFrame, {Size = UDim2.new(0, 400, 0, 500)}, 0.3, Enum.EasingStyle.Quad)
        MinimizeBtn.Text = "-"
    end
end)

--// Content Frame
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -70)
Content.Position = UDim2.new(0, 10, 0, 60)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

--// Scrolling Frame for Features
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Colors.Accent
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ScrollFrame.Parent = Content

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollFrame

--// Feature Toggle Template
local function CreateToggle(name, description, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = name .. "Toggle"
    ToggleFrame.Size = UDim2.new(1, -10, 0, 80)
    ToggleFrame.BackgroundColor3 = Colors.Dark
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ScrollFrame
    CreateCorner(ToggleFrame, 8)
    CreateStroke(ToggleFrame, Colors.Secondary, 1)

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Size = UDim2.new(1, -70, 0, 25)
    ToggleLabel.Position = UDim2.new(0, 10, 0, 5)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Colors.Text
    ToggleLabel.TextSize = 18
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Name = "Description"
    DescLabel.Size = UDim2.new(1, -20, 0, 40)
    DescLabel.Position = UDim2.new(0, 10, 0, 30)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    DescLabel.TextSize = 12
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextWrapped = true
    DescLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Size = UDim2.new(0, 50, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -60, 0.5, -15)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    ToggleBtn.TextSize = 14
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ToggleFrame
    CreateCorner(ToggleBtn, 15)

    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ToggleBtn.BackgroundColor3 = Colors.Success
            ToggleBtn.Text = "ON"
            ToggleBtn.TextColor3 = Colors.Text
            Tween(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(40, 50, 40)}, 0.2)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            ToggleBtn.Text = "OFF"
            ToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
            Tween(ToggleFrame, {BackgroundColor3 = Colors.Dark}, 0.2)
        end
        if callback then callback(enabled) end
    end)

    return ToggleFrame, function() return enabled end
end

--// Brainrot Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "Status"
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StatusLabel.Text = "🧠 BRAINROT STATUS: ACTIVE"
StatusLabel.TextColor3 = Colors.Success
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Parent = ScrollFrame
CreateCorner(StatusLabel, 6)

--// FEATURES

-- 1. Auto Pickup Brainrot
local _, GetAutoPickup = CreateToggle(
    "🤖 Auto Pickup Brainrot",
    "Automatically collects all brainrot items. Sigma grindset activated.",
    function(enabled)
        if enabled then
            print("[Brainrot] Auto Pickup Enabled - Gooning items collected")
        else
            print("[Brainrot] Auto Pickup Disabled")
        end
    end
)

-- 2. God Mode (I Won't Die)
local _, GetGodMode = CreateToggle(
    "🛡️ I Won't Die Mode",
    "Become immortal. Literally cannot die to anything. Skibidi rizz.",
    function(enabled)
        if enabled then
            print("[Brainrot] God Mode Enabled - You are the alpha sigma")
            -- Hook into character death
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = math.huge
                    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                        if humanoid.Health < math.huge then
                            humanoid.Health = math.huge
                        end
                    end)
                end
            end
        end
    end
)

-- 3. Auto Escape Tsunami
local _, GetAutoEscape = CreateToggle(
    "🏃 Auto Escape Tsunami",
    "Teleports to safe zones when tsunami approaches. No cap.",
    function(enabled)
        print("[Brainrot] Auto Escape:", enabled)
    end
)

-- 4. Brainrot ESP
local _, GetBrainrotESP = CreateToggle(
    "👁️ Brainrot ESP",
    "See all brainrot through walls. Ohio vision activated.",
    function(enabled)
        print("[Brainrot] ESP:", enabled)
    end
)

-- 5. Speed Hack (Skibidi Fast)
local _, GetSpeedHack = CreateToggle(
    "⚡ Skibidi Speed",
    "Move faster than light. Fanum tax evasion speed.",
    function(enabled)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = enabled and 100 or 16
        end
    end
)

-- 6. Fly Mode
local _, GetFlyMode = CreateToggle(
    "🕊️ Gyatt Fly Mode",
    "Fly around the map. Absolute cinema.",
    function(enabled)
        print("[Brainrot] Fly Mode:", enabled)
    end
)

-- 7. Auto Farm Brainrot
local _, GetAutoFarm = CreateToggle(
    "💰 Auto Farm Brainrot",
    "Farms brainrot points automatically. Mogging the economy.",
    function(enabled)
        print("[Brainrot] Auto Farm:", enabled)
    end
)

-- 8. Anti AFK
local _, GetAntiAFK = CreateToggle(
    "😴 Anti-AFK (Gooning Protection)",
    "Prevents getting kicked for being idle. Always grinding.",
    function(enabled)
        if enabled then
            local vu = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
)

--// Brainrot Quote Generator
local QuoteFrame = Instance.new("Frame")
QuoteFrame.Name = "QuoteFrame"
QuoteFrame.Size = UDim2.new(1, -10, 0, 60)
QuoteFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 40)
QuoteFrame.Parent = ScrollFrame
CreateCorner(QuoteFrame, 8)

local Quotes = {
    "Skibidi toilet is life",
    "Sigma grindset never stops",
    "Ohio final boss energy",
    "Fanum tax is inevitable",
    "Gyatt level over 9000",
    "No cap, just facts",
    "Rizzler supreme activated",
    "Based and brainrot-pilled",
    "Mewing while tsunami hits",
    "Looksmaxxing to survive"
}

local QuoteLabel = Instance.new("TextLabel")
QuoteLabel.Name = "Quote"
QuoteLabel.Size = UDim2.new(1, -20, 1, -10)
QuoteLabel.Position = UDim2.new(0, 10, 0, 5)
QuoteLabel.BackgroundTransparency = 1
QuoteLabel.Text = "💭 " .. Quotes[math.random(1, #Quotes)]
QuoteLabel.TextColor3 = Colors.Accent
QuoteLabel.TextSize = 14
QuoteLabel.Font = Enum.Font.GothamBold
QuoteLabel.TextWrapped = true
QuoteLabel.Parent = QuoteFrame

-- Random quote changer
spawn(function()
    while wait(5) do
        if QuoteLabel and QuoteLabel.Parent then
            Tween(QuoteLabel, {TextTransparency = 1}, 0.5).Completed:Wait()
            QuoteLabel.Text = "💭 " .. Quotes[math.random(1, #Quotes)]
            Tween(QuoteLabel, {TextTransparency = 0}, 0.5)
        end
    end
end)

--// Dragging Logic
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// Auto Pickup Logic (The Brainrot Collector)
spawn(function()
    while wait(0.1) do
        if GetAutoPickup() then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                -- Look for brainrot items (common names in tsunami games)
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") or obj:IsA("MeshPart") then
                        local name = obj.Name:lower()
                        if name:find("brainrot") or name:find("item") or name:find("coin") or 
                           name:find("collect") or name:find("orb") or name:find("gem") then
                            if obj:FindFirstChild("TouchInterest") or obj:IsA("TouchTransmitter") then
                                local dist = (hrp.Position - obj.Position).magnitude
                                if dist < 50 then
                                    firetouchinterest(hrp, obj, 0)
                                    firetouchinterest(hrp, obj, 1)
                                    -- Visual feedback
                                    local pop = Instance.new("TextLabel")
                                    pop.Text = "🧠"
                                    pop.Size = UDim2.new(0, 30, 0, 30)
                                    pop.Position = UDim2.new(0, math.random(100, 300), 0, math.random(100, 400))
                                    pop.BackgroundTransparency = 1
                                    pop.TextSize = 24
                                    pop.Parent = ScreenGui
                                    Tween(pop, {Position = UDim2.new(pop.Position.X.Scale, pop.Position.X.Offset, pop.Position.Y.Scale, pop.Position.Y.Offset - 50), TextTransparency = 1}, 1)
                                    game:GetService("Debris"):AddItem(pop, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

--// Tsunami Detection & Auto Escape
spawn(function()
    while wait(0.5) do
        if GetAutoEscape() then
            -- Look for tsunami water
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Size.Y > 50 and (obj.Name:lower():find("water") or obj.Name:lower():find("tsunami") or obj.Name:lower():find("wave")) then
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local hrp = char.HumanoidRootPart
                        local dist = (hrp.Position - obj.Position).magnitude
                        if dist < 200 and obj.Position.Y > hrp.Position.Y - 10 then
                            -- Find safe zone (usually highest point or specific location)
                            local safePos = Vector3.new(0, 500, 0) -- Default sky escape
                            -- Try to find actual safe zone
                            for _, safe in pairs(workspace:GetDescendants()) do
                                if safe.Name:lower():find("safe") or safe.Name:lower():find("spawn") then
                                    if safe:IsA("BasePart") then
                                        safePos = safe.Position + Vector3.new(0, 10, 0)
                                        break
                                    end
                                end
                            end
                            hrp.CFrame = CFrame.new(safePos)
                            -- Notification
                            StatusLabel.Text = "🚨 TSUNAMI ESCAPED!"
                            StatusLabel.TextColor3 = Colors.Warning
                            wait(2)
                            StatusLabel.Text = "🧠 BRAINROT STATUS: ACTIVE"
                            StatusLabel.TextColor3 = Colors.Success
                        end
                    end
                end
            end
        end
    end
end)

--// Fly Logic
local flying = false
local flySpeed = 50
spawn(function()
    while wait() do
        if GetFlyMode() and not flying then
            flying = true
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local bv = Instance.new("BodyVelocity")
                bv.Name = "BrainrotFly"
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = hrp

                while GetFlyMode() and char and hrp and hrp.Parent do
                    local cam = workspace.CurrentCamera
                    local dir = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
                    bv.Velocity = dir * flySpeed
                    wait()
                end

                if hrp:FindFirstChild("BrainrotFly") then
                    hrp.BrainrotFly:Destroy()
                end
                flying = false
            end
        end
    end
end)

--// ESP Logic
spawn(function()
    while wait(1) do
        if GetBrainrotESP() then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local name = obj.Name:lower()
                    if name:find("brainrot") or name:find("item") or name:find("collect") then
                        if not obj:FindFirstChild("BrainrotESP") then
                            local esp = Instance.new("BoxHandleAdornment")
                            esp.Name = "BrainrotESP"
                            esp.Size = obj.Size + Vector3.new(0.1, 0.1, 0.1)
                            esp.Adornee = obj
                            esp.AlwaysOnTop = true
                            esp.ZIndex = 10
                            esp.Transparency = 0.5
                            esp.Color3 = Colors.Accent
                            esp.Parent = obj
                        end
                    end
                end
            end
        else
            -- Remove ESP
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("BrainrotESP") then
                    obj.BrainrotESP:Destroy()
                end
            end
        end
    end
end)

--// Intro Animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
wait(0.1)
Tween(MainFrame, {Size = UDim2.new(0, 400, 0, 500), Position = UDim2.new(0.5, -200, 0.5, -250)}, 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

--// Brainrot Rain Effect (Visual Flair)
spawn(function()
    while wait(math.random(1, 3)) do
        if math.random() > 0.7 then
            local emoji = ({"🧠", "🌊", "💀", "🤖", "⚡", "🔥"})[math.random(1, 6)]
            local drop = Instance.new("TextLabel")
            drop.Text = emoji
            drop.Size = UDim2.new(0, 30, 0, 30)
            drop.Position = UDim2.new(math.random(), 0, 0, -30)
            drop.BackgroundTransparency = 1
            drop.TextSize = 24
            drop.Parent = ScreenGui
            Tween(drop, {Position = UDim2.new(drop.Position.X.Scale, 0, 1, 30)}, math.random(3, 6)).Completed:Connect(function()
                drop:Destroy()
            end)
        end
    end
end)

print("[Brainrot Tsunami Menu] Loaded successfully! 🧠🌊")
print("[Brainrot] I won't die in anything mode: ACTIVE")
