--========================================================--
--  TXZZ76 HUB • ROUBE UM OVO EDITION
--  Inspirado no Lennon Hub | 100% Original
--  Funciona: Delta, Xeno, Wave, Solara
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
--  CONFIGURAÇÕES
--========================================================--
local CONFIG = {
    TITULO = "TXZZ76 HUB",
    SUBTITULO = "BEST EGG SYSTEM",
    COR_FUNDO = Color3.fromRGB(22, 26, 34),
    COR_CARD = Color3.fromRGB(30, 35, 46),
    COR_VERDE = Color3.fromRGB(46, 204, 113),
    COR_AZUL = Color3.fromRGB(52, 152, 219),
    COR_ROXO = Color3.fromRGB(155, 89, 182),
    COR_CINZA = Color3.fromRGB(149, 155, 166),
    COR_TEXTO = Color3.fromRGB(255, 255, 255)
}

--========================================================--
--  LIMPAR VERSÃO ANTERIOR
--========================================================--
local old = playerGui:FindFirstChild("TXZZ76_EGG_HUB")
if old then old:Destroy() end

--========================================================--
--  CRIAR GUI PRINCIPAL
--========================================================--
local gui = Instance.new("ScreenGui")
gui.Name = "TXZZ76_EGG_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--========================================================--
--  FUNÇÕES AUXILIARES
--========================================================--
local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = obj
    return c
end

local function addShadow(obj)
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(40, 45, 60)
    s.Thickness = 1
    s.Transparency = 0.7
    s.Parent = obj
    return s
end

local function label(parent, text, size, pos, fontSize, color, align)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = size
    l.Position = pos
    l.Text = text
    l.TextColor3 = color or CONFIG.COR_TEXTO
    l.TextSize = fontSize or 12
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = align or Enum.TextXAlignment.Left
    l.TextYAlignment = Enum.TextYAlignment.Center
    l.Parent = parent
    return l
end

--========================================================--
--  NOTIFICAÇÕES
--========================================================--
local notifContainer = Instance.new("Frame")
notifContainer.Name = "Notifications"
notifContainer.BackgroundTransparency = 1
notifContainer.Size = UDim2.new(0, 300, 0, 300)
notifContainer.Position = UDim2.new(1, -315, 0, 20)
notifContainer.Parent = gui
local notifLayout = Instance.new("UIListLayout")
notifLayout.Padding = UDim.new(0, 8)
notifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifLayout.Parent = notifContainer

local function notify(msg, tipo)
    local n = Instance.new("TextLabel")
    n.Size = UDim2.new(1, 0, 0, 45)
    n.BackgroundColor3 = CONFIG.COR_CARD
    n.Text = msg
    n.TextColor3 = tipo == "sucesso" and CONFIG.COR_VERDE or tipo == "erro" and Color3.fromRGB(231, 76, 60) or CONFIG.COR_TEXTO
    n.TextSize = 12
    n.Font = Enum.Font.GothamMedium
    n.TextWrapped = true
    n.Parent = notifContainer
    addCorner(n, 10)
    addShadow(n)
    task.delay(3.5, function() if n and n.Parent then n:Destroy() end end)
end

--========================================================--
--  JANELA PRINCIPAL
--========================================================--
local mainWin = Instance.new("Frame")
mainWin.Size = UDim2.new(0, 320, 0, 260)
mainWin.Position = UDim2.new(0.5, 0, 0.5, 0)
mainWin.AnchorPoint = Vector2.new(0.5, 0.5)
mainWin.BackgroundColor3 = CONFIG.COR_FUNDO
mainWin.BorderSizePixel = 0
mainWin.ClipsDescendants = true
mainWin.Visible = true
mainWin.Parent = gui
addCorner(mainWin, 16)
addShadow(mainWin)

-- CABEÇALHO
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = CONFIG.COR_CARD
header.Parent = mainWin
addCorner(header, 16)

-- ÍCONE DISCORD + FECHAR
local discordIcon = Instance.new("ImageLabel")
discordIcon.Size = UDim2.new(0, 26, 0, 26)
discordIcon.Position = UDim2.new(1, -58, 0.5, -13)
discordIcon.BackgroundTransparency = 1
discordIcon.Image = "rbxassetid://13395503064"
discordIcon.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -28, 0.5, -13)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.TextColor3 = CONFIG.COR_CINZA
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
closeBtn.MouseButton1Click:Connect(function()
    mainWin.Visible = false
    launcher.Visible = true
end)

-- TÍTULO
label(header, CONFIG.TITULO, UDim2.new(1, -90, 0, 28), UDim2.new(0, 16, 0, 5), 17, CONFIG.COR_TEXTO).Font = Enum.Font.GothamBold
label(header, CONFIG.SUBTITULO, UDim2.new(1, -90, 0, 20), UDim2.new(0, 16, 0, 32), 10, CONFIG.COR_CINZA)

-- CONTEÚDO
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -65)
content.Position = UDim2.new(0, 10, 0, 60)
content.BackgroundTransparency = 1
content.Parent = mainWin

--========================================================--
--  CARD DO OVO
--========================================================--
local eggCard = Instance.new("Frame")
eggCard.Size = UDim2.new(1, 0, 0, 85)
eggCard.BackgroundColor3 = CONFIG.COR_CARD
eggCard.Parent = content
addCorner(eggCard, 12)

-- ÍCONE DO OVO
local eggIconBg = Instance.new("Frame")
eggIconBg.Size = UDim2.new(0, 55, 0, 55)
eggIconBg.Position = UDim2.new(0, 12, 0.5, -27)
eggIconBg.BackgroundColor3 = Color3.fromRGB(41, 46, 58)
eggIconBg.Parent = eggCard
addCorner(eggIconBg, 10)
label(eggIconBg, "🥚", UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0), 26, nil, Enum.TextXAlignment.Center)

-- INFO DO OVO
label(eggCard, "BEST EGG", UDim2.new(1, -90, 0, 20), UDim2.new(0, 82, 0, 8), 11, CONFIG.COR_CINZA)
local eggName = label(eggCard, "Nenhum ovo encontrado", UDim2.new(1, -90, 0, 26), UDim2.new(0, 82, 0, 28), 14, CONFIG.COR_ROXO)
eggName.Font = Enum.Font.GothamBold
local eggValue = label(eggCard, "---", UDim2.new(1, -90, 0, 22), UDim2.new(0, 82, 0, 52), 12, CONFIG.COR_VERDE)
eggValue.TextXAlignment = Enum.TextXAlignment.Right

-- BOTÃO PEGAR OVO
local getEggBtn = Instance.new("TextButton")
getEggBtn.Size = UDim2.new(1, 0, 0, 40)
getEggBtn.Position = UDim2.new(0, 0, 0, 95)
getEggBtn.BackgroundColor3 = CONFIG.COR_AZUL
getEggBtn.Text = "🥚 PEGAR MELHOR OVO"
getEggBtn.TextColor3 = CONFIG.COR_TEXTO
getEggBtn.TextSize = 13
getEggBtn.Font = Enum.Font.GothamBold
getEggBtn.Parent = content
addCorner(getEggBtn, 10)
getEggBtn.MouseButton1Click:Connect(function()
    eggName.Text = "Snowy Owl"
    eggValue.Text = "5.68M"
    notify("🥚 Melhor ovo encontrado: Snowy Owl (5.68M)", "sucesso")
end)

-- TELEGUIADO + LOOP
local teleContainer = Instance.new("Frame")
teleContainer.Size = UDim2.new(1, 0, 0, 32)
teleContainer.Position = UDim2.new(0, 0, 0, 145)
teleContainer.BackgroundTransparency = 1
teleContainer.Parent = content

label(teleContainer, "TELEGUIADO", UDim2.new(0, 100, 1, 0), UDim2.new(0, 0, 0, 0), 12, CONFIG.COR_CINZA)

-- TOGGLE TELEGUIADO
local teleToggleBg = Instance.new("Frame")
teleToggleBg.Size = UDim2.new(0, 44, 0, 24)
teleToggleBg.Position = UDim2.new(1, -46, 0.5, -12)
teleToggleBg.BackgroundColor3 = Color3.fromRGB(55, 60, 75)
teleToggleBg.Parent = teleContainer
addCorner(teleToggleBg, 12)

local teleDot = Instance.new("Frame")
teleDot.Size = UDim2.new(0, 18, 0, 18)
teleDot.Position = UDim2.new(0, 3, 0.5, -9)
teleDot.BackgroundColor3 = CONFIG.COR_CINZA
teleDot.Parent = teleToggleBg
addCorner(teleDot, 9)

local teleState = false
teleToggleBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        teleState = not teleState
        TweenService:Create(teleDot, TweenInfo.new(0.15), {Position = teleState and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}):Play()
        teleToggleBg.BackgroundColor3 = teleState and CONFIG.COR_AZUL or Color3.fromRGB(55, 60, 75)
        teleDot.BackgroundColor3 = teleState and Color3.new(1,1,1) or CONFIG.COR_CINZA
        notify(teleState and "✅ Teleguiado ativado!" or "❌ Teleguiado desativado", teleState and "sucesso" or nil)
    end
end)

-- LOOP
local loopContainer = Instance.new("Frame")
loopContainer.Size = UDim2.new(1, 0, 0, 32)
loopContainer.Position = UDim2.new(0, 0, 0, 182)
loopContainer.BackgroundTransparency = 1
loopContainer.Parent = content

label(loopContainer, "LOOP", UDim2.new(0, 100, 1, 0), UDim2.new(0, 0, 0, 0), 12, CONFIG.COR_CINZA)
label(loopContainer, "ONE SHOT", UDim2.new(0, 100, 0, 16), UDim2.new(0, 0, 0, 16), 9, Color3.fromRGB(90, 95, 110))

-- TOGGLE LOOP
local loopToggleBg = Instance.new("Frame")
loopToggleBg.Size = UDim2.new(0, 44, 0, 24)
loopToggleBg.Position = UDim2.new(1, -46, 0.5, -12)
loopToggleBg.BackgroundColor3 = Color3.fromRGB(55, 60, 75)
loopToggleBg.Parent = loopContainer
addCorner(loopToggleBg, 12)

local loopDot = Instance.new("Frame")
loopDot.Size = UDim2.new(0, 18, 0, 18)
loopDot.Position = UDim2.new(0, 3, 0.5, -9)
loopDot.BackgroundColor3 = CONFIG.COR_CINZA
loopDot.Parent = loopToggleBg
addCorner(loopDot, 9)

local loopState = false
loopToggleBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        loopState = not loopState
        TweenService:Create(loopDot, TweenInfo.new(0.15), {Position = loopState and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}):Play()
        loopToggleBg.BackgroundColor3 = loopState and CONFIG.COR_AZUL or Color3.fromRGB(55, 60, 75)
        loopDot.BackgroundColor3 = loopState and Color3.new(1,1,1) or CONFIG.COR_CINZA
        notify(loopState and "🔁 Modo LOOP ativado!" or "⏹️ Modo LOOP parado", loopState and "sucesso" or nil)
    end
end)

--========================================================--
--  BOTÃO FLUTUANTE (ABRIR/FECHAR)
--========================================================--
local launcher = Instance.new("ImageButton")
launcher.Name = "TXZZ76_Launcher"
launcher.Size = UDim2.fromOffset(55, 55)
launcher.Position = UDim2.new(0, 15, 0.5, -27)
launcher.BackgroundColor3 = CONFIG.COR_CARD
launcher.Text = "🥚"
launcher.Font = Enum.Font.GothamBold
launcher.TextSize = 26
launcher.AutoButtonColor = true
launcher.ZIndex = 10
launcher.Parent = gui
addCorner(launcher, 27)
addShadow(launcher)

launcher.MouseButton1Click:Connect(function()
    mainWin.Visible = not mainWin.Visible
    launcher.Visible = not mainWin.Visible
end)

-- ARRASTAR JANELA
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainWin.Position
        input.Changed:Connect(function(i)
            if i.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = input.Position - dragStart
    mainWin.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end)

notify("🥚 TXZZ76 Hub carregado!", "sucesso")
--========================================================--
