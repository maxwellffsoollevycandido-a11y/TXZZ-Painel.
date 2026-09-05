-- ==================================================
-- 🔥 TXZZ 76 • BANANA HUB EDITION 🔥
-- SÓ BLOX FRUITS • SEM OUTROS JOGOS
-- Discord: https://discord.gg/cYKwrDjfKk
-- Atualizado: 05/09/2026 | Key + FPS + Aimbot + Banana Hub
-- ==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==================================================
-- CONFIGURAÇÕES
-- ==================================================

local DISCORD_LINK = "https://discord.gg/cYKwrDjfKk" -- ✅ NOVO LINK
local LOGO_ID = "rbxassetid://134571219107537"
local KEY_CORRETA = "TXZZ-TESTE-123"

-- ==================================================
-- AIMBOT / FOV / HITBOX
-- ==================================================

local aimbotEnabled = false
local fovVisible = true
local fovSize = 120
local hitboxSize = 6
local currentAimTarget = nil
local playerHitboxes = {}
local fovCircle, mainPanel, launcher

-- ==================================================
-- LIMPAR VERSÃO ANTERIOR
-- ==================================================

for _, name in ipairs({"TXZZ76_V8", "TXZZ76_V7"}) do
    local old = playerGui:FindFirstChild(name)
    if old then old:Destroy() end
end

-- ==================================================
-- SCREEN GUI
-- ==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "TXZZ76_V8"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

-- ==================================================
-- CORES
-- ==================================================

local BG = Color3.fromRGB(13, 15, 22)
local PANEL = Color3.fromRGB(19, 22, 31)
local CARD = Color3.fromRGB(23, 27, 38)
local BLUE = Color3.fromRGB(0, 160, 245)
local BLUE2 = Color3.fromRGB(45, 110, 235)
local TEXT = Color3.fromRGB(245, 245, 250)
local SUB = Color3.fromRGB(145, 150, 165)
local RED = Color3.fromRGB(160, 45, 55)
local GREEN = Color3.fromRGB(40, 150, 85)

-- ==================================================
-- KEY SYSTEM
-- ==================================================

local keyVerified = false
local keyVerifiedAt = ""

-- ==================================================
-- FUNÇÕES AUXILIARES
-- ==================================================

local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function addStroke(obj, color)
    local s = Instance.new("UIStroke")
    s.Color = color or BLUE2
    s.Thickness = 1
    s.Transparency = 0.5
    s.Parent = obj
    return s
end

local function label(parent, text, size, position, fontSize, color)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = size
    l.Position = position
    l.Text = text
    l.TextColor3 = color or TEXT
    l.TextSize = fontSize or 12
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Parent = parent
    return l
end

local function button(parent, text, size, position, color)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = position
    b.BackgroundColor3 = color or CARD
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = TEXT
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = true
    b.Parent = parent
    addCorner(b, 8)
    return b
end

-- ==================================================
-- NOTIFICAÇÕES
-- ==================================================

local notifications = Instance.new("Frame")
notifications.Name = "Notifications"
notifications.BackgroundTransparency = 1
notifications.Size = UDim2.new(0, 290, 0, 300)
notifications.Position = UDim2.new(1, -305, 0, 20)
notifications.Parent = gui

local notificationLayout = Instance.new("UIListLayout")
notificationLayout.Padding = UDim.new(0, 7)
notificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
notificationLayout.Parent = notifications

local function notify(message)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(1, 0, 0, 42)
    n.BackgroundColor3 = PANEL
    n.BorderSizePixel = 0
    n.Text = message
    n.TextColor3 = TEXT
    n.TextSize = 12
    n.Font = Enum.Font.GothamMedium
    n.TextWrapped = true
    n.Parent = notifications
    addCorner(n, 8)
    addStroke(n)
    task.delay(3, function() if n and n.Parent then n:Destroy() end end)
end

-- ==================================================
-- ARRASTAR JANELA
-- ==================================================

local function makeDraggable(window, bar)
    bar.Active = true
    local dragging, dragStart, startPosition
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = window.Position
            input.Changed:Connect(function(i) if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging or (input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch) then return end
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
    end)
end

-- ==================================================
-- CRIAR JANELA
-- ==================================================

local function createWindow(width, height, titleText)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, width, 0, height)
    window.Position = UDim2.new(0.5, 0, 0.5, 0.5)
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    window.BackgroundColor3 = BG
    window.BorderSizePixel = 0
    window.Active = true
    window.Parent = gui
    addCorner(window, 12)
    addStroke(window)

    local top = Instance.new("Frame")
    top.Size = UDim2.new(1, 0, 0, 42)
    top.BackgroundColor3 = PANEL
    top.BorderSizePixel = 0
    top.Active = true
    top.Parent = window
    addCorner(top, 12)

    local title = label(top, titleText, UDim2.new(1, -115, 1, 0), UDim2.new(0, 14, 0, 0), 13, TEXT)
    title.Font = Enum.Font.GothamBold

    local minimize = button(top, "—", UDim2.new(0, 32, 0, 30), UDim2.new(1, -70, 0, 6), Color3.fromRGB(42, 46, 58))
    local close = button(top, "×", UDim2.new(0, 32, 0, 30), UDim2.new(1, -34, 0, 6), RED)

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, -42)
    content.Position = UDim2.new(0, 0, 0, 42)
    content.BackgroundTransparency = 1
    content.Parent = window

    local normalSize = window.Size
    local minimized = false

    minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            content.Visible = false
            TweenService:Create(window, TweenInfo.new(0.18), {Size = UDim2.new(0, width, 0, 42)}):Play()
        else
            TweenService:Create(window, TweenInfo.new(0.18), {Size = normalSize}):Play()
            task.delay(0.12, function() if window.Parent then content.Visible = true end end)
        end
    end)

    close.MouseButton1Click:Connect(function()
        if window == mainPanel then
            window.Visible = false
            if launcher then launcher.Visible = true end
        else
            window:Destroy()
        end
    end)

    makeDraggable(window, top)
    return window, content
end

-- ==================================================
-- FPS BOOSTER
-- ==================================================

local fpsBoostEnabled = false
local savedEffects = {}

local function setPerformance(enabled)
    if enabled then
        if fpsBoostEnabled then return end
        fpsBoostEnabled = true
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                savedEffects[obj] = {Enabled = obj.Enabled}
                pcall(function() obj.Enabled = false end)
            end
        end
        for _, obj in ipairs(Lighting:GetChildren()) do
            if obj:IsA("PostEffect") then
                savedEffects[obj] = savedEffects[obj] or {Enabled = obj.Enabled}
                pcall(function() obj.Enabled = false end)
            end
        end
        pcall(function() Lighting.GlobalShadows = false end)
        notify("⚡ FPS Booster ativado!")
    else
        fpsBoostEnabled = false
        for obj, data in pairs(savedEffects) do
            if obj and obj.Parent then pcall(function() obj.Enabled = data.Enabled end) end
        end
        savedEffects = {}
        pcall(function() Lighting.GlobalShadows = true end)
        notify("♻️ Gráficos restaurados.")
    end
end

-- ==================================================
-- TELA DE KEY
-- ==================================================

local keyWindow, keyContent = createWindow(370, 330, "TXZZ 76 • KEY SYSTEM")

local logo = Instance.new("ImageLabel")
logo.BackgroundTransparency = 1
logo.Size = UDim2.new(0, 58, 0, 58)
logo.Position = UDim2.new(1, -72, 0, 48)
logo.Image = LOGO_ID
logo.ScaleType = Enum.ScaleType.Fit
logo.Parent = keyContent

label(keyContent, "🔐 Digite sua Key", UDim2.new(1, -85, 0, 30), UDim2.new(0, 15, 0, 15), 18, TEXT).Font = Enum.Font.GothamBold
label(keyContent, "Pegue sua Key no Discord e cole abaixo.", UDim2.new(1, -30, 0, 25), UDim2.new(0, 15, 0, 48), 11, SUB)

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -30, 0, 42)
keyBox.Position = UDim2.new(0, 15, 0, 78)
keyBox.BackgroundColor3 = CARD
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Digite sua Key..."
keyBox.PlaceholderColor3 = SUB
keyBox.Text = ""
keyBox.TextColor3 = TEXT
keyBox.TextSize = 12
keyBox.Font = Enum.Font.Gotham
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyContent
addCorner(keyBox, 8)
addStroke(keyBox)

local verify = button(keyContent, "✓ VERIFICAR KEY", UDim2.new(1, -30, 0, 40), UDim2.new(0, 15, 0, 130), BLUE2)
local discord = button(keyContent, "💬 PEGAR KEY NO DISCORD", UDim2.new(1, -30, 0, 38), UDim2.new(0, 15, 0, 178), Color3.fromRGB(65, 75, 150))

local discordLink = Instance.new("TextBox")
discordLink.Size = UDim2.new(1, -30, 0, 30)
discordLink.Position = UDim2.new(0, 15, 0, 225)
discordLink.BackgroundTransparency = 1
discordLink.Text = DISCORD_LINK
discordLink.TextColor3 = Color3.fromRGB(100, 160, 255)
discordLink.TextSize = 10
discordLink.Font = Enum.Font.Gotham
discordLink.TextXAlignment = Enum.TextXAlignment.Center
discordLink.TextEditable = false
discordLink.ClearTextOnFocus = false
discordLink.Parent = keyContent

-- ==================================================
-- SELEÇÃO DE JOGO — SÓ BLOX FRUITS
-- ==================================================

local function openBloxFruitsPanel()
    keyWindow:Destroy()
    
    local main, mainContent = createWindow(720, 470, "TXZZ 76 • BLOX FRUITS + BANANA HUB")
    mainPanel = main
    
    -- SIDEBAR
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 170, 1, 0)
    sidebar.BackgroundColor3 = PANEL
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainContent
    addCorner(sidebar, 10)
    
    label(sidebar, "TXZZ 76", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 12), 19, TEXT).Font = Enum.Font.GothamBlack
    label(sidebar, "Blox Fruits + Banana Hub", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, 42), 10, Color3.fromRGB(85, 150, 255)).Font = Enum.Font.GothamBold
    
    -- PÁGINAS
    local pageArea = Instance.new("Frame")
    pageArea.Size = UDim2.new(1, -180, 1, -10)
    pageArea.Position = UDim2.new(0, 180, 0, 5)
    pageArea.BackgroundTransparency = 1
    pageArea.Parent = mainContent
    
    local pages = {}
    local function createPage(name)
        local page = Instance.new("Frame")
        page.Name = name
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Parent = pageArea
        pages[name] = page
        return page
    end
    
    local home = createPage("Inicio")
    local fps = createPage("FPS")
    local banana = createPage("BananaHub")
    local settings = createPage("Configuracoes")
    local dcPage = createPage("Discord")
    
    home.Visible = true
    
    local function pageTitle(page, titleText, subtitle)
        local t = label(page, titleText, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 10), 19, TEXT)
        t.Font = Enum.Font.GothamBold
        label(page, subtitle, UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, 42), 10, SUB)
    end
    
    pageTitle(home, "Painel Principal", "Bem-vindo ao TXZZ 76 + Banana Hub")
    pageTitle(fps, "⚡ FPS Booster", "Desempenho máximo para PC e Celular")
    pageTitle(banana, "🍌 Banana Hub", "Todas as funções do Banana Hub")
    pageTitle(settings, "⚙ Configurações", "Ajustes do painel")
    pageTitle(dcPage, "💬 Discord", "Servidor oficial TXZZ 76")
    
    -- PERFIL
    local profile = Instance.new("Frame")
    profile.Size = UDim2.new(1, -20, 0, 125)
    profile.Position = UDim2.new(0, 10, 0, 75)
    profile.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
    profile.BorderSizePixel = 0
    profile.Parent = home
    addCorner(profile, 10)
    addStroke(profile)
    
    local blueTop = Instance.new("Frame")
    blueTop.Size = UDim2.new(1, 0, 0, 28)
    blueTop.BackgroundColor3 = BLUE
    blueTop.BorderSizePixel = 0
    blueTop.Parent = profile
    addCorner(blueTop, 10)
    
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 62, 0, 62)
    avatar.Position = UDim2.new(0, 12, 0, 22)
    avatar.BackgroundColor3 = Color3.fromRGB(28, 32, 43)
    avatar.BorderSizePixel = 0
    avatar.Parent = profile
    addCorner(avatar, 31)
    
    task.spawn(function()
        local success, image = pcall(function()
            return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        if success and image then avatar.Image = image end
    end)
    
    label(profile, player.DisplayName, UDim2.new(1, -100, 0, 23), UDim2.new(0, 88, 0, 34), 15, TEXT).Font = Enum.Font.GothamBold
    label(profile, "@" .. player.Name, UDim2.new(1, -100, 0, 18), UDim2.new(0, 88, 0, 57), 10, SUB)
    
    local keyStatus = Instance.new("Frame")
    keyStatus.Size = UDim2.new(1, -24, 0, 27)
    keyStatus.Position = UDim2.new(0, 12, 0, 90)
    keyStatus.BackgroundColor3 = Color3.fromRGB(13, 16, 24)
    keyStatus.BorderSizePixel = 0
    keyStatus.Parent = profile
    addCorner(keyStatus, 6)
    
    local keyText = label(keyStatus, "", UDim2.new(1, -15, 1, 0), UDim2.new(0, 8, 0, 0), 10, TEXT)
    keyText.Font = Enum.Font.GothamBold
    if keyVerified then
        keyText.Text = "🔑 Lifetime Key  •  Verificada em " .. keyVerifiedAt
        keyText.TextColor3 = Color3.fromRGB(80, 220, 130)
    else
        keyText.Text = "🔑 Lifetime Key  •  Aguardando verificação"
    end
    
    -- CARDS HOME
    local function infoCard(parent, text, sub, y)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -20, 0, 55)
        card.Position = UDim2.new(0, 10, 0, y)
        card.BackgroundColor3 = CARD
        card.BorderSizePixel = 0
        card.Parent = parent
        addCorner(card, 8)
        addStroke(card)
        label(card, text, UDim2.new(1, -20, 0, 23), UDim2.new(0, 10, 0, 5), 12, TEXT).Font = Enum.Font.GothamBold
        label(card, sub, UDim2.new(1, -20, 0, 20), UDim2.new(0, 10, 0, 29), 9, SUB)
    end
    
    infoCard(home, "🍎 Jogo", "Blox Fruits", 210)
    infoCard(home, "🍌 Banana Hub", "Todas as funções carregadas", 273)
    
    -- PÁGINA FPS
    local fpsStatus = label(fps, "Status: DESATIVADO", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 82), 13, SUB)
    fpsStatus.Font = Enum.Font.GothamBold
    
    local fpsButton = button(fps, "⚡ ATIVAR FPS BOOSTER", UDim2.new(1, -20, 0, 45), UDim2.new(0, 10, 0, 120), BLUE2)
    fpsButton.MouseButton1Click:Connect(function()
        setPerformance(not fpsBoostEnabled)
        if fpsBoostEnabled then
            fpsButton.Text = "♻️ RESTAURAR GRÁFICOS"
            fpsButton.BackgroundColor3 = GREEN
            fpsStatus.Text = "Status: ATIVADO"
        else
            fpsButton.Text = "⚡ ATIVAR FPS BOOSTER"
            fpsButton.BackgroundColor3 = BLUE2
            fpsStatus.Text = "Status: DESATIVADO"
        end
    end)
    
    local fpsInfo = Instance.new("Frame")
    fpsInfo.Size = UDim2.new(1, -20, 0, 125)
    fpsInfo.Position = UDim2.new(0, 10, 0, 180)
    fpsInfo.BackgroundColor3 = CARD
    fpsInfo.BorderSizePixel = 0
    fpsInfo.Parent = fps
    addCorner(fpsInfo, 8)
    label(fpsInfo, "🚀 O que o Booster faz", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 0, 8), 12, TEXT).Font = Enum.Font.GothamBold
    label(fpsInfo, "• Desativa partículas\n• Desativa efeitos pesados\n• Desativa pós-processamento\n• Desativa sombras globais\n• Ajuda dispositivos fracos", UDim2.new(1, -20, 1, -38), UDim2.new(0, 10, 0, 34), 10, SUB)
    
    local fpsCounter = label(fps, "FPS: calculando...", UDim2.new(1, -20, 0, 25), UDim2.new(0, 10, 1, -35), 11, Color3.fromRGB(100, 160, 255))
    fpsCounter.TextXAlignment = Enum.TextXAlignment.Right
    
    local frames = 0
    local lastTime = os.clock()
    RunService.RenderStepped:Connect(function()
        if not fps.Parent then return end
        frames += 1
        local now = os.clock()
        if now - lastTime >= 1 then
            fpsCounter.Text = "FPS: " .. frames
            frames = 0
            lastTime = now
        end
    end)
    
    -- ==================================================
    -- 🍌 PÁGINA BANANA HUB — TODAS AS FUNÇÕES
    -- ==================================================
    
    local bananaTitle = label(banana, "🍌 Banana Hub — Funções Completas", UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 10), 16, TEXT)
    bananaTitle.Font = Enum.Font.GothamBold
    
    -- FUNÇÃO PARA BOTÃO TOGGLE
    local function bananaButton(parent, text, y)
        local btn = button(parent, text .. "  [OFF]", UDim2.new(1, -20, 0, 38), UDim2.new(0, 10, 0, y), CARD)
        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            if active then
                btn.Text = text .. "  [ON]"
                btn.BackgroundColor3 = GREEN
                notify("🍌 " .. text .. " — ATIVADO")
            else
                btn.Text = text .. "  [OFF]"
                btn.BackgroundColor3 = CARD
                notify("🍌 " .. text .. " — DESATIVADO")
            end
        end)
        return btn
    end
    
    -- 📋 TODAS AS FUNÇÕES DO BANANA HUB
    bananaButton(banana, "🌾 Auto Farm Level", 55)
    bananaButton(banana, "📜 Auto Quest", 98)
    bananaButton(banana, "👹 Auto Boss", 141)
    bananaButton(banana, "🏴 Auto Raid", 184)
    bananaButton(banana, "💰 Auto Bounty", 227)
    bananaButton(banana, "📈 Mastery Farm", 270)
    bananaButton(banana, "🌊 Auto Sea Event", 313)
    bananaButton(banana, "🐉 Auto Leviathan", 356)
    
    bananaButton(banana, "🍎 Fruit Sniper", 405)
    bananaButton(banana, "🔔 Notificação de Fruta", 448)
    bananaButton(banana, "📦 Auto Pegar Fruta", 491)
    bananaButton(banana, "📍 Teleport para Fruta", 534)
    bananaButton(banana, "🧲 Magnet Fruta", 577)
    
    bananaButton(banana, "🎯 Aimbot", 626)
    bananaButton(banana, "📦 H
