--// TXZZ76 HUB + KEY SYSTEM
--// KEY: TXZZ
--// DISCORD: discord.gg/cYKwrDjfKk

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local KEY_CORRETA = "TXZZ"
local DISCORD_LINK = "https://discord.gg/cYKwrDjfKk"

--==================================================
-- KEY SYSTEM
--==================================================

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "TXZZ_KeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.Parent = PlayerGui

--==================================================
-- KEY WINDOW
--==================================================

local KeyMain = Instance.new("Frame")
KeyMain.Name = "KeyMain"
KeyMain.Size = UDim2.new(0, 410, 0, 315)
KeyMain.Position = UDim2.new(0.5, -205, 0.5, -157)
KeyMain.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
KeyMain.BorderSizePixel = 0
KeyMain.ClipsDescendants = true
KeyMain.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 16)
KeyCorner.Parent = KeyMain

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(255, 200, 0)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyMain

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 12)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(30, 25, 8)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 12))
})
KeyGradient.Rotation = 35
KeyGradient.Parent = KeyMain

-- TOP BAR
local KeyTop = Instance.new("Frame")
KeyTop.Name = "KeyTop"
KeyTop.Size = UDim2.new(1, 0, 0, 48)
KeyTop.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
KeyTop.BackgroundTransparency = 0.05
KeyTop.BorderSizePixel = 0
KeyTop.Parent = KeyMain

local KeyTopCorner = Instance.new("UICorner")
KeyTopCorner.CornerRadius = UDim.new(0, 16)
KeyTopCorner.Parent = KeyTop

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -105, 1, 0)
KeyTitle.Position = UDim2.new(0, 16, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "TXZZ 76  •  KEY SYSTEM"
KeyTitle.TextColor3 = Color3.fromRGB(255, 210, 0)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyTop

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, -32, 0, 18)
KeyStatus.Position = UDim2.new(0, 16, 0, 52)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = "ACCESS  •  ENTER YOUR KEY"
KeyStatus.TextColor3 = Color3.fromRGB(130, 130, 135)
KeyStatus.TextSize = 9
KeyStatus.Font = Enum.Font.GothamBold
KeyStatus.TextXAlignment = Enum.TextXAlignment.Left
KeyStatus.Parent = KeyMain

-- MINIMIZE
local KeyMinimize = Instance.new("TextButton")
KeyMinimize.Name = "Minimize"
KeyMinimize.Size = UDim2.new(0, 28, 0, 28)
KeyMinimize.Position = UDim2.new(1, -66, 0, 10)
KeyMinimize.BackgroundColor3 = Color3.fromRGB(40, 35, 8)
KeyMinimize.BorderSizePixel = 0
KeyMinimize.Text = "—"
KeyMinimize.TextColor3 = Color3.fromRGB(255, 215, 0)
KeyMinimize.TextSize = 15
KeyMinimize.Font = Enum.Font.GothamBold
KeyMinimize.Parent = KeyTop

local KeyMinCorner = Instance.new("UICorner")
KeyMinCorner.CornerRadius = UDim.new(0, 8)
KeyMinCorner.Parent = KeyMinimize

-- CLOSE
local KeyClose = Instance.new("TextButton")
KeyClose.Name = "Close"
KeyClose.Size = UDim2.new(0, 28, 0, 28)
KeyClose.Position = UDim2.new(1, -34, 0, 10)
KeyClose.BackgroundColor3 = Color3.fromRGB(55, 15, 15)
KeyClose.BorderSizePixel = 0
KeyClose.Text = "×"
KeyClose.TextColor3 = Color3.fromRGB(255, 105, 105)
KeyClose.TextSize = 18
KeyClose.Font = Enum.Font.GothamBold
KeyClose.Parent = KeyTop

local KeyCloseCorner = Instance.new("UICorner")
KeyCloseCorner.CornerRadius = UDim.new(0, 8)
KeyCloseCorner.Parent = KeyClose

-- CONTENT
local KeyInfo = Instance.new("TextLabel")
KeyInfo.Size = UDim2.new(1, -48, 0, 34)
KeyInfo.Position = UDim2.new(0, 24, 0, 78)
KeyInfo.BackgroundTransparency = 1
KeyInfo.Text = "🔐  Digite sua Key para liberar o TXZZ HUB"
KeyInfo.TextColor3 = Color3.fromRGB(230, 230, 230)
KeyInfo.TextSize = 12
KeyInfo.Font = Enum.Font.GothamMedium
KeyInfo.TextXAlignment = Enum.TextXAlignment.Left
KeyInfo.Parent = KeyMain

local KeyBox = Instance.new("TextBox")
KeyBox.Name = "KeyBox"
KeyBox.Size = UDim2.new(1, -48, 0, 48)
KeyBox.Position = UDim2.new(0, 24, 0, 120)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "  Digite a Key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(105, 105, 110)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.GothamMedium
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyMain

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 10)
KeyBoxCorner.Parent = KeyBox

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Color = Color3.fromRGB(55, 55, 60)
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Parent = KeyBox

local Verify = Instance.new("TextButton")
Verify.Name = "Verify"
Verify.Size = UDim2.new(1, -48, 0, 44)
Verify.Position = UDim2.new(0, 24, 0, 178)
Verify.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
Verify.BorderSizePixel = 0
Verify.Text = "✓  VERIFICAR KEY"
Verify.TextColor3 = Color3.fromRGB(255, 215, 0)
Verify.TextSize = 12
Verify.Font = Enum.Font.GothamBold
Verify.Parent = KeyMain

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 10)
VerifyCorner.Parent = Verify

local VerifyStroke = Instance.new("UIStroke")
VerifyStroke.Color = Color3.fromRGB(190, 150, 0)
VerifyStroke.Thickness = 1
VerifyStroke.Parent = Verify

local DiscordButton = Instance.new("TextButton")
DiscordButton.Name = "Discord"
DiscordButton.Size = UDim2.new(1, -48, 0, 38)
DiscordButton.Position = UDim2.new(0, 24, 0, 232)
DiscordButton.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
DiscordButton.BorderSizePixel = 0
DiscordButton.Text = "DISCORD  •  discord.gg/cYKwrDjfKk"
DiscordButton.TextColor3 = Color3.fromRGB(210, 210, 215)
DiscordButton.TextSize = 10
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.Parent = KeyMain

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 9)
DiscordCorner.Parent = DiscordButton

local DiscordStroke = Instance.new("UIStroke")
DiscordStroke.Color = Color3.fromRGB(55, 55, 60)
DiscordStroke.Thickness = 1
DiscordStroke.Parent = DiscordButton

DiscordButton.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard(DISCORD_LINK)
        end
    end)

    DiscordButton.Text = "✓  LINK COPIADO"

    task.delay(1.5, function()
        if DiscordButton.Parent then
            DiscordButton.Text = "DISCORD  •  discord.gg/cYKwrDjfKk"
        end
    end)
end)

-- DRAG KEY WINDOW
local keyDragging = false
local keyDragStart
local keyStartPosition
local keyDragInput

KeyTop.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        keyDragging = true
        keyDragStart = input.Position
        keyStartPosition = KeyMain.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                keyDragging = false
            end
        end)
    end
end)

KeyTop.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        keyDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == keyDragInput and keyDragging then
        local delta = input.Position - keyDragStart

        KeyMain.Position = UDim2.new(
            keyStartPosition.X.Scale,
            keyStartPosition.X.Offset + delta.X,
            keyStartPosition.Y.Scale,
            keyStartPosition.Y.Offset + delta.Y
        )
    end
end)

-- MINIMIZE KEY WINDOW
local keyMinimized = false

KeyMinimize.MouseButton1Click:Connect(function()
    keyMinimized = not keyMinimized

    if keyMinimized then
        KeyMinimize.Text = "+"
        KeyStatus.Visible = false
        KeyInfo.Visible = false
        KeyBox.Visible = false
        Verify.Visible = false
        DiscordButton.Visible = false

        TweenService:Create(
            KeyMain,
            TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 410, 0, 48)}
        ):Play()
    else
        KeyMinimize.Text = "—"

        TweenService:Create(
            KeyMain,
            TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 410, 0, 315)}
        ):Play()

        task.delay(0.18, function()
            if not KeyMain.Parent then
                return
            end

            KeyStatus.Visible = true
            KeyInfo.Visible = true
            KeyBox.Visible = true
            Verify.Visible = true
            DiscordButton.Visible = true
        end)
    end
end)

KeyClose.MouseButton1Click:Connect(function()
    KeyGui:Destroy()
end)

--==================================================
-- HUB PRINCIPAL
--==================================================

local function StartHub()

    local CoreGui = game:GetService("CoreGui")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local Workspace = game:GetService("Workspace")

    pcall(function()
        local old = PlayerGui:FindFirstChild("TXZZ76HUBCore")
        if old then
            old:Destroy()
        end

        local oldCore = CoreGui:FindFirstChild("TXZZ76HUBCore")
        if oldCore then
            oldCore:Destroy()
        end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TXZZ76HUBCore"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = PlayerGui

    --==================================================
    -- NOTIFICAÇÃO
    --==================================================

    local function Notify(text)

        local Notification = Instance.new("Frame")
        Notification.Size = UDim2.new(0, 220, 0, 32)
        Notification.Position = UDim2.new(1, 10, 1, -45)
        Notification.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Notification.BackgroundTransparency = 0.1
        Notification.BorderSizePixel = 0
        Notification.Parent = ScreenGui

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = Notification

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(255, 200, 0)
        Stroke.Thickness = 1
        Stroke.Parent = Notification

        local Text = Instance.new("TextLabel")
        Text.Size = UDim2.new(1, -12, 1, 0)
        Text.Position = UDim2.new(0, 6, 0, 0)
        Text.BackgroundTransparency = 1
        Text.Text = text
        Text.TextColor3 = Color3.fromRGB(240, 240, 240)
        Text.TextSize = 9
        Text.Font = Enum.Font.GothamBold
        Text.TextXAlignment = Enum.TextXAlignment.Left
        Text.Parent = Notification

        TweenService:Create(
            Notification,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(1, -230, 1, -45)
            }
        ):Play()

        task.delay(2.5, function()

            if not Notification.Parent then
                return
            end

            local tween = TweenService:Create(
                Notification,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {
                    Position = UDim2.new(1, 10, 1, -45)
                }
            )

            tween:Play()

            tween.Completed:Connect(function()
                if Notification then
                    Notification:Destroy()
                end
            end)
        end)
    end

    --==================================================
    -- ANTI LAG
    --==================================================

    pcall(function()

        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9000000000
        Lighting.Brightness = 1

        for _, object in ipairs(Lighting:GetChildren()) do

            local IsEffect =
                object:IsA("PostEffect")
                or object:IsA("BlurEffect")
                or object:IsA("SunRaysEffect")
                or object:IsA("ColorCorrectionEffect")
                or object:IsA("BloomEffect")

            if IsEffect then
                pcall(function()
                    object.Enabled = false
                end)
            end
        end

        local function OptimizeObject(object)

            if object:IsA("BasePart") then
                pcall(function()
                    object.Material = Enum.Material.SmoothPlastic
                    object.Reflectance = 0
                end)
                return
            end

            if object:IsA("Decal") or object:IsA("Texture") then
                pcall(function()
                    object.Transparency = 1
                end)
                return
            end

            if object:IsA("ParticleEmitter")
                or object:IsA("Trail")
                or object:IsA("Smoke")
                or object:IsA("Fire")
                or object:IsA("Sparkles") then

                pcall(function()
                    object.Enabled = false
                end)
            end
        end

        for _, object in ipairs(Workspace:GetDescendants()) do
            OptimizeObject(object)
        end

        Workspace.DescendantAdded:Connect(function(object)
            task.defer(function()
                if object and object.Parent then
                    OptimizeObject(object)
                end
            end)
        end)
    end)

    Notify("✓ Anti-Lag Activated")

    --==================================================
    -- MAIN FRAME
    --==================================================

    local GlowFrame = Instance.new("Frame")
    GlowFrame.Name = "GlowFrame"
    GlowFrame.Size = UDim2.new(0, 350, 0, 300)
    GlowFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
    GlowFrame.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
    GlowFrame.BackgroundTransparency = 0.65
    GlowFrame.BorderSizePixel = 0
    GlowFrame.Parent = ScreenGui

    local GlowCorner = Instance.new("UICorner")
    GlowCorner.CornerRadius = UDim.new(0, 12)
    GlowCorner.Parent = GlowFrame

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 342, 0, 292)
    MainFrame.Position = UDim2.new(0, 4, 0, 4)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.BackgroundTransparency = 0.15
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = GlowFrame

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(255, 200, 0)
    MainStroke.Thickness = 1.5
    MainStroke.Parent = MainFrame

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 12)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(55, 45, 10)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12))
    })
    Gradient.Rotation = 45
    Gradient.Parent = MainFrame

    local rotation = 0

    RunService.RenderStepped:Connect(function(dt)

        if not GlowFrame.Parent then
            return
        end

        rotation = (rotation + dt * 1.5) % 6.283185307
        Gradient.Rotation = math.sin(rotation) * 15 + 45
        GlowFrame.BackgroundTransparency =
            math.sin(rotation * 2) * 0.1 + 0.6
    end)

    --==================================================
    -- TOP BAR
    --==================================================

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 34)
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    TopBar.BackgroundTransparency = 0.2
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -88, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "TXZZ76 HUB | discord.gg/cYKwrDjfKk"
    Title.TextColor3 = Color3.fromRGB(255, 210, 0)
    Title.TextSize = 11
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
    MinimizeButton.Position = UDim2.new(1, -28, 0.5, -12)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 220, 0)
    MinimizeButton.TextSize = 14
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TopBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeButton

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Position = UDim2.new(1, -54, 0.5, -12)
    CloseButton.BackgroundColor3 = Color3.fromRGB(55, 15, 15)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 105, 105)
    CloseButton.TextSize = 17
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    --==================================================
    -- BUSCA + CATEGORIAS
    --==================================================

    local SearchBox = Instance.new("TextBox")
    SearchBox.Name = "SearchBox"
    SearchBox.Size = UDim2.new(1, -12, 0, 28)
    SearchBox.Position = UDim2.new(0, 6, 0, 38)
    SearchBox.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
    SearchBox.BorderSizePixel = 0
    SearchBox.PlaceholderText = "🔎  Buscar script..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(105, 105, 110)
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(235, 235, 235)
    SearchBox.TextSize = 10
    SearchBox.Font = Enum.Font.GothamMedium
    SearchBox.ClearTextOnFocus = false
    SearchBox.Parent = MainFrame

    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 7)
    SearchCorner.Parent = SearchBox

    local SearchStroke = Instance.new("UIStroke")
    SearchStroke.Color = Color3.fromRGB(55, 55, 60)
    SearchStroke.Thickness = 1
    SearchStroke.Parent = SearchBox

    local CategoryBar = Instance.new("ScrollingFrame")
    CategoryBar.Name = "CategoryBar"
    CategoryBar.Size = UDim2.new(1, -12, 0, 28)
    CategoryBar.Position = UDim2.new(0, 6, 0, 70)
    CategoryBar.BackgroundTransparency = 1
    CategoryBar.BorderSizePixel = 0
    CategoryBar.ScrollBarThickness = 0
    CategoryBar.ScrollingDirection = Enum.ScrollingDirection.X
    CategoryBar.CanvasSize = UDim2.new(0, 0, 0, 0)
    CategoryBar.Parent = MainFrame

    local CategoryList = Instance.new("UIListLayout")
    CategoryList.FillDirection = Enum.FillDirection.Horizontal
    CategoryList.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryList.Padding = UDim.new(0, 5)
    CategoryList.Parent = CategoryBar

    CategoryList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        CategoryBar.CanvasSize =
            UDim2.new(0, CategoryList.AbsoluteContentSize.X + 5, 0, 0)
    end)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Name = "ScrollContainer"
    Scroll.Size = UDim2.new(1, -12, 1, -108)
    Scroll.Position = UDim2.new(0, 6, 0, 102)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 2
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 200, 0)
    Scroll.Parent = MainFrame

    local List = Instance.new("UIListLayout")
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding = UDim.new(0, 6)
    List.Parent = Scroll

    List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize =
            UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 8)
    end)

    --==================================================
    -- SCRIPTS
    --==================================================

    local Scripts = {

        {
            Name = "ANTI HIT",
            HasKey = false,
            Script = 'script_key = "Trial"; loadstring(game:HttpGet("https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua"))()'
        },

        {
            Name = "BIGFROOT",
            HasKey = true,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))()'
        },

        {
            Name = "BK HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/9ee4edde227ac85f50872bf9e4226508.lua"))()'
        },

        {
            Name = "CLOVER HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://rawscripts.net/raw/Steal-An-Egg-Clover-Hub-or-Auto-Steal-Egg-Predictor-Auto-Hatch-and-ESP-226600"))()'
        },

        {
            Name = "FOXNAME HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Bliqe/Upload/refs/heads/main/Games/RUO/12665928789.lua"))()'
        },

        {
            Name = "FYY HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://FyyCommunity.my.id"))()'
        },

        {
            Name = "Keyless Hub",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/97c3f6db55a2cf72141537a85458e5a7.lua"))()'
        },

        {
            Name = "LENNON HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/lennonxscripts/lennonhubv2/main/stealaneggv2"))()'
        },

        {
            Name = "LEST HUB",
            HasKey = false,
            Script = 'getgenv().SCRIPT_KEY = "KEYLESS"; loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/c916d48837ab69c48a9b3cafb04b49c8d9253af84cf8e403b19e2be302cbe67a/download"))()'
        },

        {
            Name = "MIRANDA HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaeggs"))()'
        },

        {
            Name = "MOSHI HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/moshixzn/ahhagdienavd/refs/heads/main/Loader.lua.txt"))()'
        },

        {
            Name = "OBUROSBOS",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()'
        },

        {
            Name = "OMG HUB",
            HasKey = true,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))()'
        },

        {
            Name = "OXIDE HUB",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/xulfo/Oxide-Loader/main/Main.lua"))()'
        },

        {
            Name = "PET SPAWNER",
            HasKey = true,
            Script = 'loadstring(game:HttpGet("https://scriptversekey.xyz/s/steal-an-egg-pet-spawner"))()'
        },

        {
            Name = "RENE BATERBONIA SCRIPT",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscrip-arch/srver/refs/heads/main/Stealanegg"))()'
        },

        {
            Name = "RIFT HUB",
            HasKey = true,
            Script = 'loadstring(game:HttpGet("https://rifton.top/loader.lua"))()'
        },

        {
            Name = "SENA HUB KEYLESS",
            HasKey = false,
            Script = "loadstring(game:HttpGet('https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/loader'))()"
        },

        {
            Name = "SERVER FINDER 1 PEOPLE",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://api.obscuravm.com/scripts/8232205074136213997"))()'
        },

        {
            Name = "STEAL AN EGG",
            HasKey = false,
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Dodoyung24/script-core/main/Steal-An-Egg"))()'
        },

        --==================================================
        -- BLOX FRUITS
        --==================================================

        {
            Name = "QUANTUM ONYX",
            HasKey = false,
            Game = "BLOX FRUITS",
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/main/QuantumOnyx.lua"))()'
        },

        --==================================================
        -- KING LEGACY
        --==================================================

        {
            Name = "ZEE HUB",
            HasKey = false,
            Game = "KING LEGACY",
            Script = 'loadstring(game:HttpGet("https://zuwz.me/Ls-Zee-Hub-KL"))()'
        },

        {
            Name = "GENESIS HUB",
            HasKey = false,
            Game = "KING LEGACY",
            Script = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/mainloadergg/GenesisHub/refs/heads/main/KingLegacy.lua"))()'
        },

        --==================================================
        -- MM2
        --==================================================

        {
            Name = "MM2 SCRIPT 1",
            HasKey = false,
            Game = "MM2",
            Script = 'loadstring(game:HttpGet("https://api.rubis.app/v2/scrap/8vpaZV79UL5P8XAO/raw"))()'
        },

        {
            Name = "MM2 SCRIPT 2",
            HasKey = false,
            Game = "MM2",
            Script = 'loadstring(game:HttpGet("https://api.rubis.app/v2/scrap/5NZn92uwEzEFfpj8/raw"))()'
        },

        {
            Name = "ZEROIN HUB",
            HasKey = true,
            Script = 'loadstring(game:HttpGet("https://zeroinhub.com/api/script"))()'
        }
    }

    table.sort(Scripts, function(a, b)
        return a.Name:lower() < b.Name:lower()
    end)

    --==================================================
    -- CATEGORIAS
    --==================================================

    local CurrentCategory = "TODOS"

    local function GetCategory(data)

        if data.Game then
            return data.Game
        end

        local n = string.lower(data.Name or "")
        local u = string.lower(data.Script or "")

        if string.find(n, "blox")
            or string.find(n, "bigfroot")
            or string.find(n, "fruit") then
            return "BLOX FRUITS"
        end

        if string.find(n, "egg")
            or string.find(u, "steal%-an%-egg")
            or string.find(u, "stealanegg")
            or string.find(u, "stealaegg") then
            return "STEAL A EGG"
        end

        return "OUTROS"
    end

    local CategoryButtons = {}

    local Categories = {
        "TODOS",
        "BLOX FRUITS",
        "STEAL A EGG",
        "KING LEGACY",
        "MM2",
        "OUTROS"
    }

    local function UpdateCategoryVisuals()

        for category, button in pairs(CategoryButtons) do

            if category == CurrentCategory then
                button.BackgroundColor3 = Color3.fromRGB(48, 38, 7)
                button.TextColor3 = Color3.fromRGB(255, 215, 0)
            else
                button.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
                button.TextColor3 = Color3.fromRGB(175, 175, 180)
            end
        end
    end

    for index, category in ipairs(Categories) do

        local Button = Instance.new("TextButton")
        Button.Name = "Category_" .. category
        Button.LayoutOrder = index

        local buttonWidth = 78

        if category == "STEAL A EGG" then
            buttonWidth = 92
        elseif category == "BLOX FRUITS" then
            buttonWidth = 88
        elseif category == "KING LEGACY" then
            buttonWidth = 88
        elseif category == "MM2" then
            buttonWidth = 58
        end

        Button.Size = UDim2.new(0, buttonWidth, 0, 25)
        Button.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
        Button.BorderSizePixel = 0
        Button.Text = category
        Button.TextSize = 8
        Button.Font = Enum.Font.GothamBold
        Button.TextColor3 = Color3.fromRGB(175, 175, 180)
        Button.Parent = CategoryBar

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 7)
        Corner.Parent = Button

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Color3.fromRGB(50, 50, 55)
        Stroke.Thickness = 1
        Stroke.Parent = Button

        CategoryButtons[category] = Button

        Button.MouseButton1Click:Connect(function()

            CurrentCategory = category
            UpdateCategoryVisuals()

            local query = string.lower(SearchBox.Text or "")

            for _, child in ipairs(Scroll:GetChildren()) do

                if child:IsA("Frame")
                    and child:GetAttribute("TXZZScriptItem") then

                    local itemCategory =
                        child:GetAttribute("Category") or "OUTROS"

                    local itemName =
                        string.lower(child:GetAttribute("ScriptName") or "")

                    local categoryOK =
                        CurrentCategory == "TODOS"
                        or itemCategory == CurrentCategory

                    local searchOK =
                        query == ""
                        or string.find(itemName, query, 1, true) ~= nil

                    child.Visible = categoryOK and searchOK
                end
            end

            Scroll.CanvasPosition = Vector2.new(0, 0)
        end)
    end

    UpdateCategoryVisuals()

    --==================================================
    -- CRIAR BOTÕES
    --==================================================

    local ScriptItems = {}

    for i, data in ipairs(Scripts) do

        local Item = Instance.new("Frame")
        Item.Name = data.Name
        Item.LayoutOrder = i
        Item.Size = UDim2.new(1, -4, 0, 36)
        Item.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        Item.BackgroundTransparency = 0.2
        Item.BorderSizePixel = 0
        Item.Parent = Scroll

        Item:SetAttribute("TXZZScriptItem", true)
        Item:SetAttribute("Category", GetCategory(data))
        Item:SetAttribute("ScriptName", data.Name)

        table.insert(ScriptItems, Item)

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 5)
        ItemCorner.Parent = Item

        local ItemStroke = Instance.new("UIStroke")
        ItemStroke.Color = Color3.fromRGB(35, 35, 35)
        ItemStroke.Thickness = 1
        ItemStroke.Parent = Item

        local Name = Instance.new("TextLabel")
        Name.Size = UDim2.new(0.42, 0, 1, 0)
        Name.Position = UDim2.new(0, 8, 0, 0)
        Name.BackgroundTransparency = 1
        Name.Text = data.Name
        Name.TextColor3 = Color3.fromRGB(220, 220, 220)
        Name.TextSize = 9
        Name.Font = Enum.Font.GothamSemibold
        Name.TextXAlignment = Enum.TextXAlignment.Left
        Name.Parent = Item

        local Badge = Instance.new("Frame")
        Badge.Size = UDim2.new(0, 60, 0, 19)
        Badge.Position = UDim2.new(1, -132, 0.5, -9.5)
        Badge.BorderSizePixel = 0
        Badge.Parent = Item

        local BadgeCorner = Instance.new("UICorner")
        BadgeCorner.CornerRadius = UDim.new(0, 4)
        BadgeCorner.Parent = Badge

        local BadgeStroke = Instance.new("UIStroke")
        BadgeStroke.Thickness = 1
        BadgeStroke.Parent = Badge

        local BadgeText = Instance.new("TextLabel")
        BadgeText.Size = UDim2.new(1, 0, 1, 0)
        BadgeText.BackgroundTransparency = 1
        BadgeText.TextSize = 8
        BadgeText.Font = Enum.Font.GothamBold
        BadgeText.Parent = Badge

        if data.HasKey then

            Badge.BackgroundColor3 = Color3.fromRGB(38, 32, 8)
            BadgeStroke.Color = Color3.fromRGB(255, 200, 0)
            BadgeText.Text = "KEY"
            BadgeText.TextColor3 = Color3.fromRGB(255, 215, 0)

        else

            Badge.BackgroundColor3 = Color3.fromRGB(8, 36, 14)
            BadgeStroke.Color = Color3.fromRGB(30, 180, 70)
            BadgeText.Text = "KEYLESS"
            BadgeText.TextColor3 = Color3.fromRGB(50, 230, 100)

        end

        local Execute = Instance.new("TextButton")
        Execute.Size = UDim2.new(0, 66, 0, 24)
        Execute.Position = UDim2.new(1, -72, 0.5, -12)
        Execute.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
        Execute.Text = "EXECUTE"
        Execute.TextColor3 = Color3.fromRGB(255, 210, 0)
        Execute.TextSize = 9
        Execute.Font = Enum.Font.GothamBold
        Execute.BorderSizePixel = 0
        Execute.Parent = Item

        local ExecuteCorner = Instance.new("UICorner")
        ExecuteCorner.CornerRadius = UDim.new(0, 4)
        ExecuteCorner.Parent = Execute

        local ExecuteStroke = Instance.new("UIStroke")
        ExecuteStroke.Color = Color3.fromRGB(190, 150, 0)
        ExecuteStroke.Thickness = 1
        ExecuteStroke.Parent = Execute

        Execute.MouseButton1Click:Connect(function()

            local success = pcall(function()
                loadstring(data.Script)()
            end)

            if success then

                Execute.Text = "LOADED"
                Execute.TextColor3 = Color3.fromRGB(50, 230, 100)
                Execute.BackgroundColor3 = Color3.fromRGB(8, 36, 14)
                ExecuteStroke.Color = Color3.fromRGB(30, 180, 70)

                Notify("✓ Executed " .. data.Name)

            else

                Execute.Text = "ERROR"
                Execute.TextColor3 = Color3.fromRGB(255, 80, 80)

                Notify("✕ Erro ao executar " .. data.Name)

            end

            task.delay(2, function()

                if Execute.Parent then

                    Execute.Text = "EXECUTE"
                    Execute.TextColor3 = Color3.fromRGB(255, 210, 0)
                    Execute.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
                    ExecuteStroke.Color = Color3.fromRGB(190, 150, 0)

                end
            end)
        end)
    end

    --==================================================
    -- FILTRO DE BUSCA
    --==================================================

    local function ApplyFilters()

        local query = string.lower(SearchBox.Text or "")

        for _, item in ipairs(ScriptItems) do

            local itemCategory =
                item:GetAttribute("Category") or "OUTROS"

            local itemName =
                string.lower(item:GetAttribute("ScriptName") or "")

            local categoryOK =
                CurrentCategory == "TODOS"
                or itemCategory == CurrentCategory

            local searchOK =
                query == ""
                or string.find(itemName, query, 1, true) ~= nil

            item.Visible = categoryOK and searchOK
        end

        Scroll.CanvasPosition = Vector2.new(0, 0)
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(ApplyFilters)

    --==================================================
    -- ARRASTAR PAINEL
    --==================================================

    local dragging = false
    local dragStart
    local startPosition
    local dragInput

    TopBar.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = GlowFrame.Position

            input.Changed:Connect(function()

                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)

        if input == dragInput and dragging then

            local delta = input.Position - dragStart

            GlowFrame.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    --==================================================
    -- MINIMIZAR
    --==================================================

    local minimized = false

    MinimizeButton.MouseButton1Click:Connect(function()

        if minimized then

            Scroll.Visible = true
            MinimizeButton.Text = "_"

            TweenService:Create(
                GlowFrame,
                TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 350, 0, 300)
                }
            ):Play()

            TweenService:Create(
                MainFrame,
                TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 342, 0, 292)
                }
            ):Play()

            minimized = false

        else

            MinimizeButton.Text = "+"

            local tween = TweenService:Create(
                GlowFrame,
                TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 328, 0, 42)
                }
            )

            TweenService:Create(
                MainFrame,
                TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 320, 0, 34)
                }
            ):Play()

            tween:Play()

            Scroll.Visible = false
            minimized = true
        end
    end)

    --==================================================
    -- ABRIR/FECHAR COM INSERT OU RIGHT CTRL
    --==================================================

    UserInputService.InputBegan:Connect(function(input, processed)

        if processed then
            return
        end

        if input.KeyCode == Enum.KeyCode.RightControl
            or input.KeyCode == Enum.KeyCode.Insert then

            GlowFrame.Visible = not GlowFrame.Visible
        end
    end)

    --==================================================
    -- TAG DO DISCORD
    --==================================================

    local function AddDiscordTag(character)

        if not character then
            return
        end

        local Head = character:WaitForChild("Head", 5)

        if not Head then
            return
        end

        local oldTag = Head:FindFirstChild("TXZZDiscordTag")

        if oldTag then
            oldTag:Destroy()
        end

        local Billboard = Instance.new("BillboardGui")
        Billboard.Name = "TXZZDiscordTag"
        Billboard.Size = UDim2.new(0, 200, 0, 35)
        Billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        Billboard.AlwaysOnTop = true
        Billboard.Parent = Head

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 1, 0)
        Label.BackgroundTransparency = 1
        Label.Text = DISCORD_LINK
        Label.TextSize = 12
        Label.Font = Enum.Font.GothamBold
        Label.Parent = Billboard

        local hue = 0

        RunService.RenderStepped:Connect(function(dt)

            if not Label.Parent then
                return
            end

            hue = (hue + dt * 0.35) % 1
            Label.TextColor3 = Color3.fromHSV(hue, 0.85, 1)
        end)
    end

    if LocalPlayer.Character then
        task.spawn(AddDiscordTag, LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(function(character)
        task.spawn(AddDiscordTag, character)
    end)

    Notify("✓ TXZZ76 HUB carregado!")
end

--==================================================
-- VERIFICAR KEY
--==================================================

Verify.MouseButton1Click:Connect(function()

    local typedKey = KeyBox.Text:gsub("^%s*(.-)%s*$", "%1")

    if typedKey == KEY_CORRETA then

        Verify.Text = "✓ KEY VERIFICADA"
        Verify.TextColor3 = Color3.fromRGB(50, 230, 100)
        Verify.BackgroundColor3 = Color3.fromRGB(8, 36, 14)

        task.wait(0.5)

        KeyGui:Destroy()
        StartHub()

    else

        Verify.Text = "✕ KEY INCORRETA"
        Verify.TextColor3 = Color3.fromRGB(255, 80, 80)
        Verify.BackgroundColor3 = Color3.fromRGB(55, 10, 10)

        KeyBox.Text = ""

        task.wait(1)

        Verify.Text = "VERIFICAR KEY"
        Verify.TextColor3 = Color3.fromRGB(255, 210, 0)
        Verify.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
    end
end)
