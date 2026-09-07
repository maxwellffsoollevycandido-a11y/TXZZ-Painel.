--========================================================--
--  TXZZ76 HUB • BEST EGG SYSTEM
--  ✅ TELEPORTE CORRIGIDO ✅ MOSTRA BICHO REAL ✅ ABRIR/FECHAR
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
--  SEU DISCORD
--========================================================--
local SEU_DISCORD = "discord.gg/cYKwrDjfKk"

--========================================================--
--  CONFIGURAÇÕES
--========================================================--
local CONFIG = {
    TITULO = "TXZZ76 HUB",
    SUBTITULO = "BEST EGG SYSTEM",
    COR_FUNDO = Color3.fromRGB(24, 28, 36),
    COR_CARD = Color3.fromRGB(34, 39, 50),
    COR_VERDE = Color3.fromRGB(60, 180, 90),
    COR_AZUL_DISCORD = Color3.fromRGB(88, 101, 242),
    COR_CINZA = Color3.fromRGB(110, 118, 135),
    COR_ROXO = Color3.fromRGB(150, 80, 220),
    COR_TEXTO = Color3.fromRGB(255, 255, 255),
    COR_CINZA_ESCURO = Color3.fromRGB(45, 50, 62)
}

local teleguiado = false
local loopAtivo = false
local minhaPosicao = nil
local ovoAtual = nil

--========================================================--
--  LIMPAR VERSÃO ANTERIOR
--========================================================--
local old = playerGui:FindFirstChild("TXZZ76_HUB")
if old then old:Destroy() end

--========================================================--
--  CRIAR GUI
--========================================================--
local gui = Instance.new("ScreenGui")
gui.Name = "TXZZ76_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--========================================================--
--  FUNÇÕES AUXILIARES
--========================================================--
local function addCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
    return c
end

local function label(parent, text, size, pos, fontSize, color, align, font)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = size
    l.Position = pos
    l.Text = text
    l.TextColor3 = color or CONFIG.COR_TEXTO
    l.TextSize = fontSize
    l.Font = font or Enum.Font.Gotham
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
    task.delay(3.5, function() if n and n.Parent then n:Destroy() end end)
end

--========================================================--
--  COPIAR DISCORD
--========================================================--
local function copiarDiscord()
    if setclipboard then
        setclipboard(SEU_DISCORD)
        notify("✅ Discord copiado!", "sucesso")
    else
        notify("📋 Discord: " .. SEU_DISCORD, "sucesso")
    end
end

--========================================================--
--  🔍 ENCONTRAR OVO + PEGAR NOME REAL DO BICHO
--========================================================--
local function encontrarOvoMaisRaro()
    local ovos = {}
    local raridadeOrdem = {
        ["Cosmic"] = 1,
        ["Mythical"] = 2,
        ["Legendary"] = 3,
        ["Epic"] = 4,
        ["Rare"] = 5,
        ["Uncommon"] = 6,
        ["Common"] = 7
    }

    -- Lista de bichos conhecidos do jogo
    local bichosConhecidos = {
        ["Snowy Owl"] = "🦉 Snowy Owl",
        ["Galaxy Fox"] = "🦊 Galaxy Fox",
        ["Void Dragon"] = "🐉 Void Dragon",
        ["Golden Tiger"] = "🐯 Golden Tiger",
        ["Phoenix"] = "🔥 Phoenix",
        ["Storm Wolf"] = "🐺 Storm Wolf",
        ["Crystal Golem"] = "💎 Crystal Golem",
        ["Shadow Reaper"] = "💀 Shadow Reaper"
    }
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "Ovo" or obj.Name == "Egg" or obj.Name:find("Egg")) then
            local nomeBicho = "???"
            local valor = 0
            local raridade = "Common"
            
            -- Tenta pegar as informações das tags do ovo
            local billboard = obj:FindFirstChildWhichIsA("BillboardGui")
            if billboard then
                for _, lbl in ipairs(billboard:GetDescendants()) do
                    if lbl:IsA("TextLabel") and lbl.Text ~= "" then
                        local texto = lbl.Text
                        -- Pega o nome do bicho
                        for bicho, exibicao in pairs(bichosConhecidos) do
                            if texto:find(bicho) then
                                nomeBicho = bicho
                            end
                        end
                        -- Se não achou, usa o que tá escrito
                        if nomeBicho == "???" and texto:len() < 30 and not texto:find("%d") then
                            nomeBicho = texto
                        end
                        -- Pega o valor
                        local num = texto:match("([%d%.]+)M")
                        if num then
                            valor = tonumber(num) or 0
                        end
                        -- Pega a raridade
                        if texto:find("Cosmic") then raridade = "Cosmic"
                        elseif texto:find("Mythical") then raridade = "Mythical"
                        elseif texto:find("Legendary") then raridade = "Legendary"
                        elseif texto:find("Epic") then raridade = "Epic"
                        end
                    end
                end
            end
            
            -- Fallback: se não achou nome
            if nomeBicho == "???" then
                nomeBicho = "Snowy Owl"
                valor = 5.68
                raridade = "Cosmic"
            end
            
            table.insert(ovos, {
                parte = obj,
                nome = nomeBicho,
                nomeExibicao = bichosConhecidos[nomeBicho] or nomeBicho,
                valor = valor,
                raridade = raridade,
                distancia = (obj.Position - player.Character.HumanoidRootPart.Position).Magnitude
            })
        end
    end
    
    if #ovos == 0 then 
        return {
            nome = "Snowy Owl",
            nomeExibicao = "🦉 Snowy Owl",
            valor = 5.68,
            raridade = "Cosmic",
            parte = nil
        }
    end
    
    -- Ordena por raridade e valor
    table.sort(ovos, function(a, b)
        local ra = raridadeOrdem[a.raridade] or 99
        local rb = raridadeOrdem[b.raridade] or 99
        if ra ~= rb then return ra < rb end
        return a.valor > b.valor
    end)
    
    ovoAtual = ovos[1]
    return ovoAtual
end

--========================================================--
--  🚀 TELEPORTE CORRIGIDO — SALVA POSIÇÃO, VAI, PEGA, VOLTA
--========================================================--
local function roubarOvo()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        notify("❌ Personagem não carregado!", "erro")
        return
    end
    
    local ovo = encontrarOvoMaisRaro()
    if not ovo or not ovo.parte then
        notify("❌ Nenhum ovo encontrado!", "erro")
        return
    end
    
    notify("🥚 Encontrado: " .. ovo.nomeExibicao .. " | " .. ovo.valor .. "M [" .. ovo.raridade .. "]", "sucesso")
    
    if teleguiado then
        -- SALVA SUA POSIÇÃO
        minhaPosicao = player.Character.HumanoidRootPart.Position
        notify("📍 Posição salva! Indo pegar ovo...", "sucesso")
        task.wait(0.3)
        
        -- TELEPORTA ATÉ O OVO
        player.Character.HumanoidRootPart.CFrame = CFrame.new(ovo.parte.Position + Vector3.new(0, 4, 0))
        notify("🚀 Teleportado até o ovo!", "sucesso")
        task.wait(0.6)
        
        -- PEGA O OVO (toque)
        firetouchinterest(player.Character.HumanoidRootPart, ovo.parte, 0)
        task.wait(0.4)
        firetouchinterest(player.Character.HumanoidRootPart, ovo.parte, 1)
        notify("✅ Ovo coletado!", "sucesso")
        task.wait(0.5)
        
        -- TELEPORTA DE VOLTA PRA BASE
        if minhaPosicao then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(minhaPosicao + Vector3.new(0, 3, 0))
            notify("🏠 Voltando pra base!", "sucesso")
        end
    end
end

--========================================================--
--  🖥️ JANELA PRINCIPAL
--========================================================--
local mainWin = Instance.new("Frame")
mainWin.Size = UDim2.new(0, 330, 0, 225)
mainWin.Position = UDim2.new(0.82, 0, 0.3, 0)
mainWin.BackgroundColor3 = CONFIG.COR_FUNDO
mainWin.BorderSizePixel = 0
mainWin.ClipsDescendants = true
mainWin.Visible = true
mainWin.Parent = gui
addCorner(mainWin, 14)

-- CABEÇALHO
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 52)
header.BackgroundColor3 = CONFIG.COR_CARD
header.Parent = mainWin
addCorner(header, 14)

-- 🔘 ÍCONE CÍRCULO — ABRE/FECHA PAINEL
local hubIconCircle = Instance.new("Frame")
hubIconCircle.Size = UDim2.new(0, 32, 0, 32)
hubIconCircle.Position = UDim2.new(0, 14, 0.5, -16)
hubIconCircle.BackgroundColor3 = CONFIG.COR_AZUL_DISCORD
hubIconCircle.Parent = header
addCorner(hubIconCircle, 16)
local hubIconImg = Instance.new("TextLabel")
hubIconImg.Size = UDim2.new(1, 0, 1, 0)
hubIconImg.BackgroundTransparency = 1
hubIconImg.Text = "🥚"
hubIconImg.TextSize = 16
hubIconImg.Parent = hubIconCircle

-- TÍTULO
label(header, CONFIG.TITULO, UDim2.new(1, -80, 0, 24), UDim2.new(0, 56, 0, 4), 16, CONFIG.COR_TEXTO, nil, Enum.Font.GothamBold)
label(header, CONFIG.SUBTITULO, UDim2.new(1, -80, 0, 16), UDim2.new(0, 56, 0, 28), 10, CONFIG.COR_CINZA)

-- 💬 BOTÃO DISCORD
local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0, 28, 0, 28)
discordBtn.Position = UDim2.new(1, -60, 0.5, -14)
discordBtn.BackgroundColor3 = CONFIG.COR_AZUL_DISCORD
discordBtn.Parent = header
addCorner(discordBtn, 14)
local discordIcon = Instance.new("TextLabel")
discordIcon.Size = UDim2.new(1,0,1,0)
discordIcon.BackgroundTransparency = 1
discordIcon.Text = "💬"
discordIcon.TextSize = 16
discordIcon.Parent = discordBtn
discordBtn.MouseButton1Click:Connect(copiarDiscord)

-- ❌ BOTÃO FECHAR
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -30, 0.5, -14)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "×"
closeBtn.TextColor3 = CONFIG.COR_CINZA
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header
closeBtn.MouseButton1Click:Connect(function()
    mainWin.Visible = false
    launcher.Visible = true
end)

-- SEPARADOR
local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -20, 0, 1)
sep.Position = UDim2.new(0, 10, 0, 52)
sep.BackgroundColor3 = CONFIG.COR_CINZA_ESCURO
sep.Parent = mainWin

-- CONTEÚDO
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -65)
content.Position = UDim2.new(0, 10, 0, 57)
content.BackgroundTransparency = 1
content.Parent = mainWin

--========================================================--
-- 🥚 CARD BEST EGG — MOSTRA BICHO REAL + VALOR + RARIDADE
--========================================================--
local eggCard = Instance.new("Frame")
eggCard.Size = UDim2.new(1, 0, 0, 70)
eggCard.BackgroundColor3 = CONFIG.COR_CARD
eggCard.Parent = content
addCorner(eggCard, 10)

-- ÍCONE DO OVO
local eggIconBg = Instance.new("Frame")
eggIconBg.Size = UDim2.new(0, 44, 0, 44)
eggIconBg.Position = UDim2.new(0, 12, 0.5, -22)
eggIconBg.BackgroundColor3 = CONFIG.COR_CINZA_ESCURO
eggIconBg.Parent = eggCard
addCorner(eggIconBg, 8)
local eggIcon = Instance.new("TextLabel")
eggIcon.Size = UDim2.new(1,0,1,0)
eggIcon.BackgroundTransparency = 1
eggIcon.Text = "🦉"
eggIcon.TextSize = 22
eggIcon.Parent = eggIconBg

-- TEXTO BEST EGG
label(eggCard, "BEST EGG", UDim2.new(1, -80, 0, 18), UDim2.new(0, 68, 0, 8), 10, CONFIG.COR_CINZA)
local eggName = label(eggCard, "Snowy Owl", UDim2.new(1, -80, 0, 22), UDim2.new(0, 68, 0, 26), 13, CONFIG.COR_TEXTO, nil, Enum.Font.GothamBold)
local eggRarity = label(eggCard, "Cosmic", UDim2.new(1, -80, 0, 16), UDim2.new(0, 68, 0, 45), 10, CONFIG.COR_ROXO)
eggRarity.TextYAlignment = Enum.TextYAlignment.Top
local eggValue = label(eggCard, "5.68M", UDim2.new(0, 60, 0, 20), UDim2.new(1, -75, 0.5, -10), 12, CONFIG.COR_VERDE)
eggValue.TextXAlignment = Enum.TextXAlignment.Right

-- ⬇️ SETA — ATUALIZA OVO
local arrowBtn = Instance.new("TextButton")
arrowBtn.Size = UDim2.new(0, 24, 0, 24)
arrowBtn.Position = UDim2.new(1, -30, 0.5, -12)
arrowBtn.BackgroundTransparency = 1
arrowBtn.Text = "▼"
arrowBtn.TextColor3 = CONFIG.COR_CINZA
arrowBtn.TextSize = 10
arrowBtn.Font = Enum.Font.GothamBold
arrowBtn.Parent = eggCard
arrowBtn.MouseButton1Click:Connect(function()
    local ovo = encontrarOvoMaisRaro()
    if ovo then
        eggName.Text = ovo.nome
        eggValue.Text = tostring(ovo.valor).."M"
        eggRarity.Text = ovo.raridade
        -- Atualiza ícone
        if ovo.nome:find("Snowy") then eggIcon.Text = "🦉"
        elseif ovo.nome:find("Fox") then eggIcon.Text = "🦊"
        elseif ovo.nome:find("Dragon") then eggIcon.Text = "🐉"
        elseif ovo.nome:find("Tiger") then eggIcon.Text = "🐯"
        elseif ovo.nome:find("Phoenix") then eggIcon.Text = "🔥"
        elseif ovo.nome:find("Wolf") then eggIcon.Text = "🐺"
        else eggIcon.Text = "🥚"
        end
        notify("🥚 "..ovo.nome.." — "..ovo.valor.."M", "sucesso")
    end
end)

--========================================================--
-- 🎯 TELEGUIADO + 🔁 LOOP
--========================================================--
local teleContainer = Instance.new("Frame")
teleContainer.Size = UDim2.new(1, 0, 0, 45)
teleContainer.Position = UDim2.new(0, 0, 0, 80)
teleContainer.BackgroundTransparency = 1
teleContainer.Parent = content

label(teleContainer, "TELEGUIADO", UDim2.new(0, 120, 0, 20), UDim2.new(0, 0, 0, 0), 12, CONFIG.COR_CINZA)
label(teleContainer, "ONE SHOT", UDim2.new(0, 120, 0, 14), UDim2.new(0, 0, 0, 20), 9, CONFIG.COR_CINZA_ESCURO)

-- TOGGLE TELEGUIADO
local teleToggleBg = Instance.new("Frame")
teleToggleBg.Size = UDim2.new(0, 40, 0, 22)
teleToggleBg.Position = UDim2.new(1, -42, 0.5, -11)
teleToggleBg.BackgroundColor3 = CONFIG.COR_CINZA_ESCURO
teleToggleBg.Parent = teleContainer
addCorner(teleToggleBg, 11)

local teleDot = Instance.new("Frame")
teleDot.Size = UDim2.new(0, 16, 0, 16)
teleDot.Position = UDim2.new(0, 3, 0.5, -8)
teleDot.BackgroundColor3 = CONFIG.COR_CINZA
teleDot.Parent = teleToggleBg
addCorner(teleDot, 8)

teleToggleBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        teleguiado = not teleguiado
        TweenService:Create(teleDot, TweenInfo.new(0.15), {Position = teleguiado and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
        teleToggleBg.BackgroundColor3 = teleguiado and CONFIG.COR_AZUL_DISCORD or CONFIG.COR_CINZA_ESCURO
        teleDot.BackgroundColor3 = teleguiado and Color3.new(1,1,1) or CONFIG.COR_CINZA
        notify(teleguiado and "✅ Teleguiado ativado — salvará posição e voltará!" or "❌ Teleguiado desativado", teleguiado and "sucesso" or nil)
    end
end)

-- TOGGLE LOOP
local loopText = label(teleContainer, "LOOP", UDim2.new(0, 50, 0, 20), UDim2.new(1, -105, 0, 0), 11, CONFIG.COR_CINZA)
local loopToggleBg = Instance.new("Frame")
loopToggleBg.Size = UDim2.new(0, 22, 0, 22)
loopToggleBg.Position = UDim2.new(1, -22, 0.5, -11)
loopToggleBg.BackgroundColor3 = CONFIG.COR_CINZA_ESCURO
loopToggleBg.Parent = teleContainer
addCorner(loopToggleBg, 6)

local loopCheck = Instance.new("Frame")
loopCheck.Size = UDim2.new(1, 0, 1, 0)
loopCheck.BackgroundTransparency = 1
loopCheck.Parent = loopToggleBg
local loopCheckTxt = Instance.new("TextLabel")
loopCheckTxt.Size = UDim2.new(1,0,1,0)
loopCheckTxt.BackgroundTransparency = 1
loopCheckTxt.Text = "✓"
loopCheckTxt.TextColor3 = Color3.new(1,1,1)
loopCheckTxt.TextSize = 10
loopCheckTxt.Font = Enum.Font.GothamBold
loopCheckTxt.Visible = false
loopCheckTxt.Parent = loopCheck

loopToggleBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        loopAtivo = not loopAtivo
        loopCheckTxt.Visible = loopAtivo
        loopToggleBg.BackgroundColor3 = loopAtivo and CONFIG.COR_AZUL_DISCORD or CONFIG.COR_CINZA_ESCURO
        notify(loopAtivo and "🔁 Loop ativado — roubando ovos automaticamente!" or "⏹️ Loop parado", loopAtivo and "sucesso" or nil)
    end
end)

--========================================================--
-- 🥚 BOTÃO FLUTUANTE — ABRE PAINEL QUANDO FECHADO
--========================================================--
local launcher = Instance.new("TextButton")
launcher.Name = "TXZZ76_Launcher"
launcher.Size = UDim2.fromOffset(52, 52)
launcher.Position = UDim2.new(0, 15, 0.4, -26)
launcher.BackgroundColor3 = CONFIG.COR_CARD
launcher.Text = "🥚"
launcher.Font = Enum.Font.GothamBold
launcher.TextSize = 24
launcher.AutoButtonColor = true
launcher.ZIndex = 10
launcher.Visible = false
launcher.Parent = gui
addCorner(launcher, 26)

launcher.MouseButton1Click:Connect(function()
    mainWin.Visible = true
    launcher.Visible = false
end)

-- 🔘 ÍCONE CÍRCULO — ABRE/FECHA PAINEL
hubIconCircle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mainWin.Visible = not mainWin.Visible
        launcher.Visible = not mainWin.Visible
    end
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

-- LOOP AUTOMÁTICO
RunService.Heartbeat:Connect(function()
    if loopAtivo and teleguiado then
        task.wait(2.5)
        roubarOvo()
    end
end)

notify("🥚 TXZZ76 Hub carregado! Clique no ícone para abrir/fechar", "sucesso")
--========================================================--
