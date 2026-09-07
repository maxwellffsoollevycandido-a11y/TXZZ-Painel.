--// TXZZ HUB
--// Interface inspirada no layout enviado

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TXZZ_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Janela principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 540, 0, 380)
main.Position = UDim2.new(0.5, -270, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(20, 25, 20)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 22)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(20, 180, 70)
stroke.Thickness = 2
stroke.Parent = main

-- Cabeçalho
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 0, 65)
title.Position = UDim2.new(0, 25, 0, 5)
title.BackgroundTransparency = 1
title.Text = "TXZZ HUB"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 27
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -100, 0, 25)
subtitle.Position = UDim2.new(0, 27, 0, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "BEST EGG SYSTEM"
subtitle.TextColor3 = Color3.fromRGB(100,170,110)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = main

-- Fechar
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 45, 0, 45)
close.Position = UDim2.new(1, -60, 0, 12)
close.BackgroundColor3 = Color3.fromRGB(30,40,30)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(200,220,200)
close.TextSize = 28
close.Font = Enum.Font.GothamBold
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

-- Discord
local discord = Instance.new("TextButton")
discord.Size = UDim2.new(0, 55, 0, 55)
discord.Position = UDim2.new(1, -125, 0, 8)
discord.BackgroundColor3 = Color3.fromRGB(80,85,220)
discord.Text = "DC"
discord.TextColor3 = Color3.new(1,1,1)
discord.TextSize = 17
discord.Font = Enum.Font.GothamBold
discord.Parent = main

Instance.new("UICorner", discord).CornerRadius = UDim.new(1,0)

discord.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://discord.gg/cYKwrDjfKk")
	end
end)

-- Área do pet
local pet = Instance.new("Frame")
pet.Size = UDim2.new(1, -40, 0, 100)
pet.Position = UDim2.new(0, 20, 0, 82)
pet.BackgroundColor3 = Color3.fromRGB(12,18,13)
pet.BorderSizePixel = 0
pet.Parent = main

Instance.new("UICorner", pet).CornerRadius = UDim.new(0,18)

local petName = Instance.new("TextLabel")
petName.Size = UDim2.new(1, -100, 0, 30)
petName.Position = UDim2.new(0, 25, 0, 18)
petName.BackgroundTransparency = 1
petName.Text = "BEST EGG"
petName.TextColor3 = Color3.fromRGB(120,150,125)
petName.TextSize = 12
petName.Font = Enum.Font.GothamBold
petName.TextXAlignment = Enum.TextXAlignment.Left
petName.Parent = pet

local petValue = Instance.new("TextLabel")
petValue.Size = UDim2.new(1, -100, 0, 35)
petValue.Position = UDim2.new(0, 25, 0, 42)
petValue.BackgroundTransparency = 1
petValue.Text = "Snowy Owl"
petValue.TextColor3 = Color3.fromRGB(240,240,240)
petValue.TextSize = 18
petValue.Font = Enum.Font.GothamBold
petValue.TextXAlignment = Enum.TextXAlignment.Left
petValue.Parent = pet

-- Botão toggle
local function createToggle(text, y)
	local box = Instance.new("Frame")
	box.Size = UDim2.new(1, -40, 0, 65)
	box.Position = UDim2.new(0, 20, 0, y)
	box.BackgroundColor3 = Color3.fromRGB(13,19,14)
	box.BorderSizePixel = 0
	box.Parent = main

	Instance.new("UICorner", box).CornerRadius = UDim.new(0,16)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -100, 1, 0)
	label.Position = UDim2.new(0, 20, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(235,235,235)
	label.TextSize = 17
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = box

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 65, 0, 35)
	button.Position = UDim2.new(1, -85, 0.5, -17)
	button.BackgroundColor3 = Color3.fromRGB(35,45,37)
	button.Text = ""
	button.Parent = box

	Instance.new("UICorner", button).CornerRadius = UDim.new(1,0)

	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 27, 0, 27)
	circle.Position = UDim2.new(0, 4, 0.5, -13)
	circle.BackgroundColor3 = Color3.fromRGB(170,180,170)
	circle.Parent = button

	Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)

	local enabled = false

	button.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			circle.Position = UDim2.new(1, -31, 0.5, -13)
			button.BackgroundColor3 = Color3.fromRGB(30,150,70)
		else
			circle.Position = UDim2.new(0, 4, 0.5, -13)
			button.BackgroundColor3 = Color3.fromRGB(35,45,37)
		end
	end)

	return box
end

createToggle("TELEGUIADO", 195)
createToggle("LOOP", 270)

-- Arrastar janela
local dragging = false
local dragStart
local startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Botão para abrir novamente
local open = Instance.new("TextButton")
open.Size = UDim2.new(0, 70, 0, 70)
open.Position = UDim2.new(0, 20, 0.5, -35)
open.BackgroundColor3 = Color3.fromRGB(15,25,15)
open.Text = "TXZZ"
open.TextColor3 = Color3.fromRGB(100,255,100)
open.TextSize = 15
open.Font = Enum.Font.GothamBold
open.Parent = gui

Instance.new("UICorner", open).CornerRadius = UDim.new(1,0)

open.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
