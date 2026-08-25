--==================================================
-- TXZZ 76 • PAINEL COMPLETO
-- KEY SYSTEM + RIVALS + MORTE NEGRA
-- PC + CELULAR
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- CONFIGURAÇÃO
--==================================================

local KEY_CORRETA = "TXZZ-TESTE-123"
local DISCORD_LINK = "https://discord.gg/KhAmznCuHm"

local ICON_IMAGE = "rbxassetid://134571219107537"

local KEY_DURATION = 24 * 60 * 60
local keyExpiresAt = 0

--==================================================
-- ESTADOS
--==================================================

local states = {

	-- RIVALS
	["Mira Cabeça"] = false,
	["Priorizar Cabeça"] = false,
	["Atravessa Parede"] = false,
	["Pulo Alto"] = false,
	["Pulo Duplo"] = false,
	["Pulo Triplo"] = false,
	["Sem Dano Queda"] = false,
	["Anti Empurrão"] = false,
	["Linhas ESP"] = false,
	["Caixa Corpo"] = false,
	["Nome + Vida"] = false,

	-- MORTE NEGRA
	["Sem Dano"] = false,
	["Habilidades Infinitas"] = false,
	["Gruda e Não Desgruda"] = false,
	["AFK Matador"] = false,
	["Voar"] = false,
	["Velocidade"] = false,
	["Super Pulo"] = false,
	["Linhas Inimigo"] = false,
	["Caixa Corpo MN"] = false,
	["Mostrar Nome"] = false,
	["Mostrar Vida"] = false,

	-- SETTINGS
	["Notificações"] = false,
	["Animações"] = true,
	["Modo Compacto"] = false
}

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "TXZZPanel"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--==================================================
-- FUNÇÕES
--==================================================

local function corner(obj, radius)

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = obj

end

local function stroke(obj, color, transparency, thickness)

	local s = Instance.new("UIStroke")

	s.Color = color
	s.Transparency = transparency or 0
	s.Thickness = thickness or 1

	s.Parent = obj

end

local function animate(obj, time, properties)

	local tween = TweenService:Create(
		obj,
		TweenInfo.new(
			time,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),
		properties
	)

	tween:Play()

	return tween

end

--==================================================
-- FUNÇÃO ARRASTAR
--==================================================

local function makeDraggable(object, dragArea)

	local dragging = false
	local dragStart
	local startPosition

	dragArea.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = object.Position

		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPosition.X.Scale,
				startPosition.X.Offset + delta.X,
				startPosition.Y.Scale,
				startPosition.Y.Offset + delta.Y
			)

		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = false

		end

	end)

end

--==================================================
-- KEY PAGE
--==================================================

local keyPage = Instance.new("Frame")

keyPage.Name = "KeyPage"
keyPage.Size = UDim2.fromOffset(380,270)
keyPage.Position = UDim2.new(0.5,-190,0.5,-135)

keyPage.BackgroundColor3 = Color3.fromRGB(10,10,13)
keyPage.BorderSizePixel = 0
keyPage.ClipsDescendants = true

keyPage.Parent = gui

corner(keyPage,10)

stroke(
	keyPage,
	Color3.fromRGB(155,0,0),
	0.15,
	1
)

--==================================================
-- KEY HEADER
--==================================================

local keyHeader = Instance.new("Frame")

keyHeader.Size = UDim2.new(1,0,0,46)
keyHeader.BackgroundColor3 = Color3.fromRGB(14,14,18)
keyHeader.BorderSizePixel = 0
keyHeader.Parent = keyPage

local keyIcon = Instance.new("ImageLabel")

keyIcon.Image = ICON_IMAGE
keyIcon.ScaleType = Enum.ScaleType.Crop
keyIcon.Size = UDim2.fromOffset(32,32)
keyIcon.Position = UDim2.fromOffset(10,7)
keyIcon.BackgroundColor3 = Color3.fromRGB(155,0,0)
keyIcon.BorderSizePixel = 0
keyIcon.Parent = keyHeader

corner(keyIcon,8)

local keyTitle = Instance.new("TextLabel")

keyTitle.Size = UDim2.new(1,-145,1,0)
keyTitle.Position = UDim2.fromOffset(52,0)

keyTitle.BackgroundTransparency = 1
keyTitle.Text = "TXZZ KEY SYSTEM"

keyTitle.TextColor3 = Color3.fromRGB(235,235,235)
keyTitle.TextSize = 17
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextXAlignment = Enum.TextXAlignment.Left

keyTitle.Parent = keyHeader

--==================================================
-- KEY MINIMIZAR
--==================================================

local keyMinimize = Instance.new("TextButton")

keyMinimize.Size = UDim2.fromOffset(28,28)
keyMinimize.Position = UDim2.new(1,-66,0,9)

keyMinimize.BackgroundColor3 = Color3.fromRGB(45,45,52)
keyMinimize.BorderSizePixel = 0

keyMinimize.Text = "—"
keyMinimize.TextColor3 = Color3.new(1,1,1)
keyMinimize.TextSize = 15
keyMinimize.Font = Enum.Font.GothamBold

keyMinimize.Parent = keyHeader

corner(keyMinimize,6)

--==================================================
-- KEY FECHAR
--==================================================

local keyClose = Instance.new("TextButton")

keyClose.Size = UDim2.fromOffset(28,28)
keyClose.Position = UDim2.new(1,-34,0,9)

keyClose.BackgroundColor3 = Color3.fromRGB(125,20,25)
keyClose.BorderSizePixel = 0

keyClose.Text = "X"
keyClose.TextColor3 = Color3.new(1,1,1)
keyClose.TextSize = 12
keyClose.Font = Enum.Font.GothamBold

keyClose.Parent = keyHeader

corner(keyClose,6)

--==================================================
-- KEY INFO
--==================================================

local keyInfo = Instance.new("TextLabel")

keyInfo.Size = UDim2.new(1,-30,0,26)
keyInfo.Position = UDim2.fromOffset(15,58)

keyInfo.BackgroundTransparency = 1
keyInfo.Text = "Digite sua key para continuar"

keyInfo.TextColor3 = Color3.fromRGB(145,145,155)
keyInfo.TextSize = 13
keyInfo.Font = Enum.Font.Gotham

keyInfo.Parent = keyPage

--==================================================
-- KEY BOX
--==================================================

local keyBox = Instance.new("TextBox")

keyBox.Size = UDim2.new(1,-30,0,42)
keyBox.Position = UDim2.fromOffset(15,91)

keyBox.BackgroundColor3 = Color3.fromRGB(24,24,29)
keyBox.BorderSizePixel = 0

keyBox.PlaceholderText = "Digite sua key..."
keyBox.PlaceholderColor3 = Color3.fromRGB(90,90,100)

keyBox.Text = ""
keyBox.TextColor3 = Color3.new(1,1,1)

keyBox.TextSize = 14
keyBox.Font = Enum.Font.Gotham

keyBox.ClearTextOnFocus = false

keyBox.Parent = keyPage

corner(keyBox,7)

--==================================================
-- VALIDAR
--==================================================

local validate = Instance.new("TextButton")

validate.Size = UDim2.new(1,-30,0,40)
validate.Position = UDim2.fromOffset(15,142)

validate.BackgroundColor3 = Color3.fromRGB(145,0,0)
validate.BorderSizePixel = 0

validate.Text = "VALIDAR KEY"

validate.TextColor3 = Color3.new(1,1,1)
validate.TextSize = 13
validate.Font = Enum.Font.GothamBold

validate.Parent = keyPage

corner(validate,7)

--==================================================
-- DISCORD
--==================================================

local discord = Instance.new("TextButton")

discord.Size = UDim2.new(1,-30,0,40)
discord.Position = UDim2.fromOffset(15,190)

discord.BackgroundColor3 = Color3.fromRGB(70,72,150)
discord.BorderSizePixel = 0

discord.Text = "COPIAR LINK DO DISCORD"

discord.TextColor3 = Color3.new(1,1,1)
discord.TextSize = 13
discord.Font = Enum.Font.GothamBold

discord.Parent = keyPage

corner(discord,7)

--==================================================
-- STATUS
--==================================================

local status = Instance.new("TextLabel")

status.Size = UDim2.new(1,-30,0,24)
status.Position = UDim2.fromOffset(15,238)

status.BackgroundTransparency = 1
status.Text = ""

status.TextSize = 12
status.Font = Enum.Font.Gotham

status.Parent = keyPage

--==================================================
-- DISCORD COPY
--==================================================

discord.Activated:Connect(function()

	if setclipboard then

		setclipboard(DISCORD_LINK)

		status.Text = "LINK COPIADO!"

	else

		status.Text = DISCORD_LINK

	end

	status.TextColor3 = Color3.fromRGB(180,185,255)

end)

--==================================================
-- DASHBOARD
--==================================================

local dashboard = Instance.new("Frame")

dashboard.Name = "Dashboard"

dashboard.Size = UDim2.fromOffset(620,370)
dashboard.Position = UDim2.new(0.5,-310,0.5,-185)

dashboard.BackgroundColor3 = Color3.fromRGB(8,8,10)
dashboard.BorderSizePixel = 0

dashboard.Visible = false
dashboard.ClipsDescendants = true

dashboard.Parent = gui

corner(dashboard,8)

stroke(
	dashboard,
	Color3.fromRGB(150,0,0),
	0.15,
	1
)

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")

header.Size = UDim2.new(1,0,0,46)
header.BackgroundColor3 = Color3.fromRGB(12,12,15)
header.BorderSizePixel = 0

header.Parent = dashboard

--==================================================
-- FOTO DO PLAYER
--==================================================

local playerIcon = Instance.new("ImageLabel")

playerIcon.Size = UDim2.fromOffset(34,34)
playerIcon.Position = UDim2.fromOffset(10,6)

playerIcon.BackgroundColor3 = Color3.fromRGB(155,0,0)
playerIcon.BorderSizePixel = 0

playerIcon.Parent = header

corner(playerIcon,9)

task.spawn(function()

	local success, image = pcall(function()

		return Players:GetUserThumbnailAsync(
			player.UserId,
			Enum.ThumbnailType.HeadShot,
			Enum.ThumbnailSize.Size100x100
		)

	end)

	if success then
		playerIcon.Image = image
	else
		playerIcon.Image = ICON_IMAGE
	end

end)

--==================================================
-- NOME DO PLAYER
--==================================================

local playerName = Instance.new("TextLabel")

playerName.Size = UDim2.fromOffset(130,18)
playerName.Position = UDim2.fromOffset(54,5)

playerName.BackgroundTransparency = 1

playerName.Text = player.DisplayName

playerName.TextColor3 = Color3.fromRGB(235,235,235)

playerName.TextSize = 11
playerName.Font = Enum.Font.GothamBold

playerName.TextXAlignment = Enum.TextXAlignment.Left

playerName.Parent = header

local playerUser = Instance.new("TextLabel")

playerUser.Size = UDim2.fromOffset(130,14)
playerUser.Position = UDim2.fromOffset(54,23)

playerUser.BackgroundTransparency = 1

playerUser.Text = "@" .. player.Name

playerUser.TextColor3 = Color3.fromRGB(105,105,115)

playerUser.TextSize = 8
playerUser.Font = Enum.Font.Gotham

playerUser.TextXAlignment = Enum.TextXAlignment.Left

playerUser.Parent = header

--==================================================
-- TÍTULO
--==================================================

local dashTitle = Instance.new("TextLabel")

dashTitle.Size = UDim2.fromOffset(180,46)
dashTitle.Position = UDim2.fromOffset(190,0)

dashTitle.BackgroundTransparency = 1

dashTitle.Text = "TXZZ 76 • PAINEL"

dashTitle.TextColor3 = Color3.fromRGB(230,230,235)

dashTitle.TextSize = 17
dashTitle.Font = Enum.Font.GothamBold

dashTitle.TextXAlignment = Enum.TextXAlignment.Left

dashTitle.Parent = header

--==================================================
-- MINIMIZAR
--==================================================

local minimizeButton = Instance.new("TextButton")

minimizeButton.Size = UDim2.fromOffset(30,30)
minimizeButton.Position = UDim2.new(1,-68,0,8)

minimizeButton.BackgroundColor3 = Color3.fromRGB(45,45,52)
minimizeButton.BorderSizePixel = 0

minimizeButton.Text = "—"

minimizeButton.TextColor3 = Color3.new(1,1,1)
minimizeButton.TextSize = 15
minimizeButton.Font = Enum.Font.GothamBold

minimizeButton.Parent = header

corner(minimizeButton,7)

--==================================================
-- FECHAR
--==================================================

local closeButton = Instance.new("TextButton")

closeButton.Size = UDim2.fromOffset(30,30)
closeButton.Position = UDim2.new(1,-34,0,8)

closeButton.BackgroundColor3 = Color3.fromRGB(125,20,25)
closeButton.BorderSizePixel = 0

closeButton.Text = "X"

closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.TextSize = 12
closeButton.Font = Enum.Font.GothamBold

closeButton.Parent = header

corner(closeButton,7)

--==================================================
-- BOTÃO TXZZ FLUTUANTE
--==================================================

local mobileButton = Instance.new("ImageButton")

mobileButton.Name = "TXZZOpenButton"

mobileButton.Size = UDim2.fromOffset(58,58)
mobileButton.Position = UDim2.fromOffset(15,90)

mobileButton.BackgroundColor3 = Color3.fromRGB(145,0,0)
mobileButton.BorderSizePixel = 0

mobileButton.Image = ICON_IMAGE
mobileButton.ScaleType = Enum.ScaleType.Crop

mobileButton.Visible = false

mobileButton.Parent = gui

corner(mobileButton,12)

stroke(
	mobileButton,
	Color3.fromRGB(220,30,30),
	0.1,
	1
)

--==================================================
-- TEXTO TXZZ
--==================================================

local txzzText = Instance.new("TextLabel")

txzzText.Size = UDim2.new(1,0,0,14)
txzzText.Position = UDim2.new(0,0,1,-15)

txzzText.BackgroundColor3 = Color3.fromRGB(0,0,0)
txzzText.BackgroundTransparency = 0.25

txzzText.Text = "TXZZ"

txzzText.TextColor3 = Color3.new(1,1,1)

txzzText.TextSize = 8
txzzText.Font = Enum.Font.GothamBold

txzzText.Parent = mobileButton

corner(txzzText,5)

--==================================================
-- BOTÃO FLUTUANTE ARRASTÁVEL
--==================================================

makeDraggable(mobileButton, mobileButton)

--==================================================
-- SIDEBAR
--==================================================

local sidebar = Instance.new("Frame")

sidebar.Size = UDim2.fromOffset(150,310)
sidebar.Position = UDim2.fromOffset(10,54)

sidebar.BackgroundColor3 = Color3.fromRGB(10,10,13)
sidebar.BorderSizePixel = 0

sidebar.Parent = dashboard

corner(sidebar,6)

local sideTitle = Instance.new("TextLabel")

sideTitle.Size = UDim2.new(1,-14,0,25)
sideTitle.Position = UDim2.fromOffset(7,6)

sideTitle.BackgroundTransparency = 1

sideTitle.Text = "MENU"

sideTitle.TextColor3 = Color3.fromRGB(110,110,120)

sideTitle.TextSize = 10
sideTitle.Font = Enum.Font.GothamBold

sideTitle.TextXAlignment = Enum.TextXAlignment.Left

sideTitle.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")

sideLayout.Padding = UDim.new(0,4)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder

sideLayout.Parent = sidebar

sideTitle.LayoutOrder = 0

--==================================================
-- CATEGORIAS
--==================================================

local function category(text, order)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1,-12,0,32)

	button.BackgroundColor3 = Color3.fromRGB(18,18,22)
	button.BorderSizePixel = 0

	button.Text = "  " .. text

	button.TextColor3 = Color3.fromRGB(190,190,195)

	button.TextSize = 10
	button.Font = Enum.Font.GothamSemibold

	button.TextXAlignment = Enum.TextXAlignment.Left

	button.LayoutOrder = order

	button.Parent = sidebar

	corner(button,5)

	return button

end

local home = category("MAIN",1)
local rivals = category("RIVALS",2)
local morteNegra = category("MORTE NEGRA",3)
local settings = category("SETTINGS",4)

--==================================================
-- CONTEÚDO
--==================================================

local content = Instance.new("Frame")

content.Size = UDim2.new(1,-170,1,-64)
content.Position = UDim2.fromOffset(160,54)

content.BackgroundColor3 = Color3.fromRGB(12,12,15)
content.BorderSizePixel = 0

content.Parent = dashboard

corner(content,6)

local pageTitle = Instance.new("TextLabel")

pageTitle.Size = UDim2.new(1,-20,0,28)
pageTitle.Position = UDim2.fromOffset(10,7)

pageTitle.BackgroundTransparency = 1

pageTitle.Text = "MAIN"

pageTitle.TextColor3 = Color3.fromRGB(235,235,235)

pageTitle.TextSize = 14
pageTitle.Font = Enum.Font.GothamBold

pageTitle.TextXAlignment = Enum.TextXAlignment.Left

pageTitle.Parent = content

local pageInfo = Instance.new("TextLabel")

pageInfo.Size = UDim2.new(1,-20,0,18)
pageInfo.Position = UDim2.fromOffset(10,32)

pageInfo.BackgroundTransparency = 1

pageInfo.Text = "Painel TXZZ • PC + CELULAR"

pageInfo.TextColor3 = Color3.fromRGB(110,110,120)

pageInfo.TextSize = 10
pageInfo.Font = Enum.Font.Gotham

pageInfo.TextXAlignment = Enum.TextXAlignment.Left

pageInfo.Parent = content

--==================================================
-- OPÇÕES
--==================================================

local options = Instance.new("ScrollingFrame")

options.Size = UDim2.new(1,-20,1,-58)
options.Position = UDim2.fromOffset(10,54)

options.BackgroundTransparency = 1
options.BorderSizePixel = 0

options.ScrollBarThickness = 3

options.CanvasSize = UDim2.new()

options.Parent = content

local optionLayout = Instance.new("UIListLayout")

optionLayout.Padding = UDim.new(0,6)
optionLayout.Parent = options

optionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

	options.CanvasSize = UDim2.fromOffset(
		0,
		optionLayout.AbsoluteContentSize.Y + 8
	)

end)

--==================================================
-- LIMPAR OPÇÕES
--==================================================

local function clearOptions()

	for _, child in ipairs(options:GetChildren()) do

		if child:IsA("Frame") then
			child:Destroy()
		end

	end

end

--==================================================
-- ADICIONAR OPÇÃO
--==================================================

local function addOption(titleText, descText)

	local row = Instance.new("Frame")

	row.Size = UDim2.new(1,-4,0,48)

	row.BackgroundColor3 = Color3.fromRGB(18,18,22)
	row.BorderSizePixel = 0

	row.Parent = options

	corner(row,5)

	local title = Instance.new("TextLabel")

	title.Size = UDim2.new(1,-70,0,18)
	title.Position = UDim2.fromOffset(9,5)

	title.BackgroundTransparency = 1

	title.Text = titleText

	title.TextColor3 = Color3.fromRGB(220,220,225)

	title.TextSize = 11
	title.Font = Enum.Font.GothamSemibold

	title.TextXAlignment = Enum.TextXAlignment.Left

	title.Parent = row

	local desc = Instance.new("TextLabel")

	desc.Size = UDim2.new(1,-78,0,14)
	desc.Position = UDim2.fromOffset(9,24)

	desc.BackgroundTransparency = 1

	desc.Text = descText

	desc.TextColor3 = Color3.fromRGB(105,105,115)

	desc.TextSize = 9
	desc.Font = Enum.Font.Gotham

	desc.TextXAlignment = Enum.TextXAlignment.Left

	desc.Parent = row

	local button = Instance.new("TextButton")

	button.Size = UDim2.fromOffset(45,22)
	button.Position = UDim2.new(1,-54,0.5,-11)

	button.BackgroundColor3 = Color3.fromRGB(45,45,52)
	button.BorderSizePixel = 0

	button.Text = states[titleText] and "ON" or "OFF"

	button.TextColor3 = states[titleText]
		and Color3.new(1,1,1)
		or Color3.fromRGB(170,170,175)

	button.TextSize = 9
	button.Font = Enum.Font.GothamBold

	button.Parent = row

	corner(button,11)

	if states[titleText] then

		button.BackgroundColor3 =
			Color3.fromRGB(150,0,0)

	end

	button.Activated:Connect(function()

		states[titleText] =
			not states[titleText]

		if states[titleText] then

			button.Text = "ON"

			button.BackgroundColor3 =
				Color3.fromRGB(150,0,0)

			button.TextColor3 =
				Color3.new(1,1,1)

		else

			button.Text = "OFF"

			button.BackgroundColor3 =
				Color3.fromRGB(45,45,52)

			button.TextColor3 =
				Color3.fromRGB(170,170,175)

		end

	end)

end

--==================================================
-- MOSTRAR PÁGINA
--==================================================

local function showPage(titleText,infoText,list)

	pageTitle.Text = titleText
	pageInfo.Text = infoText

	clearOptions()

	for _, item in ipairs(list) do

		addOption(
			item[1],
			item[2]
		)

	end

	options.CanvasPosition =
		Vector2.new(0,0)

end

--==================================================
-- MAIN
--==================================================

home.Activated:Connect(function()

	showPage(
		"MAIN",
		"Informações do painel",
		{

			{
				"Status",
				"Painel TXZZ carregado."
			},

			{
				"Jogador",
				player.DisplayName
			},

			{
				"Usuário",
				"@" .. player.Name
			},

			{
				"Key",
				"Validade de 24 horas."
			},

			{
				"Plataforma",
				"PC + Celular."
			}

		}
	)

end)

--==================================================
-- RIVALS
--==================================================

rivals.Activated:Connect(function()

	showPage(
		"RIVALS",
		"Todas as opções começam OFF",
		{

			{
				"Mira Cabeça",
				"Recurso do seu próprio jogo."
			},

			{
				"Priorizar Cabeça",
				"Prioridade do alvo."
			},

			{
				"Atravessa Parede",
				"Configuração visual autorizada."
			},

			{
				"Pulo Alto",
				"Controle de pulo."
			},

			{
				"Pulo Duplo",
				"Segundo salto."
			},

			{
				"Pulo Triplo",
				"Terceiro salto."
			},

			{
				"Sem Dano Queda",
				"Proteção contra queda."
			},

			{
				"Anti Empurrão",
				"Controle de física."
			},

			{
				"Linhas ESP",
				"Visualização do próprio jogo."
			},

			{
				"Caixa Corpo",
				"Caixa visual."
			},

			{
				"Nome + Vida",
				"Informações do jogador."
			}

		}
	)

end)

--==================================================
-- MORTE NEGRA
--==================================================

morteNegra.Activated:Connect(function()

	showPage(
		"MORTE NEGRA",
		"Todas as opções começam OFF",
		{

			{
				"Sem Dano",
				"Proteção implementada pelo seu jogo."
			},

			{
				"Habilidades Infinitas",
				"Controle das habilidades."
			},

			{
				"Gruda e Não Desgruda",
				"Sistema de alvo."
			},

			{
				"AFK Matador",
				"Automação do próprio jogo."
			},

			{
				"Voar",
				"Sistema de voo."
			},

			{
				"Velocidade",
				"Velocidade configurável."
			},

			{
				"Super Pulo",
				"Pulo aumentado."
			},

			{
				"Linhas Inimigo",
				"Visualização dos inimigos."
			},

			{
				"Caixa Corpo MN",
				"Caixa visual."
			},

			{
				"Mostrar Nome",
				"Nome do jogador."
			},

			{
				"Mostrar Vida",
				"Barra de vida."
			}

		}
	)

end)

--==================================================
-- SETTINGS
--==================================================

settings.Activated:Connect(function()

	showPage(
		"SETTINGS",
		"Configurações do painel",
		{

			{
				"Notificações",
				"Ativar notificações."
			},

			{
				"Animações",
				"Ativar animações."
			},

			{
				"Modo Compacto",
				"Reduzir tamanho do painel."
			}

		}
	)

end)

--==================================================
-- ARRASTAR PAINEL
--==================================================

makeDraggable(
	dashboard,
	header
)

--==================================================
-- ARRASTAR KEY
--==================================================

makeDraggable(
	keyPage,
	keyHeader
)

--==================================================
-- ABRIR BOTÃO TXZZ
--==================================================

mobileButton.Activated:Connect(function()

	dashboard.Visible = true
	mobileButton.Visible = false

end)

--==================================================
-- MINIMIZAR PAINEL
--==================================================

minimizeButton.Activated:Connect(function()

	dashboard.Visible = false
	mobileButton.Visible = true

end)

--==================================================
-- FECHAR PAINEL
--==================================================

closeButton.Activated:Connect(function()

	dashboard.Visible = false
	mobileButton.Visible = true

end)

--==================================================
-- MINIMIZAR KEY
--==================================================

keyMinimize.Activated:Connect(function()

	keyPage.Visible = false
	mobileButton.Visible = true

end)

--==================================================
-- FECHAR KEY
--==================================================

keyClose.Activated:Connect(function()

	keyPage.Visible = false
	mobileButton.Visible = true

end)

--==================================================
-- ABRIR DASHBOARD
--==================================================

local function openDashboard()

	keyPage.Visible = false
	dashboard.Visible = true
	mobileButton.Visible = false

	showPage(
		"MAIN",
		"Informações do painel",
		{

			{
				"Status",
				"Painel TXZZ carregado."
			},

			{
				"Jogador",
				player.DisplayName
			},

			{
				"Usuário",
				"@" .. player.Name
			},

			{
				"Key",
				"Validade de 24 horas."
			},

			{
				"Plataforma",
				"PC + Celular."
			}

		}
	)

end

--==================================================
-- VALIDAR KEY
--==================================================

validate.Activated:Connect(function()

	local enteredKey =
		keyBox.Text:gsub(
			"^%s*(.-)%s*$",
			"%1"
		)

	if enteredKey == KEY_CORRETA then

		keyExpiresAt =
			os.time() + KEY_DURATION

		status.Text =
			"KEY VÁLIDA! 24 HORAS"

		status.TextColor3 =
			Color3.fromRGB(0,255,120)

		task.wait(0.5)

		openDashboard()

	else

		status.Text =
			"KEY INVÁLIDA!"

		status.TextColor3 =
			Color3.fromRGB(255,60,60)

	end

end)

--==================================================
-- ANIMAÇÃO INICIAL
--==================================================

local originalSize = keyPage.Size

keyPage.Size =
	UDim2.fromOffset(0,0)

animate(
	keyPage,
	0.4,
	{
		Size = originalSize
	}
)

--==================================================
-- INICIAL
--==================================================

showPage(
	"MAIN",
	"Informações do painel",
	{

		{
			"Status",
			"Aguardando validação da key."
		},

		{
			"Jogador",
			player.DisplayName
		},

		{
			"Usuário",
			"@" .. player.Name
		},

		{
			"Plataforma",
			"PC + Celular."
		}

	}
)

print("====================================")
print("TXZZ 76 • PAINEL")
print("PC + CELULAR")
print("KEY SYSTEM ATIVO")
print("RIVALS: OFF")
print("MORTE NEGRA: OFF")
print("====================================")
