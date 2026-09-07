--========================================================--
--                    TXZZ HUB                            --
--          OVO -> BASE / TELEGUIADO + LOOP              --
--========================================================--

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--========================================================--
-- CONFIG
--========================================================--

local EggPoint = workspace:WaitForChild("EggPoint")
local BasePoint = workspace:WaitForChild("BasePoint")

local TELEPORT_DELAY = 1.5
local RETURN_DELAY = 2

local TeleGuiado = false
local Loop = false
local Running = false

--========================================================--
-- GUI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "TXZZ_HUB"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

local BG = Color3.fromRGB(10,17,12)
local BOX = Color3.fromRGB(13,21,15)
local GREEN = Color3.fromRGB(28,210,85)
local GREEN2 = Color3.fromRGB(80,255,120)
local WHITE = Color3.fromRGB(240,245,240)

--========================================================--
-- BOTÃO FLUTUANTE
--========================================================--

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.fromOffset(72,72)
OpenButton.Position = UDim2.new(0,25,0.5,-36)
OpenButton.BackgroundColor3 = BG
OpenButton.Text = "TXZZ"
OpenButton.TextColor3 = GREEN2
OpenButton.TextSize = 17
OpenButton.Font = Enum.Font.GothamBlack
OpenButton.AutoButtonColor = false
OpenButton.Parent = Gui

local OC = Instance.new("UICorner")
OC.CornerRadius = UDim.new(1,0)
OC.Parent = OpenButton

local OS = Instance.new("UIStroke")
OS.Color = GREEN
OS.Thickness = 2
OS.Parent = OpenButton

--========================================================--
-- PAINEL
--========================================================--

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(550,390)
Main.Position = UDim2.new(0.5,-275,0.5,-195)
Main.BackgroundColor3 = BG
Main.BackgroundTransparency = 0.05
Main.BorderSizePixel = 0
Main.Parent = Gui

local MC = Instance.new("UICorner")
MC.CornerRadius = UDim.new(0,22)
MC.Parent = Main

local MS = Instance.new("UIStroke")
MS.Color = Color3.fromRGB(25,170,70)
MS.Thickness = 2
MS.Parent = Main

--========================================================--
-- CABEÇALHO
--========================================================--

local Logo = Instance.new("Frame")
Logo.Size = UDim2.fromOffset(54,54)
Logo.Position = UDim2.fromOffset(18,15)
Logo.BackgroundColor3 = Color3.fromRGB(22,32,23)
Logo.Parent = Main

local LC = Instance.new("UICorner")
LC.CornerRadius = UDim.new(1,0)
LC.Parent = Logo

local LS = Instance.new("UIStroke")
LS.Color = GREEN
LS.Parent = Logo

local LT = Instance.new("TextLabel")
LT.Size = UDim2.fromScale(1,1)
LT.BackgroundTransparency = 1
LT.Text = "TX"
LT.TextColor3 = GREEN2
LT.TextSize = 18
LT.Font = Enum.Font.GothamBlack
LT.Parent = Logo

local Title = Instance.new("TextLabel")
Title.Position = UDim2.fromOffset(88,13)
Title.Size = UDim2.new(1,-220,0,30)
Title.BackgroundTransparency = 1
Title.Text = "TXZZ HUB"
Title.TextColor3 = WHITE
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Sub = Instance.new("TextLabel")
Sub.Position = UDim2.fromOffset(90,41)
Sub.Size = UDim2.new(1,-220,0,20)
Sub.BackgroundTransparency = 1
Sub.Text = "BEST EGG SYSTEM"
Sub.TextColor3 = Color3.fromRGB(95,135,100)
Sub.TextSize = 11
Sub.Font = Enum.Font.GothamMedium
Sub.TextXAlignment = Enum.TextXAlignment.Left
Sub.Parent = Main

--========================================================--
-- DISCORD
--========================================================--

local Discord = Instance.new("TextButton")
Discord.Size = UDim2.fromOffset(50,50)
Discord.Position = UDim2.new(1,-112,0,15)
Discord.BackgroundColor3 = Color3.fromRGB(80,85,220)
Discord.Text = "DC"
Discord.TextColor3 = WHITE
Discord.TextSize = 15
Discord.Font = Enum.Font.GothamBlack
Discord.AutoButtonColor = false
Discord.Parent = Main

local DC = Instance.new("UICorner")
DC.CornerRadius = UDim.new(1,0)
DC.Parent = Discord

Discord.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://discord.gg/cYKwrDjfKk")
	end
end)

--========================================================--
-- FECHAR
--========================================================--

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(42,42)
Close.Position = UDim2.new(1,-54,0,19)
Close.BackgroundColor3 = Color3.fromRGB(30,40,32)
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(180,195,180)
Close.TextSize = 25
Close.Font = Enum.Font.GothamMedium
Close.AutoButtonColor = false
Close.Parent = Main

local CC = Instance.new("UICorner")
CC.CornerRadius = UDim.new(1,0)
CC.Parent = Close

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

OpenButton.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

--========================================================--
-- BEST EGG
--========================================================--

local EggCard = Instance.new("Frame")
EggCard.Size = UDim2.new(1,-32,0,104)
EggCard.Position = UDim2.fromOffset(16,88)
EggCard.BackgroundColor3 = Color3.fromRGB(12,20,14)
EggCard.BorderSizePixel = 0
EggCard.Parent = Main

local EC = Instance.new("UICorner")
EC.CornerRadius = UDim.new(0,18)
EC.Parent = EggCard

local EggIcon = Instance.new("TextLabel")
EggIcon.Size = UDim2.fromOffset(72,72)
EggIcon.Position = UDim2.fromOffset(12,16)
EggIcon.BackgroundColor3 = Color3.fromRGB(5,9,6)
EggIcon.Text = "🥚"
EggIcon.TextSize = 37
EggIcon.Parent = EggCard

local EIC = Instance.new("UICorner")
EIC.CornerRadius = UDim.new(0,14)
EIC.Parent = EggIcon

local Best = Instance.new("TextLabel")
Best.Position = UDim2.fromOffset(100,16)
Best.Size = UDim2.new(1,-200,0,20)
Best.BackgroundTransparency = 1
Best.Text = "BEST EGG"
Best.TextColor3 = Color3.fromRGB(115,140,120)
Best.TextSize = 11
Best.Font = Enum.Font.GothamBold
Best.TextXAlignment = Enum.TextXAlignment.Left
Best.Parent = EggCard

local EggName = Instance.new("TextLabel")
EggName.Position = UDim2.fromOffset(100,38)
EggName.Size = UDim2.new(1,-200,0,27)
EggName.BackgroundTransparency = 1
EggName.Text = "SEU OVO"
EggName.TextColor3 = WHITE
EggName.TextSize = 17
EggName.Font = Enum.Font.GothamBold
EggName.TextXAlignment = Enum.TextXAlignment.Left
EggName.Parent = EggCard

local Type = Instance.new("TextLabel")
Type.Position = UDim2.fromOffset(100,66)
Type.Size = UDim2.new(1,-200,0,20)
Type.BackgroundTransparency = 1
Type.Text = "SECRET"
Type.TextColor3 = Color3.fromRGB(150,70,255)
Type.TextSize = 12
Type.Font = Enum.Font.GothamBold
Type.TextXAlignment = Enum.TextXAlignment.Left
Type.Parent = EggCard

--========================================================--
-- FUNÇÃO DE TELEPORTE
--========================================================--

local function TeleportTo(Point)

	local Character = Player.Character
	if not Character then return false end

	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Root then return false end

	Character:PivotTo(Point.CFrame + Vector3.new(0,4,0))

	return true
end

--========================================================--
-- ROTA OVO -> BASE
--========================================================--

local function FazerRota()

	if Running then return end

	Running = true

	while TeleGuiado do

		-- 1. Vai até o ovo
		TeleportTo(EggPoint)

		task.wait(TELEPORT_DELAY)

		--================================================
		-- AQUI É O MOMENTO DE COLETA DO OVO
		--
		-- Se o seu sistema de ovos usar uma função
		-- específica para entregar/resgatar, ela entra aqui.
		--================================================

		task.wait(0.5)

		-- 2. Volta para a base
		TeleportTo(BasePoint)

		task.wait(RETURN_DELAY)

		-- 3. Se LOOP estiver desligado, para
		if not Loop then
			break
		end
	end

	Running = false
end

--========================================================--
-- TOGGLE
--========================================================--

local function CreateToggle(Name, Description, Y, Callback)

	local Box = Instance.new("Frame")
	Box.Size = UDim2.new(1,-32,0,76)
	Box.Position = UDim2.fromOffset(16,Y)
	Box.BackgroundColor3 = BOX
	Box.BorderSizePixel = 0
	Box.Parent = Main

	local BC = Instance.new("UICorner")
	BC.CornerRadius = UDim.new(0,17)
	BC.Parent = Box

	local Label = Instance.new("TextLabel")
	Label.Position = UDim2.fromOffset(20,12)
	Label.Size = UDim2.new(1,-115,0,25)
	Label.BackgroundTransparency = 1
	Label.Text = Name
	Label.TextColor3 = WHITE
	Label.TextSize = 15
	Label.Font = Enum.Font.GothamBold
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Parent = Box

	local Desc = Instance.new("TextLabel")
	Desc.Position = UDim2.fromOffset(20,39)
	Desc.Size = UDim2.new(1,-115,0,20)
	Desc.BackgroundTransparency = 1
	Desc.Text = Description
	Desc.TextColor3 = Color3.fromRGB(85,105,88)
	Desc.TextSize = 10
	Desc.Font = Enum.Font.GothamMedium
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.Parent = Box

	local Toggle = Instance.new("TextButton")
	Toggle.Size = UDim2.fromOffset(66,36)
	Toggle.Position = UDim2.new(1,-88,0.5,-18)
	Toggle.BackgroundColor3 = Color3.fromRGB(31,43,34)
	Toggle.Text = ""
	Toggle.AutoButtonColor = false
	Toggle.Parent = Box

	local TC = Instance.new("UICorner")
	TC.CornerRadius = UDim.new(1,0)
	TC.Parent = Toggle

	local Circle = Instance.new("Frame")
	Circle.Size = UDim2.fromOffset(28,28)
	Circle.Position = UDim2.fromOffset(4,4)
	Circle.BackgroundColor3 = Color3.fromRGB(170,185,172)
	Circle.Parent = Toggle

	local CC2 = Instance.new("UICorner")
	CC2.CornerRadius = UDim.new(1,0)
	CC2.Parent = Circle

	local Enabled = false

	Toggle.MouseButton1Click:Connect(function()

		Enabled = not Enabled

		if Enabled then

			TweenService:Create(
				Toggle,
				TweenInfo.new(0.18),
				{BackgroundColor3 = GREEN}
			):Play()

			TweenService:Create(
				Circle,
				TweenInfo.new(0.18),
				{Position = UDim2.new(1,-32,0,4)}
			):Play()

		else

			TweenService:Create(
				Toggle,
				TweenInfo.new(0.18),
				{BackgroundColor3 = Color3.fromRGB(31,43,34)}
			):Play()

			TweenService:Create(
				Circle,
				TweenInfo.new(0.18),
				{Position = UDim2.fromOffset(4,4)}
			):Play()
		end

		Callback(Enabled)
	end)
end

--========================================================--
-- TELEGUIADO
--========================================================--

CreateToggle(
	"TELEGUIADO",
	"ONE SHOT",
	205,
	function(State)

		TeleGuiado = State

		if State then
			task.spawn(FazerRota)
		end
	end
)

--========================================================--
-- LOOP
--========================================================--

CreateToggle(
	"LOOP",
	"AUTOMATIC",
	289,
	function(State)

		Loop = State

		if State and TeleGuiado then
			task.spawn(FazerRota)
		end
	end
)

--========================================================--
-- ARRASTAR PAINEL
--========================================================--

local Dragging = false
local DragStart
local StartPosition

Main.InputBegan:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
	or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPosition = Main.Position
	end
end)

UIS.InputChanged:Connect(function(Input)

	if not Dragging then return end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
	or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(Input)

	if Input.UserInputType == Enum.UserInputType.MouseButton1
	or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = false
	end
end)
