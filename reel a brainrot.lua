local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Reel a Brainrot",
   LoadingTitle = "by Aewonne...",
})

local Tab = Window:CreateTab("Automation", 4483362458)

-- Variables
local autoCollect = false
local autoFish = false
local autoUpgrade = false
local targetUpgrade = "power1" -- Default to power1

-- 1. AUTO-COLLECT (PLOTS 1-10)
Tab:CreateSection("Collector")
Tab:CreateToggle({
   Name = "💰 Auto-Collect All Plots",
   CurrentValue = false,
   Callback = function(Value)
      autoCollect = Value
      task.spawn(function()
         while autoCollect do
            for i = 1, 10 do
               if not autoCollect then break end
               game:GetService("ReplicatedStorage"):WaitForChild("RemoteHandler"):WaitForChild("Collect"):FireServer("Plot" .. i)
               task.wait(0.05)
            end
            task.wait(0.5)
         end
      end)
   end,
})

-- 2. AUTO-FISHING
Tab:CreateSection("Fishing")
Tab:CreateToggle({
   Name = "🎣 Auto-Fish/Reel",
   CurrentValue = false,
   Callback = function(Value)
      autoFish = Value
      task.spawn(function()
         while autoFish do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteHandler"):WaitForChild("Fishing"):FireServer("Caught", 2)
            task.wait(0.3)
         end
      end)
   end,
})

-- 3. AUTO-UPGRADE (SPECIFIC)
Tab:CreateSection("Targeted Upgrades")

Tab:CreateDropdown({
   Name = "Select Upgrade Tier",
   Options = {"power1", "power5", "power10"},
   CurrentOption = {"power1"},
   Callback = function(Option)
      targetUpgrade = Option[1]
   end,
})

Tab:CreateToggle({
   Name = "🚀 Auto-Upgrade Selected",
   CurrentValue = false,
   Callback = function(Value)
      autoUpgrade = Value
      task.spawn(function()
         while autoUpgrade do
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteHandler"):WaitForChild("Upgrade"):FireServer(targetUpgrade)
            task.wait(0.1) -- Fast spam rate
         end
      end)
   end,
})