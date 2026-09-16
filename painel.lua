--========================================================--
-- TXZZ76 HUB | KEY SYSTEM
-- VERSÃO CORRIGIDA
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    return
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local KEY_CORRETA = "TXZZ"
local DISCORD_LINK = "https://discord.gg/cYKwrDjfKk"

--========================================================--
-- LIMPAR
--========================================================--

pcall(function()
    local oldKey = PlayerGui:FindFirstChild("TXZZ76_KEY_SYSTEM")
    if oldKey then
        oldKey:Destroy()
    end

    local oldHub = PlayerGui:FindFirstChild("TXZZ76HUBCore")
    if oldHub then
        oldHub:Destroy()
    end
end)

--========================================================--
-- KEY GUI
--========================================================--

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "TXZZ76_KEY_SYSTEM"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.DisplayOrder = 999999
KeyGui.Parent = PlayerGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 370, 0, 300)
KeyFrame.Position = UDim2.new(0.5, -185, 0.5, -150)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(255, 200, 0)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

-- título

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "TXZZ76 HUB"
Title.TextColor3 = Color3.fromRGB(255, 210, 0)
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.Parent = KeyFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 25)
Subtitle.Position = UDim2.new(0, 10, 0, 53)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "KEY SYSTEM"
Subtitle.TextColor3 = Color3.fromRGB(170, 170, 170)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.GothamSemibold
Subtitle.Parent = KeyFrame

-- instrução

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, -30, 0, 30)
Info.Position = UDim2.new(0, 15, 0, 80)
Info.BackgroundTransparency = 1
Info.Text = "Digite sua Key para liberar o painel"
Info.TextColor3 = Color3.fromRGB(220, 220, 220)
Info.TextSize = 12
Info.Font = Enum.Font.Gotham
Info.Parent = KeyFrame

-- caixa

local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(1, -30, 0, 42)
KeyBox.Position = UDim2.new(0, 15, 0, 115)
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyBox.BorderSizePixel = 0
KeyBox.ClearTextOnFocus = false
KeyBox.PlaceholderText = "Digite sua Key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 110)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 12
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 7)
BoxCorner.Parent = KeyBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(55, 55, 55)
BoxStroke.Thickness = 1
BoxStroke.Parent = KeyBox

-- botão verificar

local Verify = Instance.new("TextButton")
Verify.Name = "VerifyButton"
Verify.Size = UDim2.new(1, -30, 0, 40)
Verify.Position = UDim2.new(0, 15, 0, 168)
Verify.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
Verify.BorderSizePixel = 0
Verify.Text = "VERIFICAR KEY"
Verify.TextColor3 = Color3.fromRGB(255, 210, 0)
Verify.TextSize = 12
Verify.Font = Enum.Font.GothamBold
Verify.Parent = KeyFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 7)
VerifyCorner.Parent = Verify

local VerifyStroke = Instance.new("UIStroke")
VerifyStroke.Color = Color3.fromRGB(190, 150, 0)
VerifyStroke.Thickness = 1
VerifyStroke.Parent = Verify

-- discord

local DiscordButton = Instance.new("TextButton")
DiscordButton.Name = "DiscordButton"
DiscordButton.Size = UDim2.new(1, -30, 0, 38)
DiscordButton.Position = UDim2.new(0, 15, 0, 218)
DiscordButton.BackgroundColor3 = Color3.fromRGB(45, 45, 80)
DiscordButton.BorderSizePixel = 0
DiscordButton.Text = "COPIAR DISCORD"
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.TextSize = 11
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.Parent = KeyFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 7)
DiscordCorner.Parent = DiscordButton

-- link

local LinkLabel = Instance.new("TextLabel")
LinkLabel.Size = UDim2.new(1, -30, 0, 22)
LinkLabel.Position = UDim2.new(0, 15, 0, 263)
LinkLabel.BackgroundTransparency = 1
LinkLabel.Text = DISCORD_LINK
LinkLabel.TextColor3 = Color3.fromRGB(100, 160, 255)
LinkLabel.TextSize = 10
LinkLabel.Font = Enum.Font.Gotham
LinkLabel.Parent = KeyFrame

--========================================================--
-- NOTIFICAÇÃO KEY
--========================================================--

local function NotifyKey(text)

    local Notification = Instance.new("TextLabel")

    Notification.Size = UDim2.new(0, 300, 0, 38)
    Notification.Position = UDim2.new(0.5, -150, 0, 20)
    Notification.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Notification.BorderSizePixel = 0
    Notification.Text = text
    Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notification.TextSize = 11
    Notification.Font = Enum.Font.GothamBold
    Notification.ZIndex = 100
    Notification.Parent = KeyGui

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = Notification

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(255, 200, 0)
    s.Thickness = 1
    s.Parent = Notification

    task.delay(2, function()
        if Notification and Notification.Parent then
            Notification:Destroy()
        end
    end)
end

--========================================================--
-- COPIAR DISCORD
--========================================================--

DiscordButton.MouseButton1Click:Connect(function()

    local copied = false

    pcall(function()
        if setclipboard then
            setclipboard(DISCORD_LINK)
            copied = true
        end
    end)

    if copied then
        DiscordButton.Text = "DISCORD COPIADO!"
        NotifyKey("Discord copiado!")
    else
        DiscordButton.Text = "LINK: cYKwrDjfKk"
        NotifyKey("Link: " .. DISCORD_LINK)
    end

    task.delay(1.5, function()
        if DiscordButton and DiscordButton.Parent then
            DiscordButton.Text = "COPIAR DISCORD"
        end
    end)

end)

--========================================================--
-- HUB PRINCIPAL
--========================================================--

local function StartHub()

    -- cria nova interface

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TXZZ76HUBCore"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 999998
    ScreenGui.Parent = PlayerGui

    --====================================================--
    -- NOTIFICAÇÃO
    --====================================================--

    local function HubNotify(text)

        local Frame = Instance.new("Frame")

        Frame.Size = UDim2.new(0, 220, 0, 32)
        Frame.Position = UDim2.new(1, 10, 1, -45)
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Frame.BackgroundTransparency = 0.1
        Frame.BorderSizePixel = 0
        Frame.Parent = ScreenGui

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = Frame

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(255, 200, 0)
        Stroke.Thickness = 1
        Stroke.Parent = Frame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -12, 1, 0)
        Label.Position = UDim2.new(0, 6, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(240, 240, 240)
        Label.TextSize = 9
        Label.Font = Enum.Font.GothamBold
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Frame

        TweenService:Create(
            Frame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(1, -230, 1, -45)
            }
        ):Play()

        task.delay(2.5, function()

            if not Frame.Parent then
                return
            end

            local Tween = TweenService:Create(
                Frame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {
                    Position = UDim2.new(1, 10, 1, -45)
                }
            )

            Tween:Play()

            Tween.Completed:Connect(function()
                if Frame then
                    Frame:Destroy()
                end
            end)

        end)

    end

    --====================================================--
    -- ANTI LAG
    --====================================================--

    pcall(function()

        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9000000000
        Lighting.Brightness = 1

        for _, object in ipairs(Lighting:GetChildren()) do

            if object:IsA("PostEffect")
                or object:IsA("BlurEffect")
                or object:IsA("SunRaysEffect")
                or object:IsA("ColorCorrectionEffect")
                or object:IsA("BloomEffect") then

                object.Enabled = false

            end

        end

        local function OptimizeObject(object)

            pcall(function()

                if object:IsA("BasePart") then

                    object.Material = Enum.Material.SmoothPlastic
                    object.Reflectance = 0

                elseif object:IsA("Decal")
                    or object:IsA("Texture") then

                    object.Transparency = 1

                elseif object:IsA("ParticleEmitter")
                    or object:IsA("Trail")
                    or object:IsA("Smoke")
                    or object:IsA("Fire")
                    or object:IsA("Sparkles") then

                    object.Enabled = false

                end

            end)

        end

        for _, object in ipairs(Workspace:GetDescendants()) do
            OptimizeObject(object)
        end

        Workspace.DescendantAdded:Connect(function(object)

            task.wait()

            OptimizeObject(object)

        end)

    end)

    HubNotify("Anti-Lag Activated")

    --====================================================--
    -- JANELA
    --====================================================--

    local Frame = Instance.new("Frame")

    Frame.Name = "GlowFrame"
    Frame.Size = UDim2.new(0, 328, 0, 248)
    Frame.Position = UDim2.new(0.5, -164, 0.5, -124)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    Frame.BackgroundTransparency = 0.65
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Frame

    local Main = Instance.new("Frame")

    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 320, 0, 240)
    Main.Position = UDim2.new(0, 4, 0, 4)
    Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Main.BackgroundTransparency = 0.15
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = Frame

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(255, 200, 0)
    MainStroke.Thickness = 1.5
    MainStroke.Parent = Main

    local Gradient = Instance.new("UIGradient")

    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(
            0,
            Color3.fromRGB(12, 12, 12)
        ),
        ColorSequenceKeypoint.new(
            0.5,
            Color3.fromRGB(55, 45, 10)
        ),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(12, 12, 12)
        )
    })

    Gradient.Rotation = 45
    Gradient.Parent = Main

    local Animation = 0

    RunService.RenderStepped:Connect(function(dt)

        if not Frame.Parent then
            return
        end

        Animation = (Animation + dt * 1.5) % 6.283185307

        Gradient.Rotation =
            math.sin(Animation) * 15 + 45

        Frame.BackgroundTransparency =
            math.sin(Animation * 2) * 0.1 + 0.6

    end)

    --====================================================--
    -- TOP BAR
    --====================================================--

    local TopBar = Instance.new("Frame")

    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 34)
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    TopBar.BackgroundTransparency = 0.2
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    local HubTitle = Instance.new("TextLabel")

    HubTitle.Size = UDim2.new(1, -40, 1, 0)
    HubTitle.Position = UDim2.new(0, 10, 0, 0)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = "TXZZ76 HUB | discord.gg/cYKwrDjfKk"
    HubTitle.TextColor3 = Color3.fromRGB(255, 210, 0)
    HubTitle.TextSize = 11
    HubTitle.Font = Enum.Font.GothamBold
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    HubTitle.Parent = TopBar

    local Minimize = Instance.new("TextButton")

    Minimize.Name = "MinimizeButton"
    Minimize.Size = UDim2.new(0, 24, 0, 24)
    Minimize.Position = UDim2.new(1, -28, 0.5, -12)
    Minimize.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
    Minimize.Text = "_"
    Minimize.TextColor3 = Color3.fromRGB(255, 220, 0)
    Minimize.TextSize = 14
    Minimize.Font = Enum.Font.GothamBold
    Minimize.Parent = TopBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = Minimize

    --====================================================--
    -- SCROLL
    --====================================================--

    local Scroll = Instance.new("ScrollingFrame")

    Scroll.Name = "ScrollContainer"
    Scroll.Size = UDim2.new(1, -12, 1, -42)
    Scroll.Position = UDim2.new(0, 6, 0, 38)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 2
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 200, 0)
    Scroll.Parent = Main

    local Layout = Instance.new("UIListLayout")

    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6)
    Layout.Parent = Scroll

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

        Scroll.CanvasSize = UDim2.new(
            0,
            0,
            0,
            Layout.AbsoluteContentSize.Y + 8
        )

    end)

    --====================================================--
    -- HUBS
    --====================================================--

    local Scripts = {

        {
            Name = "ANTI HIT",
            HasKey = false,
            Script = [[
                script_key = "Trial"
                loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()
            ]]
        },

        {
            Name = "BIGFROOT",
            HasKey = true,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()
            ]]
        },

        {
            Name = "BK HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/9ee4edde227ac85f50872bf9e4226508.lua"))()
            ]]
        },

        {
            Name = "CLOVER HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://rawscripts.net/raw/Steal-An-Egg-Clover-Hub-or-Auto-Steal-Egg-Predictor-Auto-Hatch-and-ESP-226600"))()
            ]]
        },

        {
            Name = "FOXNAME HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Bliqe/Upload/refs/heads/main/Games/RUO/12665928789.lua"))()
            ]]
        },

        {
            Name = "FYY HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://FyyCommunity.my.id"))()
            ]]
        },

        {
            Name = "Keyless Hub",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"))()
            ]]
        },

        {
            Name = "LENNON HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhubv2/main/stealaneggv2"))()
            ]]
        },

        {
            Name = "LEST HUB",
            HasKey = false,
            Script = [[
                getgenv().SCRIPT_KEY = "KEYLESS"
                loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/c916d48837ab69c48a9b3cafb04b49c8d9253af84cf8e403b19e2be302cbe67a/download"))()
            ]]
        },

        {
            Name = "MIRANDA HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaeggs"))()
            ]]
        },

        {
            Name = "MOSHI HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/moshixzn/ahhagdienavd/refs/heads/main/Loader.lua.txt"))()
            ]]
        },

        {
            Name = "OBUROSBOS",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
            ]]
        },

        {
            Name = "OMG HUB",
            HasKey = true,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()
            ]]
        },

        {
            Name = "OXIDE HUB",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/xulfo/Oxide-Loader/main/Main.lua"))()
            ]]
        },

        {
            Name = "PET SPAWNER",
            HasKey = true,
            Script = [[
                loadstring(game:HttpGet("https://scriptversekey.xyz/s/steal-an-egg-pet-spawner"))()
            ]]
        },

        {
            Name = "RENE BATERBONIA SCRIPT",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg"))()
            ]]
        },

        {
            Name = "RIFT HUB",
            HasKey = true,
            Script = [[
                loadstring(game:HttpGet("https://rifton.top/loader.lua"))()
            ]]
        },

        {
            Name = "SENA HUB KEYLESS",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/loader"))()
            ]]
        },

        {
            Name = "SERVER FINDER 1 PEOPLE",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://api.obscuravm.com/scripts/8232205074136213997"))()
            ]]
        },

        {
            Name = "STEAL AN EGG",
            HasKey = false,
            Script = [[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Dodoyung24/script-core/main/Steal-An-Egg"))()
            ]]
        },

        {
            Name = "ZEROIN HUB",
            HasKey = true,
            Script = [[
                loadstring(game:HttpGet("https://zeroinhub.com/api/script"))()
            ]]
        }

    }

    table.sort(Scripts, function(a, b)
        return a.Name:lower() < b.Name:lower()
    end)

    --====================================================--
    -- BOTÕES
    --====================================================--

    for i, item in ipairs(Scripts) do

        local Row = Instance.new("Frame")

        Row.Name = item.Name
        Row.LayoutOrder = i
        Row.Size = UDim2.new(1, -4, 0, 32)
        Row.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        Row.BackgroundTransparency = 0.2
        Row.BorderSizePixel = 0
        Row.Parent = Scroll

        local RowCorner = Instance.new("UICorner")
        RowCorner.CornerRadius = UDim.new(0, 5)
        RowCorner.Parent = Row

        local RowStroke = Instance.new("UIStroke")
        RowStroke.Color = Color3.fromRGB(35, 35, 35)
        RowStroke.Thickness = 1
        RowStroke.Parent = Row

        local Name = Instance.new("TextLabel")

        Name.Size = UDim2.new(0.42, 0, 1, 0)
        Name.Position = UDim2.new(0, 8, 0, 0)
        Name.BackgroundTransparency = 1
        Name.Text = item.Name
        Name.TextColor3 = Color3.fromRGB(220, 220, 220)
        Name.TextSize = 9
        Name.Font = Enum.Font.GothamSemibold
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.Parent = Row

        local Status = Instance.new("Frame")

        Status.Size = UDim2.new(0, 56, 0, 18)
        Status.Position = UDim2.new(1, -132, 0.5, -9)
        Status.BorderSizePixel = 0
        Status.Parent = Row

        local StatusCorner = Instance.new("UICorner")
        StatusCorner.CornerRadius = UDim.new(0, 4)
        StatusCorner.Parent = Status

        local StatusStroke = Instance.new("UIStroke")
        StatusStroke.Thickness = 1
        StatusStroke.Parent = Status

        local StatusText = Instance.new("TextLabel")

        StatusText.Size = UDim2.new(1, 0, 1, 0)
        StatusText.BackgroundTransparency = 1
        StatusText.TextSize = 8
        StatusText.Font = Enum.Font.GothamBold
        StatusText.Parent = Status

        if item.HasKey then

            Status.BackgroundColor3 =
                Color3.fromRGB(38, 32, 8)

            StatusStroke.Color =
                Color3.fromRGB(255, 200, 0)

            StatusText.Text = "KEY"

            StatusText.TextColor3 =
                Color3.fromRGB(255, 215, 0)

        else

            Status.BackgroundColor3 =
                Color3.fromRGB(8, 36, 14)

            StatusStroke.Color =
                Color3.fromRGB(30, 180, 70)

            StatusText.Text = "KEYLESS"

            StatusText.TextColor3 =
                Color3.fromRGB(50, 230, 100)

        end

        local Execute = Instance.new("TextButton")

        Execute.Size = UDim2.new(0, 64, 0, 22)
        Execute.Position = UDim2.new(1, -70, 0.5, -11)
        Execute.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
        Execute.BorderSizePixel = 0
        Execute.Text = "EXECUTE"
        Execute.TextColor3 = Color3.fromRGB(255, 210, 0)
        Execute.TextSize = 9
        Execute.Font = Enum.Font.GothamBold
        Execute.Parent = Row

        local ExecuteCorner = Instance.new("UICorner")
        ExecuteCorner.CornerRadius = UDim.new(0, 4)
        ExecuteCorner.Parent = Execute

        local ExecuteStroke = Instance.new("UIStroke")
        ExecuteStroke.Color = Color3.fromRGB(190, 150, 0)
        ExecuteStroke.Thickness = 1
        ExecuteStroke.Parent = Execute

        Execute.MouseButton1Click:Connect(function()

            local success, err = pcall(function()
                local fn = loadstring(item.Script)

                if not fn then
                    error("loadstring não disponível")
                end

                fn()
            end)

            if success then

                Execute.Text = "LOADED"
                Execute.TextColor3 =
                    Color3.fromRGB(50, 230, 100)

                Execute.BackgroundColor3 =
                    Color3.fromRGB(8, 36, 14)

                ExecuteStroke.Color =
                    Color3.fromRGB(30, 180, 70)

                HubNotify("Executed " .. item.Name)

            else

                Execute.Text = "ERROR"

                Execute.TextColor3 =
                    Color3.fromRGB(255, 100, 100)

                HubNotify(
                    "Erro em " .. item.Name
                )

                warn(
                    "[TXZZ76] Erro: ",
                    err
                )

            end

            task.delay(2, function()

                if not Execute.Parent then
                    return
                end

                Execute.Text = "EXECUTE"

                Execute.TextColor3 =
                    Color3.fromRGB(255, 210, 0)

                Execute.BackgroundColor3 =
                    Color3.fromRGB(45, 35, 5)

                ExecuteStroke.Color =
                    Color3.fromRGB(190, 150, 0)

            end)

        end)

    end

    --====================================================--
    -- ARRASTAR
    --====================================================--

    local Dragging = false
    local DragStart
    local StartPosition
    local DragInput

    TopBar.InputBegan:Connect(function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true
            DragStart = input.Position
            StartPosition = Frame.Position

            input.Changed:Connect(function()

                if input.UserInputState ==
                    Enum.UserInputState.End then

                    Dragging = false

                end

            end)

        end

    end)

    TopBar.InputChanged:Connect(function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            DragInput = input

        end

    end)

    UserInputService.InputChanged:Connect(function(input)

        if input == DragInput and Dragging then

            local Delta =
                input.Position - DragStart

            Frame.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )

        end

    end)

    --====================================================--
    -- MINIMIZAR
    --====================================================--

    local Minimized = false

    Minimize.MouseButton1Click:Connect(function()

        Minimized = not Minimized

        if Minimized then

            Minimize.Text = "+"
            Scroll.Visible = false

            TweenService:Create(
                Frame,
                TweenInfo.new(
                    0.25,
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 328, 0, 42)
                }
            ):Play()

            TweenService:Create(
                Main,
                TweenInfo.new(
                    0.25,
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 320, 0, 34)
                }
            ):Play()

        else

            Minimize.Text = "_"

            TweenService:Create(
                Frame,
                TweenInfo.new(
                    0.25,
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 328, 0, 248)
                }
            ):Play()

            TweenService:Create(
                Main,
                TweenInfo.new(
                    0.25,
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.Out
                ),
                {
                    Size = UDim2.new(0, 320, 0, 240)
                }
            ):Play()

            task.delay(0.2, function()

                if Scroll.Parent then
                    Scroll.Visible = true
                end

            end)

        end

    end)

    --====================================================--
    -- INSERT / RIGHT CONTROL
    --====================================================--

    UserInputService.InputBegan:Connect(function(input, processed)

        if processed then
            return
        end

        if input.KeyCode == Enum.KeyCode.Insert
            or input.KeyCode == Enum.KeyCode.RightControl then

            Frame.Visible = not Frame.Visible

        end

    end)

    --====================================================--
    -- TAG
    --====================================================--

    local function CreateTag(character)

        if not character then
            return
        end

        local Head = character:WaitForChild("Head", 5)

        if not Head then
            return
        end

        local Old = Head:FindFirstChild("SourcesHubTag")

        if Old then
            Old:Destroy()
        end

        local Billboard = Instance.new("BillboardGui")

        Billboard.Name = "SourcesHubTag"
        Billboard.Size = UDim2.new(0, 200, 0, 35)
        Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        Billboard.AlwaysOnTop = true
        Billboard.Parent = Head

        local Text = Instance.new("TextLabel")

        Text.Size = UDim2.new(1, 0, 1, 0)
        Text.BackgroundTransparency = 1
        Text.Text = DISCORD_LINK
        Text.TextSize = 12
        Text.Font = Enum.Font.GothamBold
        Text.Parent = Billboard

        local Hue = 0

        RunService.RenderStepped:Connect(function(dt)

            if not Text.Parent then
                return
            end

            Hue = (Hue + dt * 0.35) % 1

            Text.TextColor3 =
                Color3.fromHSV(
                    Hue,
                    0.85,
                    1
                )

        end)

    end

    if LocalPlayer.Character then
        CreateTag(LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(CreateTag)

    HubNotify("TXZZ76 HUB carregado!")

end

--========================================================--
-- VERIFICAR KEY
--========================================================--

local Verificando = false

Verify.MouseButton1Click:Connect(function()

    if Verificando then
        return
    end

    Verificando = true

    local TypedKey = KeyBox.Text

    TypedKey = TypedKey:gsub("^%s*(.-)%s*$", "%1")

    if TypedKey == KEY_CORRETA then

        Verify.Text = "KEY VERIFICADA"
        Verify.TextColor3 =
            Color3.fromRGB(80, 255, 130)

        Verify.BackgroundColor3 =
            Color3.fromRGB(8, 80, 30)

        VerifyStroke.Color =
            Color3.fromRGB(30, 200, 80)

        NotifyKey("Key correta! Abrindo TXZZ76 HUB...")

        task.wait(0.7)

        pcall(function()
            KeyGui:Destroy()
        end)

        task.wait(0.1)

        StartHub()

    else

        Verify.Text = "KEY INCORRETA"
        Verify.TextColor3 =
            Color3.fromRGB(255, 100, 100)

        Verify.BackgroundColor3 =
            Color3.fromRGB(80, 20, 25)

        NotifyKey("Key incorreta!")

        task.wait(0.8)

        KeyBox.Text = ""

        Verify.Text = "VERIFICAR KEY"
        Verify.TextColor3 =
            Color3.fromRGB(255, 210, 0)

        Verify.BackgroundColor3 =
            Color3.fromRGB(45, 35, 5)

        VerifyStroke.Color =
            Color3.fromRGB(190, 150, 0)

    end

    Verificando = false

end)

--========================================================--
-- TESTE INICIAL
--========================================================--

NotifyKey("TXZZ76 Key System carregado!")
