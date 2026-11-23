-- ===================== 反作弊绕过 / 防检测 =====================
pcall(function()
    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local CoreGui = game:GetService("CoreGui")

    getgenv().AC_Bypass = true
    getgenv().AC_KickBlocked = 0

    -- 1) 拦截 Kick（__namecall 与实例方法双重）
    pcall(function()
        local rawmt = rawget(_G, "getrawmetatable")
        local setro = rawget(_G, "setreadonly")
        local newc  = rawget(_G, "newcclosure")
        if rawmt and setro and newc then
            local mt = rawmt(game)
            local oldNamecall = mt.__namecall
            setro(mt, false)
            mt.__namecall = newc(function(self, ...)
                if getnamecallmethod() == "Kick" then
                    getgenv().AC_KickBlocked = (getgenv().AC_KickBlocked or 0) + 1
                    return nil
                end
                return oldNamecall(self, ...)
            end)
            setro(mt, true)
        end
    end)

    pcall(function()
        local hookf = rawget(_G, "hookfunction")
        if hookf then
            local oldKick
            oldKick = hookf(LP.Kick, function(self, ...)
                if self == LP then
                    getgenv().AC_KickBlocked = (getgenv().AC_KickBlocked or 0) + 1
                    return nil
                end
                return oldKick(self, ...)
            end)
        end
    end)

    -- 2) 反作弊上报屏蔽（拦截带检测关键字的远程调用）
    pcall(function()
        local rawmt = rawget(_G, "getrawmetatable")
        local setro = rawget(_G, "setreadonly")
        local newc  = rawget(_G, "newcclosure")
        local bad = {"detect", "anticheat", "anti_cheat", "cheat", "exploit", "banned", "banplayer", "kickplayer"}
        if rawmt and setro and newc then
            local mt = rawmt(game)
            local oldNamecall = mt.__namecall
            setro(mt, false)
            mt.__namecall = newc(function(self, ...)
                local m = getnamecallmethod()
                if (m == "FireServer" or m == "InvokeServer") and typeof(self) == "Instance" then
                    local nm = string.lower(self.Name)
                    for i = 1, #bad do
                        if string.find(nm, bad[i], 1, true) then return nil end
                    end
                end
                return oldNamecall(self, ...)
            end)
            setro(mt, true)
        end
    end)

    -- 3) 界面守卫：被反作弊移出 CoreGui 时自动拉回
    pcall(function()
        task.spawn(function()
            while task.wait(2) do
                pcall(function()
                    local gui = CoreGui:FindFirstChild("frosty")
                    if gui and gui.Parent ~= CoreGui then gui.Parent = CoreGui end
                    if gui and not gui.Enabled and getgenv().AC_ForceOn then gui.Enabled = true end
                end)
            end
        end)
    end)

    -- 4) 提示
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "『阿风脚本』",
            Text = "反作弊绕过已开启",
            Icon = "rbxassetid://92833142656790",
            Duration = 4,
        })
    end)
end)
-- ==============================================================

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "『阿风脚本』"; Text ="防踢已开启"; Icon = "rbxassetid://92833142656790"; Duration = 1; })
 wait(2)

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "『阿风脚本』"; Text ="加载成功 祝你愉快"; Icon = "rbxassetid://92833142656790"; Duration = 1; })
 wait(1)

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/FD2Team/archive/main/notificationtest"))();
local Notify = Notification.Notify;

 Notify({
		 Description = "阿风";
		 Title = "认准";
		 Duration = 5;
		 
});

local dropdown = {}
local playernamedied = ""

for i, player in pairs(game.Players:GetPlayers()) do
    dropdown[i] = player.Name
end

function Notify(top, text, ico, dur)
  game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = top,
    Text = text,
    Icon = ico,
    Duration = dur,
  })
end

local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
    LastIteration = tick()
    for Index = #FrameUpdateTable, 1, -1 do
        FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
    end
    FrameUpdateTable[1] = LastIteration
    local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
    CurrentFPS = CurrentFPS - CurrentFPS % 1
    FpsLabel.Text = ("阿风时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

local Lengui = loadstring(game:HttpGet("https://tinyurl.com/2xjc5yj3"))()
local win = Lengui:new("阿风脚本V3")
--
local UITab1 = win:Tab("『信息』",'16060333448')

local about = UITab1:section("『信息』",false)

about:Label("欢迎使用阿风脚本")
about:Label("作者: 阿风")
about:Label("作者QQ: 3157360048")
about:Label("QQ群: 807981614")
about:Label("持续更新中")
about:Label("务必加入QQ群以获取更新")

local UITab1 = win:Tab("『测试员必看』",'16060333448')

local about = UITab1:section("『使用须知』",false)

about:Label("可正常使用：🟢")
about:Label("不可使用：🔴")
about:Label("可能有异常：🟠")

local UITab3 = win:Tab("『技术测试员』",'16060333448')

local about = UITab3:section("『技术测试员』",false)
    
about:Label("阿风")

local UITab5 = win:Tab("『复制阿风脚本群』",'16060333448')

local about = UITab5:section("『复制阿风脚本群』",false)

    about:Button("点我复制阿风脚本交流群",function()
    setclipboard("807981614")
end)

    about:Button("点我复制作者QQ",function()
    setclipboard("3157360048")
end)

local UITab6 = win:Tab("『通用功能』",'16060333448')

local about = UITab6:section("『其他功能』",false)

local Players = about:Dropdown("选择玩家", 'Dropdown', dropdown, function(v)
    playernamedied = v
end)

game.Players.ChildAdded:Connect(function(player)
    dropdown[player.UserId] = player.Name
    Players:AddOption(player.Name)
end)

game.Players.ChildRemoved:Connect(function(player)
    Players:RemoveOption(player.Name)
    for k, v in pairs(dropdown) do
        if v == player.Name then
            dropdown[k] = nil
        end
    end
end)

about:Button("传送到玩家旁边", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        HumRoot.CFrame = tp_player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("阿风", "已经传送到玩家身边", "rbxassetid://", 5)
    else
        Notify("阿风", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

about:Button("把玩家传送过来", function()
    local HumRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
    local tp_player = game.Players:FindFirstChild(playernamedied)
    if tp_player and tp_player.Character and tp_player.Character.HumanoidRootPart then
        tp_player.Character.HumanoidRootPart.CFrame = HumRoot.CFrame + Vector3.new(0, 3, 0)
        Notify("阿风", "已传送过来", "rbxassetid://", 5)
    else
        Notify("阿风", "无法传送 玩家已消失", "rbxassetid://", 5)
    end
end)

about:Toggle("查看玩家", 'Toggleflag', false, function(state)
    if state then
        game:GetService('Workspace').CurrentCamera.CameraSubject =
            game:GetService('Players'):FindFirstChild(playernamedied).Character.Humanoid
            Notify("阿风", "已开启", "rbxassetid://", 5)
    else
        Notify("阿风", "已关闭", "rbxassetid://", 5)
        local lp = game.Players.LocalPlayer
        game:GetService('Workspace').CurrentCamera.CameraSubject = lp.Character.Humanoid
    end
end)

about:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)

about:Toggle("脚本框架变小一点", "", false, function(state)
        if state then
        game:GetService("CoreGui")["frosty"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty"].Main.Style = "Custom"
        end
    end)
    about:Button("关闭脚本",function()
        game:GetService("CoreGui")["frosty"]:Destroy()
    end)

local about = UITab6:section("『自瞄与子追』",false)

about:Button("阿风自瞄(带圈圈)仅限PC",function()
loadstring(game:HttpGet("https://tinyurl.com/2xw6lfsl"))()
end)

about:Button("自瞄子追",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
end)

local about = UITab6:section("『范围』",false)

about:Textbox("头部范围 推荐", "Gravity", "输入", function(Value)
    _G.HeadSize = Value
    _G.Disabled = true
    game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
    pcall(function()
    v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
    v.Character.Head.Transparency = 1
    v.Character.Head.BrickColor = BrickColor.new("Red")
    v.Character.Head.Material = "Neon"
    v.Character.Head.CanCollide = false
    v.Character.Head.Massless = true
    end)
    end
    end
    end
    end)
end)

about:Textbox("自定义范围", "HitBox", "输入", function(Value)
   _G.HeadSize = Value
    _G.Disabled = true 
   game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then 
    pcall(function()
    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize) 
   v.Character.HumanoidRootPart.Transparency = 0.7 
   v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
    v.Character.HumanoidRootPart.Material = "Neon"
    v.Character.HumanoidRootPart.CanCollide = false
    end)
    end 
   end 
   end
    end)
end)

local about = UITab6:section("『飞』",false)

about:Button("飞车",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/-V2.0/refs/heads/main/%E5%86%B7%E9%A3%9E%E8%BD%A6%E6%BA%90%E7%A0%81.txt"))()
end)

about:Button("阿风飞行",function()
loadstring(game:HttpGet("https://pastebin.com/raw/NB3MBpPs"))()
end)

local about = UITab6:section("『通用功能』",false)

about:Button("反挂机v2",function()
  loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)
    
about:Button("获得管理员权限",function()
loadstring(game:HttpGet("https://pastebin.com/raw/sZpgTVas"))()
end)

about:Button("死亡笔记",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt"))()
end)

about:Button("汉化穿墙",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/OtherScript/main/Noclip"))()
end)

about:Toggle("夜视","Toggle",false,function(Value)
if Value then

		    game.Lighting.Ambient = Color3.new(1, 1, 1)

		else

		    game.Lighting.Ambient = Color3.new(0, 0, 0)

		end
end)

about:Toggle("自动互动", "Auto Interact", false, function(state)
        if state then
            autoInteract = true
            while autoInteract do
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("ProximityPrompt") then
                        fireproximityprompt(descendant)
                    end
                end
                task.wait(0.25) -- Adjust the wait time as needed
            end
        else
            autoInteract = false
        end
    end)

about:Toggle("无限跳","Toggle",false,function(Value)
        Jump = Value
        game.UserInputService.JumpRequest:Connect(function()
            if Jump then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end)

about:Slider("步行速度!", "WalkSpeed", game.Players.LocalPlayer.Character.Humanoid.WalkSpeed, 16, 400, false, function(Speed)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed end end)
end)

about:Slider("跳跃高度!", "JumpPower", game.Players.LocalPlayer.Character.Humanoid.JumpPower, 50, 400, false, function(Jump)
  spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump end end)
end)

about:Button("甩人",function()
loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)
about:Slider('设置重力', 'Sliderflag', 196.2, 196.2, 1000,false, function(Value)
        game.Workspace.Gravity = Value
    end)
    
about:Button("替身",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain')))()
end)

about:Button("爬墙",function()
loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

about:Button("iw指令", function()
  loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

about:Button("工具挂",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
end)

about:Button("铁拳",function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

about:Toggle("ESP 显示玩家", "ESP", false, function(state)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                if state then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.Adornee = player.Character

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = player.Character
                    billboard.Adornee = player.Character
                    billboard.Size = UDim2.new(0, 100, 0, 100)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true

                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Parent = billboard
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.TextScaled = true

                    local circle = Instance.new("ImageLabel")
                    circle.Parent = billboard
                    circle.Size = UDim2.new(0, 50, 0, 50)
                    circle.Position = UDim2.new(0.5, 0, 0.5, 0) -- Center the circle
                    circle.AnchorPoint = Vector2.new(0.5, 0.5) -- Set the anchor point to the center
                    circle.BackgroundTransparency = 1
                    circle.Image = "rbxassetid://2200552246" -- Replace with your circle image asset ID
                else
                    if player.Character:FindFirstChildOfClass("Highlight") then
                        player.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                    if player.Character:FindFirstChildOfClass("BillboardGui") then
                        player.Character:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end)

about:Button("透视 ESP",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
end)

about:Button("隐身（指令挂）",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

about:Button("电脑键盘",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)

about:Button("改fps",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/gclich/FPS-X-GUI/main/FPS_X.lua"))()
end)

about:Button("fps显示",function()
loadstring(game:HttpGet("https://pastefy.app/d9j82YJr/raw",false))()
end)

about:Button("解帧",function()
loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-FpsBoost-9260"))()
end)

about:Button("踏空行走",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
end)

about:Button("自杀",function()
game.Players.LocalPlayer.Character.Humanoid.Health=0
end)

about:Button("反挂机",function()
    loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
end)

about:Button("旋转",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%97%8B%E8%BD%AC.lua"))()
end)

about:Button("spy",function()
getgenv().Spy="汉化Spy" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/refs/heads/main/spy%E6%B1%89%E5%8C%96%20(1).txt"))()
end)

about:Button("位置仪",function()
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local copy = Instance.new("TextButton")
local pos = Instance.new("TextBox")
local find = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.639646292, 0, 0.399008662, 0)
Frame.Size = UDim2.new(0, 387, 0, 206)
Frame.Active = true
 
title.Name = "title"
title.Parent = Frame
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.BorderSizePixel = 0
title.Size = UDim2.new(0, 387, 0, 50)
title.Font = Enum.Font.GothamBold
title.Text = "位置仪"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 30.000
title.TextWrapped = true
 
copy.Name = "copy"
copy.Parent = Frame
copy.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
copy.BorderSizePixel = 0
copy.Position = UDim2.new(0.527131796, 0, 0.635922313, 0)
copy.Size = UDim2.new(0, 148, 0, 50)
copy.Font = Enum.Font.GothamSemibold
copy.Text = "复制"
copy.TextColor3 = Color3.fromRGB(255, 255, 255)
copy.TextSize = 20.000
 
pos.Name = "pos"
pos.Parent = Frame
pos.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
pos.BorderSizePixel = 0
pos.Position = UDim2.new(0.0904392749, 0, 0.305825233, 0)
pos.Size = UDim2.new(0, 317, 0, 50)
pos.Font = Enum.Font.GothamSemibold
pos.Text = ""
pos.TextColor3 = Color3.fromRGB(255, 255, 255)
pos.TextSize = 14.000
pos.TextWrapped = true
 
find.Name = "find"
find.Parent = Frame
find.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
find.BorderSizePixel = 0
find.Position = UDim2.new(0.0904392898, 0, 0.635922313, 0)
find.Size = UDim2.new(0, 148, 0, 50)
find.Font = Enum.Font.GothamSemibold
find.Text = "查找当前位置"
find.TextColor3 = Color3.fromRGB(255, 255, 255)
find.TextSize = 20.000
 
-- Scripts:
 
local function UMTQ_fake_script() -- copy.LocalScript 
	local script = Instance.new('LocalScript', copy)
 
	script.Parent.MouseButton1Click:Connect(function()
		setclipboard(script.Parent.Parent.pos.Text)
	end)
end
coroutine.wrap(UMTQ_fake_script)()
local function KJAYG_fake_script() -- Frame.Dragify 
	local script = Instance.new('LocalScript', Frame)
 
	local UIS = game:GetService("UserInputService")
	function dragify(Frame)
	    dragToggle = nil
	    local dragSpeed = 0
	    dragInput = nil
	    dragStart = nil
	    local dragPos = nil
	    function updateInput(input)
	        local Delta = input.Position - dragStart
	        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	        game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
	    end
	    Frame.InputBegan:Connect(function(input)
	        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
	            dragToggle = true
	            dragStart = input.Position
	            startPos = Frame.Position
	            input.Changed:Connect(function()
	                if input.UserInputState == Enum.UserInputState.End then
	                    dragToggle = false
	                end
	            end)
	        end
	    end)
	    Frame.InputChanged:Connect(function(input)
	        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	            dragInput = input
	        end
	    end)
	    game:GetService("UserInputService").InputChanged:Connect(function(input)
	        if input == dragInput and dragToggle then
	            updateInput(input)
	        end
	    end)
	end
 
	dragify(script.Parent)
end
coroutine.wrap(KJAYG_fake_script)()
local function EKBNYI_fake_script() -- find.LocalScript 
	local script = Instance.new('LocalScript', find)
 
	script.Parent.MouseButton1Down:Connect(function()
		script.Parent.Parent.pos.Text = tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
	end)
end
coroutine.wrap(EKBNYI_fake_script)()
end)

local UITab7 = win:Tab("『画质光影』",'16060333448')

local about = UITab7:section("『画质光影』",false)

about:Button("光影", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("光影滤镜", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("超高画质",function()
loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

about:Button("光影V4",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)

about:Button("RTX高仿",function()
loadstring(game:HttpGet('https://pastebin.com/raw/Bkf0BJb3'))()
end)

about:Button("光影深", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml"))()
end)
about:Button("光影浅", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/jHBfJYmS"))()
end)

local UITab8 = win:Tab("『无限Robux』",'16060333448')

local about = UITab8:section("『无限Robux』",false)

about:Button("20Robux",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/CloudX-ScriptsWane/White-ash-script/main/Free%20Robux.LUA'))()
end)

about:Button("50Robux",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/CloudX-ScriptsWane/White-ash-script/main/Free%20Robux.LUA'))()
end)

about:Button("100Robux",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/CloudX-ScriptsWane/White-ash-script/main/Free%20Robux.LUA'))()
end)

about:Button("200Robux",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/CloudX-ScriptsWane/White-ash-script/main/Free%20Robux.LUA'))()
end)

about:Button("500Robux",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/CloudX-ScriptsWane/White-ash-script/main/Free%20Robux.LUA'))()
end)

about:Button("1000Robux",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/CloudX-ScriptsWane/White-ash-script/main/Free%20Robux.LUA'))()
end)

local UITab30 = win:Tab("『整合脚本 未更新』",'7734068321')

local about = UITab30:section("『整合脚本』",true)

about:Button("皮脚本",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

about:Button("叶脚本",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua"))()
end)

about:Button("名脚本",function()
loadstring(game:HttpGet("https://github.com/root-jiege/new/raw/refs/heads/main/%E5%90%8D%E8%84%9A%E6%9C%AC.txt"))()
end)

about:Button("情云脚本",function()
loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
end)

about:Button("神青脚本",function()
loadstring(game:HttpGet"https://raw.githubusercontent.com/gycgchgyfytdttr/QQ-9-2-8-9-50173/refs/heads/main/V13KS.txt")()
end)

about:Button("禁漫中心",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/ng/main/jmlllllllIIIIlllllII.lua"))()
end)

about:Button("落叶中心",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"))()
end)

about:Button("剑客V7",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Zer0neK/Hello/refs/heads/main/SG-V7"))()
end)

about:Button("XK脚本中心",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BINjiaobzx6/BINjiao/main/XK.TXT"))()
end)

local UITab30 = win:Tab("『GB🔴』",'7734068321')

local about = UITab30:section("『内脏与黑火药』",true)

about:Button("情云-内脏与黑火药",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/Scripts/Main/GB"))()
end)

local UITab30 = win:Tab("『DOORS🔴』",'7734068321')

local about = UITab30:section("『DOORS』",true)

about:Button("DOORS",function()
loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

local UITab30 = win:Tab("『鸟🔴』",'7734068321')

local about = UITab30:section("『鸟 与鱼玩法类似』",true)

about:Button("服务器名称:beaks",function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/e0f8a0809afcd8b22e64b02d363d0310.lua"))()
end)

local UITab30 = win:Tab("『鱼🔴』",'7734068321')

local about = UITab30:section("『鱼』",true)

about:Button("鱼",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Efe0626/RaitoHub/refs/heads/main/Script"))()
end)

local UITab30 = win:Tab("『挖掘它🔴』",'7734068321')

local about = UITab30:section("『挖掘它』",true)

about:Button("挖掘它",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/refs/heads/main/FrostByte/Initiate.lua"))()
end)

local UITab30 = win:Tab("『被遗弃🔴』",'7734068321')

local about = UITab30:section("『被遗弃』",true)

about:Button("被遗弃",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/refs/heads/main/FrostByte/Initiate.lua"))()
end)

local UITab30 = win:Tab("『伐木大亨2🔴』",'7734068321')

local about = UITab30:section("『伐木大亨2』",true)

about:Button("白-伐木大亨2",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/Kavo-Ui/main/%E4%BC%90%E6%9C%A8%E5%A4%A7%E4%BA%A82.lua", true))()
end)

local UITab30 = win:Tab("『索纳里亚🔴』",'7734068321')

local about = UITab30:section("『索纳里亚』",true)

about:Button("索纳里亚",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/refs/heads/main/FrostByte/Initiate.lua"))()
end)

local UITab30 = win:Tab("『一路向西🟢』",'16060333448')

local SGV_Tab = UITab30:section("无法奔跑请重置人物",false)

local SGV_Tab = UITab30:section("人物模式",false)

SGV_Tab:Toggle("无限跳跃","开关",false,function(v)
    Jump = v
    game.UserInputService.JumpRequest:Connect(function()
        if Jump then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end)

SGV_Tab:Toggle("动物透视","开关",false,function(v)
	getgenv().esp = v
	esp()
end)

SGV_Tab:Button("开启透视",function()

        _G.FriendColor = Color3.fromRGB(0, 0, 255)
        _G.EnemyColor = Color3.fromRGB(255, 0, 0)
        _G.UseTeamColor = true
        
        --------------------------------------------------------------------
        local Holder = Instance.new("Folder", game.CoreGui)
        Holder.Name = "ESP"
        
        local Box = Instance.new("BoxHandleAdornment")
        Box.Name = "nilBox"
        Box.Size = Vector3.new(1, 2, 1)
        Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
        Box.Transparency = 0.7
        Box.ZIndex = 0
        Box.AlwaysOnTop = false
        Box.Visible = false
        
        local NameTag = Instance.new("BillboardGui")
        NameTag.Name = "nilNameTag"
        NameTag.Enabled = false
        NameTag.Size = UDim2.new(0, 200, 0, 50)
        NameTag.AlwaysOnTop = true
        NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
        local Tag = Instance.new("TextLabel", NameTag)
        Tag.Name = "Tag"
        Tag.BackgroundTransparency = 1
        Tag.Position = UDim2.new(0, -50, 0, 0)
        Tag.Size = UDim2.new(0, 300, 0, 20)
        Tag.TextSize = 15
        Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
        Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
        Tag.TextStrokeTransparency = 0.4
        Tag.Text = "nil"
        Tag.Font = Enum.Font.SourceSansBold
        Tag.TextScaled = false
        
        local LoadCharacter = function(v)
            repeat wait() until v.Character ~= nil
            v.Character:WaitForChild("Humanoid")
            local vHolder = Holder:FindFirstChild(v.Name)
            vHolder:ClearAllChildren()
            local b = Box:Clone()
            b.Name = v.Name .. "Box"
            b.Adornee = v.Character
            b.Parent = vHolder
            local t = NameTag:Clone()
            t.Name = v.Name .. "NameTag"
            t.Enabled = true
            t.Parent = vHolder
            t.Adornee = v.Character:WaitForChild("Head", 5)
            if not t.Adornee then
                return UnloadCharacter(v)
            end
            t.Tag.Text = v.Name
            b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
            t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
            local Update
            local UpdateNameTag = function()
                if not pcall(function()
                        v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        local maxh = math.floor(v.Character.Humanoid.MaxHealth)
                        local h = math.floor(v.Character.Humanoid.Health)
                    end) then
                    Update:Disconnect()
                end
            end
            UpdateNameTag()
            Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
        end
        
        local UnloadCharacter = function(v)
            local vHolder = Holder:FindFirstChild(v.Name)
            if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
                vHolder:ClearAllChildren()
            end
        end
        
        local LoadPlayer = function(v)
            local vHolder = Instance.new("Folder", Holder)
            vHolder.Name = v.Name
            v.CharacterAdded:Connect(function()
                pcall(LoadCharacter, v)
            end)
            v.CharacterRemoving:Connect(function()
                pcall(UnloadCharacter, v)
            end)
            v.Changed:Connect(function(prop)
                if prop == "TeamColor" then
                    UnloadCharacter(v)
                    wait()
                    LoadCharacter(v)
                end
            end)
            LoadCharacter(v)
        end
        
        local UnloadPlayer = function(v)
            UnloadCharacter(v)
            local vHolder = Holder:FindFirstChild(v.Name)
            if vHolder then
                vHolder:Destroy()
            end
        end
        
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            spawn(function() pcall(LoadPlayer, v) end)
        end
        
        game:GetService("Players").PlayerAdded:Connect(function(v)
            pcall(LoadPlayer, v)
        end)
        
        game:GetService("Players").PlayerRemoving:Connect(function(v)
            pcall(UnloadPlayer, v)
        end)
        
        game:GetService("Players").LocalPlayer.NameDisplayDistance = 0
        
        if _G.Reantheajfdfjdgs then
            return
        end
        
        _G.Reantheajfdfjdgs = ":suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df"
        
        local players = game:GetService("Players")
        local plr = players.LocalPlayer
        
        function esp(target, color)
            if target.Character then
                if not target.Character:FindFirstChild("GetReal") then
                    local highlight = Instance.new("Highlight")
                    highlight.RobloxLocked = true
                    highlight.Name = "GetReal"
                    highlight.Adornee = target.Character
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillColor = color
                    highlight.Parent = target.Character
                else
                    target.Character.GetReal.FillColor = color
                end
            end
        end
        
        while task.wait() do
            for i, v in pairs(players:GetPlayers()) do
                if v ~= plr then
                    esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
                end
            end
        end
end)

SGV_Tab:Button("无跌落伤害",function()
    local gamemt = getrawmetatable(game)
	local oldNc = gamemt.__namecall
	setreadonly(gamemt, false)
	
	gamemt.__namecall = newcclosure(function(self, ...)
	if (getnamecallmethod() == 'FireServer' and self.Name == 'ChangeCharacter') then
		local args = {...}
		if (args[1] and args[1] == 'Damage') then
		return nil
		end
	end 
	return oldNc(self, ...)
	end)
end)

SGV_Tab:Button("快速拾取",function()
    local v15 = require(game:GetService("Workspace")[game.Players.LocalPlayer.Name].ContextActions.ContextMain);
	v15:New({
	RobPlayerLength = 0.1, 
	FixWallLength = 0.1, 
	CrackSafeLength = 0.1, 
	RobSafeLength = 0.1, 
	RobRegisterLength = 0.1, 
	PickCellLength = 0.1, 
	SkinAnimalLength = 0.1
	}, 200, 
	{ "Get out of my shop! Outlaws are not welcome here!", "Hey, scoundrel! Get out before I call the sheriff!", "You're an outlaw! We don't serve your type here!" }, 
	{ "This here's a bandit camp! Get out!", "Get lost, cowboy!", "Are you an outlaw? Didn't think so! Scram!" });
end)

local SGV_Tab = UITab30:section("范围模式",false)
    SGV_Tab:Textbox("头部范围", "Gravity", "输入", function(v)
    _G.HeadSize = v
    _G.Disabled = true
    game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
    pcall(function()
    v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
    v.Character.Head.Transparency = 1
    v.Character.Head.BrickColor = BrickColor.new("Red")
    v.Character.Head.Material = "Neon"
    v.Character.Head.CanCollide = false
    v.Character.Head.Massless = true
    end)
    end
    end
    end
    end)
end)

local SGV_Tab = UITab30:section("武器模式",false)

SGV_Tab:Button("无后座力",function()
	local mods = {
		FanFire = true, 
		camShakeResist = 0, 
		prepTime = 0, 
		equipTime = 0, 
		Spread = 0, 
		InstantFireAnimation = true
	}

	for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
		for prop, value in pairs(mods) do
			if gun[prop] then
				gun[prop] = value
			end
		end
	end
end)

SGV_Tab:Button("子弹汇聚",function()
    local mods = {
		FanFire = true, 
		prepTime = 0, 
		equipTime = 0, 
		camShakeResist = 0, 
		ReloadAnimationSpeed = 10, 
		ReloadSpeed = 0, 
		Spread = 0, 
		HipFireAccuracy = 0, 
		ZoomAccuracy = 0, 
		InstantFireAnimation = true
	}

	for _, gun in pairs(require(game:GetService("ReplicatedStorage").GunScripts.GunStats)) do
		for prop, value in pairs(mods) do
			if gun[prop] then
				gun[prop] = value
			end
		end
	end
end)



local SGV_Tab = UITab30:section("购买模式",false)

SGV_Tab:Label("需要靠近NPC")

SGV_Tab:Toggle("自动出售","开关",false,function(v)
	getgenv().sell = v
	sell()
end)

SGV_Tab:Toggle("手枪子弹","开关",false,function(v)
	getgenv().buyammo1 = v
	buyammo1()
end)

SGV_Tab:Toggle("步枪子弹","开关",false,function(v)
	getgenv().buyammo2 = v
	buyammo2()
end)

SGV_Tab:Toggle("购买箭矢","开关",false,function(v)
	getgenv().buyammo3 = v
	buyammo3()
end)

SGV_Tab:Toggle("霰弹子弹","开关",false,function(v)
	getgenv().buyammo4 = v
	buyammo4()
end)

SGV_Tab:Toggle("狙击子弹","开关",false,function(v)
	getgenv().buyammo5 = v
	buyammo5()
end)

SGV_Tab:Toggle("小型炸药","开关",false,function(v)
	getgenv().buyammo6 = v
	buyammo6()
end)

SGV_Tab:Toggle("大型炸药","开关",false,function(v)
	getgenv().buyammo7 = v
	buyammo7()
end)

local SGV_Tab = UITab30:section("白天模式",false)

SGV_Tab:Toggle("白天","开关",false,function()
    if not _G.FullBrightExecuted then

        _G.FullBrightEnabled = false
    
        _G.NormalLightingSettings = {
            Brightness = game:GetService("Lighting").Brightness,
            ClockTime = game:GetService("Lighting").ClockTime,
            FogEnd = game:GetService("Lighting").FogEnd,
            GlobalShadows = game:GetService("Lighting").GlobalShadows,
            Ambient = game:GetService("Lighting").Ambient
        }
    
        game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
            if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
                _G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").Brightness = 1
            end
        end)
    
        game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
            if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
                _G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").ClockTime = 12
            end
        end)
    
        game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
            if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
                _G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").FogEnd = 786543
            end
        end)
    
        game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
            if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
                _G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").GlobalShadows = false
            end
        end)
    
        game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
            if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
                _G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
                if not _G.FullBrightEnabled then
                    repeat
                        wait()
                    until _G.FullBrightEnabled
                end
                game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
            end
        end)
    
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 786543
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
    
        local LatestValue = true
        spawn(function()
            repeat
                wait()
            until _G.FullBrightEnabled
            while wait() do
                if _G.FullBrightEnabled ~= LatestValue then
                    if not _G.FullBrightEnabled then
                        game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
                        game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
                        game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
                        game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
                        game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
                    else
                        game:GetService("Lighting").Brightness = 1
                        game:GetService("Lighting").ClockTime = 12
                        game:GetService("Lighting").FogEnd = 786543
                        game:GetService("Lighting").GlobalShadows = false
                        game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                    end
                    LatestValue = not LatestValue
                end
            end
        end)
    end
    
    _G.FullBrightExecuted = true
    _G.FullBrightEnabled = not _G.FullBrightEnabled
end)

local SGV_UI_Tab = win:Tab("『战争大亨🟠』")

local SGV_Tab = SGV_UI_Tab:section("基地模式",false)
SGV_Tab:Button("删除门",function()
    for k,v in pairs(Workspace.Tycoon.Tycoons:GetChildren()) do
        for x,y in pairs(v.PurchasedObjects:GetChildren()) do
            if(y.Name:find("Door") or y.Name:find("Gate")) then y:destroy(); end;
        end;
    end;
end)


local SGV_Tab = SGV_UI_Tab:section("速度模式",false)

SGV_Tab:Toggle("速度 (开/关)","开关",false,function(v)
    if v == true then
        sudu = game:GetService("RunService").Heartbeat:Connect(function()
            if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 10)
                end
            end
        end)
    elseif not v and sudu then
        sudu:Disconnect()
        sudu = nil
    end
end)

SGV_Tab:Slider('速度设置', '拉条',  1, 0, 100,false, function(v)
    Speed = v
end)

local SGV_Tab = SGV_UI_Tab:section("跳跃模式",false)

SGV_Tab:Button("无限跳跃",function()
    game:GetService("UserInputService").JumpRequest:connect(function()
        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")		
    end)
end)

--欢迎使用阿风脚本
local SGV_Tab = SGV_UI_Tab:section("透视模式",false)

SGV_Tab:Button("开启透视",function()

    _G.FriendColor = Color3.fromRGB(0, 0, 255)
        _G.EnemyColor = Color3.fromRGB(255, 0, 0)
        _G.UseTeamColor = true
        
        --------------------------------------------------------------------
        local Holder = Instance.new("Folder", game.CoreGui)
        Holder.Name = "ESP"
        
        local Box = Instance.new("BoxHandleAdornment")
        Box.Name = "nilBox"
        Box.Size = Vector3.new(1, 2, 1)
        Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
        Box.Transparency = 0.7
        Box.ZIndex = 0
        Box.AlwaysOnTop = false
        Box.Visible = false
        
        local NameTag = Instance.new("BillboardGui")
        NameTag.Name = "nilNameTag"
        NameTag.Enabled = false
        NameTag.Size = UDim2.new(0, 200, 0, 50)
        NameTag.AlwaysOnTop = true
        NameTag.StudsOffset = Vector3.new(0, 1.8, 0)
        local Tag = Instance.new("TextLabel", NameTag)
        Tag.Name = "Tag"
        Tag.BackgroundTransparency = 1
        Tag.Position = UDim2.new(0, -50, 0, 0)
        Tag.Size = UDim2.new(0, 300, 0, 20)
        Tag.TextSize = 15
        Tag.TextColor3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
        Tag.TextStrokeColor3 = Color3.new(0 / 255, 0 / 255, 0 / 255)
        Tag.TextStrokeTransparency = 0.4
        Tag.Text = "nil"
        Tag.Font = Enum.Font.SourceSansBold
        Tag.TextScaled = false
        
        local LoadCharacter = function(v)
            repeat wait() until v.Character ~= nil
            v.Character:WaitForChild("Humanoid")
            local vHolder = Holder:FindFirstChild(v.Name)
            vHolder:ClearAllChildren()
            local b = Box:Clone()
            b.Name = v.Name .. "Box"
            b.Adornee = v.Character
            b.Parent = vHolder
            local t = NameTag:Clone()
            t.Name = v.Name .. "NameTag"
            t.Enabled = true
            t.Parent = vHolder
            t.Adornee = v.Character:WaitForChild("Head", 5)
            if not t.Adornee then
                return UnloadCharacter(v)
            end
            t.Tag.Text = v.Name
            b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
            t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
            local Update
            local UpdateNameTag = function()
                if not pcall(function()
                        v.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        local maxh = math.floor(v.Character.Humanoid.MaxHealth)
                        local h = math.floor(v.Character.Humanoid.Health)
                    end) then
                    Update:Disconnect()
                end
            end
            UpdateNameTag()
            Update = v.Character.Humanoid.Changed:Connect(UpdateNameTag)
        end
        
        local UnloadCharacter = function(v)
            local vHolder = Holder:FindFirstChild(v.Name)
            if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
                vHolder:ClearAllChildren()
            end
        end
        
        local LoadPlayer = function(v)
            local vHolder = Instance.new("Folder", Holder)
            vHolder.Name = v.Name
            v.CharacterAdded:Connect(function()
                pcall(LoadCharacter, v)
            end)
            v.CharacterRemoving:Connect(function()
                pcall(UnloadCharacter, v)
            end)
            v.Changed:Connect(function(prop)
                if prop == "TeamColor" then
                    UnloadCharacter(v)
                    wait()
                    LoadCharacter(v)
                end
            end)
            LoadCharacter(v)
        end
        
        local UnloadPlayer = function(v)
            UnloadCharacter(v)
            local vHolder = Holder:FindFirstChild(v.Name)
            if vHolder then
                vHolder:Destroy()
            end
        end
        
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            spawn(function() pcall(LoadPlayer, v) end)
        end
        
        game:GetService("Players").PlayerAdded:Connect(function(v)
            pcall(LoadPlayer, v)
        end)
        
        game:GetService("Players").PlayerRemoving:Connect(function(v)
            pcall(UnloadPlayer, v)
        end)
        
        game:GetService("Players").LocalPlayer.NameDisplayDistance = 0
        
        if _G.Reantheajfdfjdgs then
            return
        end
        
        _G.Reantheajfdfjdgs = ":suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df"
        
        local players = game:GetService("Players")
        local plr = players.LocalPlayer
        
        function esp(target, color)
            if target.Character then
                if not target.Character:FindFirstChild("GetReal") then
                    local highlight = Instance.new("Highlight")
                    highlight.RobloxLocked = true
                    highlight.Name = "GetReal"
                    highlight.Adornee = target.Character
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillColor = color
                    highlight.Parent = target.Character
                else
                    target.Character.GetReal.FillColor = color
                end
            end
        end
        
        while task.wait() do
            for i, v in pairs(players:GetPlayers()) do
                if v ~= plr then
                    esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
                end
            end
        end
end)


local SGV_Tab = SGV_UI_Tab:section("范围模式",false)
SGV_Tab:Textbox("头部范围", "Gravity", "输入", function(v)
    _G.HeadSize = v
    _G.Disabled = true
    game:GetService('RunService').RenderStepped:connect(function()
    if _G.Disabled then
    for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
    pcall(function()
    v.Character.Head.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
    v.Character.Head.Transparency = 1
    v.Character.Head.BrickColor = BrickColor.new("Red")
    v.Character.Head.Material = "Neon"
    v.Character.Head.CanCollide = false
    v.Character.Head.Massless = true
    end)
    end
    end
    end
    end)
end)

local SGV_Tab = SGV_UI_Tab:section("捕捉点传送",false)
SGV_Tab:Button("捕捉点",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-652.087158203125, 121.78434753417969, -1259.2510986328125)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

SGV_Tab:Button("捕捉点玻璃窗顶部",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-646.4267578125, 187.38427734375, -1265.0452880859375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

SGV_Tab:Button("捕捉点高楼",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-216.8485565185547, 447.56982421875, -1514.64599609375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

local SGV_Tab = SGV_UI_Tab:section("断桥传送",false)
SGV_Tab:Button("断桥Ⅰ",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-69.81941223144531, 70.02616119384766, -793.1098022460938)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

SGV_Tab:Button("断桥Ⅱ",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-680.5787963867188, 68.09300994873047, -1425.0596923828125)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

SGV_Tab:Button("断桥Ⅲ",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-1127.9139404296875, 70.02674865722656, -1737.7227783203125)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

local SGV_Tab = SGV_UI_Tab:section("基地传送",false)
SGV_Tab:Button("Alpha",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-446.5848693847656, 67.15837860107422, -4655.828125)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)

SGV_Tab:Button("Bravo",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(877.7924194335938, 67.15836334228516, -4854.021484375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Charlie",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(2178.3076171875, 67.2578125, -4048.072021484375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Delta",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(2886.37060546875, 67.2578125, -3045.22802734375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Echo",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(3182.239013671875, 67.2578125, -1740.0211181640625)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Foxtrot",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(3515.21044921875, 67.2578125, -511.40130615234375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Golf",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(3416.2080078125, 67.25782775878906, 660.7476196289062)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Hotel",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(3074.851318359375, 67.2578125, 1885.713623046875)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Kilo",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(2663.734619140625, 67.2578353881836, 3036.18115234375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
end)


SGV_Tab:Button("Lima",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(1101.6029052734375, 67.2578125, 3509.763671875)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Loading",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(856.9780883789062, 48.26701354980469, -2275.72998046875)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Omega",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-369.8501892089844, 67.2578125, 4070.253662109375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Romeo",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-1581.2449951171875, 67.25782775878906, 3823.52734375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Sierra",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-2652.007568359375, 67.15837097167969, 2606.130615234375)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Tango",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-3150.487548828125, 67.15837097167969, 1535.2030029296875)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

SGV_Tab:Button("Victor",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-3718.847900390625, 67.25780487060547, 679.558837890625)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
     
end)

SGV_Tab:Button("Zulu",function()
    local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
    local location = CFrame.new(-3712.465087890625, 67.2578125, -932.3665161132812)
    local Humanoid = game.Players.LocalPlayer.Character.Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    wait(0.2)
    pl.CFrame = location
        
end)

local SGV_Tab = SGV_UI_Tab:section("甩飞模式",false)

SGV_Tab:Button("打开甩飞窗口",function()
    local lplayer = game:GetService('Players').LocalPlayer

function GetPlayer(String)
local Found = {}
local strl = String:lower()
if strl == "all" then
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
table.insert(Found,v)
end
elseif strl == "others" then
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
if v.Name ~= lplayer.Name then
table.insert(Found,v)
end
end 
elseif strl == "me" then
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
if v.Name == lplayer.Name then
table.insert(Found,v)
end
end 
else
for i,v in pairs(game:GetService("Players"):GetPlayers()) do
if v.Name:lower():sub(1, #String) == String:lower() then
table.insert(Found,v)
end
end 
end
return Found 
end


local AutoFlingGui = Instance.new("ScreenGui")
local AutoFlingFrame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")

AutoFlingGui.Parent = game.CoreGui

AutoFlingFrame.Parent = AutoFlingGui
AutoFlingFrame.BackgroundTransparency = 1
AutoFlingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
AutoFlingFrame.BorderColor3 = Color3.new(1,1,1)
AutoFlingFrame.BorderSizePixel = 2
AutoFlingFrame.Position = UDim2.new(0.63040276, 0, 0.1, 0)
AutoFlingFrame.Size = UDim2.new(0.1,0.2,0.1)
AutoFlingFrame.Active = true
AutoFlingFrame.Draggable = true

TextBox.Parent = AutoFlingFrame
TextBox.BackgroundColor3 = Color3.new(0, 0, 0)
TextBox.BackgroundTransparency = 0.3
TextBox.BorderColor3 = Color3.new(1,1,1)
TextBox.BorderSizePixel = 1
TextBox.Position = UDim2.new(0.103524067, 0, 0.25, 0)
TextBox.Size = UDim2.new(0.8,0.9,0.2)
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.Font = Enum.Font.SourceSansLight
TextBox.FontSize = Enum.FontSize.Size14
TextBox.Text = "阿风脚本"
TextBox.TextScaled = true
TextBox.TextSize = 8
TextBox.TextWrapped = true

TextButton.Parent = AutoFlingFrame
TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.BackgroundTransparency = 0.3
TextButton.BorderColor3 = Color3.new(1,1,1)
TextButton.BorderSizePixel = 1
TextButton.Position = UDim2.new(0.2,0,0.6)
TextButton.Size = UDim2.new(0.6,0.9,0.2)
TextButton.TextColor3 = Color3.new(1,1,1)
TextButton.Text = "开始甩飞"
TextButton.TextScaled = true
TextButton.TextScaled = 22
TextButton.TextWrapped = false

ImageLabel.Parent = AutoFlingFrame
ImageLabel.Size = UDim2.new(0, 191, 0, 97)
ImageLabel.Position = UDim2.new(0.630402744, -34, 0.100000001,313)
ImageLabel.BackgroundTransparency = 1 
ImageLabel.Image = "rbxassetid://137843890417181"
ImageLabel.ImageTransparency = 0.5
ImageLabel.Position = UDim2.new(0.5, -95.5, 0.4, -48.5)
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BorderSizePixel = 0



--欢迎使用阿风脚本
local function ActiveAutoFling()
getgenv().flingloop = true
while getgenv().flingloop do
function flingloopfix()

local Targets = {""..TextBox.Text} -- "All", "Target Name"

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers,Player) then
        table.remove(GetPlayers,table.find(GetPlayers,Player))
        end
        return GetPlayers[math.random(#GetPlayers)]
    elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
        for _,x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) then
                    return x;
                elseif x.DisplayName:lower():match("^"..Name) then
                    return x;
                end
            end
        end
    else
        return
    end
end

local Message = function(_Title, _Text, Time)
    --game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessoy and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            --return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait or getgenv().flingloop == false
        end

        workspace.FallenPartsDestroyHeight = 0/0

        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            --return Message("Error Occurred", "Target is missing everything", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        --return Message("Error Occurred", "Random error", 5)
    end
end

if not Welcome then Message("阿风脚本", "中心", 5) end
getgenv().Welcome = true
if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
    for _,x in next, Players:GetPlayers() do
        SkidFling(x)
    end
end

for _,x in next, Targets do
    if GetPlayer(x) and GetPlayer(x) ~= Player then
        if GetPlayer(x).UserId ~= 1414978355 then
            local TPlayer = GetPlayer(x)
            if TPlayer then
                SkidFling(TPlayer)
            end
        else
            --Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
        end
    elseif not GetPlayer(x) and not AllBool then
        --Message("Error Occurred", "Username Invalid", 5)
    end
end
task.wait()
end
wait()
pcall(flingloopfix)
end
end
--



TextButton.MouseButton1Click:connect(function()
if TextBox.Text == ";All" then
TextBox.Text = "All"
else
TextBox.Text = unpack(GetPlayer(TextBox.Text)).Name
end
if TextButton.Text == "开始甩飞" and TextBox.Text ~= game.Players.LocalPlayer.Name and TextBox.Text ~= Ghostplayer then
TextButton.Text = "关闭甩飞"
ActiveAutoFling()
else
TextButton.Text = "开始甩飞"
getgenv().flingloop = false
end
end)
end)

local SGV_Tab = SGV_UI_Tab:section("飞天模式",false)
SGV_Tab:Label("仅限电脑注入器")
SGV_Tab:Label("Q - 下")
SGV_Tab:Label("E - 上")

SGV_Tab:Toggle("飞天","开关",false,function(v)
    settings.Fly = v
            
    if v then
        local bg = Instance.new("BodyGyro", Character.HumanoidRootPart)
        bg.P = 9e4
        bg.MaxTorque = Vector3.one * 9e9
        
        local bv = Instance.new("BodyVelocity", Character.HumanoidRootPart)
        bv.Velocity = Vector3.new(0,0,0)
        bv.MaxForce = Vector3.one * 9e9

        --local ag = Instance.new("BodyVelocity", Character.HumanoidRootPart)
        --ag.Velocity = Vector3.new(0,workspace.Gravity,0) * getMass(Character)
        --ag.MaxForce = Vector3.one * 9e9

        settings.FlyBG = bg
        settings.FlyBV = bv
        --settings.FlyAG = ag
    else
        settings.FlyBG:Destroy()
        settings.FlyBV:Destroy()
        --settings.FlyAG:Destroy()
    end
end)

SGV_Tab:Slider('飞天速度', '拉条',  1, 1, 5000,false, function(v)
    settings.FlySpeed = tonumber(v) or 10
end)


addConnection(RuS.RenderStepped, function()
    Character = Player.Character
    Humanoid = Character.Humanoid

    if Character and Humanoid then
        Humanoid.WalkSpeed = settings.WalkSpeed
        Humanoid.JumpPower = settings.JumpPower

        if Humanoid.Health > 0 and settings.Carpet then
            local carpet = settings.CarpetObject
            local yChange = 0

            

            carpet.Position = Character.HumanoidRootPart.Position - Vector3.new(0,3.05 + yChange,0)

            if settings.CarpetVisible then
                carpet.Transparency = 0.5
            else
                carpet.Transparency = 1
            end
        end

        if settings.Noclip then
            for i,v in pairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = not settings.Noclip
                end
            end
        end

        Humanoid.PlatformStand = settings.Fly

        if settings.Fly and Humanoid.Health > 0 then
            local ctrl = {f = UsS:IsKeyDown(Enum.KeyCode.W) and 1 or 0, b = UsS:IsKeyDown(Enum.KeyCode.S) and -1 or 0, l = UsS:IsKeyDown(Enum.KeyCode.A) and -1 or 0, r = UsS:IsKeyDown(Enum.KeyCode.D) and 1 or 0, u = UsS:IsKeyDown(Enum.KeyCode.E) and 1 or 0, d = UsS:IsKeyDown(Enum.KeyCode.Q) and -1 or 0}
            local look = Camera.CFrame.LookVector
            local up = Camera.CFrame.UpVector
            local right = Camera.CFrame.RightVector

            local velocity = UsS:GetFocusedTextBox() and Vector3.zero or (look * ((ctrl.f + ctrl.b) * settings.FlySpeed)) + (right * ((ctrl.l + ctrl.r) * settings.FlySpeed)) + (up * ((ctrl.u + ctrl.d) * settings.FlySpeed))

            TwS:Create(settings.FlyBG,TweenInfo.new(0.2),{CFrame = Camera.CFrame}):Play()
            TwS:Create(settings.FlyBV,TweenInfo.new(0.2),{Velocity = velocity}):Play()
        end
    end
end)

local player = game.Players.LocalPlayer
local playerTeam = player.Team
local teamName = playerTeam and playerTeam.Name or "No Team"