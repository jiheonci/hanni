-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

-- Create Window
local Window = Rayfield:CreateWindow({
   Name = "🌸 Spring Event Farm (v3) 🌸",
   LoadingTitle = "Initializing Script...",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SpringFarm",
      FileName = "SpringConfig"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

-- Create Tabs
local Tab = Window:CreateTab("Farming", 4483362458)
local EggTab = Window:CreateTab("Hatching", 4483362458)

-- Variables for toggles
getgenv().AutoPick = false
getgenv().AutoHatch = false
getgenv().AutoWheel = false

-- --- FARMING TAB ---
local PetalsSection = Tab:CreateSection("Petal Farming")

-- Toggle for Auto Picking
Tab:CreateToggle({
   Name = "Auto Pick Petals & Sunflowers",
   CurrentValue = false,
   Flag = "AutoPickToggle",
   Callback = function(Value)
        getgenv().AutoPick = Value
        if Value then
            print("Auto Pick Enabled")
            spawn(function()
                while getgenv().AutoPick do
                    local petals = {
                        "PickSun1", "PickViolet8", "PickViolet2", "PickViolet1",
                        "PickViolet6", "PickViolet4", "PickViolet5", "PickViolet7",
                        "PickViolet3", "PickRose2", "PickRose3", "PickRose1",
                        "PickSun2", "PickSun4", "PickSun3"
                    }
                    
                    for _, petalName in pairs(petals) do
                        if not getgenv().AutoPick then break end
                        local args = {
                            "PickPetal",
                            workspace:WaitForChild("Spring"):WaitForChild("PickPetals"):WaitForChild(petalName)
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                        task.wait(0.1) 
                    end
                    task.wait(0.5)
                end
            end)
        else
            print("Auto Pick Disabled")
        end
   end,
})

-- Section for Wheel
local WheelSection = Tab:CreateSection("Wheel Spin")

-- Toggle for Auto Wheel Spin (Every 60 seconds)
Tab:CreateToggle({
   Name = "Auto Spin Wheel (Every 1m)",
   CurrentValue = false,
   Flag = "AutoWheelToggle",
   Callback = function(Value)
        getgenv().AutoWheel = Value
        if Value then
            print("Auto Wheel Enabled")
            spawn(function()
                while getgenv().AutoWheel do
                    local args = {
                        "SpringWheelSpin"
                    }
                    -- Note: InvokeServer waits for a server response.
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
                    
                    Rayfield:Notify({Title = "Wheel", Content = "Spun the wheel!", Duration = 3})
                    
                    task.wait(60) -- Wait 1 minute
                end
            end)
        else
            print("Auto Wheel Disabled")
        end
   end,
})

-- --- EGG TAB ---
local EggSection = EggTab:CreateSection("Egg Hatching")

-- Toggle for Auto Hatching (FAST)
EggTab:CreateToggle({
   Name = "Auto Hatch Spring Egg (x7)",
   CurrentValue = false,
   Flag = "AutoHatchToggle",
   Callback = function(Value)
        getgenv().AutoHatch = Value
        if Value then
            print("Auto Hatch Enabled")
            spawn(function()
                while getgenv().AutoHatch do
                    local args = {
                        "HatchEgg",
                        "Spring Egg",
                        7
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
                    
                    task.wait(0.2) 
                end
            end)
        else
            print("Auto Hatch Disabled")
        end
   end,
})

-- Load Settings
Rayfield:LoadConfiguration()