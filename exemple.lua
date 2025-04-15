local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/EncryptedV10/Roblox-Scripts/refs/heads/main/Fisch.lua"))()

local Window = Library:CreateWindow("My Awesome GUI")


local Tab = Window:CreateTab("Tab 1")


local Elements = Tab:CreateFolder("Elements")

Elements:CreateLabel("This is a label.")


Elements:CreateButton("Click Me", function()
    print("Button clicked!")
end)


Elements:CreateSwitch("Toggle Me", function(state)
    print("Switch is now " .. (state and "ON" or "OFF"))
end)


Elements:CreateDropdown("Choose an option", {"Option 1", "Option 2", "Option 3"}, function(selectedOption)
    print("You selected: " .. selectedOption)
end)


local Tab2 = Window:CreateTab("Tab 2")


local Elements2 = Tab2:CreateFolder("More Elements")

Elements2:CreateLabel("Here's another label.")


Elements2:CreateButton("Button in Tab 2", function()
    print("Button in Tab 2 clicked!")
end)


Elements2:CreateSwitch("Switch in Tab 2", function(state)
    print("Second tab switch is now " .. (state and "ON" or "OFF"))
end)


Elements2:CreateSlider("Adjust Me", 100, function(value)
    print("Slider value: " .. value)
end)
