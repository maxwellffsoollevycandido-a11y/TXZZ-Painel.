-- script in discord.gg/sabcom

if not game:IsLoaded() then game.Loaded:Wait() end

local flashid = "rbxassetid://70883871260184"
local TP = 2.5
local PRIO = Enum.AnimationPriority.Action4
local BIG = 25

local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local hs = game:GetService("HttpService")
local ts = game:GetService("TweenService")

local lp = plrs.LocalPlayer
while not lp do
    task.wait()
    lp = plrs.LocalPlayer
end
if not lp.Character then lp.CharacterAdded:Wait() end
lp.Character:WaitForChild("Humanoid")

local F = "sabcomflash.json"
local cfg = { flash = false, spam = false, anti = false, w = 0.03, s = 0.2, px = 50, py = 130 }

if isfile and isfile(F) then
    local ok, d = pcall(function() return hs:JSONDecode(readfile(F)) end)
    if ok and type(d) == "table" then
        for k, v in pairs(d) do
            if cfg[k] ~= nil then cfg[k] = v end
        end
    end
end

if type(cfg.px) ~= "number" then cfg.px = 50 end
if type(cfg.py) ~= "number" then cfg.py = 130 end

local function save()
    pcall(function()
        if writefile then writefile(F, hs:JSONEncode(cfg)) end
    end)
end

local Theme = {
    Bg       = Color3.fromRGB(8, 8, 10),
    Panel    = Color3.fromRGB(14, 14, 16),
    Row      = Color3.fromRGB(18, 18, 22),
    Accent   = Color3.fromRGB(125, 211, 252),
    On       = Color3.fromRGB(56, 189, 248),
    Off      = Color3.fromRGB(22, 22, 26),
    Text     = Color3.fromRGB(248, 250, 252),
    Dim      = Color3.fromRGB(148, 163, 184),
}

local function corner(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = inst
    return c
end

local function stroke(inst, col, thick, trans)
    local e = Instance.new("UIStroke")
    e.Color = col or Theme.Accent
    e.Thickness = thick or 1
    e.Transparency = trans or 0.35
    e.Parent = inst
    return e
end

local function tween(inst, props, t)
    ts:Create(inst, TweenInfo.new(t or 0.14, Enum.EasingStyle.Quad), props):Play()
end

local tracks = {}
local err, togup = "off", {}

local skinok = false

local function checkskin()
    local chr = lp.Character
    if not chr then return end
    local ut = chr:FindFirstChild("UpperTorso")
    if not ut then return end
    local ok, v = pcall(function() return ut.HasSkinnedMesh end)
    if ok and v then skinok = true end
end

local function hasskin()
    return skinok
end

local function setstat()
end

local function stopflash()
    for _, t in ipairs(tracks) do
        pcall(function() t:AdjustWeight(0, 0) end)
        pcall(function() t:Stop(0) end)
        pcall(function() t:Destroy() end)
    end
    tracks = {}
end

local function startflash()
    stopflash()
    local chr = lp.Character
    if not chr then err = "no character" setstat() return end
    local anm = chr:FindFirstChildWhichIsA("Animator", true)
    if not anm then err = "no animator" setstat() return end
    if not anm.LoadAnimationCoreScript then
        err = "no LoadAnimationCoreScript"
        warn("[sabcom flash] " .. err)
        setstat()
        return
    end
    local a = Instance.new("Animation")
    a.AnimationId = flashid
    local ok, t = pcall(function() return anm:LoadAnimationCoreScript(a) end)
    if not ok or not t then
        err = tostring(t)
        warn("[sabcom flash] load failed: " .. err)
        setstat()
        return
    end
    t:Play()
    t.Priority = PRIO
    t.Looped = true
    t:AdjustSpeed(cfg.spam and cfg.s or 0)
    t:AdjustWeight(cfg.w)
    t.TimePosition = TP
    tracks[1] = t
    err = ""
    setstat()
end

local function restart()
    if not cfg.flash then return end
    stopflash()
    task.wait(0.05)
    startflash()
end

local function apply()
    if cfg.flash and not hasskin() then
        cfg.flash = false
        if togup.flash then togup.flash() end
        save()
    end
    if not cfg.flash then
        stopflash()
        err = "off"
        setstat()
        return
    end
    if #tracks == 0 then startflash() return end
    for _, t in ipairs(tracks) do
        pcall(function()
            t:AdjustSpeed(cfg.spam and cfg.s or 0)
            t:AdjustWeight(cfg.w)
        end)
    end
end

local map

local function donor()
    if map then return map end
    map = {}
    pcall(function()
        local r = plrs:CreateHumanoidModelFromDescription(
            Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15)
        for _, d in ipairs(r:GetChildren()) do
            if d:IsA("MeshPart") then map[d.Name] = d.MeshId end
        end
        r:Destroy()
    end)
    return map
end

local done = setmetatable({}, { __mode = "k" })
local orig = setmetatable({}, { __mode = "k" })

local function unskin(c)
    if done[c] then return end
    done[c] = true
    local mp = donor()
    for _, d in ipairs(c:GetChildren()) do
        if d:IsA("MeshPart") and mp[d.Name] then
            pcall(function()
                if d.HasSkinnedMesh then
                    if orig[d] == nil then orig[d] = d.MeshId end
                    d.MeshId = mp[d.Name]
                    d.HasSkinnedMesh = false
                end
            end)
        end
    end
end

local function reskin()
    for d, id in pairs(orig) do
        pcall(function()
            d.MeshId = id
            d.HasSkinnedMesh = true
        end)
    end
    table.clear(orig)
    table.clear(done)
end

local function huge(c)
    local ok, s = pcall(function() return c:GetExtentsSize() end)
    return ok and s and (s.X > BIG or s.Y > BIG or s.Z > BIG)
end

task.spawn(function()
    while task.wait(0.4) do
        if cfg.anti then
            for _, v in ipairs(plrs:GetPlayers()) do
                if v.Character and huge(v.Character) then
                    pcall(unskin, v.Character)
                end
            end
        end
    end
end)

lp.CharacterAdded:Connect(function(c)
    c:WaitForChild("Humanoid")
    skinok = false
    checkskin()
    task.wait(1.5)
    checkskin()
    tracks = {}
    apply()
end)

local guiParent = (gethui and gethui()) or game:GetService("CoreGui")
pcall(function()
    local old = guiParent:FindFirstChild("SabcomFlasher")
    if old then old:Destroy() end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "SabcomFlasher"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = guiParent

local PW, PH = 228, 196

local m = Instance.new("Frame")
m.Name = "Panel"
m.Size = UDim2.new(0, PW, 0, PH)
m.Position = UDim2.new(0, cfg.px, 0, cfg.py)
m.BackgroundColor3 = Theme.Bg
m.BorderSizePixel = 0
m.Parent = sg
corner(m, 10)
stroke(m, Theme.Accent, 1, 0.42)

local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, 0, 0, 28)
bar.BackgroundColor3 = Theme.Panel
bar.BorderSizePixel = 0
bar.Parent = m
corner(bar, 10)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(1, 0, 0, 10)
barFill.Position = UDim2.new(0, 0, 1, -10)
barFill.BackgroundColor3 = Theme.Panel
barFill.BorderSizePixel = 0
barFill.Parent = bar

local dot = Instance.new("Frame")
dot.Size = UDim2.new(0, 6, 0, 6)
dot.Position = UDim2.new(0, 10, 0.5, -3)
dot.BackgroundColor3 = Theme.Accent
dot.BorderSizePixel = 0
dot.Parent = bar
corner(dot, 3)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -118, 1, 0)
title.Position = UDim2.new(0, 22, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Theme.Text
title.Text = "sabcom flasher"
title.Parent = bar

local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(0, 92, 1, 0)
brand.Position = UDim2.new(1, -100, 0, 0)
brand.BackgroundTransparency = 1
brand.Font = Enum.Font.Gotham
brand.TextSize = 9
brand.TextXAlignment = Enum.TextXAlignment.Right
brand.TextColor3 = Theme.Dim
brand.Text = "discord.gg/sabcom"
brand.Parent = bar

local function savepos()
    cfg.px = math.floor(m.Position.X.Offset + 0.5)
    cfg.py = math.floor(m.Position.Y.Offset + 0.5)
    save()
end

do
    local ds, sp, dg
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            dg = true ds = i.Position sp = m.Position
        end
    end)
    uis.InputChanged:Connect(function(i)
        if dg and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            m.Position = UDim2.new(0, sp.X.Offset + d.X, 0, sp.Y.Offset + d.Y)
        end
    end)
    uis.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            if dg then savepos() end
            dg = false
        end
    end)
end

local function mktog(y, txt, key, fn)
    local b = Instance.new("TextButton")
    b.Position = UDim2.new(0, 8, 0, y)
    b.Size = UDim2.new(1, -16, 0, 24)
    b.BorderSizePixel = 0
    b.Font = Enum.Font.Gotham
    b.TextSize = 11
    b.TextColor3 = Theme.Text
    b.AutoButtonColor = false
    b.Parent = m
    corner(b, 6)

    local pill = Instance.new("Frame")
    pill.Size = UDim2.new(0, 30, 0, 14)
    pill.Position = UDim2.new(1, -38, 0.5, -7)
    pill.BorderSizePixel = 0
    pill.Parent = b
    corner(pill, 7)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 10, 0, 10)
    knob.Position = UDim2.new(0, 2, 0.5, -5)
    knob.BorderSizePixel = 0
    knob.BackgroundColor3 = Theme.Text
    knob.Parent = pill
    corner(knob, 5)

    local function up()
        local on = cfg[key]
        tween(b, { BackgroundColor3 = on and Color3.fromRGB(10, 24, 34) or Theme.Off })
        tween(pill, { BackgroundColor3 = on and Theme.On or Color3.fromRGB(48, 50, 58) })
        tween(knob, { Position = on and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5) })
        b.Text = "  " .. txt
        b.TextXAlignment = Enum.TextXAlignment.Left
    end
    togup[key] = up
    b.MouseButton1Click:Connect(function()
        cfg[key] = not cfg[key]
        up()
        save()
        apply()
        up()
        if fn then fn() end
    end)
    b.MouseEnter:Connect(function()
        tween(b, { BackgroundColor3 = cfg[key] and Color3.fromRGB(14, 32, 44) or Color3.fromRGB(28, 28, 34) })
    end)
    b.MouseLeave:Connect(up)
    up()
end

local function mksld(y, txt, key, mn, mx, st, ph)
    local row = Instance.new("Frame")
    row.Position = UDim2.new(0, 8, 0, y)
    row.Size = UDim2.new(1, -16, 0, 32)
    row.BackgroundColor3 = Theme.Off
    row.BorderSizePixel = 0
    row.Parent = m
    corner(row, 6)

    local l = Instance.new("TextLabel")
    l.Position = UDim2.new(0, 8, 0, 3)
    l.Size = UDim2.new(0, 90, 0, 12)
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextColor3 = Theme.Dim
    l.Text = txt
    l.Parent = row

    local tb = Instance.new("TextBox")
    tb.Position = UDim2.new(1, -50, 0, 3)
    tb.Size = UDim2.new(0, 42, 0, 12)
    tb.BackgroundTransparency = 1
    tb.Font = Enum.Font.GothamBold
    tb.TextSize = 10
    tb.TextXAlignment = Enum.TextXAlignment.Right
    tb.TextColor3 = Theme.Text
    tb.ClearTextOnFocus = true
    tb.PlaceholderText = ph
    tb.PlaceholderColor3 = Color3.fromRGB(100, 110, 122)
    tb.Parent = row

    local b = Instance.new("Frame")
    b.Position = UDim2.new(0, 8, 0, 18)
    b.Size = UDim2.new(1, -16, 0, 5)
    b.BackgroundColor3 = Theme.Row
    b.BorderSizePixel = 0
    b.Parent = row
    corner(b, 3)

    local f = Instance.new("Frame")
    f.BackgroundColor3 = Theme.Accent
    f.BorderSizePixel = 0
    f.Parent = b
    corner(f, 3)

    local k = Instance.new("Frame")
    k.Size = UDim2.new(0, 10, 0, 10)
    k.BackgroundColor3 = Theme.Text
    k.BorderSizePixel = 0
    k.Parent = b
    corner(k, 5)

    local function refresh()
        local rel = (cfg[key] - mn) / (mx - mn)
        f.Size = UDim2.new(rel, 0, 1, 0)
        k.Position = UDim2.new(rel, -5, 0.5, -5)
        tb.Text = string.format("%.2f", cfg[key])
    end

    local function put(v)
        v = math.floor(v / st + 0.5) * st
        cfg[key] = math.clamp(v, mn, mx)
        refresh()
        save()
        apply()
    end

    local function set(x)
        local rel = math.clamp((x - b.AbsolutePosition.X) / b.AbsoluteSize.X, 0, 1)
        put(mn + rel * (mx - mn))
    end

    local sl
    b.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            sl = true set(i.Position.X)
        end
    end)
    k.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            sl = true set(i.Position.X)
        end
    end)
    uis.InputChanged:Connect(function(i)
        if sl and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            set(i.Position.X)
        end
    end)
    uis.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then sl = false end
    end)

    tb.FocusLost:Connect(function()
        local n = tonumber(tb.Text)
        if n then put(n) else refresh() end
    end)

    refresh()
end

mktog(34, "FLASH", "flash")
mktog(60, "SPAM", "spam", restart)
mktog(86, "ANTI FLASH", "anti", function()
    if not cfg.anti then reskin() end
end)

mksld(116, "SIZE", "w", 0.01, 1, 0.01, "0.03")
mksld(152, "SPAM SPEED", "s", 0.05, 2, 0.05, "0.20")

checkskin()
task.wait(0.5)
checkskin()
apply()
setstat()
