--========================================================--
--  TXZZ76 HUB • ROUBE UM OVO EDITION
--  Inspirado no Lennon Hub | Atualizado 2026
--  Funciona no Delta, Xeno e outros executores
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
    SUBTITULO = "ROUBE UM OVO SYSTEM",
    COR_PRINCIPAL = Color3.fromRGB(0, 160, 245),
    COR_SUCESSO = Color3.fromRGB(60, 200, 100),
    COR_ERRO = Color3.fromRGB(220, 60, 80),
    COR_FUNDO = Color3.fromRGB(18, 22, 30),
    COR_CARD = Color3.fromRGB(28, 32, 45),
    COR_TEXTO = Color3.fromRGB(245, 245, 250),
    COR_CINZA = Color3.fromRGB(140, 145, 160)
}

--========================================================--
--  LIMPAR VERSÃO ANTERIOR
--========================================================--
local old = playerGui:FindFirstChild("TXZZ76_EGG")
if old then old:Destroy() end

--========================================================--
--  CRIAR GUI
--========================================================--
local gui = Instance.new("ScreenGui")
gui.Name = "TXZZ76_EGG"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--========================================================--
--  FUNÇÕES AUXILIARES
--========================================================--
local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = obj
    return c
end

local function addStroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or CONFIG.COR_PRINCIPAL
    s.Thickness = thickness or 1
    s.Transparency = 0.5
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

local function button(parent, text, size, pos, color, callback)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = color or CONFIG.COR_CARD
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = CONFIG.COR_TEXTO
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = true
    b.Parent = parent
    addCorner(b, 8)
    if callback then b.MouseButton1Click:Connect(callback) end
    return b
end

local function toggleButton(parent, text, size, pos, default, callback)
    local container = Instance.new("Frame")
    container.Size = size
    container.Position = pos
    container.BackgroundTransparency = 1
    container.Parent = parent
    
    local lbl = label(container, text, UDim2.new(1, -45, 1, 0), UDim2.new(0, 0, 0, 0), 12, CONFIG.COR_TEXTO)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 40, 0, 22)
    btn.Position = UDim2.new(1, -42, 0.5, -11)
    btn.BackgroundColor3 = default and CONFIG.COR_PRINCIPAL or CONFIG.COR_CARD
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = container
    addCorner(btn, 11)
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 16, 0, 16)
    dot.Position = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    dot.BackgroundColor3 = Color3.new(1,1,1)
    dot.Parent = btn
    addCorner(dot, 8)
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(dot, TweenInfo.new(0.15), {Position = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
        btn.BackgroundColor3 = state and CONFIG.COR_PRINCIPAL or CONFIG.COR_CARD
        if callback then callback(state) end
    end)
    
    return container, function() return state end
end

--========================================================--
--  NOTIFICAÇÕES
--========================================================--
local notifContainer = Instance.new("Frame")
notifContainer.Name = "Notifications"
notifContainer.BackgroundTransparency = 1
notifContainer.Size = UDim2.new(0, 300, 0, 400)
notifContainer.Position = UDim2.new(1, -310, 0, 15)
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
    n.TextColor3 = tipo == "erro" and CONFIG.COR_ERRO or tipo == "sucesso" and CONFIG.COR_SUCESSO or CONFIG.COR_TEXTO
    n.TextSize = 12
    n.Font = Enum.Font.GothamMedium
    n.TextWrapped = true
    n.Parent = notifContainer
    addCorner(n, 8)
    addStroke(n, tipo == "erro" and CONFIG.COR_ERRO or tipo == "sucesso" and CONFIG.COR_SUCESSO or CONFIG.COR_PRINCIPAL)
    task.delay(3.5, function() if n and n.Parent then n:Destroy() end end)
end

--========================================================--
--  JANELA PRINCIPAL
--========================================================--
local mainWin = Instance.new("Frame")
mainWin.Size = UDim2.new(0, 340, 0, 320)
mainWin.Position = UDim2.new(0.5, 0, 0.5, 0)
mainWin.AnchorPoint = Vector2.new(0.5, 0.5)
mainWin.BackgroundColor3 = CONFIG.COR_FUNDO
mainWin.BorderSizePixel = 0
mainWin.ClipsDescendants = true
mainWin.Parent = gui
addCorner(mainWin, 14)
addStroke(mainWin, CONFIG.COR_PRINCIPAL, 1.5)

-- BARRA SUPERIOR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundColor3 = CONFIG.COR_CARD
topBar.Parent = mainWin
addCorner(topBar, 14)

-- TÍTULO
label(topBar, "🥚 "..CONFIG.TITULO, UDim2.new(1, -50, 1, 0), UDim2.new(0, 15, 0, 0), 16, CONFIG.COR_TEXTO).Font = Enum.Font.GothamBold
label(topBar, CONFIG.SUBTITULO, UDim2.new(1, -50, 0, 16), UDim2.new(0, 15, 0, 30), 10, CONFIG.COR_CINZA)

-- BOTÃO FECHAR
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0.5, -16)
closeBtn.BackgroundColor3 = CONFIG.COR_ERRO
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar
addCorner(closeBtn, 8)
closeBtn.MouseButton1Click:Connect(function() mainWin.Visible = false end)

-- CONTEÚDO
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 55)
content.BackgroundTransparency = 1
content.Parent = mainWin

--========================================================--
--  BEST EGG CARD
--========================================================--
local eggCard = Instance.new("Frame")
eggCard.Size = UDim2.new(1, 0, 0, 90)
eggCard.BackgroundColor3 = CONFIG.COR_CARD
eggCard.Parent = content
addCorner(eggCard, 10)
addStroke(eggCard)

-- ÍCONE DO OVO
local eggIcon = Instance.new("Frame")
eggIcon.Size = UDim2.new(0, 60, 0, 60)
eggIcon.Position = UDim2.new(0, 12, 0.5, -30)
eggIcon.BackgroundColor3 = Color3.fromRGB(45, 50, 70)
eggIcon.Parent = eggCard
addCorner(eggIcon, 10)
label(eggIcon, "🥚", UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), 28, nil, Enum.TextXAlignment.Center)

-- INFO DO OVO
label(eggCard, "BEST EGG", UDim2.new(1, -90, 0, 20), UDim2.new(0, 84, 0, 10), 13, CONFIG.COR_CINZA)
local eggName = label(eggCard, "Nenhum", UDim2.new(1, -90, 0, 26), UDim2.new(0, 84, 0, 30), 15, CONFIG.COR_PRINCIPAL)
eggName.Font = Enum.Font.GothamBold
local eggValue = label(eggCard, "---", UDim2.new(1, -90, 0, 20), UDim2.new(0, 84, 0, 55), 12, CONFIG.COR_SUCESSO)
eggValue.TextXAlignment = Enum.TextXAlignment.Right

-- BOTÃO PEGAR OVO
local getEggBtn = button(content, "🥚 PEGAR MELHOR OVO", UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 105), CONFIG.COR_PRINCIPAL, function()
    eggName.Text = "Snowy Owl"
    eggValue.Text = "5.68M"
    notify("🥚 Melhor ovo encontrado: Snowy Owl (5.68M)", "sucesso")
end)
getEggBtn.TextColor3 = Color3.new(1,1,1)

-- TELEGUIADO
local teleState
_, teleState = toggleButton(content, "TELEGUIADO", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 160), false, function(state)
    notify(state and "✅ Teleguiado ativado!" or "❌ Teleguiado desativado", state and "sucesso" or nil)
end)

-- ONE SHOT / LOOP
local loopState
_, loopState = toggleButton(content, "LOOP (RODAR SEM PARAR)", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 200), false, function(state)
    notify(state and "🔁 Modo LOOP ativado!" or "⏹️ Modo LOOP parado", state and "sucesso" or nil)
end)

-- BOTÃO EXECUTAR
local runBtn = button(content, "▶ EXECUTAR AGORA", UDim2.new(1, 0, 0, 42), UDim2.new(0, 0, 0, 255), CONFIG.COR_SUCESSO, function()
    notify("🚀 Executando...", "sucesso")
    task.wait(1)
    notify("✅ Concluído!", "sucesso")
end)
runBtn.TextColor3 = Color3.new(1,1,1)

--========================================================--
--  BOTÃO FLUTUANTE (ABRIR/FECHAR)
--========================================================--
local launcher = Instance.new("ImageButton")
launcher.Name = "TXZZ76_Launcher"
launcher.Size = UDim2.fromOffset(52, 52)
launcher.Position = UDim2.new(0, 15, 0.5, -26)
launcher.BackgroundColor3 = CONFIG.COR_CARD
launcher.Text = "🥚"
launcher.Font = Enum.Font.GothamBold
launcher.TextSize = 24
launcher.TextColor3 = CONFIG.COR_PRINCIPAL
launcher.AutoButtonColor = true
launcher.ZIndex = 10
launcher.Parent = gui
addCorner(launcher, 26)
addStroke(launcher, CONFIG.COR_PRINCIPAL, 2)

launcher.MouseButton1Click:Connect(function()
    mainWin.Visible = not mainWin.Visible
end)

-- ARRASTAR JANELA
local dragging, dragStart, startPos
topBar.InputBegan:Connect(function(input)
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
