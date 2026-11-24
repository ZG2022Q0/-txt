-- =====================================================================
-- 阿风脚本 · 竞争对手（RIVALS）独立面板
-- 不依赖界面库，全部用 Instance.new 自己画：黑底小窗 + 角落“阿风”按钮
-- 只放竞争对手服务器的功能：静默瞄准 / 透视 / 模块状态
-- 所有开关默认关闭，不会自动开启任何功能
-- =====================================================================

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

local function afNotify(title, text, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = "rbxassetid://92833142656790",
            Duration = dur or 4,
        })
    end)
end

-- ===== 服务器判定 =====
local isRivals = false
pcall(function()
    if game.PlaceId == 17625359962 then isRivals = true end
    if tonumber(game.GameId) == 6035872082 then isRivals = true end
end)
pcall(function()
    local name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    if type(name) == "string" and string.find(string.lower(name), "rivals", 1, true) then isRivals = true end
end)

-- =====================================================================
-- 功能内核（与主脚本里的『竞争对手🟢』分区同一套逻辑）
-- =====================================================================
local RVS = {
    on = false,
    part = "Smart",
    fov = 180,
    hit = 100,
    maxDist = 350,
    wall = true,
    sticky = true,
    circle = false,
    esp = false,
    info = true,
    duelOnly = true,
}

local rvGun, rvFighter, rvUtility, rvDuel
local rvOldStart = nil
local rvHooked = false

local rvRay = RaycastParams.new()
rvRay.FilterType = Enum.RaycastFilterType.Exclude
rvRay.IgnoreWater = true

local function rvUpdRay()
    local list = {}
    if LP.Character then list[#list + 1] = LP.Character end
    rvRay.FilterDescendantsInstances = list
end
rvUpdRay()
LP.CharacterAdded:Connect(function() task.defer(rvUpdRay) end)

local function rvLoad()
    rvGun, rvFighter, rvUtility, rvDuel = nil, nil, nil, nil
    local ps = LP:FindFirstChild("PlayerScripts")
    local mods = ps and ps:FindFirstChild("Modules")
    local types = mods and mods:FindFirstChild("ItemTypes")
    local gunMod = types and types:FindFirstChild("Gun")
    if gunMod then
        local ok, mod = pcall(require, gunMod)
        if ok then rvGun = mod end
    end
    local ctrl = ps and ps:FindFirstChild("Controllers")
    local fcMod = ctrl and ctrl:FindFirstChild("FighterController")
    if fcMod then
        local ok, mod = pcall(require, fcMod)
        if ok then rvFighter = mod end
    end
    local dcMod = ctrl and ctrl:FindFirstChild("DuelController")
    if dcMod then
        local ok, mod = pcall(require, dcMod)
        if ok then rvDuel = mod end
    end
    local rmods = RS:FindFirstChild("Modules")
    local utilMod = rmods and rmods:FindFirstChild("Utility")
    if utilMod then
        local ok, mod = pcall(require, utilMod)
        if ok then rvUtility = mod end
    end
    return rvGun, rvFighter, rvUtility
end
pcall(rvLoad)

local function rvHuman(character)
    return character and character:FindFirstChildOfClass("Humanoid") or nil
end

local function rvAlive(pl)
    local hum = rvHuman(pl and pl.Character)
    return hum ~= nil and hum.Health > 0
end

local function rvDuelObj()
    if not rvDuel or not rvDuel.GetDuel then return nil end
    local ok, d = pcall(rvDuel.GetDuel, rvDuel, LP)
    return ok and d or nil
end

local function rvEnemy(pl)
    if not pl or pl == LP then return false end
    if not RVS.duelOnly then
        return pl.Character ~= nil and (pl.Team == nil or pl.Team ~= LP.Team)
    end
    local d = rvDuelObj()
    if not d or not d.GetDueler then return false end
    local okA, mine = pcall(d.GetDueler, d, LP)
    local okB, theirs = pcall(d.GetDueler, d, pl)
    if not okA or not okB or not mine or not theirs then return false end
    local myTeam, theirTeam
    pcall(function()
        if mine.Get then myTeam = mine:Get("TeamID") end
    end)
    pcall(function()
        if theirs.Get then theirTeam = theirs:Get("TeamID") end
    end)
    if myTeam ~= nil and theirTeam ~= nil then return myTeam ~= theirTeam end
    return true
end

local rvSmart = { "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart", "LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg" }

local function rvParts(character)
    if RVS.part ~= "Smart" then
        local p = character and character:FindFirstChild(RVS.part)
        if p and p:IsA("BasePart") then return { p } end
        return {}
    end
    local list = {}
    for _, n in ipairs(rvSmart) do
        local p = character and character:FindFirstChild(n)
        if p and p:IsA("BasePart") then list[#list + 1] = p end
    end
    return list
end

local function rvMetrics(part)
    local cam = workspace.CurrentCamera
    if not cam or not part then return nil end
    local screen, on = cam:WorldToViewportPoint(part.Position)
    if not on or screen.Z <= 0 then return nil end
    local vp = cam.ViewportSize
    local center = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
    local sd = (Vector2.new(screen.X, screen.Y) - center).Magnitude
    local wd = (part.Position - cam.CFrame.Position).Magnitude
    return sd, wd
end

local function rvVisible(origin, character, part)
    if not RVS.wall then return true end
    local res = workspace:Raycast(origin, part.Position - origin, rvRay)
    return (not res) or res.Instance:IsDescendantOf(character)
end

local rvTP, rvTPart, rvLostAt = nil, nil, 0

local function rvBestPart(pl)
    local character = pl.Character
    if not character then return nil end
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local origin = cam.CFrame.Position
    local best, bestScore = nil, math.huge
    for _, part in ipairs(rvParts(character)) do
        local sd, wd = rvMetrics(part)
        if sd and wd <= RVS.maxDist and sd <= RVS.fov and rvVisible(origin, character, part) then
            local penalty = 0
            if RVS.part == "Smart" then
                if part.Name == "Head" then
                    penalty = 0
                elseif part.Name == "UpperTorso" then
                    penalty = 1.5
                elseif part.Name == "LowerTorso" or part.Name == "HumanoidRootPart" then
                    penalty = 3
                else
                    penalty = 6
                end
            end
            local score = sd + penalty
            if score < bestScore then
                bestScore, best = score, part
            end
        end
    end
    return best
end

local function rvFindTarget()
    local bestPl, bestPart, bestScore = nil, nil, math.huge
    for _, pl in ipairs(Players:GetPlayers()) do
        if rvEnemy(pl) and rvAlive(pl) then
            local part = rvBestPart(pl)
            if part then
                local sd, wd = rvMetrics(part)
                if sd and (sd + wd * 0.035) < bestScore then
                    bestScore, bestPl, bestPart = sd + wd * 0.035, pl, part
                end
            end
        end
    end
    return bestPl, bestPart
end

local function rvLockedOK()
    local pl, part = rvTP, rvTPart
    if not RVS.sticky or not pl or not part then return false end
    if not pl.Parent or not part.Parent or not rvEnemy(pl) or not rvAlive(pl) then return false end
    local sd, wd = rvMetrics(part)
    if not sd then return false end
    if wd > RVS.maxDist or sd > RVS.fov * 1.2 then return false end
    local cam = workspace.CurrentCamera
    if RVS.wall and (not cam or not rvVisible(cam.CFrame.Position, pl.Character, part)) then return false end
    return true
end

local function rvAcquire(fresh)
    local now = os.clock()
    if rvLockedOK() then
        rvLostAt = 0
        return rvTP, rvTPart
    end
    if (not fresh) and rvTP and RVS.sticky then
        if rvLostAt == 0 then
            rvLostAt = now
            return nil, nil
        end
        if now - rvLostAt < 0.18 then return nil, nil end
    end
    local pl, part = rvFindTarget()
    rvTP, rvTPart, rvLostAt = pl, part, 0
    return pl, part
end

local function rvPayload(origin, target)
    if not rvUtility or not rvUtility.EncodeCFrame then return nil end
    local aim = rvUtility:EncodeCFrame(CFrame.new(origin, target))
    local off = rvUtility:EncodeCFrame(CFrame.new(0.43, 0.25, 0.42))
    return aim, off
end

local function rvInstall()
    if rvHooked then return true end
    if not rvGun or type(rvGun.StartShooting) ~= "function" or not rvUtility then
        rvLoad()
    end
    if not rvGun or type(rvGun.StartShooting) ~= "function" then
        afNotify("竞争对手", "模块未就绪：找不到 Gun 模块", 4)
        return false
    end
    if not rvUtility or not rvUtility.EncodeCFrame then
        afNotify("竞争对手", "模块未就绪：找不到 Utility", 4)
        return false
    end
    rvOldStart = rvGun.StartShooting
    rvGun.StartShooting = function(self, ...)
        local res = table.pack(rvOldStart(self, ...))
        if not self or not self.ClientFighter or not self.ClientFighter.IsLocalPlayer then
            return table.unpack(res, 1, res.n)
        end
        if res[1] ~= true or res[2] ~= "StartShooting" then
            return table.unpack(res, 1, res.n)
        end
        if not RVS.on or math.random(1, 100) > RVS.hit then
            return table.unpack(res, 1, res.n)
        end
        local _, part = rvAcquire(true)
        if not part or not part.Parent then
            return table.unpack(res, 1, res.n)
        end
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            return table.unpack(res, 1, res.n)
        end
        local aim, off = rvPayload(root.Position, part.Position)
        if not aim then
            return table.unpack(res, 1, res.n)
        end
        local k0, k1, k2, k3 = utf8.char(0), utf8.char(1), utf8.char(2), utf8.char(3)
        local cd = res[3]
        if type(cd) == "table" then
            cd[k0] = aim
            cd[k1] = aim
            cd[k2] = part
            cd[k3] = off
            res[3] = cd
        else
            res[3] = { [k0] = aim, [k1] = aim, [k2] = part, [k3] = off }
        end
        return table.unpack(res, 1, res.n)
    end
    rvHooked = true
    afNotify("竞争对手", "静默瞄准已开启", 3)
    return true
end

local function rvUninstall()
    if rvOldStart and rvGun then
        pcall(function() rvGun.StartShooting = rvOldStart end)
    end
    rvOldStart = nil
    rvHooked = false
    RVS.on = false
end

-- 视野圈
local rvCircle = nil
local function rvCircleMake()
    if rvCircle then return rvCircle end
    if not (Drawing and Drawing.new) then return nil end
    local ok, c = pcall(function()
        local circle = Drawing.new("Circle")
        circle.Filled = false
        circle.Thickness = 1
        circle.NumSides = 80
        circle.Color = Color3.new(1, 1, 1)
        circle.Transparency = 0.85
        return circle
    end)
    if ok then rvCircle = c end
    return rvCircle
end
local function rvCircleDel()
    if rvCircle then
        pcall(function() rvCircle:Remove() end)
        rvCircle = nil
    end
end

-- 透视
local rvEspFolder = nil
local rvEspItems = {}
local function rvEspFolderGet()
    if rvEspFolder and rvEspFolder.Parent then return rvEspFolder end
    rvEspFolder = workspace:FindFirstChild("_AF_RivalsESP")
    if not rvEspFolder then
        rvEspFolder = Instance.new("Folder")
        rvEspFolder.Name = "_AF_RivalsESP"
        rvEspFolder.Parent = workspace
    end
    return rvEspFolder
end

local function rvWeapon(pl)
    if not rvFighter or not rvFighter.GetFighter then return nil end
    local ok, fighter = pcall(rvFighter.GetFighter, rvFighter, pl)
    if ok and fighter and fighter.EquippedItem then return fighter.EquippedItem.Name end
end

local function rvEspRemove(pl)
    local e = rvEspItems[pl]
    if not e then return end
    if e.hl then pcall(function() e.hl:Destroy() end) end
    if e.gui then pcall(function() e.gui:Destroy() end) end
    rvEspItems[pl] = nil
end

local function rvEspClear()
    for pl, _ in pairs(rvEspItems) do rvEspRemove(pl) end
    if rvEspFolder and rvEspFolder.Parent then pcall(function() rvEspFolder:Destroy() end) end
    rvEspFolder = nil
end

local function rvEspTick()
    if not RVS.esp then return end
    local folder = rvEspFolderGet()
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LP then
            local char = pl.Character
            local head = char and char:FindFirstChild("Head")
            if (not RVS.esp) or (not rvEnemy(pl)) or (not rvAlive(pl)) or not head then
                rvEspRemove(pl)
            else
                local e = rvEspItems[pl]
                if e and e.char ~= char then
                    rvEspRemove(pl)
                    e = nil
                end
                if not e then
                    local hl = Instance.new("Highlight")
                    hl.Name = "AFRV"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillColor = Color3.fromRGB(255, 70, 70)
                    hl.FillTransparency = 0.72
                    hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineTransparency = 0
                    hl.Adornee = char
                    hl.Parent = folder

                    local gui = Instance.new("BillboardGui")
                    gui.Name = "AFRVName"
                    gui.Size = UDim2.fromOffset(240, 52)
                    gui.StudsOffset = Vector3.new(0, 2.8, 0)
                    gui.AlwaysOnTop = true
                    gui.Adornee = head
                    gui.Parent = folder

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.fromScale(1, 1)
                    lbl.BackgroundTransparency = 1
                    lbl.TextSize = 14
                    lbl.Font = Enum.Font.GothamSemibold
                    lbl.TextStrokeTransparency = 0.45
                    lbl.TextColor3 = Color3.fromRGB(255, 120, 120)
                    lbl.TextWrapped = true
                    lbl.Text = ""
                    lbl.Parent = gui

                    e = { char = char, hl = hl, gui = gui, lbl = lbl }
                    rvEspItems[pl] = e
                end
                local lines = { pl.DisplayName }
                local root = char:FindFirstChild("HumanoidRootPart")
                if root and myRoot then
                    lines[1] = lines[1] .. "  |  " .. tostring(math.floor((root.Position - myRoot.Position).Magnitude + 0.5)) .. "米"
                end
                local info = {}
                if RVS.info then
                    local hum = rvHuman(char)
                    if hum then info[#info + 1] = "血 " .. tostring(math.floor(hum.Health + 0.5)) end
                    local w = rvWeapon(pl)
                    if w then info[#info + 1] = w end
                end
                if #info > 0 then lines[#lines + 1] = table.concat(info, "  |  ") end
                if e.lbl then e.lbl.Text = table.concat(lines, "\n") end
            end
        end
    end
    for pl, _ in pairs(rvEspItems) do
        if not pl.Parent then rvEspRemove(pl) end
    end
end

-- 主循环
local rvCon = nil
local rvAcc, rvEspAcc = 0, 0
local function rvLoopStart()
    if rvCon then return end
    rvCon = Run.RenderStepped:Connect(function(dt)
        local cam = workspace.CurrentCamera
        if rvCircle then
            local vp = cam and cam.ViewportSize or Vector2.zero
            rvCircle.Position = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
            rvCircle.Radius = RVS.fov
            rvCircle.Visible = RVS.on and RVS.circle
        end
        rvAcc = rvAcc + dt
        if rvAcc >= 0.016 then
            rvAcc = 0
            if RVS.on then pcall(rvAcquire) end
        end
        rvEspAcc = rvEspAcc + dt
        if rvEspAcc >= 0.15 then
            rvEspAcc = 0
            pcall(rvEspTick)
        end
    end)
end
local function rvLoopStop()
    if rvCon then
        pcall(function() rvCon:Disconnect() end)
        rvCon = nil
    end
end

-- =====================================================================
-- 自绘面板：黑底小窗，可拖动，右上角关闭，角落留“阿风”小按钮
-- =====================================================================
pcall(function()
    local oldGui = game:GetService("CoreGui"):FindFirstChild("AF_RivalsUI")
    if oldGui then oldGui:Destroy() end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "AF_RivalsUI"
sg.IgnoreGuiInset = true
sg.ResetOnSpawn = false
sg.DisplayOrder = 2000

local mounted = false
pcall(function()
    local h = getgenv and getgenv().gethui and getgenv().gethui()
    if h then sg.Parent = h mounted = true end
end)
if not mounted then
    pcall(function() sg.Parent = game:GetService("CoreGui") mounted = sg.Parent ~= nil end)
end
if not mounted then
    pcall(function() sg.Parent = LP:FindFirstChildOfClass("PlayerGui") mounted = sg.Parent ~= nil end)
end
if not sg.Parent then
    afNotify("竞争对手", "面板挂不上（CoreGui 被拦），换个执行器再试", 6)
    return
end

local ACCENT = Color3.fromRGB(230, 60, 60)
local BG = Color3.fromRGB(18, 18, 18)
local ROWBG = Color3.fromRGB(30, 30, 30)
local TXT = Color3.fromRGB(235, 235, 235)

local function corner(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 4)
    c.Parent = inst
end

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(320, 430)
main.Position = UDim2.new(0.5, -160, 0.5, -215)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
corner(main, 8)
main.Parent = sg

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(70, 70, 70)
stroke.Thickness = 1
stroke.Parent = main

local title = Instance.new("Frame")
title.Size = UDim2.new(1, 0, 0, 32)
title.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
title.BorderSizePixel = 0
corner(title, 8)
title.Parent = main

local titleTxt = Instance.new("TextLabel")
titleTxt.Size = UDim2.new(1, -40, 1, 0)
titleTxt.Position = UDim2.fromOffset(10, 0)
titleTxt.BackgroundTransparency = 1
titleTxt.TextColor3 = TXT
titleTxt.TextSize = 15
titleTxt.Font = Enum.Font.GothamBold
titleTxt.TextXAlignment = Enum.TextXAlignment.Left
titleTxt.Text = "阿风脚本 · 竞争对手"
titleTxt.Parent = title

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(26, 22)
close.Position = UDim2.new(1, -32, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(60, 26, 26)
close.TextColor3 = TXT
close.TextSize = 14
close.Font = Enum.Font.GothamBold
close.Text = "×"
close.BorderSizePixel = 0
corner(close, 5)
close.Parent = title

local body = Instance.new("ScrollingFrame")
body.Size = UDim2.new(1, -8, 1, -40)
body.Position = UDim2.new(0, 4, 0, 36)
body.BackgroundTransparency = 1
body.BorderSizePixel = 0
body.ScrollBarThickness = 4
body.CanvasSize = UDim2.new(0, 0, 0, 0)
body.AutomaticCanvasSize = Enum.AutomaticSize.Y
body.ScrollBarImageColor3 = ACCENT
body.Parent = main

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 4)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = body

local pad = Instance.new("UIPadding")
pad.PaddingLeft = UDim.new(0, 4)
pad.PaddingRight = UDim.new(0, 4)
pad.PaddingTop = UDim.new(0, 2)
pad.Parent = body

local order = 0
local function nextOrder()
    order = order + 1
    return order
end

local function mkHeader(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -8, 0, 24)
    l.BackgroundTransparency = 1
    l.TextColor3 = ACCENT
    l.TextSize = 14
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = " " .. text
    l.LayoutOrder = nextOrder()
    l.Parent = body
    return l
end

local function mkRow(label)
    local r = Instance.new("TextButton")
    r.Size = UDim2.new(1, -8, 0, 26)
    r.BackgroundColor3 = ROWBG
    r.Text = ""
    r.AutoButtonColor = true
    r.BorderSizePixel = 0
    r.TextXAlignment = Enum.TextXAlignment.Left
    r.LayoutOrder = nextOrder()
    corner(r, 4)
    r.Parent = body

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -60, 1, 0)
    l.Position = UDim2.fromOffset(8, 0)
    l.BackgroundTransparency = 1
    l.TextColor3 = TXT
    l.TextSize = 13
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = label
    l.Parent = r

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 52, 1, 0)
    v.Position = UDim2.new(1, -56, 0, 0)
    v.BackgroundTransparency = 1
    v.TextColor3 = Color3.fromRGB(140, 140, 140)
    v.TextSize = 12
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Text = "关"
    v.Parent = r
    return r, l, v
end

local function mkToggle(label, get, set)
    local r, l, v = mkRow(label)
    local function refresh()
        local on = get()
        v.Text = on and "开" or "关"
        v.TextColor3 = on and Color3.fromRGB(80, 220, 120) or Color3.fromRGB(140, 140, 140)
        r.BackgroundColor3 = on and Color3.fromRGB(34, 48, 34) or ROWBG
    end
    refresh()
    r.MouseButton1Click:Connect(function()
        set(not get())
        refresh()
    end)
    return r
end

local function mkNudge(label, get, set, step, minv, maxv)
    local r = Instance.new("Frame")
    r.Size = UDim2.new(1, -8, 0, 26)
    r.BackgroundColor3 = ROWBG
    r.BorderSizePixel = 0
    r.LayoutOrder = nextOrder()
    corner(r, 4)
    r.Parent = body

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -112, 1, 0)
    l.Position = UDim2.fromOffset(8, 0)
    l.BackgroundTransparency = 1
    l.TextColor3 = TXT
    l.TextSize = 13
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = label
    l.Parent = r

    local val = Instance.new("TextLabel")
    val.Size = UDim2.fromOffset(46, 26)
    val.Position = UDim2.new(1, -100, 0, 0)
    val.BackgroundTransparency = 1
    val.TextColor3 = Color3.fromRGB(120, 190, 255)
    val.TextSize = 13
    val.Font = Enum.Font.GothamBold
    val.Text = tostring(get())
    val.Parent = r

    local minus = Instance.new("TextButton")
    minus.Size = UDim2.fromOffset(22, 20)
    minus.Position = UDim2.new(1, -74, 0, 3)
    minus.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    minus.TextColor3 = TXT
    minus.TextSize = 14
    minus.Font = Enum.Font.GothamBold
    minus.Text = "−"
    minus.BorderSizePixel = 0
    corner(minus, 4)
    minus.Parent = r

    local plus = Instance.new("TextButton")
    plus.Size = UDim2.fromOffset(22, 20)
    plus.Position = UDim2.new(1, -28, 0, 3)
    plus.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    plus.TextColor3 = TXT
    plus.TextSize = 14
    plus.Font = Enum.Font.GothamBold
    plus.Text = "+"
    plus.BorderSizePixel = 0
    corner(plus, 4)
    plus.Parent = r

    minus.MouseButton1Click:Connect(function()
        local nv = math.max(minv, get() - step)
        set(nv)
        val.Text = tostring(nv)
    end)
    plus.MouseButton1Click:Connect(function()
        local nv = math.min(maxv, get() + step)
        set(nv)
        val.Text = tostring(nv)
    end)
    return r
end

local PART_LIST = {
    { "智能", "Smart" }, { "头部", "Head" }, { "上躯干", "UpperTorso" },
    { "下躯干", "LowerTorso" }, { "身体中心", "HumanoidRootPart" },
    { "左上臂", "LeftUpperArm" }, { "右上臂", "RightUpperArm" },
    { "左上腿", "LeftUpperLeg" }, { "右上腿", "RightUpperLeg" },
}

local function mkCycle(label, list, index, onchange)
    local cur = index
    local r, l, v = mkRow(label)
    local function refresh()
        v.Text = list[cur][1]
        v.TextColor3 = Color3.fromRGB(120, 190, 255)
        v.Size = UDim2.new(0, 78, 1, 0)
        v.Position = UDim2.new(1, -82, 0, 0)
    end
    refresh()
    r.MouseButton1Click:Connect(function()
        cur = cur + 1
        if cur > #list then cur = 1 end
        refresh()
        onchange(list[cur][2], list[cur][1])
    end)
    return r
end

-- 分区：静默瞄准
mkHeader("静默瞄准")
mkToggle("开启静默瞄准", function() return RVS.on end, function(v)
    if v then
        if rvInstall() then
            RVS.on = true
            rvLoopStart()
        else
            RVS.on = false
        end
    else
        rvUninstall()
    end
end)
mkCycle("瞄准部位", PART_LIST, 1, function(key)
    RVS.part = key
end)
mkNudge("视野范围(像素)", function() return RVS.fov end, function(v) RVS.fov = v end, 10, 60, 600)
mkNudge("命中率 %", function() return RVS.hit end, function(v) RVS.hit = v end, 5, 0, 100)
mkNudge("最远命中距离", function() return RVS.maxDist end, function(v) RVS.maxDist = v end, 25, 50, 900)
mkToggle("只打对局对手", function() return RVS.duelOnly end, function(v) RVS.duelOnly = v end)
mkToggle("穿墙检测", function() return RVS.wall end, function(v) RVS.wall = v end)
mkToggle("锁定当前目标", function() return RVS.sticky end, function(v) RVS.sticky = v end)
mkToggle("显示视野圈", function() return RVS.circle end, function(v)
    RVS.circle = v
    if v then
        if not rvCircleMake() then
            afNotify("竞争对手", "执行器不支持 Drawing，画不了视野圈", 4)
        end
        rvLoopStart()
    else
        rvCircleDel()
    end
end)

-- 分区：透视
mkHeader("透视")
mkToggle("开启透视", function() return RVS.esp end, function(v)
    RVS.esp = v
    if v then
        rvLoopStart()
        pcall(rvEspTick)
    else
        rvEspClear()
    end
end)
mkToggle("显示血量与武器", function() return RVS.info end, function(v) RVS.info = v end)

local clearBtn, _, clearVal = mkRow("清除透视")
clearVal.Text = "›"
clearVal.TextColor3 = TXT
clearBtn.MouseButton1Click:Connect(function()
    RVS.esp = false
    rvEspClear()
    afNotify("竞争对手", "透视已清除", 3)
end)

-- 分区：模块状态
mkHeader("模块状态")
local depLabel = Instance.new("TextLabel")
depLabel.Size = UDim2.new(1, -8, 0, 30)
depLabel.BackgroundTransparency = 1
depLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
depLabel.TextSize = 11
depLabel.TextWrapped = true
depLabel.Font = Enum.Font.Gotham
depLabel.TextXAlignment = Enum.TextXAlignment.Left
depLabel.Text = " 依赖: PlayerScripts.Modules.ItemTypes.Gun / Controllers / ReplicatedStorage.Modules.Utility"
depLabel.LayoutOrder = nextOrder()
depLabel.Parent = body

local chkBtn, _, chkVal = mkRow("检测模块状态")
chkVal.Text = "›"
chkVal.TextColor3 = TXT
chkBtn.MouseButton1Click:Connect(function()
    rvLoad()
    local tip = "Gun" .. (rvGun and "就绪" or "缺失")
        .. " · 战斗" .. (rvFighter and "就绪" or "缺失")
        .. " · 对局" .. (rvDuel and "就绪" or "缺失")
        .. " · Utility" .. (rvUtility and "就绪" or "缺失")
    afNotify("竞争对手", tip, 5)
end)

local reBtn, _, reVal = mkRow("重新连接模块")
reVal.Text = "›"
reVal.TextColor3 = TXT
reBtn.MouseButton1Click:Connect(function()
    if rvHooked then rvUninstall() end
    rvLoad()
    afNotify("竞争对手", "已重新读取模块", 3)
end)

local offBtn, _, offVal = mkRow("关闭并还原全部")
offVal.Text = "›"
offVal.TextColor3 = Color3.fromRGB(255, 140, 140)
offBtn.MouseButton1Click:Connect(function()
    rvUninstall()
    rvLoopStop()
    rvCircleDel()
    rvEspClear()
    afNotify("竞争对手", "已还原", 3)
end)

-- 角落小按钮
local mini = Instance.new("TextButton")
mini.Name = "Mini"
mini.Size = UDim2.fromOffset(46, 46)
mini.Position = UDim2.fromOffset(10, 70)
mini.BackgroundColor3 = BG
mini.TextColor3 = ACCENT
mini.TextSize = 14
mini.Font = Enum.Font.GothamBold
mini.Text = "阿风"
mini.BorderSizePixel = 0
mini.Visible = false
corner(mini, 8)
mini.Parent = sg

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = ACCENT
miniStroke.Thickness = 1
miniStroke.Transparency = 0.4
miniStroke.Parent = mini

close.MouseButton1Click:Connect(function()
    main.Visible = false
    mini.Visible = true
end)
mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)

-- 拖动（按住标题栏）
local dragging, dragStart, startPos = false, nil, nil
title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
title.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y
        )
    end
end)

-- 启动提示
if isRivals then
    afNotify("阿风脚本", "竞争对手面板已加载，功能默认关闭", 4)
else
    afNotify("阿风脚本", "当前不是竞争对手服务器，功能可能无效", 5)
end
warn("[阿风脚本] 竞争对手独立面板已加载 · 挂载位置=" .. tostring(sg.Parent and sg.Parent.Name or "无"))
