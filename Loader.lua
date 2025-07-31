--!strict
-- Loader chính, load UI và module
local repo = "https://raw.githubusercontent.com/YourUsername/Universal-Fluent/master/"

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/source.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Universal Hub",
    SubTitle = "Fluent UI | by Overflow",
    TabWidth = 140,
    Size = UDim2.fromOffset(600, 440),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local modules = {
    "Movement", "Combat", "Visual", "ESP", "Utility", "AntiHack", "UISettings"
}

for _, m in ipairs(modules) do
    local ok, fn = pcall(function()
        return assert(loadstring(game:HttpGet(repo.."Modules/"..m..".lua")))
    end)
    if ok then
        fn(Window)
    end
end

Fluent:Notify({
    Title = "Universal Hub Loaded",
    Content = "Script by Overflow | Fluent UI",
    Duration = 6
})
