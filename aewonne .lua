local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ==========================================
-- AESTHETIC CONFIGURATION
-- ==========================================
local cfg = {
    width = 500,
    height = 400,
    cornerRadius = 25,
    borderWidth = 3,
    
    colors = {
        bg = Color3.fromRGB(30, 30, 30),
        bgLight = Color3.fromRGB(50, 50, 50),
        primary = Color3.fromRGB(200, 200, 200),
        highlight = Color3.fromRGB(100, 100, 100),
        text = Color3.fromRGB(255, 255, 255),
        textDim = Color3.fromRGB(150, 150, 150),
        border = Color3.fromRGB(10, 10, 10),
        green = Color3.fromRGB(0, 120, 0),
        red = Color3.fromRGB(120, 0, 0)
    },
    font = Enum.Font.SourceSans
}

-- ==========================================
-- 1. Create the GUI Interface
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoRollGui"
screenGui.Parent = PlayerGui
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, cfg.width, 0, cfg.height)
frame.Position = UDim2.new(0.5, -cfg.width/2, 0.5, -cfg.height/2)
frame.BackgroundColor3 = cfg.colors.bg
frame.BorderSizePixel = cfg.borderWidth
frame.BorderColor3 = cfg.colors.border
frame.Parent = screenGui
frame.ClipsDescendants = true
frame.AutomaticSize = Enum.AutomaticSize.None

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, cfg.cornerRadius)
corner.Parent = frame

-- Title Bar
local title = Instance.new("TextLabel")
title.Name = "TitleBar"
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "AUTO SYSTEM"
title.TextColor3 = cfg.colors.text
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.BackgroundTransparency = 0.5
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, cfg.cornerRadius)
titleCorner.Parent = title

-- Minimize Button
local minButton = Instance.new("TextButton")
minButton.Size = UDim2.new(0, 40, 0, 40)
minButton.Position = UDim2.new(1, -45, 0, 0)
minButton.Text = "-"
minButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minButton.BackgroundTransparency = 1
minButton.Font = Enum.Font.SourceSansBold
minButton.TextSize = 22
minButton.Parent = title

-- ==========================================
-- DRAGGABLE LOGIC
-- ==========================================
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- ==========================================
-- NAV BAR (VERTICAL - LEFT SIDE)
-- ==========================================
local navBar = Instance.new("Frame")
navBar.Size = UDim2.new(0, 100, 1, -50)
navBar.Position = UDim2.new(0, 10, 0, 50)
navBar.BackgroundColor3 = cfg.colors.bgLight
navBar.BorderSizePixel = 0
navBar.Parent = frame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 10)
navCorner.Parent = navBar

local navLayout = Instance.new("UIListLayout")
navLayout.Parent = navBar
navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
navLayout.SortOrder = Enum.SortOrder.LayoutOrder
navLayout.Padding = UDim.new(0, 5)

local function createNavButton(name, text, order)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = text
    btn.TextColor3 = cfg.colors.text
    btn.BackgroundColor3 = cfg.colors.bg
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.LayoutOrder = order
    btn.Parent = navBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    return btn
end

local btnMain = createNavButton("BtnMain", "Main", 1)
local btnSelection = createNavButton("BtnSelection", "Selection", 2)
local btnToggles = createNavButton("BtnToggles", "Toggles", 3)

-- ==========================================
-- CONTENT CONTAINERS (PAGES)
-- ==========================================
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -120, 1, -60)
contentContainer.Position = UDim2.new(0, 120, 0, 50)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = frame
contentContainer.ClipsDescendants = true

local contentLayout = Instance.new("UIListLayout")
contentLayout.Parent = contentContainer
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 10)

-- ==========================================
-- PAGE: MAIN
-- ==========================================
local mainPage = Instance.new("Frame")
mainPage.Size = UDim2.new(1, 0, 1, 0)
mainPage.BackgroundTransparency = 1
mainPage.LayoutOrder = 1
mainPage.Parent = contentContainer

local mainText = Instance.new("TextLabel")
mainText.Size = UDim2.new(0.9, 0, 0, 100)
mainText.Position = UDim2.new(0.05, 0, 0.1, 0)
mainText.Text = "Welcome!\nConfigure 'Selection' and 'Toggles' using the left menu."
mainText.TextColor3 = cfg.colors.text
mainText.BackgroundTransparency = 1
mainText.Font = cfg.font
mainText.TextSize = 18
mainText.TextWrapped = true
mainText.Parent = mainPage

-- ==========================================
-- PAGE: SELECTION
-- ==========================================
local selectionPage = Instance.new("Frame")
selectionPage.Size = UDim2.new(1, 0, 1, 0)
selectionPage.BackgroundTransparency = 1
selectionPage.Visible = false
selectionPage.LayoutOrder = 2
selectionPage.Parent = contentContainer

local selLayout = Instance.new("UIListLayout")
selLayout.Parent = selectionPage
selLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
selLayout.SortOrder = Enum.SortOrder.LayoutOrder
selLayout.Padding = UDim.new(0, 5)

-- Search Bar
local searchBar = Instance.new("TextBox")
searchBar.Size = UDim2.new(0.95, 0, 0, 30)
searchBar.BackgroundColor3 = cfg.colors.bgLight
searchBar.PlaceholderText = "Search..."
searchBar.Text = ""
searchBar.TextColor3 = cfg.colors.text
searchBar.Font = cfg.font
searchBar.TextSize = 14
searchBar.LayoutOrder = 0
searchBar.Parent = selectionPage

local scCorner = Instance.new("UICorner")
scCorner.CornerRadius = UDim.new(0, 6)
scCorner.Parent = searchBar

-- --- SELECT ALL/DESELECT ALL BUTTONS ---
local actionFrame = Instance.new("Frame")
actionFrame.Size = UDim2.new(0.95, 0, 0, 30)
actionFrame.BackgroundTransparency = 1
actionFrame.LayoutOrder = 1
actionFrame.Parent = selectionPage

local selectAllBtn = Instance.new("TextButton")
selectAllBtn.Size = UDim2.new(0.48, 0, 1, 0)
selectAllBtn.BackgroundColor3 = cfg.colors.highlight
selectAllBtn.Text = "Select All"
selectAllBtn.TextColor3 = cfg.colors.text
selectAllBtn.Font = cfg.font
selectAllBtn.TextSize = 12
selectAllBtn.Parent = actionFrame

local saCorner = Instance.new("UICorner")
saCorner.CornerRadius = UDim.new(0, 6)
saCorner.Parent = selectAllBtn

local deselectAllBtn = Instance.new("TextButton")
deselectAllBtn.Size = UDim2.new(0.48, 0, 1, 0)
deselectAllBtn.Position = UDim2.new(0.52, 0, 0, 0)
deselectAllBtn.BackgroundColor3 = cfg.colors.highlight
deselectAllBtn.Text = "Deselect All"
deselectAllBtn.TextColor3 = cfg.colors.text
deselectAllBtn.Font = cfg.font
deselectAllBtn.TextSize = 12
deselectAllBtn.Parent = actionFrame

local daCorner = Instance.new("UICorner")
daCorner.CornerRadius = UDim.new(0, 6)
daCorner.Parent = deselectAllBtn

-- Helper for Containers
local function createContainer(name, layoutOrder)
    local c = Instance.new("Frame")
    c.Name = name
    c.Size = UDim2.new(0.95, 0, 0, 120)
    c.BackgroundColor3 = cfg.colors.bgLight
    c.LayoutOrder = layoutOrder
    c.ClipsDescendants = true
    c.Parent = selectionPage
    
    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0, 8)
    cr.Parent = c
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 0, 20)
    lbl.Position = UDim2.new(0.02, 0, 0, 0)
    lbl.Text = name
    lbl.TextColor3 = cfg.colors.textDim
    lbl.BackgroundTransparency = 1
    lbl.Font = cfg.font
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = c
    
    local sc = Instance.new("ScrollingFrame")
    sc.Size = UDim2.new(1, -10, 0, 95)
    sc.Position = UDim2.new(0, 5, 0, 20)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 6
    sc.Parent = c
    
    return sc
end

local diceScroll = createContainer("Dice Selection", 2)
local claimScroll = createContainer("Claim Selection", 4)

-- Amount Input
local amountInput = Instance.new("TextBox")
amountInput.Size = UDim2.new(0.95, 0, 0, 30)
amountInput.Text = "99"
amountInput.PlaceholderText = "Amount"
amountInput.TextColor3 = Color3.fromRGB(255, 255, 255)
amountInput.BackgroundColor3 = cfg.colors.bgLight
amountInput.Font = cfg.font
amountInput.TextSize = 14
amountInput.LayoutOrder = 3
amountInput.Parent = selectionPage

local ic = Instance.new("UICorner")
ic.CornerRadius = UDim.new(0, 8)
ic.Parent = amountInput

amountInput:GetPropertyChangedSignal("Text"):Connect(function()
    amountInput.Text = amountInput.Text:gsub("%D+", "")
end)

-- ==========================================
-- PAGE: TOGGLES
-- ==========================================
local togglesPage = Instance.new("Frame")
togglesPage.Size = UDim2.new(1, 0, 1, 0)
togglesPage.BackgroundTransparency = 1
togglesPage.Visible = false
togglesPage.LayoutOrder = 3
togglesPage.Parent = contentContainer

local togLayout = Instance.new("UIListLayout")
togLayout.Parent = togglesPage
togLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
togLayout.SortOrder = Enum.SortOrder.LayoutOrder
togLayout.Padding = UDim.new(0, 15)

local function createToggleButton(text, layoutOrder)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Text = text .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = cfg.colors.red
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.LayoutOrder = layoutOrder
    btn.Parent = togglesPage
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = text .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and cfg.colors.green or cfg.colors.red
    end)
    
    return btn
end

local toggleRollButton = createToggleButton("Auto Roll", 1)
local toggleBuyButton = createToggleButton("Auto Buy", 2)
local toggleClaimButton = createToggleButton("Auto Claim", 3)

-- ==========================================
-- NAVIGATION LOGIC
-- ==========================================
local function showPage(page)
    mainPage.Visible = (page == "Main")
    selectionPage.Visible = (page == "Selection")
    togglesPage.Visible = (page == "Toggles")
    
    btnMain.BackgroundColor3 = (page == "Main") and cfg.colors.highlight or cfg.colors.bg
    btnSelection.BackgroundColor3 = (page == "Selection") and cfg.colors.highlight or cfg.colors.bg
    btnToggles.BackgroundColor3 = (page == "Toggles") and cfg.colors.highlight or cfg.colors.bg
end

btnMain.MouseButton1Click:Connect(function() showPage("Main") end)
btnSelection.MouseButton1Click:Connect(function() showPage("Selection") end)
btnToggles.MouseButton1Click:Connect(function() showPage("Toggles") end)

-- ==========================================
-- SMOOTH MINIMIZE LOGIC
-- ==========================================
local isMinimized = false
local expandedHeight = cfg.height
local minimizedHeight = 40
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

minButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        minButton.Text = "+"
        TweenService:Create(frame, tweenInfo, {Size = UDim2.new(0, cfg.width, 0, minimizedHeight)}):Play()
        TweenService:Create(contentContainer, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
        TweenService:Create(navBar, tweenInfo, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        
        for _, child in pairs(navBar:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, tweenInfo, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
            end
        end
    else
        minButton.Text = "-"
        TweenService:Create(frame, tweenInfo, {Size = UDim2.new(0, cfg.width, 0, expandedHeight)}):Play()
        TweenService:Create(contentContainer, tweenInfo, {Size = UDim2.new(1, -120, 1, -60)}):Play()
        TweenService:Create(navBar, tweenInfo, {Size = UDim2.new(0, 100, 1, -50), BackgroundTransparency = 0.5}):Play()
        
        for _, child in pairs(navBar:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, tweenInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
            end
        end
    end
end)

-- ==========================================
-- SELECTION LOGIC
-- ==========================================
local selectedDiceTable = {}
local selectedPedestalsTable = {}
local diceButtonRefs = {}

local function setupCheckboxList(scrollingFrame, items, targetTable, isDice)
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = scrollingFrame
    listLayout.Padding = UDim.new(0, 2)
    
    local buttonRefs = {}
    
    for i, itemName in ipairs(items) do
        local checkboxButton = Instance.new("TextButton")
        checkboxButton.Name = itemName
        checkboxButton.Size = UDim2.new(1, -5, 0, 25)
        checkboxButton.Text = " [ ] " .. itemName
        checkboxButton.TextColor3 = cfg.colors.text
        checkboxButton.BackgroundColor3 = cfg.colors.bg
        checkboxButton.Font = cfg.font
        checkboxButton.TextSize = 12
        checkboxButton.Parent = scrollingFrame
        
        local cbCorner = Instance.new("UICorner")
        cbCorner.CornerRadius = UDim.new(0, 5)
        cbCorner.Parent = checkboxButton
        
        table.insert(buttonRefs, checkboxButton)
        if isDice then table.insert(diceButtonRefs, checkboxButton) end
        
        local isSelected = false
        checkboxButton.MouseButton1Click:Connect(function()
            isSelected = not isSelected
            checkboxButton.Text = isSelected and " [X] " .. itemName or " [ ] " .. itemName
            checkboxButton.BackgroundColor3 = isSelected and cfg.colors.highlight or cfg.colors.bg
            targetTable[itemName] = isSelected and true or nil
        end)
    end
    
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #items * 27)
    return buttonRefs
end

-- Sorted Dice List
local diceList = {
    "Aetherial", "Anomaly", "Ascendant", "Basic", "Bloodcode", "Blue Core",
    "Bramble", "Candy", "Catalyst", "Celestial Emperor", "Crystal", "Devil",
    "Diamond", "Doom", "Galaxy", "Glacier", "Godroll", "Golden", "Heaven",
    "Hellcore", "Infinity", "King Sun", "King's mantle", "Molten Core",
    "Nebula", "Ouroboros", "Overgrown", "Phantom", "Pinnacle", "Platinum",
    "Quantum", "Radiant", "Silver", "Singularity", "The End", "Time Bender",
    "Toxic Reactor", "Verca", "Verdict", "Vortex"
}
table.sort(diceList)

setupCheckboxList(diceScroll, diceList, selectedDiceTable, true)

local pedestalList = {}
for i = 1, 11 do table.insert(pedestalList, "PedastalHolder" .. i) end
setupCheckboxList(claimScroll, pedestalList, selectedPedestalsTable, false)

-- --- SELECT ALL/DESELECT ALL LOGIC ---
selectAllBtn.MouseButton1Click:Connect(function()
    for _, btn in pairs(diceButtonRefs) do
        local itemName = btn.Name
        if not selectedDiceTable[itemName] then
            btn.MouseButton1Click:Invoke()
        end
    end
end)

deselectAllBtn.MouseButton1Click:Connect(function()
    for _, btn in pairs(diceButtonRefs) do
        local itemName = btn.Name
        if selectedDiceTable[itemName] then
            btn.MouseButton1Click:Invoke()
        end
    end
end)

-- Search Bar Logic
searchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBar.Text:lower()
    for _, btn in pairs(diceButtonRefs) do 
        btn.Visible = (query == "" or btn.Name:lower():find(query)) 
    end
end)

-- ==========================================
-- AUTOMATION BACKEND (WITH DIAGNOSTICS)
-- ==========================================
local networkFolder = ReplicatedStorage:WaitForChild("Network", 5):WaitForChild("Client", 5)

if not networkFolder then
    error("Critical Error: Network folder not found!")
end

local RollRemote = networkFolder:WaitForChild("RollDice", 5)
local PurchaseRemote = networkFolder:WaitForChild("PurchaseItem", 5)
local ClaimRemote = networkFolder:WaitForChild("ClaimCash", 5)

-- Diagnostic Check
if not RollRemote then warn("Missing Remote: RollDice") end
if not PurchaseRemote then warn("Missing Remote: PurchaseItem") end
if not ClaimRemote then warn("Missing Remote: ClaimCash") end

local function isToggleOn(toggleBtn)
    return toggleBtn.Text:find("ON") 
end

-- Purchase Loop
task.spawn(function()
    while true do
        if isToggleOn(toggleRollButton) and isToggleOn(toggleBuyButton) and PurchaseRemote then
            local amount = tonumber(amountInput.Text) or 99
            for diceName, _ in pairs(selectedDiceTable) do
                if not isToggleOn(toggleRollButton) or not isToggleOn(toggleBuyButton) then break end
                
                task.spawn(function()
                    local success, err = pcall(function() PurchaseRemote:InvokeServer(diceName, amount) end)
                    if not success then warn("Purchase Error: " .. tostring(err)) end
                end)
                
                task.wait(0.3)
            end
            task.wait(1)
        else
            task.wait(0.5)
        end
    end
end)

-- Roll Loop
task.spawn(function()
    while true do
        if isToggleOn(toggleRollButton) and RollRemote then
            for diceName, _ in pairs(selectedDiceTable) do
                if not isToggleOn(toggleRollButton) then break end
                
                task.spawn(function()
                    local success, err = pcall(function() RollRemote:InvokeServer(unpack({diceName})) end)
                    if not success then warn("Roll Error: " .. tostring(err)) end
                end)
                
                task.wait(0.1)
            end
        else
            task.wait(0.5)
        end
    end
end)

-- Auto Claim Loop
task.spawn(function()
    while true do
        if isToggleOn(toggleClaimButton) and ClaimRemote then
            for pedName, _ in pairs(selectedPedestalsTable) do
                if not isToggleOn(toggleClaimButton) then break end
                
                task.spawn(function()
          