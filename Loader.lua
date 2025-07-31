--!strict
-- Universal Fluent All-in-One | Script by overflow

local Fluent = loadstring(game:HttpGet("https://github.com/AbstractPoo/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "🌐 Universal All-in-One | overflow",
    SubTitle = "No Key - Fluent UI",
    TabWidth = 160,
    Size = UDim2.fromOffset(540, 370),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Watermark + BGM
Fluent:Notify({ Title = "Universal Hub", Content = "Script by overflow", Duration = 6 })
local Sound = Instance.new("Sound", game.SoundService)
Sound.SoundId = "rbxassetid://9129210086"
Sound.Looped = true
Sound.Volume = 1
Sound:Play()

-- Combat Tab
local combatTab = Window:AddTab({ Title = "⚔️ Combat", Icon = "sword" })
combatTab:AddButton({ Title = "Aimbot (CamLock)", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lonmethgkhoi/UniversalFluentUI/main/modules/aimbot.lua"))()
end })
combatTab:AddButton({ Title = "ESP + Tracer", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lonmethgkhoi/UniversalFluentUI/main/modules/esp.lua"))()
end })
combatTab:AddButton({ Title = "Silent Aimbot", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lonmethgkhoi/UniversalFluentUI/main/modules/silentaim.lua"))()
end })

-- Visual Tab
local visualTab = Window:AddTab({ Title = "🧠 Visual", Icon = "eye" })
visualTab:AddButton({ Title = "Full Bright", Callback = function()
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 2
    lighting.ClockTime = 14
    lighting.FogEnd = 100000
    lighting.GlobalShadows = false
end })

-- Utility Tab
local utilTab = Window:AddTab({ Title = "🧰 Utility", Icon = "tool" })
utilTab:AddButton({ Title = "Rejoin Server", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end })
utilTab:AddButton({ Title = "Server Hop", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/4s3aXQ3C"))()
end })
utilTab:AddButton({ Title = "Anti-AFK", Callback = function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end })

-- FPS Boost Tab
local fpsTab = Window:AddTab({ Title = "🚀 FPS Boost", Icon = "cpu" })
fpsTab:AddButton({ Title = "Boost FPS", Callback = function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        end
        if v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        end
    end
    settings().Rendering.QualityLevel = 1
    settings().Rendering.TextureQuality = Enum.TextureQualityLevel.Low
end })

-- Anti-Hack Tab
local antiTab = Window:AddTab({ Title = "🛡️ Anti-Hack", Icon = "shield" })

local antiFlingConn
antiTab:AddToggle({
    Title = "Anti-Fling",
    Default = true,
    Callback = function(state)
        if state then
            if antiFlingConn then antiFlingConn:Disconnect() end
            antiFlingConn = game:GetService("RunService").Stepped:Connect(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Velocity.Magnitude > 1000 then
                        v.Velocity = Vector3.new(0, 0, 0)
                        v.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        else
            if antiFlingConn then antiFlingConn:Disconnect() antiFlingConn = nil end
        end
    end
})

local autoFixThread
antiTab:AddToggle({
    Title = "Auto-Fix HRP",
    Default = true,
    Callback = function(state)
        if state then
            if autoFixThread and coroutine.status(autoFixThread) ~= "dead" then return end
            autoFixThread = coroutine.create(function()
                while true do
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and hrp.Velocity.Magnitude > 150 then
                        hrp.Velocity = Vector3.new(0,0,0)
                    end
                    task.wait(0.5)
                end
            end)
            coroutine.resume(autoFixThread)
        else
            -- Không thể dừng coroutine dễ dàng, bạn nên dùng biến để kiểm soát nếu cần
        end
    end
})

-- UI Tab
local uiTab = Window:AddTab({ Title = "🎨 UI Theme", Icon = "palette" })
uiTab:AddDropdown({
    Title = "Chọn Theme",
    Values = {"Dark", "Darker", "Light", "Amoled"},
    Multi = false,
    Default = 2,
    Callback = function(value)
        Window:SetTheme(value)
    end
})
uiTab:AddButton({
    Title = "Destroy UI",
    Callback = function()
        Fluent:Destroy()
        Sound:Destroy()
    end
})