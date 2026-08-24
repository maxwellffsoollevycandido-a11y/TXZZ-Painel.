--==================================================
-- TXZZ KEY SYSTEM + PAINEL
-- ÚNICO LOCALSCRIPT
-- Para uso no seu próprio jogo
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local KEY_CORRETA = "TXZZ-TESTE-123"
local DISCORD_LINK = "https://discord.gg/KhAmznCuHm"

-- ID informado
local ICON_IMAGE = "rbxassetid://134571219107537"

-- 24 horas
local KEY_DURATION = 24 * 60 * 60

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
	local t = TweenService:Create(
		obj,
		TweenInfo.new(
			time,
			Enum.EasingStyle.Quart,
			Enum.EasingDirection.Out
		),
		properties
	)

	t:Play()
	return t
end

local function getCharacter()
	return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoid()
	local character = getCharacter()
	return character:FindFirstChildOfClass("Humanoid")
end

--==================================================
-- KEY 24H
--==================================================

local keyExpiresAt = 0

local function keyStillValid()
	return keyExpiresAt > os.time()
end

local function getRemaining()
	return math.max(0, keyExpiresAt - os.time())
end

local function formatTime(seconds)
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60

	return string.format(
		"%02dh %02dm %02ds",
		hours,
		minutes,
		secs
	)
end

--==================================================
-- TELA DA KEY
--==================================================

local keyPage = Instance.new("Frame")
keyPage.Name = "KeyPage"
keyPage.Size = UDim2.fromOffset(380, 270)
keyPage.Position = UDim2.new(0.5, -190, 0.5, -135)
keyPage.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
keyPage.BorderSizePixel = 0
keyPage.ClipsDescendants = true
keyPage.Parent = gui

corner(keyPage, 10)
stroke(
	keyPage,
	Color3.fromRGB(155, 0, 0),
	0.15,
	1
)

local keyHeader = Instance.new("Frame")
keyHeader.Size = UDim2.new(1, 0, 0, 46)
keyHeader.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
keyHeader.BorderSizePixel = 0
keyHeader.Parent = keyPage

--==================================================
-- ÍCONE
--==================================================

local keyIcon = Instance.new("ImageLabel")

keyIcon.Image = ICON_IMAGE
keyIcon.ScaleType = Enum.ScaleType.Crop
keyIcon.Size = UDim2.fromOffset(32, 32)
keyIcon.Position = UDim2.fromOffset(10, 7)
keyIcon.BackgroundColor3 = Color3.fromRGB(155, 0, 0)
keyIcon.BorderSizePixel = 0
keyIcon.Parent = keyHeader

corner(keyIcon, 8)
stroke(
	keyIcon,
	Color3.fromRGB(255, 40, 40),
	0.25,
	1
)

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, -110, 1, 0)
keyTitle.Position = UDim2.fromOffset(52, 0)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "TXZZ KEY SYSTEM"
keyTitle.TextColor3 = Color3.fromRGB(235, 235, 235)
keyTitle.TextSize = 17
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextXAlignment = Enum.TextXAlignment.Left
keyTitle.Parent = keyHeader

local keyMin = Instance.new("TextButton")
keyMin.Size = UDim2.fromOffset(30, 30)
keyMin.Position = UDim2.new(1, -68, 0, 8)
keyMin.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
keyMin.BorderSizePixel = 0
keyMin.Text = "—"
keyMin.TextColor3 = Color3.new(1, 1, 1)
keyMin.TextSize = 17
keyMin.Font = Enum.Font.GothamBold
keyMin.Parent = keyHeader

corner(keyMin, 6)

local keyClose = Instance.new("TextButton")
keyClose.Size = UDim2.fromOffset(30, 30)
keyClose.Position = UDim2.new(1, -34, 0, 8)
keyClose.BackgroundColor3 = Color3.fromRGB(125, 18, 23)
keyClose.BorderSizePixel = 0
keyClose.Text = "X"
keyClose.TextColor3 = Color3.fromRGB(255, 255, 255)
keyClose.TextSize = 12
keyClose.Font = Enum.Font.GothamBold
keyClose.Parent = keyHeader

corner(keyClose, 6)

local keyInfo = Instance.new("TextLabel")
keyInfo.Size = UDim2.new(1, -30, 0, 26)
keyInfo.Position = UDim2.fromOffset(15, 58)
keyInfo.BackgroundTransparency = 1
keyInfo.Text = "Digite sua key para continuar"
keyInfo.TextColor3 = Color3.fromRGB(145, 145, 155)
keyInfo.TextSize = 13
keyInfo.Font = Enum.Font.Gotham
keyInfo.Parent = keyPage

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -30, 0, 42)
keyBox.Position = UDim2.fromOffset(15, 91)
keyBox.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Digite sua key..."
keyBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 100)
keyBox.Text = ""
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.TextSize = 14
keyBox.Font = Enum.Font.Gotham
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyPage

corner(keyBox, 7)

local validate = Instance.new("TextButton")
validate.Size = UDim2.new(1, -30, 0, 40)
validate.Position = UDim2.fromOffset(15, 142)
validate.BackgroundColor3 = Color3.fromRGB(145, 0, 0)
validate.BorderSizePixel = 0
validate.Text = "VALIDAR KEY"
validate.TextColor3 = Color3.new(1, 1, 1)
validate.TextSize = 13
validate.Font = Enum.Font.GothamBold
validate.Parent = keyPage

corner(validate, 7)

local discord = Instance.new("TextButton")
discord.Size = UDim2.new(1, -30, 0, 40)
discord.Position = UDim2.fromOffset(15, 190)
discord.BackgroundColor3 = Color3.fromRGB(70, 72, 150)
discord.BorderSizePixel = 0
discord.Text = "COPIAR LINK DO DISCORD"
discord.TextColor3 = Color3.new(1, 1, 1)
discord.TextSize = 13
discord.Font = Enum.Font.GothamBold
discord.Parent = keyPage

corner(discord, 7)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 24)
status.Position = UDim2.fromOffset(15, 238)
status.BackgroundTransparency = 1
status.Text = ""
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.Parent = keyPage

--==================================================
-- ARRASTAR KEY
--==================================================

local draggingKey = false
local keyDragStart
local keyStartPosition

keyHeader.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		draggingKey = true
		keyDragStart = input.Position
		keyStartPosition = keyPage.Position

	end

end)

keyHeader.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		draggingKey = false

	end

end)

--==================================================
-- DISCORD
--==================================================

discord.MouseButton1Click:Connect(function()

	-- Em jogo normal, o Roblox não permite
	-- copiar clipboard diretamente pelo LocalScript.

	status.Text = DISCORD_LINK
	status.TextColor3 =
		Color3.fromRGB(180, 185, 255)

end)

--==================================================
-- MINIMIZAR KEY
--==================================================

local keyMinimized = false

keyMin.MouseButton1Click:Connect(function()

	keyMinimized = not keyMinimized

	if keyMinimized then

		keyMin.Text = "□"

		animate(
			keyPage,
			0.25,
			{
				Size = UDim2.fromOffset(380, 46)
			}
		)

	else

		keyMin.Text = "—"

		animate(
			keyPage,
			0.25,
			{
				Size = UDim2.fromOffset(380, 270)
			}
		)

	end

end)

--==================================================
-- PAINEL PRINCIPAL
--==================================================

local dashboard = Instance.new("Frame")

dashboard.Name = "Dashboard"
dashboard.Size = UDim2.fromOffset(620, 370)
dashboard.Position =
	UDim2.new(0.5, -310, 0.5, -185)

dashboard.BackgroundColor3 =
	Color3.fromRGB(8, 8, 10)

dashboard.BorderSizePixel = 0
dashboard.Visible = false
dashboard.ClipsDescendants = true
dashboard.Parent = gui

corner(dashboard, 8)

stroke(
	dashboard,
	Color3.fromRGB(150, 0, 0),
	0.15,
	1
)

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundColor3 =
	Color3.fromRGB(12, 12, 15)

header.BorderSizePixel = 0
header.Parent = dashboard

local panelIcon = Instance.new("ImageLabel")

panelIcon.Image = ICON_IMAGE
panelIcon.ScaleType = Enum.ScaleType.Crop
panelIcon.Size = UDim2.fromOffset(34, 34)
panelIcon.Position = UDim2.fromOffset(10, 6)
panelIcon.BackgroundColor3 =
	Color3.fromRGB(155, 0, 0)

panelIcon.BorderSizePixel = 0
panelIcon.Parent = header

corner(panelIcon, 9)

stroke(
	panelIcon,
	Color3.fromRGB(255, 50, 50),
	0.2,
	1
)

local dashTitle = Instance.new("TextLabel")

dashTitle.Size = UDim2.fromOffset(180, 46)
dashTitle.Position = UDim2.fromOffset(54, 0)
dashTitle.BackgroundTransparency = 1
dashTitle.Text = "ROUBE UM OVO"
dashTitle.TextColor3 =
	Color3.fromRGB(230, 230, 235)

dashTitle.TextSize = 17
dashTitle.Font = Enum.Font.GothamBold
dashTitle.TextXAlignment =
	Enum.TextXAlignment.Left

dashTitle.Parent = header

local avatar = Instance.new("ImageLabel")

avatar.Size = UDim2.fromOffset(34, 34)
avatar.Position = UDim2.new(1, -165, 0, 6)
avatar.BackgroundColor3 =
	Color3.fromRGB(25, 25, 30)

avatar.BorderSizePixel = 0
avatar.Parent = header

corner(avatar, 17)

local okThumb, thumb = pcall(function()

	return Players:GetUserThumbnailAsync(
		player.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size100x100
	)

end)

if okThumb then
	avatar.Image = thumb
end

local playerName = Instance.new("TextLabel")

playerName.Size = UDim2.fromOffset(100, 17)
playerName.Position =
	UDim2.new(1, -125, 0, 5)

playerName.BackgroundTransparency = 1
playerName.Text = player.DisplayName
playerName.TextColor3 =
	Color3.fromRGB(235, 235, 235)

playerName.TextSize = 11
playerName.Font = Enum.Font.GothamBold
playerName.TextXAlignment =
	Enum.TextXAlignment.Left

playerName.Parent = header

local playerUser = Instance.new("TextLabel")

playerUser.Size = UDim2.fromOffset(100, 16)
playerUser.Position =
	UDim2.new(1, -125, 0, 22)

playerUser.BackgroundTransparency = 1
playerUser.Text = "@" .. player.Name
playerUser.TextColor3 =
	Color3.fromRGB(125, 125, 135)

playerUser.TextSize = 10
playerUser.Font = Enum.Font.Gotham
playerUser.TextXAlignment =
	Enum.TextXAlignment.Left

playerUser.Parent = header

local minButton = Instance.new("TextButton")

minButton.Size = UDim2.fromOffset(30, 30)
minButton.Position =
	UDim2.new(1, -68, 0, 8)

minButton.BackgroundColor3 =
	Color3.fromRGB(30, 30, 35)

minButton.BorderSizePixel = 0
minButton.Text = "—"
minButton.TextColor3 =
	Color3.fromRGB(230, 230, 230)

minButton.TextSize = 18
minButton.Font = Enum.Font.GothamBold
minButton.Parent = header

corner(minButton, 7)

local closeButton = Instance.new("TextButton")

closeButton.Size = UDim2.fromOffset(30, 30)
closeButton.Position =
	UDim2.new(1, -34, 0, 8)

closeButton.BackgroundColor3 =
	Color3.fromRGB(125, 20, 25)

closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 =
	Color3.new(1, 1, 1)

closeButton.TextSize = 12
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header

corner(closeButton, 7)

--==================================================
-- SIDEBAR
--==================================================

local sidebar = Instance.new("Frame")

sidebar.Size = UDim2.fromOffset(150, 310)
sidebar.Position = UDim2.fromOffset(10, 54)

sidebar.BackgroundColor3 =
	Color3.fromRGB(10, 10, 13)

sidebar.BorderSizePixel = 0
sidebar.Parent = dashboard

corner(sidebar, 6)

local sideTitle = Instance.new("TextLabel")

sideTitle.Size =
	UDim2.new(1, -14, 0, 25)

sideTitle.Position =
	UDim2.fromOffset(7, 6)

sideTitle.BackgroundTransparency = 1
sideTitle.Text = "MENU"

sideTitle.TextColor3 =
	Color3.fromRGB(110, 110, 120)

sideTitle.TextSize = 10
sideTitle.Font = Enum.Font.GothamBold
sideTitle.TextXAlignment =
	Enum.TextXAlignment.Left

sideTitle.Parent = sidebar

local sideLayout = Instance.new("UIListLayout")

sideLayout.Padding = UDim.new(0, 4)
sideLayout.SortOrder =
	Enum.SortOrder.LayoutOrder

sideLayout.Parent = sidebar

sideTitle.LayoutOrder = 0

local function category(text, order)

	local b = Instance.new("TextButton")

	b.Size =
		UDim2.new(1, -12, 0, 29)

	b.BackgroundColor3 =
		Color3.fromRGB(18, 18, 22)

	b.BorderSizePixel = 0

	b.Text = "  " .. text

	b.TextColor3 =
		Color3.fromRGB(190, 190, 195)

	b.TextSize = 10
	b.Font = Enum.Font.GothamSemibold

	b.TextXAlignment =
		Enum.TextXAlignment.Left

	b.LayoutOrder = order
	b.Parent = sidebar

	corner(b, 5)

	return b

end

local home = category("MAIN", 1)
local admin = category("ADMIN", 2)
local jogador = category("PLAYER", 3)
local teleport = category("TELEPORT", 4)
local movimento = category("MOVEMENT", 5)
local ovos = category("EGGS", 6)
local base = category("BASE", 7)
local plantar = category("PLANT", 8)
local esteira = category("BELT", 9)
local mundo = category("WORLD", 10)
local config = category("SETTINGS", 11)

--==================================================
-- CONTEÚDO
--==================================================

local content = Instance.new("Frame")

content.Size =
	UDim2.new(1, -170, 1, -64)

content.Position =
	UDim2.fromOffset(160, 54)

content.BackgroundColor3 =
	Color3.fromRGB(12, 12, 15)

content.BorderSizePixel = 0
content.Parent = dashboard

corner(content, 6)

local pageTitle = Instance.new("TextLabel")

pageTitle.Size =
	UDim2.new(1, -20, 0, 28)

pageTitle.Position =
	UDim2.fromOffset(10, 7)

pageTitle.BackgroundTransparency = 1
pageTitle.Text = "MAIN"

pageTitle.TextColor3 =
	Color3.fromRGB(235, 235, 235)

pageTitle.TextSize = 14
pageTitle.Font = Enum.Font.GothamBold

pageTitle.TextXAlignment =
	Enum.TextXAlignment.Left

pageTitle.Parent = content

local pageInfo = Instance.new("TextLabel")

pageInfo.Size =
	UDim2.new(1, -20, 0, 18)

pageInfo.Position =
	UDim2.fromOffset(10, 32)

pageInfo.BackgroundTransparency = 1
pageInfo.Text = "Configurações"

pageInfo.TextColor3 =
	Color3.fromRGB(110, 110, 120)

pageInfo.TextSize = 10
pageInfo.Font = Enum.Font.Gotham

pageInfo.TextXAlignment =
	Enum.TextXAlignment.Left

pageInfo.Parent = content

local options = Instance.new("ScrollingFrame")

options.Size =
	UDim2.new(1, -20, 1, -58)

options.Position =
	UDim2.fromOffset(10, 54)

options.BackgroundTransparency = 1
options.BorderSizePixel = 0

options.ScrollBarThickness = 3
options.CanvasSize = UDim2.new()

options.Parent = content

local optionLayout = Instance.new("UIListLayout")

optionLayout.Padding = UDim.new(0, 6)
optionLayout.Parent = options

optionLayout:GetPropertyChangedSignal(
	"AbsoluteContentSize"
):Connect(function()

	options.CanvasSize =
		UDim2.fromOffset(
			0,
			optionLayout.AbsoluteContentSize.Y + 8
		)

end)

--==================================================
-- ESTADOS
--==================================================

local states = {}

--==================================================
-- FUNÇÕES
--==================================================

local infiniteJumpConnection

local function toggleSpeed(enabled)

	local humanoid = getHumanoid()

	if not humanoid then
		return
	end

	humanoid.WalkSpeed =
		enabled and 32 or 16

end

local function toggleJump(enabled)

	local humanoid = getHumanoid()

	if not humanoid then
		return
	end

	humanoid.JumpPower =
		enabled and 80 or 50

end

local function toggleInfiniteJump(enabled)

	if infiniteJumpConnection then

		infiniteJumpConnection:Disconnect()
		infiniteJumpConnection = nil

	end

	if enabled then

		infiniteJumpConnection =
			UserInputService.JumpRequest:Connect(
				function()

					local humanoid =
						getHumanoid()

					if humanoid then

						humanoid:ChangeState(
							Enum.HumanoidStateType.Jumping
						)

					end

				end
			)

	end

end

local function resetCharacter()

	local character =
		player.Character

	if character then

		local humanoid =
			character:FindFirstChildOfClass(
				"Humanoid"
			)

		if humanoid then
			humanoid.Health = 0
		end

	end

end

local function toggleSprint(enabled)

	local humanoid =
		getHumanoid()

	if not humanoid then
		return
	end

	humanoid.WalkSpeed =
		enabled and 24 or 16

end

--==================================================
-- OPÇÕES
--==================================================

local function clearOptions()

	for _, child in ipairs(
		options:GetChildren()
	) do

		if child:IsA("Frame") then
			child:Destroy()
		end

	end

end

local function addOption(
	titleText,
	descText,
	callback
)

	local row = Instance.new("Frame")

	row.Size =
		UDim2.new(1, -4, 0, 48)

	row.BackgroundColor3 =
		Color3.fromRGB(18, 18, 22)

	row.BorderSizePixel = 0
	row.Parent = options

	corner(row, 5)

	local title =
		Instance.new("TextLabel")

	title.Size =
		UDim2.new(1, -70, 0, 18)

	title.Position =
		UDim2.fromOffset(9, 5)

	title.BackgroundTransparency = 1
	title.Text = titleText

	title.TextColor3 =
		Color3.fromRGB(220, 220, 225)

	title.TextSize = 11
	title.Font =
		Enum.Font.GothamSemibold

	title.TextXAlignment =
		Enum.TextXAlignment.Left

	title.Parent = row

	local desc =
		Instance.new("TextLabel")

	desc.Size =
		UDim2.new(1, -78, 0, 14)

	desc.Position =
		UDim2.fromOffset(9, 24)

	desc.BackgroundTransparency = 1
	desc.Text = descText

	desc.TextColor3 =
		Color3.fromRGB(105, 105, 115)

	desc.TextSize = 9
	desc.Font = Enum.Font.Gotham

	desc.TextXAlignment =
		Enum.TextXAlignment.Left

	desc.Parent = row

	local button =
		Instance.new("TextButton")

	button.Size =
		UDim2.fromOffset(45, 22)

	button.Position =
		UDim2.new(1, -54, 0.5, -11)

	button.BackgroundColor3 =
		Color3.fromRGB(45, 45, 52)

	button.BorderSizePixel = 0
	button.Text = "OFF"

	button.TextColor3 =
		Color3.fromRGB(170, 170, 175)

	button.TextSize = 9
	button.Font = Enum.Font.GothamBold

	button.Parent = row

	corner(button, 11)

	local enabled =
		states[titleText] or false

	button.MouseButton1Click:Connect(
		function()

			enabled = not enabled

			states[titleText] =
				enabled

			if enabled then

				button.Text = "ON"

				button.BackgroundColor3 =
					Color3.fromRGB(150, 0, 0)

				button.TextColor3 =
					Color3.new(1, 1, 1)

			else

				button.Text = "OFF"

				button.BackgroundColor3 =
					Color3.fromRGB(45, 45, 52)

				button.TextColor3 =
					Color3.fromRGB(170, 170, 175)

			end

			if callback then
				callback(enabled)
			end

		end
	)

end

local function showPage(
	titleText,
	infoText,
	list
)

	pageTitle.Text = titleText
	pageInfo.Text = infoText

	clearOptions()

	for _, item in ipairs(list) do

		addOption(
			item[1],
			item[2],
			item[3]
		)

	end

	options.CanvasPosition =
		Vector2.new(0, 0)

end

--==================================================
-- PÁGINAS
--==================================================

home.MouseButton1Click:Connect(
	function()

		showPage(
			"MAIN",
			"Informações",
			{
				{
					"Status",
					"Sistema carregado."
				},
				{
					"Perfil",
					"@" .. player.Name
				},
				{
					"Key",
					"24 horas de validade."
				},
				{
					"Servidor",
					"Painel pronto."
				}
			}
		)

	end
)

admin.MouseButton1Click:Connect(
	function()

		showPage(
			"ADMIN",
			"Funções locais",
			{
				{
					"Infinite Jump",
					"Pulo contínuo.",
					toggleInfiniteJump
				},
				{
					"Heal",
					"Restaurar sua vida.",
					function(enabled)

						if enabled then

							local humanoid =
								getHumanoid()

							if humanoid then
								humanoid.Health =
									humanoid.MaxHealth
							end

							states["Heal"] =
								false

						end

					end
				},
				{
					"Respawn",
					"Reaparecer.",
					function(enabled)

						if enabled then
							resetCharacter()
							states["Respawn"] =
								false
						end

					end
				},
				{
					"Fly",
					"Requer sistema de voo próprio do jogo."
				},
				{
					"God Mode",
					"Requer autoridade do servidor."
				},
				{
					"Invisible",
					"Requer sistema próprio do jogo."
				}
			}
		)

	end
)

jogador.MouseButton1Click:Connect(
	function()

		showPage(
			"PLAYER",
			"Jogador",
			{
				{
					"Speed",
					"Velocidade 32.",
					toggleSpeed
				},
				{
					"Jump",
					"Super pulo.",
					toggleJump
				},
				{
					"Sprint",
					"Corrida.",
					toggleSprint
				},
				{
					"Reset",
					"Resetar personagem.",
					function(enabled)

						if enabled then
							resetCharacter()
							states["Reset"] =
								false
						end

					end
				}
			}
		)

	end
)

movimento.MouseButton1Click:Connect(
	function()

		showPage(
			"MOVEMENT",
			"Movimento",
			{
				{
					"Speed",
					"Aumentar velocidade.",
					toggleSpeed
				},
				{
					"Super Jump",
					"Aumentar pulo.",
					toggleJump
				},
				{
					"Infinite Jump",
					"Pulo contínuo.",
					toggleInfiniteJump
				},
				{
					"Sprint",
					"Corrida.",
					toggleSprint
				}
			}
		)

	end
)

teleport.MouseButton1Click:Connect(
	function()

		showPage(
			"TELEPORT",
			"Teleporte",
			{
				{
					"Teleport Player",
					"Configure no seu jogo."
				},
				{
					"Teleport Area",
					"Configure as posições."
				},
				{
					"Nearest Player",
					"Configure no seu jogo."
				},
				{
					"Best Egg",
					"Configure a posição."
				}
			}
		)

	end
)

ovos.MouseButton1Click:Connect(
	function()

		showPage(
			"EGGS",
			"Ovos",
			{
				{
					"Show Eggs",
					"Objetos de ovos."
				},
				{
					"Rare Eggs",
					"Identificação dos ovos."
				},
				{
					"Spawn Egg",
					"Função administrativa."
				},
				{
					"Egg Notifications",
					"Eventos de ovos."
				}
			}
		)

	end
)

base.MouseButton1Click:Connect(
	function()

		showPage(
			"BASE",
			"Base",
			{
				{
					"Go Base",
					"Posição da base."
				},
				{
					"Show Base",
					"Sistema da base."
				},
				{
					"Reset Base",
					"Reset da base."
				}
			}
		)

	end
)

plantar.MouseButton1Click:Connect(
	function()

		showPage(
			"PLANT",
			"Plantio",
			{
				{
					"Plant",
					"Sistema de plantio."
				},
				{
					"Collect",
					"Sistema de coleta."
				},
				{
					"Plant Area",
					"Área configurada."
				}
			}
		)

	end
)

esteira.MouseButton1Click:Connect(
	function()

		showPage(
			"BELT",
			"Esteira",
			{
				{
					"Belt Speed",
					"Controle da esteira."
				},
				{
					"Belt Mode",
					"Modo da esteira."
				},
				{
					"Show Belts",
					"Objetos da esteira."
				}
			}
		)

	end
)

mundo.MouseButton1Click:Connect(
	function()

		showPage(
			"WORLD",
			"Mundo",
			{
				{
					"Day",
					"Controle do mundo."
				},
				{
					"Night",
					"Controle do mundo."
				},
				{
					"Gravity",
					"Controle da gravidade."
				},
				{
					"Reset World",
					"Reset do mundo."
				}
			}
		)

	end
)

config.MouseButton1Click:Connect(
	function()

		showPage(
			"SETTINGS",
			"Configurações",
			{
				{
					"Animations",
					"Interface com animações."
				},
				{
					"Notifications",
					"Notificações."
				},
				{
					"Compact Mode",
					"Interface compacta."
				}
			}
		)

	end
)

--==================================================
-- ARRASTAR PAINEL
--==================================================

local dragging = false
local dragStart
local startPos

header.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = dashboard.Position

		end

	end
)

header.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then

			dragging = false

		end

	end
)

UserInputService.InputChanged:Connect(
	function(input)

		if dragging and
			(input.UserInputType ==
				Enum.UserInputType.MouseMovement
				or input.UserInputType ==
				Enum.UserInputType.Touch) then

			local delta =
				input.Position - dragStart

			dashboard.Position =
				UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)

		end

		if draggingKey and
			(input.UserInputType ==
				Enum.UserInputType.MouseMovement
				or input.UserInputType ==
				Enum.UserInputType.Touch) then

			local delta =
				input.Position - keyDragStart

			keyPage.Position =
				UDim2.new(
					keyStartPosition.X.Scale,
					keyStartPosition.X.Offset + delta.X,
					keyStartPosition.Y.Scale,
					keyStartPosition.Y.Offset + delta.Y
				)

		end

	end
)

--==================================================
-- MINIMIZAR
--==================================================

local minimized = false

local normalSize =
	UDim2.fromOffset(620, 370)

minButton.MouseButton1Click:Connect(
	function()

		minimized = not minimized

		if minimized then

			minButton.Text = "□"

			sidebar.Visible = false
			content.Visible = false

			animate(
				dashboard,
				0.25,
				{
					Size =
						UDim2.fromOffset(
							400,
							46
						)
				}
			)

		else

			minButton.Text = "—"

			animate(
				dashboard,
				0.25,
				{
					Size = normalSize
				}
			)

			task.wait(0.15)

			sidebar.Visible = true
			content.Visible = true

		end

	end
)

--==================================================
-- FECHAR
--==================================================

closeButton.MouseButton1Click:Connect(
	function()

		local t =
			animate(
				dashboard,
				0.25,
				{
					Size =
						UDim2.fromOffset(
							0,
							0
						)
				}
			)

		t.Completed:Wait()

		dashboard.Visible = false

	end
)

--==================================================
-- VALIDAR KEY
--==================================================

local function openDashboard()

	keyPage.Visible = false

	dashboard.Visible = true
	dashboard.Size =
		UDim2.fromOffset(0, 0)

	animate(
		dashboard,
		0.4,
		{
			Size = normalSize
		}
	)

	showPage(
		"MAIN",
		"Informações",
		{
			{
				"Status",
				"Sistema carregado."
			},
			{
				"Perfil",
				"@" .. player.Name
			},
			{
				"Key",
				"24 horas de validade."
			},
			{
				"Servidor",
				"Painel pronto."
			}
		}
	)

end

validate.MouseButton1Click:Connect(
	function()

		local enteredKey =
			keyBox.Text:gsub(
				"^%s*(.-)%s*$",
				"%1"
			)

		if enteredKey == KEY_CORRETA then

			keyExpiresAt =
				os.time() + KEY_DURATION

			status.Text =
				"✅ KEY VÁLIDA! 24 HORAS"

			status.TextColor3 =
				Color3.fromRGB(
					0,
					255,
					120
				)

			task.wait(0.5)

			local closeAnimation =
				animate(
					keyPage,
					0.35,
					{
						Size =
							UDim2.fromOffset(
								0,
								0
							)
					}
				)

			closeAnimation.Completed:Wait()

			openDashboard()

		else

			status.Text =
				"❌ KEY INVÁLIDA!"

			status.TextColor3 =
				Color3.fromRGB(
					255,
					60,
					60
				)

			local old =
				keyPage.Position

			animate(
				keyPage,
				0.06,
				{
					Position =
						old +
						UDim2.fromOffset(
							7,
							0
						)
				}
			)

			task.wait(0.06)

			animate(
				keyPage,
				0.06,
				{
					Position = old
				}
			)

		end

	end
)

--==================================================
-- ANIMAÇÃO INICIAL
--==================================================

local startingSize =
	keyPage.Size

keyPage.Size =
	UDim2.fromOffset(0, 0)

animate(
	keyPage,
	0.4,
	{
		Size = startingSize
	}
)

print("TXZZ KeySystem iniciado")
print("Key: TXZZ-TESTE-123")
print("Validade: 24 horas")
