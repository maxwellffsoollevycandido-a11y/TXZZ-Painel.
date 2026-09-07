--========================================================--
--  VIP ADMIN PANEL • SEU JOGO DE VIAGENS
--  ✅ SÓ MAIORES DE 18 ✅ ACESSO VIP ✅ DADOS DA CONTA
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
--  CONFIGURAÇÕES
--========================================================--
local CONFIG = {
    TITULO = "PAINEL VIP SECRETO",
    SUBTITULO = "Área exclusiva — Apenas VIPs",
    COR_FUNDO = Color3.fromRGB(20, 25, 35),
    COR_CARD = Color3.fromRGB(30, 38, 54),
    COR_DOURADO = Color3.fromRGB(218, 165, 32),
    COR_VERDE = Color3.fromRGB(40, 180, 90),
    COR_VERMELHO = Color3.fromRGB(190, 50, 50),
    COR_CINZA = Color3.fromRGB(120, 130, 150),
    COR_TEXTO = Color3.fromRGB(255, 255, 255)
}

-- BANCO DE DADOS SIMPLES (salva localmente)
local DADOS_USUARIOS = {
    -- Formato: ["NomeDoUsuario"] = {senha = "xxx", idade = 19, vip = true}
}

local logado = false
local usuarioAtual = nil

--========================================================--
--  LIMPAR VERSÃO ANTERIOR
--========================================================--
local old = playerGui:FindFirstChild("VIP_ADMIN_PANEL")
if old then old:Destroy() end

--========================================================--
--  CRIAR GUI
--========================================================--
local gui = Instance.new("ScreenGui")
gui.Name = "VIP_ADMIN_PANEL"
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

local function button(parent, text, size, pos, cor)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = cor or CONFIG.COR_DOURADO
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = true
    b.Parent = parent
    addCorner(b, 10)
    return b
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
    n.TextColor3 = tipo == "sucesso" and CONFIG.COR_VERDE or tipo == "erro" and CONFIG.COR_VERMELHO or CONFIG.COR_TEXTO
    n.TextSize = 12
    n.Font = Enum.Font.GothamMedium
    n.TextWrapped = true
    n.Parent = notifContainer
    addCorner(n, 10)
    task.delay(3.5, function() if n and n.Parent then n:Destroy() end end)
end

--========================================================--
--  SALVAR / CARREGAR DADOS
--========================================================--
local function salvarDados()
    if ReplicatedStorage:FindFirstChild("VIP_USUARIOS_DATA") then
        ReplicatedStorage.VIP_USUARIOS_DATA:Destroy()
    end
    local data = Instance.new("StringValue")
    data.Name = "VIP_USUARIOS_DATA"
    data.Value = game:GetService("HttpService"):JSONEncode(DADOS_USUARIOS)
    data.Parent = ReplicatedStorage
end

local function carregarDados()
    if ReplicatedStorage:FindFirstChild("VIP_USUARIOS_DATA") then
        local ok, decoded = pcall(function()
            return game:GetService("HttpService"):JSONDecode(ReplicatedStorage.VIP_USUARIOS_DATA.Value)
        end)
        if ok then DADOS_USUARIOS = decoded end
    end
end

--========================================================--
--  JANELA DE IDADE — OBRIGATÓRIO 18+
--========================================================--
local idadeWin = Instance.new("Frame")
idadeWin.Size = UDim2.new(0, 360, 0, 260)
idadeWin.Position = UDim2.new(0.5, 0, 0.5, 0)
idadeWin.AnchorPoint = Vector2.new(0.5, 0.5)
idadeWin.BackgroundColor3 = CONFIG.COR_FUNDO
idadeWin.Parent = gui
addCorner(idadeWin, 16)

label(idadeWin, "🔒 VERIFICAÇÃO DE IDADE", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 20), 17, CONFIG.COR_DOURADO, Enum.TextXAlignment.Center, Enum.Font.GothamBold)
label(idadeWin, "Este jogo é restrito a pessoas com 18 anos ou mais.", UDim2.new(1, -40, 0, 40), UDim2.new(0, 20, 0, 55), 12, CONFIG.COR_CINZA, Enum.TextXAlignment.Center)
label(idadeWin, "Qual é a sua idade?", UDim2.new(1, 0, 0, 22), UDim2.new(0, 0, 0, 105), 13, CONFIG.COR_TEXTO, Enum.TextXAlignment.Center, Enum.Font.GothamBold)

local idadeBox = Instance.new("TextBox")
idadeBox.Size = UDim2.new(1, -40, 0, 45)
idadeBox.Position = UDim2.new(0, 20, 0, 135)
idadeBox.BackgroundColor3 = CONFIG.COR_CARD
idadeBox.PlaceholderText = "Digite sua idade..."
idadeBox.Text = ""
idadeBox.TextColor3 = CONFIG.COR_TEXTO
idadeBox.TextSize = 14
idadeBox.Font = Enum.Font.GothamBold
idadeBox.Parent = idadeWin
addCorner(idadeBox, 10)

local confirmarIdade = button(idadeWin, "✅ CONFIRMAR", UDim2.new(1, -40, 0, 42), UDim2.new(0, 20, 0, 195), CONFIG.COR_DOURADO)

--========================================================--
--  JANELA DE LOGIN / CADASTRO
--========================================================--
local authWin = Instance.new("Frame")
authWin.Size = UDim2.new(0, 360, 0, 340)
authWin.Position = UDim2.new(0.5, 0, 0.5, 0)
authWin.AnchorPoint = Vector2.new(0.5, 0.5)
authWin.BackgroundColor3 = CONFIG.COR_FUNDO
authWin.Visible = false
authWin.Parent = gui
addCorner(authWin, 16)

label(authWin, "🔐 ACESSO VIP", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 20), 17, CONFIG.COR_DOURADO, Enum.TextXAlignment.Center, Enum.Font.GothamBold)

-- Campos
label(authWin, "Nome de usuário", UDim2.new(1, -40, 0, 20), UDim2.new(0, 20, 0, 60), 11, CONFIG.COR_CINZA)
local userBox = Instance.new("TextBox")
userBox.Size = UDim2.new(1, -40, 0, 42)
userBox.Position = UDim2.new(0, 20, 0, 80)
userBox.BackgroundColor3 = CONFIG.COR_CARD
userBox.PlaceholderText = "Seu nome de usuário..."
userBox.Text = ""
userBox.TextColor3 = CONFIG.COR_TEXTO
userBox.TextSize = 13
userBox.Font = Enum.Font.Gotham
userBox.Parent = authWin
addCorner(userBox, 10)

label(authWin, "Senha", UDim2.new(1, -40, 0, 20), UDim2.new(0, 20, 0, 132), 11, CONFIG.COR_CINZA)
local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(1, -40, 0, 42)
passBox.Position = UDim2.new(0, 20, 0, 152)
passBox.BackgroundColor3 = CONFIG.COR_CARD
passBox.PlaceholderText = "Sua senha..."
passBox.Text = ""
passBox.TextColor3 = CONFIG.COR_TEXTO
passBox.TextSize = 13
passBox.Font = Enum.Font.Gotham
passBox.Password = true
passBox.Parent = authWin
addCorner(passBox, 10)

local btnLogin = button(authWin, " ".."ENTRAR", UDim2.new(1, -40, 0, 40), UDim2.new(0, 20, 0, 210), CONFIG.COR_VERDE)
local btnCadastro = button(authWin, "📝 CADASTRAR VIP", UDim2.new(1, -40, 0, 40), UDim2.new(0, 20, 0, 260), CONFIG.COR_DOURADO)

--========================================================--
--  🖥️ PAINEL PRINCIPAL — MOSTRA DADOS DA CONTA
--========================================================--
local mainWin = Instance.new("Frame")
mainWin.Size = UDim2.new(0, 340, 0, 300)
mainWin.Position = UDim2.new(0.5, 0, 0.5, 0)
mainWin.AnchorPoint = Vector2.new(0.5, 0.5)
mainWin.BackgroundColor3 = CONFIG.COR_FUNDO
mainWin.Visible = false
mainWin.Parent = gui
addCorner(mainWin, 16)

-- Cabeçalho
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundColor3 = CONFIG.COR_CARD
header.Parent = mainWin
addCorner(header, 16)
label(header, "👑 "..CONFIG.TITULO, UDim2.new(1, -50, 0, 30), UDim2.new(0, 18, 0, 12), 15, CONFIG.COR_DOURADO, nil, Enum.Font.GothamBold)
local btnSair = button(header, "✕", UDim2.new(0, 32, 0, 32), UDim2.new(1, -42, 0.5, -16), CONFIG.COR_VERMELHO)

-- Conteúdo
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -30, 1, -70)
content.Position = UDim2.new(0, 15, 0, 60)
content.BackgroundTransparency = 1
content.Parent = mainWin

-- CARD: NOME DE USUÁRIO
local cardUser = Instance.new("Frame")
cardUser.Size = UDim2.new(1, 0, 0, 60)
cardUser.BackgroundColor3 = CONFIG.COR_CARD
cardUser.Parent = content
addCorner(cardUser, 10)
label(cardUser, "👤 NOME DE USUÁRIO", UDim2.new(1, -20, 0, 16), UDim2.new(0, 12, 0, 8), 10, CONFIG.COR_CINZA)
local displayUser = label(cardUser, "—", UDim2.new(1, -20, 0, 24), UDim2.new(0, 12, 0, 28), 14, CONFIG.COR_VERDE, nil, Enum.Font.GothamBold)

-- CARD: SENHA
local cardPass = Instance.new("Frame")
cardPass.Size = UDim2.new(1, 0, 0, 60)
cardPass.Position = UDim2.new(0, 0, 0, 70)
cardPass.BackgroundColor3 = CONFIG.COR_CARD
cardPass.Parent = content
addCorner(cardPass, 10)
label(cardPass, "🔑 SENHA DA CONTA", UDim2.new(1, -20, 0, 16), UDim2.new(0, 12, 0, 8), 10, CONFIG.COR_CINZA)
local displayPass = label(cardPass, "—", UDim2.new(1, -20, 0, 24), UDim2.new(0, 12, 0, 28), 14, CONFIG.COR_DOURADO, nil, Enum.Font.GothamBold)

-- CARD: STATUS VIP
local cardVip = Instance.new("Frame")
cardVip.Size = UDim2.new(1, 0, 0, 60)
cardVip.Position = UDim2.new(0, 0, 0, 140)
cardVip.BackgroundColor3 = CONFIG.COR_CARD
cardVip.Parent = content
addCorner(cardVip, 10)
label(cardVip, "💎 STATUS DA CONTA", UDim2.new(1, -20, 0, 16), UDim2.new(0, 12, 0, 8), 10, CONFIG.COR_CINZA)
local displayVip = label(cardVip, "✅ VIP ATIVO", UDim2.new(1, -20, 0, 24), UDim2.new(0, 12, 0, 28), 14, CONFIG.COR_VERDE, nil, Enum.Font.GothamBold)

-- Botão sair
local btnLogout = button(content, "🚪 SAIR DA CONTA", UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0, 210), CONFIG.COR_VERMELHO)

--========================================================--
--  LÓGICA: IDADE
--========================================================--
confirmarIdade.MouseButton1Click:Connect(function()
    local idade = tonumber(idadeBox.Text)
    if not idade then
        notify("❌ Digite uma idade válida!", "erro")
        return
    end
    if idade < 18 then
        notify("🚫 Acesso negado! Precisa ter 18 anos ou mais.", "erro")
        task.wait(3)
        player:Kick("🚫 Este jogo é apenas para maiores de 18 anos.")
        return
    end
    -- Maior de 18 → abre tela de login
    idadeWin.Visible = false
    authWin.Visible = true
    carregarDados()
    notify("✅ Acesso liberado! Faça login ou cadastre-se.", "sucesso")
end)

--========================================================--
--  LÓGICA: LOGIN
--========================================================--
btnLogin.MouseButton1Click:Connect(function()
    local usuario = userBox.Text
    local senha = passBox.Text
    
    if usuario == "" or senha == "" then
        notify("❌ Preencha todos os campos!", "erro")
        return
    end
    
    if DADOS_USUARIOS[usuario] then
        if DADOS_USUARIOS[usuario].senha == senha then
            if DADOS_USUARIOS[usuario].vip then
                logado = true
                usuarioAtual = usuario
                authWin.Visible = false
                mainWin.Visible = true
                -- Mostra os dados no painel
                displayUser.Text = usuario
                displayPass.Text = senha
                notify("✅ Bem-vindo, "..usuario.."! Acesso VIP liberado.", "sucesso")
            else
                notify("❌ Esta conta não é VIP!", "erro")
            end
        else
            notify("❌ Senha incorreta!", "erro")
        end
    else
        notify("❌ Usuário não encontrado! Cadastre-se primeiro.", "erro")
    end
end)

--========================================================--
--  LÓGICA: CADASTRO VIP
--========================================================--
btnCadastro.MouseButton1Click:Connect(function()
    local usuario = userBox.Text
    local senha = passBox.Text
    
    if usuario == "" or senha == "" then
        notify("❌ Preencha usuário e senha!", "erro")
        return
    end
    
    if DADOS_USUARIOS[usuario] then
        notify("❌ Este nome de usuário já existe!", "erro")
        return
    end
    
    -- Cadastra como VIP automaticamente (pois é quem comprou)
    DADOS_USUARIOS[usuario] = {
        senha = senha,
        idade = 18,
        vip = true,
        dataCadastro = os.date("%d/%m/%Y")
    }
    salvarDados()
    
    notify("✅ Cadastro VIP realizado! Faça login agora.", "sucesso")
    userBox.Text = ""
    passBox.Text = ""
end)

--========================================================--
--  LÓGICA: SAIR
--========================================================--
btnSair.MouseButton1Click:Connect(function()
    mainWin.Visible = false
    authWin.Visible = true
    logado = false
    usuarioAtual = nil
    userBox.Text = ""
    passBox.Text = ""
    notify("🔑 Desconectado com segurança.", nil)
end)

btnLogout.MouseButton1Click:Connect(function()
    mainWin.Visible = false
    authWin.Visible = true
    logado = false
    usuarioAtual = nil
    userBox.Text = ""
    passBox.Text = ""
    notify("🔑 Desconectado com segurança.", nil)
end)

--========================================================--
--  ARRASTAR JANELAS
--========================================================--
local function makeDraggable(window)
    local dragging, dragStart, startPos
    window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            input.Changed:Connect(function(i)
                if i.UserInputState == Enum.UserInputState.End then dragging = false end
            end
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local delta = input.Position - dragStart
        window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end)
end

makeDraggable(idadeWin)
makeDraggable(authWin)
makeDraggable(mainWin)

notify("🔐 Sistema de verificação carregado!", "sucesso")
--========================================================--
	
