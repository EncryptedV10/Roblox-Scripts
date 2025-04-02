local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/EncryptedV10/Main/refs/heads/main/Library/Fluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Nova Hub Free Version" .. Fluent.Version,
    SubTitle = "by Encrypted",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Nova",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "scan-face" }),
    AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "crown" }),
    Rebirths = Window:AddTab({ Title = "Rebirths", Icon = "rotate-ccw" }),
    Killer = Window:AddTab({ Title = "Killer", Icon = "sword" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "forward" }),
    Crystal = Window:AddTab({ Title = "Crystal", Icon = "egg" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "newspaper" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "Play" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),    
}

Tabs.Home:AddParagraph({
        Title = "Discord Server:",
        Content = "https://discord.gg/Tk9gsP4kGf"
    })

Tabs.Home:AddParagraph({
        Title = "Local Player",
        Content = ""
    })

Tabs.Home:AddInput("WalkSpeed", {
    Title = "WalkSpeed",
    Default = "16",
    Placeholder = "Enter WalkSpeed",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(Value)
    end
})

Tabs.Home:AddButton({
    Title = "Apply WalkSpeed",
    Callback = function()
        local Value = Tabs.Main:GetInput("WalkSpeed").Value
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(Value)
    end
})

Tabs.Home:AddInput("JumpPower", {
    Title = "JumpPower",
    Default = "50",
    Placeholder = "Enter JumpPower",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(Value)
    end
})

Tabs.Home:AddButton({
    Title = "Apply JumpPower",
    Callback = function()
        local Value = Tabs.Main:GetInput("JumpPower").Value
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(Value)
    end
})

Tabs.Home:AddInput("Size", {
    Title = "Size",
    Default = "1",
    Placeholder = "Enter Size Multiplier",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local Character = game.Players.LocalPlayer.Character
        for _, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") then
                Part.Size = Part.Size * tonumber(Value)
            end
        end
    end
})

Tabs.Home:AddButton({
    Title = "Apply Size",
    Callback = function()
        local Value = Tabs.Main:GetInput("Size").Value
        local Character = game.Players.LocalPlayer.Character
        for _, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") then
                Part.Size = Part.Size * tonumber(Value)
            end
        end
    end
})

local AutoWeight = Tabs.AutoFarm:AddToggle("AutoWeight", {Title = "Auto Weight", Default = false })

AutoWeight:OnChanged(function()
    while Options.AutoWeight.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Weight"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoPushups = Tabs.AutoFarm:AddToggle("AutoPushups", {Title = "Auto Pushups", Default = false })

AutoPushups:OnChanged(function()
    while Options.AutoPushups.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoSitups = Tabs.AutoFarm:AddToggle("AutoSitups", {Title = "Auto Situps", Default = false })

AutoSitups:OnChanged(function()
    while Options.AutoSitups.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Situps"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoHandstand = Tabs.AutoFarm:AddToggle("AutoHandstand", {Title = "Auto Handstand", Default = false })

AutoHandstand:OnChanged(function()
    while Options.AutoHandstand.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handstand"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoRebirthNormalToggle = Tabs.Rebirths:AddToggle("AutoRebirthNormal", {Title = "Auto Rebirth Normal", Default = false})

AutoRebirthNormalToggle:OnChanged(function()
    while AutoRebirthNormalToggle.Value do
        game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        task.wait(0.1)
    end
end)

local RebirthTargetInput = Tabs.Rebirths:AddInput("RebirthTarget", {
    Title = "Rebirth Target",
    Default = "0",
    Placeholder = "Enter target rebirths",
    Numeric = true,
    Finished = true
})

local RebirthUntilTargetToggle = Tabs.Rebirths:AddToggle("RebirthUntilTarget", {Title = "Rebirth Until Reach Target", Default = false})

RebirthUntilTargetToggle:OnChanged(function()
    local target = tonumber(RebirthTargetInput.Value)   
    while RebirthUntilTargetToggle.Value do
        if target and game.Players.LocalPlayer:FindFirstChild("leaderstats") then
            local currentRebirths = game.Players.LocalPlayer.leaderstats:FindFirstChild("Rebirths").Value         
            if currentRebirths < target then
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.1)
            else
                RebirthUntilTargetToggle:SetValue(false)
            end
        end
        task.wait(0.1)
    end
end)

Tabs.Killer:AddParagraph({
    Title = "Whitelist",
    Content = ""
})

local WhitelistDropdown = Tabs.Killer:AddDropdown("Whitelist", {
    Title = "Whitelist",
    Values = {},
    Multi = true,
    Default = {}
})

for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(WhitelistDropdown.Values, player.Name)
end

Tabs.Killer:AddParagraph({
    Title = "Killing",
    Content = ""
})

local playerWhitelist = {}

local AutoKillToggle = Tabs.Killer:AddToggle("AutoKill", {Title = "Auto Kill", Default = false })

AutoKillToggle:OnChanged(function(bool)
    local player = game.Players.LocalPlayer
    while bool do
        for _, target in ipairs(game.Players:GetPlayers()) do
            if target ~= player and not playerWhitelist[target.Name] then
                local targetChar = target.Character
                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")
                    if rightHand and leftHand then
                        firetouchinterest(rightHand, rootPart, 1)
                        firetouchinterest(leftHand, rootPart, 1)
                        firetouchinterest(rightHand, rootPart, 0)
                        firetouchinterest(leftHand, rootPart, 0)
                    end
                end
            end
        end
        wait(0.01)
    end
end)

local TargetingToggle = Tabs.Killer:AddToggle("Targeting", {Title = "Targeting", Default = false })

local SelectTargetsDropdown = Tabs.Killer:AddDropdown("SelectTargets", {
    Title = "Select Targets",
    Values = {},
    Multi = true,
    Default = {}
})

for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(SelectTargetsDropdown.Values, player.Name)
end

local KillTargetsToggle = Tabs.Killer:AddToggle("KillTargets", {Title = "Kill Targets", Default = false })

KillTargetsToggle:OnChanged(function(bool)
    local player = game.Players.LocalPlayer
    while bool do
        for _, targetName in ipairs(SelectTargetsDropdown.Value) do
            local target = game.Players:FindFirstChild(targetName)
            if target then
                local targetChar = target.Character
                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")
                    if rightHand and leftHand then
                        firetouchinterest(rightHand, rootPart, 1)
                        firetouchinterest(leftHand, rootPart, 1)
                        firetouchinterest(rightHand, rootPart, 0)
                        firetouchinterest(leftHand, rootPart, 0)
                    end
                end
            end
        end
        wait(0.01)
    end
end)

local SpyTargetToggle = Tabs.Killer:AddToggle("SpyTarget", {Title = "Spy Target", Default = false })

SpyTargetToggle:OnChanged(function(state)
    local player = game.Players.LocalPlayer
    while state do
        for _, targetName in ipairs(SelectTargetsDropdown.Value) do
            local target = game.Players:FindFirstChild(targetName)
            if target and target.Character then
                game.Workspace.CurrentCamera.CameraSubject = target.Character:FindFirstChild("Humanoid")
            end
        end
        wait(0.1)
    end
end)

Tabs.Killer:AddParagraph({
    Title = "Punching",
    Content = ""
})

local AutoEquipPunchToggle = Tabs.Killer:AddToggle("AutoEquipPunch", {Title = "Auto Equip Punch", Default = false })

AutoEquipPunchToggle:OnChanged(function(state)
    while state do
        local player = game.Players.LocalPlayer
        local punchTool = player.Backpack:FindFirstChild("Punch")
        if punchTool then
            player.Character.Humanoid:EquipTool(punchTool)
        end
        wait(0.1)
    end
end)

local AutoPunchNoAnimToggle = Tabs.Killer:AddToggle("AutoPunchNoAnim", {Title = "Auto Punch No Animation", Default = false })

AutoPunchNoAnimToggle:OnChanged(function(state)
    local player = game.Players.LocalPlayer
    while state do
        local playerName = player.Name
        local punchTool = player.Backpack:FindFirstChild("Punch") or game.Workspace:FindFirstChild(playerName):FindFirstChild("Punch")
        if punchTool then
            if punchTool.Parent ~= game.Workspace:FindFirstChild(playerName) then
                punchTool.Parent = game.Workspace:FindFirstChild(playerName)
            end
            player.muscleEvent:FireServer("punch", "rightHand")
            player.muscleEvent:FireServer("punch", "leftHand")
        else
            AutoPunchNoAnimToggle:SetValue(false)
        end
        wait(0.01)
    end
end)

Tabs.Teleport:AddButton({
    Title = "Tiny Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-31.8626194, 6.0588026, 2087.88672)
    end
})

Tabs.Teleport:AddButton({
    Title = "Starter Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226.252472, 8.1526947, 219.366516)
    end
})

Tabs.Teleport:AddButton({
    Title = "Legend Beach",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-365.798309, 44.5082932, -501.618591)
    end
})

Tabs.Teleport:AddButton({
    Title = "Frost Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2933.47998, 29.6399612, -579.946045)
    end
})

Tabs.Teleport:AddButton({
    Title = "Mythical Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2659.50635, 21.6095238, 934.690613)
    end
})

Tabs.Teleport:AddButton({
    Title = "Eternal Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7176.19141, 45.394104, -1106.31421)
    end
})

Tabs.Teleport:AddButton({
    Title = "Legend Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4446.91699, 1004.46698, -3983.76074)
    end
})

Tabs.Teleport:AddButton({
    Title = "Jungle Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8782.63477, 23.9624996, 1415.57556)
    end
})

local selectedCrystal = "Galaxy Oracle Crystal"
local autoCrystalRunning = false

Tabs.Crystal:AddParagraph({
    Title = "Select Crystal",
    Content = "Choose a crystal to auto-open."
})

local crystalNames = {
    "Blue Crystal", "Green Crystal", "Frozen Crystal", "Mythical Crystal",
    "Inferno Crystal", "Legends Crystal", "Muscle Elite Crystal",
    "Galaxy Oracle Crystal", "Sky Eclipse Crystal", "Jungle Crystal"
}

local crystalDropdown = Tabs.Crystal:AddDropdown("SelectCrystalDropdown", {
    Title = "Select Crystal",
    Values = crystalNames,
    Multi = false,
    Default = selectedCrystal,
})

crystalDropdown:OnChanged(function(selected)
    selectedCrystal = selected
end)

local function autoOpenCrystal()
    while autoCrystalRunning do
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer("openCrystal", selectedCrystal)
        wait(0.1)
    end
end

local autoCrystalToggle = Tabs.Crystal:AddToggle("AutoCrystalToggle", {
    Title = "Auto Crystal",
    Default = false,
})

autoCrystalToggle:OnChanged(function(state)
    autoCrystalRunning = state
    if autoCrystalRunning then
        task.spawn(autoOpenCrystal)
    end
end)

local SelectPlayerDropdown = Tabs.Stats:AddDropdown("SelectPlayer", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = nil
})

for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(SelectPlayerDropdown.Values, player.Name)
end

local function abbreviateNumber(num)
    local abbreviations = {"", "K", "M", "B", "T", "Qa"}
    local index = 1
    while num >= 1000 and index < #abbreviations do
        num = num / 1000
        index = index + 1
    end
    return string.format("%.1f%s", num, abbreviations[index])
end

local PlayerStatsParagraph = Tabs.Stats:AddParagraph({
    Title = "Player's Stats:",
    Content = "Strength: 0\nDurability: 0\nAgility: 0\nRebirths: 0\nKills: 0\ngoodKarma: 0\nevilKarma: 0"
})

SelectPlayerDropdown:OnChanged(function(selectedPlayer)
    local player = game.Players:FindFirstChild(selectedPlayer)
    if player then
        local leaderstats = player:FindFirstChild("leaderstats")
        local Strength = leaderstats and leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or 0
        local Rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0
        local Kills = leaderstats and leaderstats:FindFirstChild("Kills") and leaderstats.Kills.Value or 0
        local Durability = player:FindFirstChild("Durability") and player.Durability.Value or 0
        local Agility = player:FindFirstChild("Agility") and player.Agility.Value or 0
        local goodKarma = player:FindFirstChild("goodKarma") and player.goodKarma.Value or 0
        local evilKarma = player:FindFirstChild("evilKarma") and player.evilKarma.Value or 0
        
        PlayerStatsParagraph:SetDesc(string.format(
            "Strength: %s\nDurability: %s\nAgility: %s\nRebirths: %s\nKills: %s\ngoodKarma: %s\nevilKarma: %s",
            abbreviateNumber(Strength),
            abbreviateNumber(Durability),
            abbreviateNumber(Agility),
            abbreviateNumber(Rebirths),
            abbreviateNumber(Kills),
            abbreviateNumber(goodKarma),
            abbreviateNumber(evilKarma)
        ))
    end
end)

local autoJoinBrawlToggle = Tabs.Misc:AddToggle("AutoJoinBrawl", { Title = "Auto Join Brawl", Default = false })
autoJoinBrawlToggle:OnChanged(function(value)
    while value do
        game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
        task.wait(5)
    end
end)

local godModToggle = Tabs.Misc:AddToggle("GodMod", { Title = "God Mod", Default = false })
godModToggle:OnChanged(function(value)
    while value do
        game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
        task.wait(0.001)
    end
end)

Tabs.Misc:AddButton({
    Title = "Delete Portal",
    Callback = function()
        local portal = workspace:FindFirstChild("RobloxForwardPortals")
        if portal then
            portal:Destroy()
        end
    end
})

local antiKickToggle = Tabs.Misc:AddToggle("AntiKick", { Title = "Anti Kick", Default = false })
antiKickToggle:OnChanged(function(value)
    while value do
        game:GetService("Players").LocalPlayer.Idled:Wait()
        game:GetService("VirtualUser"):Button2Down(0, workspace.CurrentCamera.CFrame)
        task.wait(20)
    end
end)

local lockPositionToggle = Tabs.Misc:AddToggle("LockPosition", { Title = "Lock Position", Default = false })
lockPositionToggle:OnChanged(function(value)
    local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    if value then
        getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
            end
        end)
    else
        if getgenv().posLock then
            getgenv().posLock:Disconnect()
        end
    end
end)

local freeAutoLiftToggle = Tabs.Misc:AddToggle("FreeAutoLiftGamepass", { Title = "Free Auto Lift Gamepass", Default = false })
freeAutoLiftToggle:OnChanged(function(value)
    local gamepassFolder = game:GetService("ReplicatedStorage"):FindFirstChild("gamepassIds")
    local player = game:GetService("Plalocal Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/EncryptedV10/Main/refs/heads/main/Library/Fluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Nova Hub Free Version" .. Fluent.Version,
    SubTitle = "by Encrypted",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Nova",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Home = Window:AddTab({ Title = "Home", Icon = "scan-face" }),
    AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "crown" }),
    Rebirths = Window:AddTab({ Title = "Rebirths", Icon = "rotate-ccw" }),
    Killer = Window:AddTab({ Title = "Killer", Icon = "sword" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "forward" }),
    Crystal = Window:AddTab({ Title = "Crystal", Icon = "egg" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "newspaper" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "Play" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),    
}

Tabs.Home:AddParagraph({
        Title = "Discord Server:",
        Content = "https://discord.gg/Tk9gsP4kGf"
    })

Tabs.Home:AddParagraph({
        Title = "Local Player",
        Content = ""
    })

Tabs.Home:AddInput("WalkSpeed", {
    Title = "WalkSpeed",
    Default = "16",
    Placeholder = "Enter WalkSpeed",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(Value)
    end
})

Tabs.Home:AddButton({
    Title = "Apply WalkSpeed",
    Callback = function()
        local Value = Tabs.Main:GetInput("WalkSpeed").Value
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(Value)
    end
})

Tabs.Home:AddInput("JumpPower", {
    Title = "JumpPower",
    Default = "50",
    Placeholder = "Enter JumpPower",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(Value)
    end
})

Tabs.Home:AddButton({
    Title = "Apply JumpPower",
    Callback = function()
        local Value = Tabs.Main:GetInput("JumpPower").Value
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(Value)
    end
})

Tabs.Home:AddInput("Size", {
    Title = "Size",
    Default = "1",
    Placeholder = "Enter Size Multiplier",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        local Character = game.Players.LocalPlayer.Character
        for _, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") then
                Part.Size = Part.Size * tonumber(Value)
            end
        end
    end
})

Tabs.Home:AddButton({
    Title = "Apply Size",
    Callback = function()
        local Value = Tabs.Main:GetInput("Size").Value
        local Character = game.Players.LocalPlayer.Character
        for _, Part in pairs(Character:GetChildren()) do
            if Part:IsA("BasePart") then
                Part.Size = Part.Size * tonumber(Value)
            end
        end
    end
})

local AutoWeight = Tabs.AutoFarm:AddToggle("AutoWeight", {Title = "Auto Weight", Default = false })

AutoWeight:OnChanged(function()
    while Options.AutoWeight.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Weight"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoPushups = Tabs.AutoFarm:AddToggle("AutoPushups", {Title = "Auto Pushups", Default = false })

AutoPushups:OnChanged(function()
    while Options.AutoPushups.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoSitups = Tabs.AutoFarm:AddToggle("AutoSitups", {Title = "Auto Situps", Default = false })

AutoSitups:OnChanged(function()
    while Options.AutoSitups.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Situps"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoHandstand = Tabs.AutoFarm:AddToggle("AutoHandstand", {Title = "Auto Handstand", Default = false })

AutoHandstand:OnChanged(function()
    while Options.AutoHandstand.Value do
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Handstand"))
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
        task.wait(0.1)
    end
end)

local AutoRebirthNormalToggle = Tabs.Rebirths:AddToggle("AutoRebirthNormal", {Title = "Auto Rebirth Normal", Default = false})

AutoRebirthNormalToggle:OnChanged(function()
    while AutoRebirthNormalToggle.Value do
        game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
        task.wait(0.1)
    end
end)

local RebirthTargetInput = Tabs.Rebirths:AddInput("RebirthTarget", {
    Title = "Rebirth Target",
    Default = "0",
    Placeholder = "Enter target rebirths",
    Numeric = true,
    Finished = true
})

local RebirthUntilTargetToggle = Tabs.Rebirths:AddToggle("RebirthUntilTarget", {Title = "Rebirth Until Reach Target", Default = false})

RebirthUntilTargetToggle:OnChanged(function()
    local target = tonumber(RebirthTargetInput.Value)   
    while RebirthUntilTargetToggle.Value do
        if target and game.Players.LocalPlayer:FindFirstChild("leaderstats") then
            local currentRebirths = game.Players.LocalPlayer.leaderstats:FindFirstChild("Rebirths").Value         
            if currentRebirths < target then
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                task.wait(0.1)
            else
                RebirthUntilTargetToggle:SetValue(false)
            end
        end
        task.wait(0.1)
    end
end)

Tabs.Killer:AddParagraph({
    Title = "Whitelist",
    Content = ""
})

local WhitelistDropdown = Tabs.Killer:AddDropdown("Whitelist", {
    Title = "Whitelist",
    Values = {},
    Multi = true,
    Default = {}
})

for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(WhitelistDropdown.Values, player.Name)
end

Tabs.Killer:AddParagraph({
    Title = "Killing",
    Content = ""
})

local playerWhitelist = {}

local AutoKillToggle = Tabs.Killer:AddToggle("AutoKill", {Title = "Auto Kill", Default = false })

AutoKillToggle:OnChanged(function(bool)
    local player = game.Players.LocalPlayer
    while bool do
        for _, target in ipairs(game.Players:GetPlayers()) do
            if target ~= player and not playerWhitelist[target.Name] then
                local targetChar = target.Character
                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")
                    if rightHand and leftHand then
                        firetouchinterest(rightHand, rootPart, 1)
                        firetouchinterest(leftHand, rootPart, 1)
                        firetouchinterest(rightHand, rootPart, 0)
                        firetouchinterest(leftHand, rootPart, 0)
                    end
                end
            end
        end
        wait(0.01)
    end
end)

local TargetingToggle = Tabs.Killer:AddToggle("Targeting", {Title = "Targeting", Default = false })

local SelectTargetsDropdown = Tabs.Killer:AddDropdown("SelectTargets", {
    Title = "Select Targets",
    Values = {},
    Multi = true,
    Default = {}
})

for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(SelectTargetsDropdown.Values, player.Name)
end

local KillTargetsToggle = Tabs.Killer:AddToggle("KillTargets", {Title = "Kill Targets", Default = false })

KillTargetsToggle:OnChanged(function(bool)
    local player = game.Players.LocalPlayer
    while bool do
        for _, targetName in ipairs(SelectTargetsDropdown.Value) do
            local target = game.Players:FindFirstChild(targetName)
            if target then
                local targetChar = target.Character
                local rootPart = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local rightHand = player.Character and player.Character:FindFirstChild("RightHand")
                    local leftHand = player.Character and player.Character:FindFirstChild("LeftHand")
                    if rightHand and leftHand then
                        firetouchinterest(rightHand, rootPart, 1)
                        firetouchinterest(leftHand, rootPart, 1)
                        firetouchinterest(rightHand, rootPart, 0)
                        firetouchinterest(leftHand, rootPart, 0)
                    end
                end
            end
        end
        wait(0.01)
    end
end)

local SpyTargetToggle = Tabs.Killer:AddToggle("SpyTarget", {Title = "Spy Target", Default = false })

SpyTargetToggle:OnChanged(function(state)
    local player = game.Players.LocalPlayer
    while state do
        for _, targetName in ipairs(SelectTargetsDropdown.Value) do
            local target = game.Players:FindFirstChild(targetName)
            if target and target.Character then
                game.Workspace.CurrentCamera.CameraSubject = target.Character:FindFirstChild("Humanoid")
            end
        end
        wait(0.1)
    end
end)

Tabs.Killer:AddParagraph({
    Title = "Punching",
    Content = ""
})

local AutoEquipPunchToggle = Tabs.Killer:AddToggle("AutoEquipPunch", {Title = "Auto Equip Punch", Default = false })

AutoEquipPunchToggle:OnChanged(function(state)
    while state do
        local player = game.Players.LocalPlayer
        local punchTool = player.Backpack:FindFirstChild("Punch")
        if punchTool then
            player.Character.Humanoid:EquipTool(punchTool)
        end
        wait(0.1)
    end
end)

local AutoPunchNoAnimToggle = Tabs.Killer:AddToggle("AutoPunchNoAnim", {Title = "Auto Punch No Animation", Default = false })

AutoPunchNoAnimToggle:OnChanged(function(state)
    local player = game.Players.LocalPlayer
    while state do
        local playerName = player.Name
        local punchTool = player.Backpack:FindFirstChild("Punch") or game.Workspace:FindFirstChild(playerName):FindFirstChild("Punch")
        if punchTool then
            if punchTool.Parent ~= game.Workspace:FindFirstChild(playerName) then
                punchTool.Parent = game.Workspace:FindFirstChild(playerName)
            end
            player.muscleEvent:FireServer("punch", "rightHand")
            player.muscleEvent:FireServer("punch", "leftHand")
        else
            AutoPunchNoAnimToggle:SetValue(false)
        end
        wait(0.01)
    end
end)

Tabs.Teleport:AddButton({
    Title = "Tiny Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-31.8626194, 6.0588026, 2087.88672)
    end
})

Tabs.Teleport:AddButton({
    Title = "Starter Island",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226.252472, 8.1526947, 219.366516)
    end
})

Tabs.Teleport:AddButton({
    Title = "Legend Beach",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-365.798309, 44.5082932, -501.618591)
    end
})

Tabs.Teleport:AddButton({
    Title = "Frost Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2933.47998, 29.6399612, -579.946045)
    end
})

Tabs.Teleport:AddButton({
    Title = "Mythical Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2659.50635, 21.6095238, 934.690613)
    end
})

Tabs.Teleport:AddButton({
    Title = "Eternal Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7176.19141, 45.394104, -1106.31421)
    end
})

Tabs.Teleport:AddButton({
    Title = "Legend Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4446.91699, 1004.46698, -3983.76074)
    end
})

Tabs.Teleport:AddButton({
    Title = "Jungle Gym",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8782.63477, 23.9624996, 1415.57556)
    end
})

local selectedCrystal = "Galaxy Oracle Crystal"
local autoCrystalRunning = false

Tabs.Crystal:AddParagraph({
    Title = "Select Crystal",
    Content = "Choose a crystal to auto-open."
})

local crystalNames = {
    "Blue Crystal", "Green Crystal", "Frozen Crystal", "Mythical Crystal",
    "Inferno Crystal", "Legends Crystal", "Muscle Elite Crystal",
    "Galaxy Oracle Crystal", "Sky Eclipse Crystal", "Jungle Crystal"
}

local crystalDropdown = Tabs.Crystal:AddDropdown("SelectCrystalDropdown", {
    Title = "Select Crystal",
    Values = crystalNames,
    Multi = false,
    Default = selectedCrystal,
})

crystalDropdown:OnChanged(function(selected)
    selectedCrystal = selected
end)

local function autoOpenCrystal()
    while autoCrystalRunning do
        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer("openCrystal", selectedCrystal)
        wait(0.1)
    end
end

local autoCrystalToggle = Tabs.Crystal:AddToggle("AutoCrystalToggle", {
    Title = "Auto Crystal",
    Default = false,
})

autoCrystalToggle:OnChanged(function(state)
    autoCrystalRunning = state
    if autoCrystalRunning then
        task.spawn(autoOpenCrystal)
    end
end)

local SelectPlayerDropdown = Tabs.Stats:AddDropdown("SelectPlayer", {
    Title = "Select Player",
    Values = {},
    Multi = false,
    Default = nil
})

for _, player in ipairs(game.Players:GetPlayers()) do
    table.insert(SelectPlayerDropdown.Values, player.Name)
end

local function abbreviateNumber(num)
    local abbreviations = {"", "K", "M", "B", "T", "Qa"}
    local index = 1
    while num >= 1000 and index < #abbreviations do
        num = num / 1000
        index = index + 1
    end
    return string.format("%.1f%s", num, abbreviations[index])
end

local PlayerStatsParagraph = Tabs.Stats:AddParagraph({
    Title = "Player's Stats:",
    Content = "Strength: 0\nDurability: 0\nAgility: 0\nRebirths: 0\nKills: 0\ngoodKarma: 0\nevilKarma: 0"
})

SelectPlayerDropdown:OnChanged(function(selectedPlayer)
    local player = game.Players:FindFirstChild(selectedPlayer)
    if player then
        local leaderstats = player:FindFirstChild("leaderstats")
        local Strength = leaderstats and leaderstats:FindFirstChild("Strength") and leaderstats.Strength.Value or 0
        local Rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0
        local Kills = leaderstats and leaderstats:FindFirstChild("Kills") and leaderstats.Kills.Value or 0
        local Durability = player:FindFirstChild("Durability") and player.Durability.Value or 0
        local Agility = player:FindFirstChild("Agility") and player.Agility.Value or 0
        local goodKarma = player:FindFirstChild("goodKarma") and player.goodKarma.Value or 0
        local evilKarma = player:FindFirstChild("evilKarma") and player.evilKarma.Value or 0
        
        PlayerStatsParagraph:SetDesc(string.format(
            "Strength: %s\nDurability: %s\nAgility: %s\nRebirths: %s\nKills: %s\ngoodKarma: %s\nevilKarma: %s",
            abbreviateNumber(Strength),
            abbreviateNumber(Durability),
            abbreviateNumber(Agility),
            abbreviateNumber(Rebirths),
            abbreviateNumber(Kills),
            abbreviateNumber(goodKarma),
            abbreviateNumber(evilKarma)
        ))
    end
end)

local autoJoinBrawlToggle = Tabs.Misc:AddToggle("AutoJoinBrawl", { Title = "Auto Join Brawl", Default = false })
autoJoinBrawlToggle:OnChanged(function(value)
    while value do
        game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
        task.wait(5)
    end
end)

local godModToggle = Tabs.Misc:AddToggle("GodMod", { Title = "God Mod", Default = false })
godModToggle:OnChanged(function(value)
    while value do
        game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
        task.wait(0.001)
    end
end)

Tabs.Misc:AddButton({
    Title = "Delete Portal",
    Callback = function()
        local portal = workspace:FindFirstChild("RobloxForwardPortals")
        if portal then
            portal:Destroy()
        end
    end
})

local antiKickToggle = Tabs.Misc:AddToggle("AntiKick", { Title = "Anti Kick", Default = false })
antiKickToggle:OnChanged(function(value)
    while value do
        game:GetService("Players").LocalPlayer.Idled:Wait()
        game:GetService("VirtualUser"):Button2Down(0, workspace.CurrentCamera.CFrame)
        task.wait(20)
    end
end)

local lockPositionToggle = Tabs.Misc:AddToggle("LockPosition", { Title = "Lock Position", Default = false })
lockPositionToggle:OnChanged(function(value)
    local currentPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    if value then
        getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
            end
        end)
    else
        if getgenv().posLock then
            getgenv().posLock:Disconnect()
        end
    end
end)

local freeAutoLiftToggle = Tabs.Misc:AddToggle("FreeAutoLiftGamepass", { Title = "Free Auto Lift Gamepass", Default = false })
freeAutoLiftToggle:OnChanged(function(value)
    local gamepassFolder = game:GetService("ReplicatedStorage"):FindFirstChild("gamepassIds")
    local player = game:GetService("Players").LocalPlayer

    if not gamepassFolder or not player then return end

    if value then
        for _, gamepass in pairs(gamepassFolder:GetChildren()) do
            if not player.ownedGamepasses:FindFirstChild(gamepass.Name) then
                local valueInstance = Instance.new("IntValue")
                valueInstance.Name = gamepass.Name
                valueInstance.Value = gamepass.Value
                valueInstance.Parent = player.ownedGamepasses
            end
        end
    else
        for _, gamepass in pairs(player.ownedGamepasses:GetChildren()) do
            gamepass:Destroy()
        end
    end
end)

local autoSpinWheelToggle = Tabs.Misc:AddToggle("AutoSpinWheel", { Title = "Auto Spin Wheel", Default = false })
autoSpinWheelToggle:OnChanged(function(value)
    while value do
        local args = {
            [1] = "openFortuneWheel",
            [2] = game:GetService("ReplicatedStorage"):WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")
        }
        game:GetService("ReplicatedStorage").fortuneWheelEvent:FireServer(unpack(args))
        task.wait(0.1)
    end
end)yers").LocalPlayer

    if not gamepassFolder or not player then return end

    if value then
        for _, gamepass in pairs(gamepassFolder:GetChildren()) do
            if not player.ownedGamepasses:FindFirstChild(gamepass.Name) then
                local valueInstance = Instance.new("IntValue")
                valueInstance.Name = gamepass.Name
                valueInstance.Value = gamepass.Value
                valueInstance.Parent = player.ownedGamepasses
            end
        end
    else
        for _, gamepass in pairs(player.ownedGamepasses:GetChildren()) do
            gamepass:Destroy()
        end
    end
end)

local autoSpinWheelToggle = Tabs.Misc:AddToggle("AutoSpinWheel", { Title = "Auto Spin Wheel", Default = false })
autoSpinWheelToggle:OnChanged(function(value)
    while value do
        local args = {
            [1] = "openFortuneWheel",
            [2] = game:GetService("ReplicatedStorage"):WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")
        }
        game:GetService("ReplicatedStorage").fortuneWheelEvent:FireServer(unpack(args))
        task.wait(0.1)
    end
end)
