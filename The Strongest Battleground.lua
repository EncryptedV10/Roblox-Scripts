_G.tokenvar = tostring(math.random(100000, 999999))
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EncryptedV10/Nova-Library/refs/heads/main/LibraryObfuscated.lua", true))()
local window = Library:AddWindow("Nova Hub | Legends Of Speed")

local HomeTab = Library:CreateTab("Home", "122442803739407")
HomeTab:CreateLabel("Welcome To Nova Hub The Strongest BattleGround")
HomeTab:CreateButton("Copy Discord Server Link", "Copies the Discord link", function()
    setclipboard("https://discord.gg/HJ7q82Q6pP")
end)

local WalkSpeedBox = HomeTab:CreateTextbox("WalkSpeed", "Set your walkspeed", function(text)
    local speed = tonumber(text)
    if speed then
        humanoid.WalkSpeed = speed
    end
end)

local JumpPowerBox = HomeTab:CreateTextbox("JumpPower", "Set your jumppower", function(text)
    local power = tonumber(text)
    if power then
        humanoid.JumpPower = power
    end
end)

local defaultWalkSpeed = humanoid.WalkSpeed
local defaultJumpPower = humanoid.JumpPower

local WalkSpeedToggle
WalkSpeedToggle = HomeTab:CreateToggle("WalkSpeed Toggle", "Keep WalkSpeed applied", function(state)
    task.spawn(function()
        while state do
            humanoid.WalkSpeed = tonumber(WalkSpeedBox.Text) or humanoid.WalkSpeed
            task.wait(0.1)
        end
        humanoid.WalkSpeed = defaultWalkSpeed
    end)
end)

local JumpPowerToggle
JumpPowerToggle = HomeTab:CreateToggle("JumpPower Toggle", "Keep JumpPower applied", function(state)
    task.spawn(function()
        while state do
            humanoid.JumpPower = tonumber(JumpPowerBox.Text) or humanoid.JumpPower
            task.wait(0.1)
        end
        humanoid.JumpPower = defaultJumpPower
    end)
end)

local MainTab = Library:CreateTab("Main", "113339774911055")
