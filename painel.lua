--========================================================--
-- TXZZ 76 • MULTI GAME PANEL V8
-- ROBLOX STUDIO • LOCALSCRIPT
-- KEY + DISCORD + PERFIL + DATA/HORA + JOGOS + FPS BOOSTER
-- + AIMBOT PLAYER + FOV + HITBOX + LOGO ABRIR/FECHAR
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local DISCORD_LINK = "https://discord.gg/VBaUJPre49"
local LOGO_ID = "rbxassetid://134571219107537"
local KEY_CORRETA = "TXZZ-TESTE-123"

--========================================================--
-- AIMBOT / FOV / HITBOX
--========================================================--

local aimbotEnabled = false
local fovVisible = true

local fovSize = 120
local hitboxSize = 6

local currentAimTarget = nil
local playerHitboxes = {}

local fovCircle
local mainPanel
local launcher

--========================================================--
-- LIMPAR VERSÃO ANTERIOR
--========================================================--

local old = playerGui:FindFirstChild("TXZZ76_V8")

if old then
	old:Destroy()
end

local oldV7 = playerGui:FindFirstChild("TXZZ76_V7")

if oldV7 then
	oldV7:Destroy()
end

--========================================================--
-- SCREEN GUI
--========================================================--

local gui = Instance.new("ScreenGui")
gui.Name = "TXZZ76_V8"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

--========================================================--
-- CORES
--========================================================--

local BG = Color3.fromRGB(13, 15, 22)
local PANEL = Color3.fromRGB(19, 22, 31)
local CARD = Color3.fromRGB(23, 27, 38)

local BLUE = Color3.fromRGB(0, 160, 245)
local BLUE2 = Color3.fromRGB(45, 110, 235)

local TEXT = Color3.fromRGB(245, 245, 250)
local SUB = Color3.fromRGB(145, 150, 165)

local RED = Color3.fromRGB(160, 45, 55)
local GREEN = Color3.fromRGB(40, 150, 85)

--========================================================--
-- ESTADO DA KEY
--========================================================--

local keyVerified = false
local keyVerifiedAt = ""

--========================================================--
-- HELPERS
--========================================================--

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

--========================================================--
-- NOTIFICAÇÕES
--========================================================--

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

	task.delay(3, function()
		if n and n.Parent then
			n:Destroy()
		end
	end)
end

--========================================================--
-- DRAG
--========================================================--

local function makeDraggable(window, bar)

	bar.Active = true

	local dragging = false
	local dragStart
	local startPosition

	bar.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPosition = window.Position

			input.Changed:Connect(function()

				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end

			end)
		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if not dragging then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local delta = input.Position - dragStart

		window.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

	end)

end

--========================================================--
-- JANELA
--========================================================--

local function createWindow(width, height, titleText)

	local window = Instance.new("Frame")

	window.Size = UDim2.new(0, width, 0, height)
	window.Position = UDim2.new(0.5, 0, 0.5, 0)
	window.AnchorPoint = Vector2.new(0.5, 0.5)

	window.BackgroundColor3 = BG
	window.BorderSizePixel = 0
	window.Active = true

	window.Parent = gui

	addCorner(window, 12)
	addStroke(window)

	-- TOP BAR

	local top = Instance.new("Frame")

	top.Size = UDim2.new(1, 0, 0, 42)

	top.BackgroundColor3 = PANEL
	top.BorderSizePixel = 0
	top.Active = true

	top.Parent = window

	addCorner(top, 12)

	-- TÍTULO

	local title = label(
		top,
		titleText,
		UDim2.new(1, -115, 1, 0),
		UDim2.new(0, 14, 0, 0),
		13,
		TEXT
	)

	title.Font = Enum.Font.GothamBold

	-- MINIMIZAR

	local minimize = button(
		top,
		"—",
		UDim2.new(0, 32, 0, 30),
		UDim2.new(1, -70, 0, 6),
		Color3.fromRGB(42, 46, 58)
	)

	-- FECHAR

	local close = button(
		top,
		"×",
		UDim2.new(0, 32, 0, 30),
		UDim2.new(1, -34, 0, 6),
		RED
	)

	-- CONTEÚDO

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

			TweenService:Create(
				window,
				TweenInfo.new(0.18),
				{
					Size = UDim2.new(0, width, 0, 42)
				}
			):Play()

		else

			TweenService:Create(
				window,
				TweenInfo.new(0.18),
				{
					Size = normalSize
				}
			):Play()

			task.delay(0.12, function()

				if window.Parent then
					content.Visible = true
				end

			end)
		end

	end)

	close.MouseButton1Click:Connect(function()

		--================================================--
		-- NO PAINEL PRINCIPAL:
		-- ESCONDE, NÃO DESTROI
		--================================================--

		if window == mainPanel then
			window.Visible = false

			if launcher then
				launcher.Visible = true
			end

		else
			window:Destroy()
		end

	end)

	makeDraggable(window, top)

	return window, content
end

--========================================================--
-- FPS BOOSTER
--========================================================--

local fpsBoostEnabled = false
local savedEffects = {}

local function saveObject(object)

	if savedEffects[object] then
		return
	end

	if object:IsA("ParticleEmitter")
		or object:IsA("Trail")
		or object:IsA("Beam")
		or object:IsA("Smoke")
		or object:IsA("Fire")
		or object:IsA("Sparkles") then

		savedEffects[object] = {
			Enabled = object.Enabled
		}

	end

end

local function setPerformance(enabled)

	if enabled then

		if fpsBoostEnabled then
			return
		end

		fpsBoostEnabled = true

		for _, obj in ipairs(workspace:GetDescendants()) do

			if obj:IsA("ParticleEmitter")
				or obj:IsA("Trail")
				or obj:IsA("Beam")
				or obj:IsA("Smoke")
				or obj:IsA("Fire")
				or obj:IsA("Sparkles") then

				saveObject(obj)

				pcall(function()
					obj.Enabled = false
				end)

			end

		end

		for _, obj in ipairs(Lighting:GetChildren()) do

			if obj:IsA("PostEffect") then

				if not savedEffects[obj] then
					savedEffects[obj] = {
						Enabled = obj.Enabled
					}
				end

				pcall(function()
					obj.Enabled = false
				end)

			end

		end

		pcall(function()
			Lighting.GlobalShadows = false
		end)

		notify("⚡ FPS Booster ativado!")

	else

		fpsBoostEnabled = false

		for obj, data in pairs(savedEffects) do

			if obj and obj.Parent then

				pcall(function()
					obj.Enabled = data.Enabled
				end)

			end

		end

		savedEffects = {}

		pcall(function()
			Lighting.GlobalShadows = true
		end)

		notify("♻️ Gráficos restaurados.")

	end

end

--========================================================--
-- KEY WINDOW
--========================================================--

local keyWindow, keyContent = createWindow(
	370,
	330,
	"TXZZ 76 • KEY SYSTEM"
)

-- LOGO

local logo = Instance.new("ImageLabel")

logo.BackgroundTransparency = 1

logo.Size = UDim2.new(0, 58, 0, 58)
logo.Position = UDim2.new(1, -72, 0, 48)

logo.Image = LOGO_ID
logo.ScaleType = Enum.ScaleType.Fit

logo.Parent = keyContent

-- TÍTULO

local keyTitle = label(
	keyContent,
	"🔐 Digite sua Key",
	UDim2.new(1, -85, 0, 30),
	UDim2.new(0, 15, 0, 15),
	18,
	TEXT
)

keyTitle.Font = Enum.Font.GothamBold

label(
	keyContent,
	"Pegue sua Key no Discord e cole abaixo.",
	UDim2.new(1, -30, 0, 25),
	UDim2.new(0, 15, 0, 48),
	11,
	SUB
)

-- KEY BOX

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

-- VERIFICAR

local verify = button(
	keyContent,
	"✓ VERIFICAR KEY",
	UDim2.new(1, -30, 0, 40),
	UDim2.new(0, 15, 0, 130),
	BLUE2
)

-- DISCORD

local discord = button(
	keyContent,
	"💬 PEGAR KEY NO DISCORD",
	UDim2.new(1, -30, 0, 38),
	UDim2.new(0, 15, 0, 178),
	Color3.fromRGB(65, 75, 150)
)

-- LINK

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

--========================================================--
-- SELETOR DE JOGO
--========================================================--

local function openSelector()

	if keyWindow and keyWindow.Parent then
		keyWindow:Destroy()
	end

	local selector, content = createWindow(
		590,
		430,
		"TXZZ 76 • SELECIONAR JOGO"
	)

	-- PESQUISA

	local search = Instance.new("TextBox")

	search.Size = UDim2.new(1, -30, 0, 38)
	search.Position = UDim2.new(0, 15, 0, 12)

	search.BackgroundColor3 = CARD
	search.BorderSizePixel = 0

	search.PlaceholderText = "🔎 Pesquisar jogo..."
	search.PlaceholderColor3 = SUB

	search.Text = ""
	search.TextColor3 = TEXT

	search.TextSize = 12
	search.Font = Enum.Font.Gotham

	search.ClearTextOnFocus = false

	search.Parent = content

	addCorner(search, 8)
	addStroke(search)

	-- SCROLL

	local scroll = Instance.new("ScrollingFrame")

	scroll.Size = UDim2.new(1, -30, 1, -65)
	scroll.Position = UDim2.new(0, 15, 0, 58)

	scroll.BackgroundTransparency = 1
	scroll.BorderSizePixel = 0

	scroll.ScrollBarThickness = 4

	scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

	scroll.Parent = content

	-- GRID

	local grid = Instance.new("UIGridLayout")

	grid.CellSize = UDim2.new(0.5, -6, 0, 70)

	grid.CellPadding = UDim2.new(0, 10, 0, 10)

	grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
	grid.SortOrder = Enum.SortOrder.LayoutOrder

	grid.Parent = scroll

	--====================================================--
	-- JOGOS
	--====================================================--

	local games = {

		{"🍎", "Blox Fruits"},
		{"🔫", "RIVALS"},
		{"☠️", "Morte Negra"},
		{"⛏️", "Quebre um Bloco"},
		{"⚔️", "TXZZ PVP"},
		{"🎮", "Outro Jogo"}

	}

	local items = {}

	--====================================================--
	-- CRIAR JOGOS
	--====================================================--

	for index, data in ipairs(games) do

		local gameButton = Instance.new("TextButton")

		gameButton.BackgroundColor3 = CARD
		gameButton.BorderSizePixel = 0

		gameButton.Text = ""

		gameButton.LayoutOrder = index

		gameButton.Parent = scroll

		addCorner(gameButton, 9)
		addStroke(gameButton)

		-- ÍCONE

		local icon = label(
			gameButton,
			data[1],
			UDim2.new(0, 45, 1, 0),
			UDim2.new(0, 5, 0, 0),
			24,
			TEXT
		)

		icon.TextXAlignment = Enum.TextXAlignment.Center

		-- NOME

		local gameName = label(
			gameButton,
			data[2],
			UDim2.new(1, -58, 0, 25),
			UDim2.new(0, 55, 0, 10),
			13,
			TEXT
		)

		gameName.Font = Enum.Font.GothamBold

		-- SUB

		label(
			gameButton,
			"Selecionar",
			UDim2.new(1, -58, 0, 20),
			UDim2.new(0, 55, 0, 36),
			10,
			SUB
		)

		table.insert(items, {
			button = gameButton,
			name = string.lower(data[2])
		})

		--================================================--
		-- SELECIONAR
		--================================================--

		gameButton.MouseButton1Click:Connect(function()

			selector:Destroy()

			local loading, loadingContent = createWindow(
				380,
				195,
				"TXZZ 76 • CARREGANDO"
			)

			label(
				loadingContent,
				"Carregando " .. data[2],
				UDim2.new(1, -30, 0, 30),
				UDim2.new(0, 15, 0, 18),
				16,
				TEXT
			).Font = Enum.Font.GothamBold

			-- BARRA

			local back = Instance.new("Frame")

			back.Size = UDim2.new(1, -30, 0, 14)
			back.Position = UDim2.new(0, 15, 0, 68)

			back.BackgroundColor3 = Color3.fromRGB(32, 36, 48)
			back.BorderSizePixel = 0

			back.Parent = loadingContent

			addCorner(back, 7)

			local fill = Instance.new("Frame")

			fill.Size = UDim2.new(0, 0, 1, 0)

			fill.BackgroundColor3 = BLUE
			fill.BorderSizePixel = 0

			fill.Parent = back

			addCorner(fill, 7)

			-- PORCENTAGEM

			local percent = label(
				loadingContent,
				"0%",
				UDim2.new(1, 0, 0, 25),
				UDim2.new(0, 0, 0, 95),
				12,
				SUB
			)

			percent.TextXAlignment = Enum.TextXAlignment.Center

			--================================================--
			-- LOADING
			--================================================--

			task.spawn(function()

				for i = 0, 100, 5 do

					if not loading.Parent then
						return
					end

					percent.Text = i .. "%"

					TweenService:Create(
						fill,
						TweenInfo.new(0.07),
						{
							Size = UDim2.new(i / 100, 0, 1, 0)
						}
					):Play()

					task.wait(0.07)

				end

				task.wait(0.25)

				if loading and loading.Parent then
					loading:Destroy()
				end

				--================================================--
				-- PAINEL PRINCIPAL
				--================================================--

				local main, mainContent = createWindow(
					720,
					470,
					"TXZZ 76 • " .. data[2]
				)

				mainPanel = main
				main:SetAttribute("TXZZ_MainPanel", true)

				--================================================--
				-- SIDEBAR
				--================================================--

				local sidebar = Instance.new("Frame")

				sidebar.Size = UDim2.new(0, 170, 1, 0)

				sidebar.BackgroundColor3 = PANEL
				sidebar.BorderSizePixel = 0

				sidebar.Parent = mainContent

				addCorner(sidebar, 10)

				local sideTitle = label(
					sidebar,
					"TXZZ 76",
					UDim2.new(1, -20, 0, 30),
					UDim2.new(0, 10, 0, 12),
					19,
					TEXT
				)

				sideTitle.Font = Enum.Font.GothamBlack

				label(
					sidebar,
					data[2],
					UDim2.new(1, -20, 0, 25),
					UDim2.new(0, 10, 0, 42),
					10,
					Color3.fromRGB(85, 150, 255)
				).Font = Enum.Font.GothamBold

				--================================================--
				-- ÁREA DAS PÁGINAS
				--================================================--

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
				local gamePage = createPage("Jogo")
				local settings = createPage("Configuracoes")
				local dcPage = createPage("Discord")

				home.Visible = true

				--================================================--
				-- TÍTULOS
				--================================================--

				local function pageTitle(page, titleText, subtitle)

					local t = label(
						page,
						titleText,
						UDim2.new(1, -20, 0, 30),
						UDim2.new(0, 10, 0, 10),
						19,
						TEXT
					)

					t.Font = Enum.Font.GothamBold

					label(
						page,
						subtitle,
						UDim2.new(1, -20, 0, 25),
						UDim2.new(0, 10, 0, 42),
						10,
						SUB
					)

				end

				pageTitle(
					home,
					"Painel principal",
					"Bem-vindo ao TXZZ 76."
				)

				pageTitle(
					fps,
					"⚡ FPS Booster",
					"Modo de desempenho para PC e celular."
				)

				pageTitle(
					gamePage,
					"🎮 Jogo",
					"Opções disponíveis para esta experiência."
				)

				pageTitle(
					settings,
					"⚙ Configurações",
					"Configurações do painel."
				)

				pageTitle(
					dcPage,
					"💬 Discord",
					"Servidor oficial do TXZZ 76."
				)

				--================================================--
				-- PERFIL
				--================================================--

				local profile = Instance.new("Frame")

				profile.Name = "PlayerProfile"

				profile.Size = UDim2.new(1, -20, 0, 125)
				profile.Position = UDim2.new(0, 10, 0, 75)

				profile.BackgroundColor3 = Color3.fromRGB(18, 21, 30)
				profile.BorderSizePixel = 0

				profile.Parent = home

				addCorner(profile, 10)
				addStroke(profile)

				-- FAIXA AZUL

				local blueTop = Instance.new("Frame")

				blueTop.Size = UDim2.new(1, 0, 0, 28)

				blueTop.BackgroundColor3 = BLUE
				blueTop.BorderSizePixel = 0

				blueTop.Parent = profile

				addCorner(blueTop, 10)

				-- AVATAR

				local avatar = Instance.new("ImageLabel")

				avatar.Size = UDim2.new(0, 62, 0, 62)

				avatar.Position = UDim2.new(0, 12, 0, 22)

				avatar.BackgroundColor3 = Color3.fromRGB(28, 32, 43)
				avatar.BorderSizePixel = 0

				avatar.Parent = profile

				addCorner(avatar, 31)

				task.spawn(function()

					local success, image = pcall(function()

						return Players:GetUserThumbnailAsync(
							player.UserId,
							Enum.ThumbnailType.HeadShot,
							Enum.ThumbnailSize.Size150x150
						)

					end)

					if success and image then
						avatar.Image = image
					end

				end)

				-- NOME

				local playerName = label(
					profile,
					player.DisplayName,
					UDim2.new(1, -100, 0, 23),
					UDim2.new(0, 88, 0, 34),
					15,
					TEXT
				)

				playerName.Font = Enum.Font.GothamBold

				-- USERNAME

				label(
					profile,
					"@" .. player.Name,
					UDim2.new(1, -100, 0, 18),
					UDim2.new(0, 88, 0, 57),
					10,
					SUB
				)

				-- STATUS KEY

				local keyStatus = Instance.new("Frame")

				keyStatus.Size = UDim2.new(1, -24, 0, 27)
				keyStatus.Position = UDim2.new(0, 12, 0, 90)

				keyStatus.BackgroundColor3 = Color3.fromRGB(13, 16, 24)
				keyStatus.BorderSizePixel = 0

				keyStatus.Parent = profile

				addCorner(keyStatus, 6)

				local keyText = label(
					keyStatus,
					"",
					UDim2.new(1, -15, 1, 0),
					UDim2.new(0, 8, 0, 0),
					10,
					TEXT
				)

				keyText.Font = Enum.Font.GothamBold

				if keyVerified then

					keyText.Text =
						"🔑 Lifetime Key  •  Verificada em " .. keyVerifiedAt

					keyText.TextColor3 = Color3.fromRGB(80, 220, 130)

				else

					keyText.Text =
						"🔑 Lifetime Key  •  Aguardando verificação"

				end

				--================================================--
				-- HOME CARDS
				--================================================--

				local function infoCard(parent, text, sub, y)

					local card = Instance.new("Frame")

					card.Size = UDim2.new(1, -20, 0, 55)
					card.Position = UDim2.new(0, 10, 0, y)

					card.BackgroundColor3 = CARD
					card.BorderSizePixel = 0

					card.Parent = parent

					addCorner(card, 8)
					addStroke(card)

					local a = label(
						card,
						text,
						UDim2.new(1, -20, 0, 23),
						UDim2.new(0, 10, 0, 5),
						12,
						TEXT
					)

					a.Font = Enum.Font.GothamBold

					label(
						card,
						sub,
						UDim2.new(1, -20, 0, 20),
						UDim2.new(0, 10, 0, 29),
						9,
						SUB
					)

				end

				infoCard(
					home,
					"🎮 Jogo selecionado",
					data[2],
					210
				)

				infoCard(
					home,
					"⚡ FPS Booster",
					"PC + Celular",
					273
				)

				--================================================--
				-- FPS
				--================================================--

				local fpsStatus = label(
					fps,
					"Status: DESATIVADO",
					UDim2.new(1, -20, 0, 30),
					UDim2.new(0, 10, 0, 82),
					13,
					SUB
				)

				fpsStatus.Font = Enum.Font.GothamBold

				local fpsButton = button(
					fps,
					"⚡ ATIVAR FPS BOOSTER",
					UDim2.new(1, -20, 0, 45),
					UDim2.new(0, 10, 0, 120),
					BLUE2
				)

				fpsButton.MouseButton1Click:Connect(function()

					setPerformance(not fpsBoostEnabled)

					if fpsBoostEnabled then

						fpsButton.Text = "♻️ RESTAURAR GRÁFICOS"
						fpsButton.BackgroundColor3 = GREEN

						fpsStatus.Text =
							"Status: ATIVADO"

					else

						fpsButton.Text =
							"⚡ ATIVAR FPS BOOSTER"

						fpsButton.BackgroundColor3 =
							BLUE2

						fpsStatus.Text =
							"Status: DESATIVADO"

					end

				end)

				-- INFO FPS

				local fpsInfo = Instance.new("Frame")

				fpsInfo.Size = UDim2.new(1, -20, 0, 125)
				fpsInfo.Position = UDim2.new(0, 10, 0, 180)

				fpsInfo.BackgroundColor3 = CARD
				fpsInfo.BorderSizePixel = 0

				fpsInfo.Parent = fps

				addCorner(fpsInfo, 8)

				local fpsInfoTitle = label(
					fpsInfo,
					"🚀 O que o Booster faz",
					UDim2.new(1, -20, 0, 25),
					UDim2.new(0, 10, 0, 8),
					12,
					TEXT
				)

				fpsInfoTitle.Font = Enum.Font.GothamBold

				label(
					fpsInfo,
					"• Desativa partículas\n• Desativa efeitos pesados\n• Desativa pós-processamento\n• Desativa sombras globais\n• Ajuda dispositivos fracos",
					UDim2.new(1, -20, 1, -38),
					UDim2.new(0, 10, 0, 34),
					10,
					SUB
				)

				-- CONTADOR FPS

				local fpsCounter = label(
					fps,
					"FPS: calculando...",
					UDim2.new(1, -20, 0, 25),
					UDim2.new(0, 10, 1, -35),
					11,
					Color3.fromRGB(100, 160, 255)
				)

				fpsCounter.TextXAlignment =
					Enum.TextXAlignment.Right

				local frames = 0
				local lastTime = os.clock()

				RunService.RenderStepped:Connect(function()

					if not fps.Parent then
						return
					end

					frames += 1

					local now = os.clock()

					if now - lastTime >= 1 then

						fpsCounter.Text =
							"FPS: " .. frames

						frames = 0
						lastTime = now

					end

				end)

				--================================================--
				-- JOGO
				--================================================--

				local gameOption1 = button(
					gamePage,
					"🎮 Opção 1  [OFF]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 85),
					CARD
				)

				local gameOption2 = button(
					gamePage,
					"🎯 Opção 2  [OFF]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 137),
					CARD
				)

				local gameOption3 = button(
					gamePage,
					"⚙ Opção 3  [OFF]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 189),
					CARD
				)

				local function toggleButton(btn, text)

					local active = false

					btn.MouseButton1Click:Connect(function()

						active = not active

						if active then

							btn.Text =
								text .. "  [ON]"

							btn.BackgroundColor3 =
								GREEN

						else

							btn.Text =
								text .. "  [OFF]"

							btn.BackgroundColor3 =
								CARD

						end

					end)

				end

				toggleButton(
					gameOption1,
					"🎮 Opção 1"
				)

				toggleButton(
					gameOption2,
					"🎯 Opção 2"
				)

				toggleButton(
					gameOption3,
					"⚙ Opção 3"
				)

				--================================================--
				-- AIMBOT
				--================================================--

				local aimbotButton = button(
					gamePage,
					"🎯 Aimbot Player  [OFF]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 241),
					CARD
				)

				aimbotButton.MouseButton1Click:Connect(function()

					aimbotEnabled = not aimbotEnabled

					if aimbotEnabled then

						aimbotButton.Text =
							"🎯 Aimbot Player  [ON]"

						aimbotButton.BackgroundColor3 =
							GREEN

						currentAimTarget = nil

						notify("🎯 Aimbot Player ativado.")

					else

						aimbotButton.Text =
							"🎯 Aimbot Player  [OFF]"

						aimbotButton.BackgroundColor3 =
							CARD

						currentAimTarget = nil

						notify("🎯 Aimbot Player desativado.")

					end

				end)

				--================================================--
				-- FOV
				--================================================--

				local fovButton = button(
					gamePage,
					"🔴 FOV  [ON]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 293),
					GREEN
				)

				fovButton.MouseButton1Click:Connect(function()

					fovVisible = not fovVisible

					if fovVisible then

						fovButton.Text =
							"🔴 FOV  [ON]"

						fovButton.BackgroundColor3 =
							GREEN

						if fovCircle then
							fovCircle.Visible = true
						end

					else

						fovButton.Text =
							"🔴 FOV  [OFF]"

						fovButton.BackgroundColor3 =
							CARD

						if fovCircle then
							fovCircle.Visible = false
						end

					end

				end)

				--================================================--
				-- HITBOX
				--================================================--

				local hitboxButton = button(
					gamePage,
					"📦 Hitbox Player  [OFF]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 345),
					CARD
				)

				local hitboxEnabled = false

				hitboxButton.MouseButton1Click:Connect(function()

					hitboxEnabled = not hitboxEnabled

					if hitboxEnabled then

						hitboxButton.Text =
							"📦 Hitbox Player  [ON]"

						hitboxButton.BackgroundColor3 =
							GREEN

						-- Aplica imediatamente
						for _, plr in ipairs(Players:GetPlayers()) do

							if plr ~= player then

								local character = plr.Character
								local root =
									character and character:FindFirstChild("HumanoidRootPart")

								if root then

									if not playerHitboxes[plr] then

										playerHitboxes[plr] = {
											Size = root.Size,
											Transparency = root.Transparency
										}

									end

									root.Size = Vector3.new(
										hitboxSize,
										hitboxSize,
										hitboxSize
									)

									root.Transparency = 0.65

								end

							end

						end

						notify(
							"📦 Hitbox Player ativada: " ..
							hitboxSize
						)

					else

						hitboxButton.Text =
							"📦 Hitbox Player  [OFF]"

						hitboxButton.BackgroundColor3 =
							CARD

						for plr, dataSaved in pairs(playerHitboxes) do

							local character = plr.Character
							local root =
								character and character:FindFirstChild("HumanoidRootPart")

							if root then

								root.Size = dataSaved.Size
								root.Transparency =
									dataSaved.Transparency

							end

						end

						playerHitboxes = {}

						notify("📦 Hitbox restaurada.")

					end

				end)

				--================================================--
				-- CONFIGURAÇÕES
				--================================================--

				local compactButton = button(
					settings,
					"📐 Interface compacta  [OFF]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 85),
					CARD
				)

				toggleButton(
					compactButton,
					"📐 Interface compacta"
				)

				local notificationButton = button(
					settings,
					"🔔 Notificações  [ON]",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 137),
					GREEN
				)

				toggleButton(
					notificationButton,
					"🔔 Notificações"
				)

				--================================================--
				-- TAMANHO DO FOV
				--================================================--

				local fovLabel = label(
					settings,
					"🔴 Tamanho do FOV: " .. fovSize,
					UDim2.new(1, -20, 0, 25),
					UDim2.new(0, 10, 0, 185),
					11,
					TEXT
				)

				local fovBox = Instance.new("TextBox")

				fovBox.Size = UDim2.new(1, -20, 0, 38)
				fovBox.Position = UDim2.new(0, 10, 0, 210)

				fovBox.BackgroundColor3 = CARD
				fovBox.BorderSizePixel = 0

				fovBox.Text = tostring(fovSize)
				fovBox.PlaceholderText = "Digite de 1 até 200"
				fovBox.PlaceholderColor3 = SUB

				fovBox.TextColor3 = TEXT
				fovBox.TextSize = 12
				fovBox.Font = Enum.Font.Gotham

				fovBox.ClearTextOnFocus = false

				fovBox.Parent = settings

				addCorner(fovBox, 8)
				addStroke(fovBox)

				fovBox.FocusLost:Connect(function()

					local value =
						tonumber(fovBox.Text)

					if value then

						value = math.clamp(
							math.floor(value),
							1,
							200
						)

						fovSize = value

						fovBox.Text =
							tostring(fovSize)

						fovLabel.Text =
							"🔴 Tamanho do FOV: " ..
							fovSize

					else

						fovBox.Text =
							tostring(fovSize)

					end

				end)

				--================================================--
				-- TAMANHO DA HITBOX
				--================================================--

				local hitboxLabel = label(
					settings,
					"📦 Tamanho da Hitbox: " .. hitboxSize,
					UDim2.new(1, -20, 0, 25),
					UDim2.new(0, 10, 0, 255),
					11,
					TEXT
				)

				local hitboxBox = Instance.new("TextBox")

				hitboxBox.Size = UDim2.new(1, -20, 0, 38)
				hitboxBox.Position = UDim2.new(0, 10, 0, 280)

				hitboxBox.BackgroundColor3 = CARD
				hitboxBox.BorderSizePixel = 0

				hitboxBox.Text = tostring(hitboxSize)
				hitboxBox.PlaceholderText = "Digite de 1 até 200"
				hitboxBox.PlaceholderColor3 = SUB

				hitboxBox.TextColor3 = TEXT
				hitboxBox.TextSize = 12
				hitboxBox.Font = Enum.Font.Gotham

				hitboxBox.ClearTextOnFocus = false

				hitboxBox.Parent = settings

				addCorner(hitboxBox, 8)
				addStroke(hitboxBox)

				hitboxBox.FocusLost:Connect(function()

					local value =
						tonumber(hitboxBox.Text)

					if value then

						value = math.clamp(
							math.floor(value),
							1,
							200
						)

						hitboxSize = value

						hitboxBox.Text =
							tostring(hitboxSize)

						hitboxLabel.Text =
							"📦 Tamanho da Hitbox: " ..
							hitboxSize

						-- Atualiza hitboxes já aplicadas
						for plr, _ in pairs(playerHitboxes) do

							local character = plr.Character
							local root =
								character and character:FindFirstChild("HumanoidRootPart")

							if root then

								root.Size = Vector3.new(
									hitboxSize,
									hitboxSize,
									hitboxSize
								)

							end

						end

					else

						hitboxBox.Text =
							tostring(hitboxSize)

					end

				end)

				--================================================--
				-- DISCORD
				--================================================--

				local dcBox = Instance.new("TextBox")

				dcBox.Size = UDim2.new(1, -20, 0, 42)
				dcBox.Position = UDim2.new(0, 10, 0, 85)

				dcBox.BackgroundColor3 = CARD
				dcBox.BorderSizePixel = 0

				dcBox.Text = DISCORD_LINK

				dcBox.TextColor3 =
					Color3.fromRGB(100, 160, 255)

				dcBox.TextSize = 11
				dcBox.Font = Enum.Font.Gotham

				dcBox.TextEditable = false
				dcBox.ClearTextOnFocus = false

				dcBox.TextXAlignment =
					Enum.TextXAlignment.Center

				dcBox.Parent = dcPage

				addCorner(dcBox, 8)

				local copyButton = button(
					dcPage,
					"💬 COPIAR LINK DO DISCORD",
					UDim2.new(1, -20, 0, 42),
					UDim2.new(0, 10, 0, 140),
					Color3.fromRGB(65, 75, 150)
				)

				copyButton.MouseButton1Click:Connect(function()

					if typeof(setclipboard) == "function" then

						setclipboard(DISCORD_LINK)

						notify(
							"💬 Link do Discord copiado!"
						)

					else

						notify(
							"Copie o link mostrado acima."
						)

					end

				end)

				--================================================--
				-- MENU
				--================================================--

				local menu = {

					{"🏠  Início", home, 80},
					{"⚡  FPS Booster", fps, 125},
					{"🎮  Jogo", gamePage, 170},
					{"⚙  Configurações", settings, 215},
					{"💬  Discord", dcPage, 260}

				}

				local function showPage(target)

					for _, p in pairs(pages) do
						p.Visible = false
					end

					target.Visible = true

				end

				for _, item in ipairs(menu) do

					local b = button(
						sidebar,
						item[1],
						UDim2.new(1, -20, 0, 35),
						UDim2.new(0, 10, 0, item[3]),
						Color3.fromRGB(25, 29, 40)
					)

					b.TextXAlignment =
						Enum.TextXAlignment.Left

					local padding = Instance.new("UIPadding")

					padding.PaddingLeft =
						UDim.new(0, 10)

					padding.Parent = b

					b.MouseButton1Click:Connect(function()

						showPage(item[2])

					end)

				end

				--================================================--
				-- FOV CIRCLE
				--================================================--

				fovCircle = Instance.new("Frame")

				fovCircle.Name = "TXZZ_FOV"
				fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)

				fovCircle.Position =
					UDim2.new(0.5, 0, 0.5, 0)

				fovCircle.Size =
					UDim2.fromOffset(fovSize, fovSize)

				fovCircle.BackgroundTransparency = 1
				fovCircle.BorderSizePixel = 0

				fovCircle.ZIndex = 2
				fovCircle.Visible = fovVisible

				fovCircle.Parent = gui

				addCorner(fovCircle, 999)

				local fovStroke =
					Instance.new("UIStroke")

				fovStroke.Color =
					Color3.fromRGB(255, 40, 40)

				fovStroke.Thickness = 2
				fovStroke.Transparency = 0

				fovStroke.Parent = fovCircle

				--================================================--
				-- LOGO FLUTUANTE
				--================================================--

				launcher = Instance.new("ImageButton")

				launcher.Name = "TXZZ76_Launcher"

				launcher.Size =
					UDim2.fromOffset(62, 62)

				launcher.Position =
					UDim2.new(0, 20, 0.5, -31)

				launcher.BackgroundColor3 =
					PANEL

				launcher.BorderSizePixel = 0

				launcher.Image = LOGO_ID
				launcher.ScaleType = Enum.ScaleType.Fit

				launcher.AutoButtonColor = true
				launcher.ZIndex = 10

				launcher.Parent = gui

				addCorner(launcher, 31)
				addStroke(launcher)

				--================================================--
				-- ARRASTAR LOGO
				--================================================--

				do

					local dragging = false
					local dragStart
					local startPosition

					launcher.InputBegan:Connect(function(input)

						if input.UserInputType ==
							Enum.UserInputType.MouseButton1
							or input.UserInputType ==
							Enum.UserInputType.Touch then

							dragging = true
							dragStart = input.Position
							startPosition = launcher.Position

							input.Changed:Connect(function()

								if input.UserInputState ==
									Enum.UserInputState.End then

									dragging = false

								end

							end)

						end

					end)

					UserInputService.InputChanged:Connect(function(input)

						if not dragging then
							return
						end

						if input.UserInputType ~=
							Enum.UserInputType.MouseMovement
							and input.UserInputType ~=
							Enum.UserInputType.Touch then

							return

						end

						local delta =
							input.Position - dragStart

						launcher.Position = UDim2.new(
							startPosition.X.Scale,
							startPosition.X.Offset + delta.X,

							startPosition.Y.Scale,
							startPosition.Y.Offset + delta.Y
						)

					end)

				end

				--================================================--
				-- ABRIR / FECHAR PELO LOGO
				--================================================--

				launcher.MouseButton1Click:Connect(function()

					if mainPanel then

						mainPanel.Visible =
							not mainPanel.Visible

					end

				end)

				--================================================--
				-- ATUALIZAÇÃO DO FOV
				--================================================--

				task.spawn(function()

					while gui.Parent do

						if fovCircle then

							fovCircle.Size =
								UDim2.fromOffset(
									fovSize,
									fovSize
								)

							fovCircle.Visible =
								fovVisible

						end

						task.wait(0.05)

					end

				end)

				notify(
					"Painel carregado: " .. data[2]
				)

			end)

		end)

	end

	--========================================================--
	-- PESQUISA
	--========================================================--

	search:GetPropertyChangedSignal("Text"):Connect(function()

		local query =
			string.lower(search.Text)

		for _, item in ipairs(items) do

			if query == ""
				or string.find(
					item.name,
					query,
					1,
					true
				) then

				item.button.Visible = true

			else

				item.button.Visible = false

			end

		end

	end)

end

--========================================================--
-- AIMBOT PLAYER
-- CORRIGIDO PARA MIRAR NA HEAD
--========================================================--

local function getPlayerHead(plr)

	if not plr or plr == player then
		return nil
	end

	local character = plr.Character

	if not character then
		return nil
	end

	local humanoid =
		character:FindFirstChildOfClass("Humanoid")

	local head =
		character:FindFirstChild("Head")

	if not humanoid
		or humanoid.Health <= 0
		or not head then

		return nil

	end

	return head
end

--========================================================--
-- ENCONTRAR PLAYER NO FOV
--========================================================--

local function getTargetInFOV()

	local camera = workspace.CurrentCamera

	if not camera then
		return nil
	end

	local center = Vector2.new(
		camera.ViewportSize.X / 2,
		camera.ViewportSize.Y / 2
	)

	local bestTarget = nil
	local bestDistance = math.huge

	for _, plr in ipairs(Players:GetPlayers()) do

		if plr ~= player then

			local head =
				getPlayerHead(plr)

			if head then

				local screenPosition, visible =
					camera:WorldToViewportPoint(
						head.Position
					)

				if visible and screenPosition.Z > 0 then

					local targetPosition =
						Vector2.new(
							screenPosition.X,
							screenPosition.Y
						)

					local distance =
						(
							targetPosition - center
						).Magnitude

					if distance <=
						(fovSize / 2) then

						if distance < bestDistance then

							bestDistance =
								distance

							bestTarget =
								plr

						end

					end

				end

			end

		end

	end

	return bestTarget
end

--========================================================--
-- AIMBOT RENDER
--========================================================--

RunService:BindToRenderStep(
	"TXZZ76_Aimbot",
	Enum.RenderPriority.Camera.Value + 1,
	function()

		if not aimbotEnabled then

			currentAimTarget = nil
			return

		end

		local camera =
			workspace.CurrentCamera

		if not camera then
			return
		end

		--================================================--
		-- MANTÉM O ALVO ATUAL
		--================================================--

		local head =
			getPlayerHead(currentAimTarget)

		--================================================--
		-- SE O ALVO MORREU/DESAPARECEU,
		-- PROCURA OUTRO
		--================================================--

		if not head then

			currentAimTarget =
				getTargetInFOV()

			head =
				getPlayerHead(
					currentAimTarget
				)

		end

		--================================================--
		-- MIRA EXATAMENTE NA CABEÇA
		--================================================--

		if head then

			local headPosition =
				head.Position

			camera.CFrame =
				CFrame.lookAt(
					camera.CFrame.Position,
					headPosition
				)

		end

	end
)

--========================================================--
-- HITBOX PLAYER
--========================================================--

Players.PlayerAdded:Connect(function(plr)

	if plr == player then
		return
	end

	plr.CharacterAdded:Connect(function(character)

		task.wait(0.5)

		if not character.Parent then
			return
		end

		local root =
			character:FindFirstChild("HumanoidRootPart")

		if not root then
			return
		end

		if not playerHitboxes[plr] then

			playerHitboxes[plr] = {
				Size = root.Size,
				Transparency = root.Transparency
			}

		end

	end)

end)

--========================================================--
-- VERIFICAR KEY
--========================================================--

verify.MouseButton1Click:Connect(function()

	local typedKey =
		string.gsub(
			keyBox.Text,
			"^%s*(.-)%s*$",
			"%1"
		)

	if typedKey == KEY_CORRETA then

		keyVerified = true

		keyVerifiedAt =
			os.date(
				"%d/%m/%Y às %H:%M:%S"
			)

		notify(
			"✓ Key verificada em " ..
			keyVerifiedAt
		)

		verify.Text =
			"✓ KEY VERIFICADA"

		verify.BackgroundColor3 =
			GREEN

		task.wait(0.5)

		openSelector()

	else

		notify(
			"✕ Key incorreta."
		)

		keyBox.Text = ""

	end

end)

--========================================================--
-- DISCORD DA KEY
--========================================================--

discord.MouseButton1Click:Connect(function()

	if typeof(setclipboard) == "function" then

		setclipboard(DISCORD_LINK)

		notify(
			"💬 Link do Discord copiado!"
		)

	else

		notify(
			"Copie o link exibido abaixo."
		)

	end

end)

--========================================================--
-- FINAL
--========================================================--

notify(
	"TXZZ 76 V8 carregado."
)
