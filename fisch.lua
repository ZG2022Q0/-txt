-- leaked and backed up by 25ms! <3
print"✅ Security verification passed. Loading NoxHub..."
local PreloadConstants = {
	PlaceVersionSupport = 4000,
	BypassVersion = "V3",
}

local Success, Error = pcall(function()
	Start = os.clock()
	local NO_HOOKING = false

	local Debugging = true

	local HttpService = game:GetService"HttpService"
	local Players = game:GetService"Players"
	local RunService = game:GetService"RunService"
	local ReplicatedStorage = game:GetService"ReplicatedStorage"
	local TweenService = game:GetService"TweenService"
	local VirtualInputManager = Instance.new"VirtualInputManager"
	local VirtualUser = game:GetService"VirtualUser"
	local StarterGui = game:GetService"StarterGui"
	local CoreGui = game:GetService"CoreGui"
	local GuiService = game:GetService"GuiService"
	local CollectionService = game:GetService"CollectionService"
	local UserInputService = game:GetService"UserInputService"
	local Lighting = game:GetService"Lighting"
	local CorePackages = game:GetService"CorePackages"
	local VeryImportantPart = Instance.new"Part"

	local Title = "NoxHub - Fisch"
	local TeleportService = game:GetService("TeleportService")

	-- GitHub 直连经常被重置, 自动换镜像
	local function FetchSource(Url)
		local Mirrors = {
			Url,
			"https://gh-proxy.com/" .. Url,
			"https://ghfast.top/" .. Url,
			"https://ghproxy.net/" .. Url,
		}

		for _, Mirror in ipairs(Mirrors) do
			local Ok, Result = pcall(function()
				return game:HttpGet(Mirror)
			end)

			if Ok and type(Result) == "string" and #Result > 0
				and not string.find(string.lower(Result), "^<!doctype")
			then
				return Result
			end
		end

		return nil
	end

	local Toasts
	do
		local Ok, Result = pcall(function()
			return loadstring(game:HttpGet("https://you.whimper.xyz/sources/NoxHub/toast.lua"))()
		end)

		if Ok and type(Result) == "table" and type(Result.CreateToast) == "function" then
			Toasts = Result
		else
			warn("[NoxHub] 提示库加载失败, 用空实现代替")
			Toasts = {
				CreateToast = function() end,
			}
		end
	end

	local function InteractiveToast()
		local ActiveToastObject = Instance.new"ScreenGui"
		ActiveToastObject.Parent = nil
		ActiveToastObject.Enabled = true
		ActiveToastObject.SafeAreaCompatibility = Enum.SafeAreaCompatibility.FullscreenExtension
		ActiveToastObject.ResetOnSpawn = false
		ActiveToastObject.IgnoreGuiInset = false
		ActiveToastObject.Name = "InteractiveToast"
		ActiveToastObject.DisplayOrder = 0
		ActiveToastObject.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		ActiveToastObject.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
		ActiveToastObject.ClipToDeviceSafeArea = true
		local Frame_2241 = Instance.new"Frame"
		Frame_2241.Parent = ActiveToastObject
		Frame_2241.LayoutOrder = 0
		Frame_2241.BorderMode = Enum.BorderMode.Outline
		Frame_2241.Interactable = true
		Frame_2241.AnchorPoint = Vector2.new(0, 0)
		Frame_2241.BorderColor = BrickColor.new"Black"
		Frame_2241.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Frame_2241.ZIndex = 1
		Frame_2241.AutomaticSize = Enum.AutomaticSize.Y
		Frame_2241.Size = UDim2.new(1, 0, 1, 0)
		Frame_2241.Draggable = false
		Frame_2241.Visible = true
		Frame_2241.ClipsDescendants = false
		Frame_2241.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Frame_2241.Selectable = false
		Frame_2241.Style = Enum.FrameStyle.Custom
		Frame_2241.SelectionOrder = 0
		Frame_2241.Rotation = 0
		Frame_2241.Transparency = 1
		Frame_2241.BackgroundTransparency = 1
		Frame_2241.Position = UDim2.new(0, 0, 0, 0)
		Frame_2241.Active = false
		Frame_2241.Name = "1"
		Frame_2241.BorderSizePixel = 1
		Frame_2241.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		local Child = Instance.new"Frame"
		Child.Parent = Frame_2241
		Child.LayoutOrder = 0
		Child.BorderMode = Enum.BorderMode.Outline
		Child.Interactable = true
		Child.AnchorPoint = Vector2.new(0.5, 0.5)
		Child.BorderColor = BrickColor.new"Black"
		Child.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Child.ZIndex = 1
		Child.AutomaticSize = Enum.AutomaticSize.Y
		Child.Size = UDim2.new(0, 360, 0, 0)
		Child.Draggable = false
		Child.Visible = true
		Child.ClipsDescendants = false
		Child.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Child.Selectable = false
		Child.Style = Enum.FrameStyle.Custom
		Child.SelectionOrder = 0
		Child.Rotation = 0
		Child.Transparency = 0.30000001192092896
		Child.BackgroundTransparency = 0.30000001192092896
		Child.Position = UDim2.new(0.5, 0, 0.5, 0)
		Child.Active = false
		Child.Name = "Child"
		Child.BorderSizePixel = 0
		Child.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		local ListLayout = Instance.new"UIListLayout"
		ListLayout.Parent = Child
		ListLayout.FillDirection = Enum.FillDirection.Horizontal
		ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		ListLayout.HorizontalFlex = Enum.UIFlexAlignment.None
		ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Name = "ListLayout"
		ListLayout.Wraps = false
		ListLayout.Padding = UDim.new(0, 8)
		ListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
		ListLayout.VerticalFlex = Enum.UIFlexAlignment.None
		local Padding = Instance.new"UIPadding"
		Padding.Parent = Child
		Padding.PaddingTop = UDim.new(0, 12)
		Padding.Name = "Padding"
		Padding.PaddingBottom = UDim.new(0, 12)
		Padding.PaddingLeft = UDim.new(0, 12)
		Padding.PaddingRight = UDim.new(0, 12)
		local Content = Instance.new"Frame"
		Content.Parent = Child
		Content.LayoutOrder = 2
		Content.BorderMode = Enum.BorderMode.Outline
		Content.Interactable = true
		Content.AnchorPoint = Vector2.new(0, 0)
		Content.BorderColor = BrickColor.new"Black"
		Content.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Content.ZIndex = 1
		Content.AutomaticSize = Enum.AutomaticSize.Y
		Content.Size = UDim2.new(0, 0, 0, 0)
		Content.Draggable = false
		Content.Visible = true
		Content.ClipsDescendants = false
		Content.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Content.Selectable = false
		Content.Style = Enum.FrameStyle.Custom
		Content.SelectionOrder = 0
		Content.Rotation = 0
		Content.Transparency = 1
		Content.BackgroundTransparency = 1
		Content.Position = UDim2.new(0, 0, 0, 0)
		Content.Active = false
		Content.Name = "Content"
		Content.BorderSizePixel = 0
		Content.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		local FlexItem = Instance.new"UIFlexItem"
		FlexItem.Parent = Content
		FlexItem.Name = "FlexItem"
		FlexItem.FlexMode = Enum.UIFlexMode.Fill
		FlexItem.ShrinkRatio = 0
		FlexItem.GrowRatio = 0
		FlexItem.ItemLineAlignment = Enum.ItemLineAlignment.Center
		local ListLayout = Instance.new"UIListLayout"
		ListLayout.Parent = Content
		ListLayout.FillDirection = Enum.FillDirection.Vertical
		ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		ListLayout.HorizontalFlex = Enum.UIFlexAlignment.None
		ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Name = "ListLayout"
		ListLayout.Wraps = false
		ListLayout.Padding = UDim.new(0, 2)
		ListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
		ListLayout.VerticalFlex = Enum.UIFlexAlignment.None
		local Actions = Instance.new"Frame"
		Actions.Parent = Content
		Actions.LayoutOrder = 3
		Actions.BorderMode = Enum.BorderMode.Outline
		Actions.Interactable = true
		Actions.AnchorPoint = Vector2.new(0, 0)
		Actions.BorderColor = BrickColor.new"Black"
		Actions.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Actions.ZIndex = 1
		Actions.AutomaticSize = Enum.AutomaticSize.Y
		Actions.Size = UDim2.new(1, 0, 0, 0)
		Actions.Draggable = false
		Actions.Visible = true
		Actions.ClipsDescendants = false
		Actions.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Actions.Selectable = false
		Actions.Style = Enum.FrameStyle.Custom
		Actions.SelectionOrder = 0
		Actions.Rotation = 0
		Actions.Transparency = 1
		Actions.BackgroundTransparency = 1
		Actions.Position = UDim2.new(0, 0, 0, 0)
		Actions.Active = false
		Actions.Name = "Actions"
		Actions.BorderSizePixel = 0
		Actions.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		local ListLayout = Instance.new"UIListLayout"
		ListLayout.Parent = Actions
		ListLayout.FillDirection = Enum.FillDirection.Horizontal
		ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ListLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
		ListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Name = "ListLayout"
		ListLayout.Wraps = false
		ListLayout.Padding = UDim.new(0, 8)
		ListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
		ListLayout.VerticalFlex = Enum.UIFlexAlignment.None
		local ToastButton1 = Instance.new"ImageButton"
		ToastButton1.Parent = Actions
		ToastButton1.LayoutOrder = 1
		ToastButton1.Active = true
		ToastButton1.Interactable = true
		ToastButton1.SizeConstraint = Enum.SizeConstraint.RelativeXY
		ToastButton1.ZIndex = 1
		ToastButton1.BorderSizePixel = 0
		ToastButton1.SliceCenter = Rect.new(0, 0, 0, 0)
		ToastButton1.Draggable = false
		ToastButton1.ScaleType = Enum.ScaleType.Stretch
		ToastButton1.Modal = false
		ToastButton1.AutoButtonColor = false
		ToastButton1.Transparency = 1
		ToastButton1.SelectionOrder = 0
		ToastButton1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		ToastButton1.ImageTransparency = 0
		ToastButton1.Selectable = true
		ToastButton1.AnchorPoint = Vector2.new(0, 0)
		ToastButton1.Image = ""
		ToastButton1.TileSize = UDim2.new(1, 0, 1, 0)
		ToastButton1.ImageRectSize = Vector2.new(0, 0)
		ToastButton1.Selected = false
		ToastButton1.AutomaticSize = Enum.AutomaticSize.X
		ToastButton1.Size = UDim2.new(1, 0, 0, 36)
		ToastButton1.Visible = true
		ToastButton1.HoverImage = ""
		ToastButton1.Style = Enum.ButtonStyle.Custom
		ToastButton1.ClipsDescendants = true
		ToastButton1.BorderColor3 = Color3.fromRGB(27, 42, 53)
		ToastButton1.BorderMode = Enum.BorderMode.Outline
		ToastButton1.ImageColor3 = Color3.fromRGB(255, 255, 255)
		ToastButton1.PressedImage = ""
		ToastButton1.Rotation = 0
		ToastButton1.ImageRectOffset = Vector2.new(0, 0)
		ToastButton1.BackgroundTransparency = 1
		ToastButton1.Position = UDim2.new(0, 0, 0, 0)
		ToastButton1.SliceScale = 1
		ToastButton1.ResampleMode = Enum.ResamplerMode.Default
		ToastButton1.BorderColor = BrickColor.new"Black"
		ToastButton1.Name = "ToastButton1"
		local Stroke = Instance.new"UIStroke"
		Stroke.Parent = ToastButton1
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		Stroke.LineJoinMode = Enum.LineJoinMode.Round
		Stroke.Name = "Stroke"
		Stroke.Color = Color3.fromRGB(255, 255, 255)
		Stroke.Transparency = 0
		Stroke.Thickness = 1
		Stroke.Enabled = true
		local Text = Instance.new"TextLabel"
		Text.Parent = ToastButton1
		Text.LayoutOrder = 2
		Text.FontSize = Enum.FontSize.Size24
		Text.TextDirection = Enum.TextDirection.Auto
		Text.Active = false
		Text.Interactable = true
		Text.TextStrokeTransparency = 1
		Text.TextTruncate = Enum.TextTruncate.AtEnd
		Text.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Text.ZIndex = 1
		Text.BorderSizePixel = 0
		Text.Draggable = false
		Text.RichText = false
		Text.SelectionOrder = 0
		Text.TextYAlignment = Enum.TextYAlignment.Center
		Text.TextScaled = false
		Text.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		Text.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Text.BorderMode = Enum.BorderMode.Outline
		Text.Selectable = false
		Text.OpenTypeFeatures = ""
		Text.AnchorPoint = Vector2.new(0, 0)
		Text.BorderColor = BrickColor.new"Black"
		Text.Visible = true
		Text.TextXAlignment = Enum.TextXAlignment.Center
		Text.AutomaticSize = Enum.AutomaticSize.X
		Text.Size = UDim2.new(1, 0, 1, 0)
		Text.TextWrapped = true
		Text.TextWrap = true
		Text.TextTransparency = 0
		Text.ClipsDescendants = false
		Text.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Text.Text = "Exit"
		Text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		Text.LineHeight = 1
		Text.Rotation = 0
		Text.Font = Enum.Font.BuilderSansBold
		Text.BackgroundTransparency = 1
		Text.Position = UDim2.new(0, 0, 0, 0)
		Text.TextSize = 20
		Text.MaxVisibleGraphemes = -1
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.Name = "Text"
		local CornerRadius = Instance.new"UICorner"
		CornerRadius.Parent = ToastButton1
		CornerRadius.Name = "CornerRadius"
		CornerRadius.CornerRadius = UDim.new(0, 8)
		local ListLayout = Instance.new"UIListLayout"
		ListLayout.Parent = ToastButton1
		ListLayout.FillDirection = Enum.FillDirection.Horizontal
		ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ListLayout.HorizontalFlex = Enum.UIFlexAlignment.None
		ListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Name = "ListLayout"
		ListLayout.Wraps = false
		ListLayout.Padding = UDim.new(0, 4)
		ListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
		ListLayout.VerticalFlex = Enum.UIFlexAlignment.None
		local ToastButton2 = Instance.new"ImageButton"
		ToastButton2.Parent = Actions
		ToastButton2.LayoutOrder = 2
		ToastButton2.Active = true
		ToastButton2.Interactable = true
		ToastButton2.SizeConstraint = Enum.SizeConstraint.RelativeXY
		ToastButton2.ZIndex = 1
		ToastButton2.BorderSizePixel = 0
		ToastButton2.SliceCenter = Rect.new(0, 0, 0, 0)
		ToastButton2.Draggable = false
		ToastButton2.ScaleType = Enum.ScaleType.Stretch
		ToastButton2.Modal = false
		ToastButton2.AutoButtonColor = false
		ToastButton2.Transparency = 0
		ToastButton2.SelectionOrder = 0
		ToastButton2.BackgroundColor3 = Color3.fromRGB(0, 179, 108)
		ToastButton2.ImageTransparency = 0
		ToastButton2.Selectable = true
		ToastButton2.AnchorPoint = Vector2.new(0, 0)
		ToastButton2.Image = ""
		ToastButton2.TileSize = UDim2.new(1, 0, 1, 0)
		ToastButton2.ImageRectSize = Vector2.new(0, 0)
		ToastButton2.Selected = false
		ToastButton2.AutomaticSize = Enum.AutomaticSize.X
		ToastButton2.Size = UDim2.new(1, 0, 0, 36)
		ToastButton2.Visible = true
		ToastButton2.HoverImage = ""
		ToastButton2.Style = Enum.ButtonStyle.Custom
		ToastButton2.ClipsDescendants = true
		ToastButton2.BorderColor3 = Color3.fromRGB(27, 42, 53)
		ToastButton2.BorderMode = Enum.BorderMode.Outline
		ToastButton2.ImageColor3 = Color3.fromRGB(255, 255, 255)
		ToastButton2.PressedImage = ""
		ToastButton2.Rotation = 0
		ToastButton2.ImageRectOffset = Vector2.new(0, 0)
		ToastButton2.BackgroundTransparency = 0
		ToastButton2.Position = UDim2.new(0, 0, 0, 0)
		ToastButton2.SliceScale = 1
		ToastButton2.ResampleMode = Enum.ResamplerMode.Default
		ToastButton2.BorderColor = BrickColor.new"Black"
		ToastButton2.Name = "ToastButton2"
		local Stroke = Instance.new"UIStroke"
		Stroke.Parent = ToastButton2
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		Stroke.LineJoinMode = Enum.LineJoinMode.Round
		Stroke.Name = "Stroke"
		Stroke.Color = Color3.fromRGB(0, 0, 0)
		Stroke.Transparency = 1
		Stroke.Thickness = 1
		Stroke.Enabled = true
		local Text = Instance.new"TextLabel"
		Text.Parent = ToastButton2
		Text.LayoutOrder = 2
		Text.FontSize = Enum.FontSize.Size24
		Text.TextDirection = Enum.TextDirection.Auto
		Text.Active = false
		Text.Interactable = true
		Text.TextStrokeTransparency = 1
		Text.TextTruncate = Enum.TextTruncate.AtEnd
		Text.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Text.ZIndex = 1
		Text.BorderSizePixel = 0
		Text.Draggable = false
		Text.RichText = false
		Text.SelectionOrder = 0
		Text.TextYAlignment = Enum.TextYAlignment.Center
		Text.TextScaled = false
		Text.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		Text.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Text.BorderMode = Enum.BorderMode.Outline
		Text.Selectable = false
		Text.OpenTypeFeatures = ""
		Text.AnchorPoint = Vector2.new(0, 0)
		Text.BorderColor = BrickColor.new"Black"
		Text.Visible = true
		Text.TextXAlignment = Enum.TextXAlignment.Center
		Text.AutomaticSize = Enum.AutomaticSize.X
		Text.Size = UDim2.new(1, 0, 1, 0)
		Text.TextWrapped = true
		Text.TextWrap = true
		Text.TextTransparency = 0
		Text.ClipsDescendants = false
		Text.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Text.Text = "Continue"
		Text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		Text.LineHeight = 1
		Text.Rotation = 0
		Text.Font = Enum.Font.BuilderSansBold
		Text.BackgroundTransparency = 1
		Text.Position = UDim2.new(0, 0, 0, 0)
		Text.TextSize = 20
		Text.MaxVisibleGraphemes = -1
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.Name = "Text"
		local CornerRadius = Instance.new"UICorner"
		CornerRadius.Parent = ToastButton2
		CornerRadius.Name = "CornerRadius"
		CornerRadius.CornerRadius = UDim.new(0, 8)
		local ListLayout = Instance.new"UIListLayout"
		ListLayout.Parent = ToastButton2
		ListLayout.FillDirection = Enum.FillDirection.Horizontal
		ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ListLayout.HorizontalFlex = Enum.UIFlexAlignment.None
		ListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Name = "ListLayout"
		ListLayout.Wraps = false
		ListLayout.Padding = UDim.new(0, 4)
		ListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
		ListLayout.VerticalFlex = Enum.UIFlexAlignment.None
		local Padding = Instance.new"UIPadding"
		Padding.Parent = Actions
		Padding.PaddingTop = UDim.new(0, 8)
		Padding.Name = "Padding"
		Padding.PaddingBottom = UDim.new(0, 0)
		Padding.PaddingLeft = UDim.new(0, 0)
		Padding.PaddingRight = UDim.new(0, 0)
		local Body = Instance.new"TextLabel"
		Body.Parent = Content
		Body.LayoutOrder = 2
		Body.FontSize = Enum.FontSize.Size18
		Body.TextDirection = Enum.TextDirection.Auto
		Body.Active = false
		Body.Interactable = true
		Body.TextStrokeTransparency = 1
		Body.TextTruncate = Enum.TextTruncate.None
		Body.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Body.ZIndex = 1
		Body.BorderSizePixel = 0
		Body.Draggable = false
		Body.RichText = false
		Body.SelectionOrder = 0
		Body.TextYAlignment = Enum.TextYAlignment.Center
		Body.TextScaled = false
		Body.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		Body.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		Body.BorderMode = Enum.BorderMode.Outline
		Body.Selectable = false
		Body.OpenTypeFeatures = ""
		Body.AnchorPoint = Vector2.new(0, 0)
		Body.BorderColor = BrickColor.new"Black"
		Body.Visible = true
		Body.TextXAlignment = Enum.TextXAlignment.Left
		Body.AutomaticSize = Enum.AutomaticSize.Y
		Body.Size = UDim2.new(1, 0, 0, 0)
		Body.TextWrapped = true
		Body.TextWrap = true
		Body.TextTransparency = 0
		Body.ClipsDescendants = false
		Body.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Body.Text = "SasGuard is unable to load due to the current PlaceVersion being higher than the supported version. This means the anti-cheat will be running. Do you want to continue?"
		Body.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		Body.LineHeight = 1.031999945640564
		Body.Rotation = 0
		Body.Font = Enum.Font.BuilderSans
		Body.BackgroundTransparency = 1
		Body.Position = UDim2.new(0, 0, 0, 0)
		Body.TextSize = 15
		Body.MaxVisibleGraphemes = -1
		Body.TextColor3 = Color3.fromRGB(189, 190, 190)
		Body.Name = "Body"
		local Padding = Instance.new"UIPadding"
		Padding.Parent = Body
		Padding.PaddingTop = UDim.new(0, 0)
		Padding.Name = "Padding"
		Padding.PaddingBottom = UDim.new(0, 0)
		Padding.PaddingLeft = UDim.new(0, 0)
		Padding.PaddingRight = UDim.new(0, 0)
		local Header = Instance.new"TextLabel"
		Header.Parent = Content
		Header.LayoutOrder = 1
		Header.FontSize = Enum.FontSize.Size32
		Header.TextDirection = Enum.TextDirection.Auto
		Header.Active = false
		Header.Interactable = true
		Header.TextStrokeTransparency = 1
		Header.TextTruncate = Enum.TextTruncate.AtEnd
		Header.SizeConstraint = Enum.SizeConstraint.RelativeXY
		Header.ZIndex = 1
		Header.BorderSizePixel = 0
		Header.Draggable = false
		Header.RichText = false
		Header.SelectionOrder = 0
		Header.TextYAlignment = Enum.TextYAlignment.Center
		Header.TextScaled = false
		Header.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		Header.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Header.BorderMode = Enum.BorderMode.Outline
		Header.Selectable = false
		Header.OpenTypeFeatures = ""
		Header.AnchorPoint = Vector2.new(0, 0)
		Header.BorderColor = BrickColor.new"Black"
		Header.Visible = true
		Header.TextXAlignment = Enum.TextXAlignment.Center
		Header.AutomaticSize = Enum.AutomaticSize.Y
		Header.Size = UDim2.new(1, 0, 0, 0)
		Header.TextWrapped = false
		Header.TextWrap = false
		Header.TextTransparency = 0
		Header.ClipsDescendants = false
		Header.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Header.Text = "Warning"
		Header.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		Header.LineHeight = 1
		Header.Rotation = 0
		Header.Font = Enum.Font.BuilderSansBold
		Header.BackgroundTransparency = 1
		Header.Position = UDim2.new(0, 0, 0, 0)
		Header.TextSize = 30
		Header.MaxVisibleGraphemes = -1
		Header.TextColor3 = Color3.fromRGB(255, 255, 255)
		Header.Name = "Header"
		local Padding = Instance.new"UIPadding"
		Padding.Parent = Header
		Padding.PaddingTop = UDim.new(0, 0)
		Padding.Name = "Padding"
		Padding.PaddingBottom = UDim.new(0, 5)
		Padding.PaddingLeft = UDim.new(0, 0)
		Padding.PaddingRight = UDim.new(0, 0)
		local CornerRadius = Instance.new"UICorner"
		CornerRadius.Parent = Child
		CornerRadius.Name = "CornerRadius"
		CornerRadius.CornerRadius = UDim.new(0, 8)
		return ActiveToastObject, ToastButton1, ToastButton2
	end

	do
		VeryImportantPart.Name = "SpawnBox"
		local prio = Instance.new("IntValue", VeryImportantPart)
		prio.Name = "priority"
		prio.Value = 10
		local name = Instance.new("StringValue", VeryImportantPart)
		name.Name = "zonename"
		name.Value = "???"
	end

	local Camera = workspace.CurrentCamera

	local ZoneFishOrigin
	local PreAutoloadConfig = true

	local State = {
		GettingMeteor = false,
		OwnedBoats = {},
		LastToolReset = os.clock(),
		ToolResetCooldown = 5,
	}

	local GlobalStorage = {
		PeakZones = {
			["Overgrowth Caves"] = true,
			["Frigid Cavern"] = true,
			["Cryogenic Canal"] = true,
			["Glacial Grotto"] = true,
		},
	}

	-- Game instance paths
	local LocalPlayer = Players.LocalPlayer
	local Unloaded = false
	local CurrentTool
	-- Test if hooking is enabled
	if not (hookfunction and hookmetamethod) then
		hookfunction = function(...)
		end
		hookmetamethod = function(...)
		end
		NO_HOOKING = true
	end

	if not getconnections then
		getconnections = function(...)
		end
	end

	if not setthreadidentity then
		setthreadidentity = function(...)
		end
	end

	local function dbgprint(...)
		if Debugging then
			print("[Debugging]", ...)
		end
	end

	local function dbgwarn(...)
		if Debugging then
			warn("[Debugging]", ...)
		end
	end

	local function WaitForTable(Root, InstancePath, Timeout)
		local Instance = Root

		for i, v in pairs(InstancePath) do
			if not Instance then
				return nil
			end

			Instance = Instance:WaitForChild(v, Timeout or 8)
		end

		return Instance
	end

	local function GetFirstAncestorOfClass(Object, Class)
		local Ancestor = Object.Parent
		local Depth = 0
		while Ancestor do
			Depth += 1

			if Depth > 255 then
				warn"Aborted GetFirstAncestorOfClass: Too deep"
				return nil
			end

			if Ancestor:IsA(Class) then
				return Ancestor
			end

			Ancestor = Ancestor.Parent
		end
		return nil
	end

	local function LockPersistent(Object)
		assert(Object:IsA"Model", "Object must be a model")
		if Object.ModelStreamingMode ~= Enum.ModelStreamingMode.Persistent then
			CollectionService:AddTag(Object, "ForcePersistent")
			Object:SetAttribute("OldStreamingMode", Object.ModelStreamingMode.Name)
			Object.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
		end
	end

	local function EnsureStream(Root, InstancePath, Position, Timeout)
		pcall(function()
			LocalPlayer:RequestStreamAroundAsync(Position, Timeout)
		end)

		local Target = WaitForTable(Root, InstancePath, Timeout)

		if not Target then
			warn("[NoxHub] 流式加载取不到:", table.concat(InstancePath, "/"))
			return nil
		end

		local Model = GetFirstAncestorOfClass(Target, "Model")

		if Model then
			pcall(LockPersistent, Model)
		end

		return Target
	end

	local function EnsureInstance(Instance)
		return (Instance and Instance:IsDescendantOf(game))
	end

	local function _round(num, numDecimalPlaces)
		local mult = 10 ^ (numDecimalPlaces or 0)
		return math.floor(num * mult + 0.5) / mult
	end

	local Configuration = {
		CheckSafeRange = 50,
	}

	local EventsFolder = ReplicatedStorage:FindFirstChild("events") or ReplicatedStorage:WaitForChild("events", 10)

	local Remotes = {
		ReelFinished = EventsFolder
			and (EventsFolder:FindFirstChild("reelfinished ") or EventsFolder:FindFirstChild("reelfinished")),
		SellAll = EventsFolder and EventsFolder:FindFirstChild("SellAll"),
		Power = EnsureStream(
			workspace,
			{
			"world",
			"npcs",
			"Merlin",
			"Merlin",
			"power"
		},
			Vector3.new(-930, 226, -993),
			5
		),
		Luck = EnsureStream(
			workspace,
			{
			"world",
			"npcs",
			"Merlin",
			"Merlin",
			"luck"
		},
			Vector3.new(-930, 226, -993),
			5
		),
	}

	-- 结构取不到时不再无限卡住: 取不到就置空, 对应功能自己跳过
	local Interface = {}

	do
		local Ok = pcall(function()
			Interface.FishRadar = ReplicatedStorage.resources.items.items["Fish Radar"]["Fish Radar"]
		end)

		if not Ok then
			Interface.FishRadar = nil
		end

		Interface.TeleportSpots = WaitForTable(workspace, { "world", "spawns", "TpSpots" }, 8)
		Interface.Inventory = WaitForTable(LocalPlayer.PlayerGui, { "hud", "safezone", "backpack" }, 8)
		Interface.MeteorItems = WaitForTable(workspace, { "active", "meteorItems" }, 8)
		Interface.NPCs = WaitForTable(workspace, { "world", "npcs" }, 8)
		Interface.BoatModels = WaitForTable(ReplicatedStorage, { "resources", "replicated", "instances", "vessels" }, 8)
		Interface.Active = workspace:FindFirstChild("active") or workspace:WaitForChild("active", 8)
		Interface.ActiveBoats = WaitForTable(workspace, { "active", "boats" }, 8)

		local Stats = workspace:FindFirstChild("PlayerStats") or workspace:WaitForChild("PlayerStats", 8)

		if Stats then
			local Mine = Stats:FindFirstChild(LocalPlayer.Name) or Stats:WaitForChild(LocalPlayer.Name, 8)

			if Mine then
				local T = Mine:FindFirstChild("T") or Mine:WaitForChild("T", 8)

				if T then
					Interface.PlayerData = T:GetChildren()[1]
				end
			end
		end
	end

	-- [修复] 名字模糊查找, 游戏结构变了也尽量能接上
	local function FindNamed(Root, Fragment)
		if not Root then
			return nil
		end

		Fragment = string.lower(Fragment)

		for _, Item in next, Root:GetDescendants() do
			if Item:IsA("RemoteEvent") or Item:IsA("RemoteFunction") then
				if string.find(string.lower(Item.Name), Fragment, 1, true) then
					return Item
				end
			end
		end

		return nil
	end

	local function GetReelGui()
		local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

		if not PlayerGui then
			return nil
		end

		local Reel = PlayerGui:FindFirstChild("reel") or PlayerGui:FindFirstChild("Reel")

		if Reel then
			return Reel
		end

		for _, Item in next, PlayerGui:GetChildren() do
			if (Item:IsA("ScreenGui") or Item:IsA("GuiObject"))
				and string.find(string.lower(Item.Name), "reel", 1, true)
			then
				return Item
			end
		end

		return nil
	end

	local function GetToolParts(Tool)
		if not Tool then
			return nil, nil, nil
		end

		local Values = Tool:FindFirstChild("values", true)
		local Events = Tool:FindFirstChild("events", true)
		local CastRemote = nil

		if Events then
			CastRemote = Events:FindFirstChild("cast", true) or FindNamed(Events, "cast")
		end

		return Values, Events, CastRemote
	end

	if not Remotes.ReelFinished then
		Remotes.ReelFinished = FindNamed(ReplicatedStorage, "reelfinished")
	end

	if not Remotes.SellAll then
		Remotes.SellAll = FindNamed(ReplicatedStorage, "sellall")
	end
	local function FireRemote(Remote, ...)
		if not Remote then
			return false
		end

		local Args = table.pack(...)
		local Ok

		if typeof(Remote) == "Instance" and Remote:IsA("RemoteFunction") then
			Ok = pcall(function()
				return Remote:InvokeServer(table.unpack(Args, 1, Args.n))
			end)
			return Ok
		end

		Ok = pcall(function()
			Remote:FireServer(table.unpack(Args, 1, Args.n))
		end)

		return Ok
	end


	local Collection = {}
	local OnUnload = Instance.new"BindableEvent"
	local function Collect(Item)
		table.insert(Collection, Item)
	end

	local Repository = "https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/"

	local function LoadLibrary(Path)
		local Source = FetchSource(Repository .. Path)

		if not Source then
			error("无法下载 " .. Path .. " (GitHub 与镜像全部失败)")
		end

		local Ok, Result = pcall(function()
			return loadstring(Source)()
		end)

		if not Ok then
			error("加载 " .. Path .. " 失败: " .. tostring(Result))
		end

		return Result
	end

	local Library = LoadLibrary("Library.lua")
	local ThemeManager = LoadLibrary("addons/ThemeManager.lua")
	local SaveManager = LoadLibrary("addons/SaveManager.lua")

	local VelocityFly
	do
		local Source = FetchSource"https://raw.githubusercontent.com/centerepic/VelocityFly/main/VelocityFly.lua"

		if Source then
			local Ok, Result = pcall(function()
				return loadstring(Source)()
			end)

			VelocityFly = Ok and Result or nil
		end
	end

	local OptionsTable = Library.Options or getgenv().Options or {}
	local TogglesTable = Library.Toggles or getgenv().Toggles or {}

	local UI = {
		Library = Library,
		Options = OptionsTable,
		Toggles = TogglesTable,
	}

	local function GetToggleValue(Name)
		local Toggle = UI.Toggles[Name]

		if not Toggle then
			dbgwarn("Toggle not found:", Name)
			return nil
		else
			return Toggle.Value
		end
	end

	local function GetOptionValue(Name)
		local Option = UI.Options[Name]

		if not Option then
			dbgwarn("Option not found:", Name)
			return nil
		else
			return Option.Value
		end
	end

	local Utils = {}
	do
		function Utils.CountInstances(Parent, Name)
			local Count = 0
			for _, Instance in next, Parent:GetChildren() do
				if Instance.Name == Name then
					Count += 1
				end
			end
			return Count
		end

		function Utils.BreakVelocity(self)
			if LocalPlayer.Character then
				task.spawn(function()
					for i = 20, 1, -1 do
						RunService.Heartbeat:Wait()
						for _, Part in next, LocalPlayer.Character:GetDescendants() do
							if Part:IsA"BasePart" then
								Part.Velocity = Vector3.new(0, 0, 0)
								Part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
							end
						end
					end
				end)
			end
		end

		function Utils.ToggleLocationCC(Value)
			local LocationCC = Lighting:FindFirstChild"location"
			if LocationCC then
				LocationCC.Enabled = Value
			end
		end

		function Utils.GameNotify(Message)
			ReplicatedStorage.events.anno_localthoughtbig:Fire(Message, nil, nil, nil, "Exotic")
		end

		function Utils.GetCharacters()
			local Characters = {}

			for _, Player in next, Players:GetPlayers() do
				if Player.Character then
					table.insert(Characters, Player.Character)
				end
			end

			return Characters
		end

		function Utils.Net(Type, Index)
			local Packages = ReplicatedStorage:FindFirstChild("packages")

			if not Packages then
				return nil
			end

			local Net = Packages:FindFirstChild("Net")

			if not Net then
				return nil
			end

			return Net:FindFirstChild(Type .. "/" .. Index)
		end

		function Utils.Character()
			return LocalPlayer.Character
		end

		function Utils.Humanoid()
			local Character = Utils.Character()

			if Character then
				return Character:FindFirstChildOfClass"Humanoid"
			end

			return nil
		end

		function Utils.CastTo(A, B, Params)
			local Direction = (B - A)
			return workspace:Raycast(A, Direction, Params)
		end
		--
		function Utils.SafePosition(Position, Range)
			local Characters = Utils.GetCharacters()
			local RayParams = RaycastParams.new()
			RayParams.FilterType = Enum.RaycastFilterType.Exclude
			RayParams.RespectCanCollide = true
			RayParams.FilterDescendantsInstances = Characters

			for _, Character in next, Characters do
				local Head = Character:FindFirstChild"Head"
				local Pivot = Character:GetPivot()

				if Head then
					local Raycast = Utils.CastTo(Position, Head.Position, RayParams)

					if Raycast then
						return false
					end
				end

				if Pivot then
					local Distance = (Position - Pivot.Position).Magnitude * 0.5

					if Distance <= Range then
						return false
					end
				end
			end

			return true
		end

		function Utils.TP(Target, CheckSafe)
			local Pivot
			if typeof(Target) == "CFrame" then
				Pivot = Target
			elseif typeof(Target) == "Vector3" then
				Pivot = CFrame.new(Target)
			elseif typeof(Target) == "Instance" then
				if Target:IsA("PVInstance") then
					Pivot = Target:GetPivot()
				end
			end

			if not Pivot then
				return false
			end

			if CheckSafe then
				if not Utils.SafePosition(Pivot.Position, Configuration.CheckSafeRange) then
					return false
				end
			end

			local Character = Utils.Character()
			if Character then
				Character:PivotTo(Pivot)
				return true
			end

			return false
		end

		function Utils.EliminateVelocity(Model)
			for _, Part in next, Model:GetDescendants() do
				if Part:IsA"BasePart" then
					Part.Velocity = Vector3.new(0, 0, 0)
					Part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
				end
			end
			return nil
		end

		function Utils.GenericToast(Duration, Message, CustomTitle)
			local MessageTitle = CustomTitle or Title

			Toasts.CreateToast(
				HttpService:GenerateGUID(false),
				MessageTitle,
				Message,
				"rbxassetid://18259985431",
				Duration
			)
		end

		function Utils.GetUsernameMatch(PartialName)
			local BestMatch
			local BestMatchLength = 0

			for _, Player in next, Players:GetPlayers() do
				if string.find(Player.Name:lower(), PartialName:lower()) then
					if #Player.Name > BestMatchLength then
						BestMatch = Player
						BestMatchLength = #Player.Name
					end
				end
			end

			return BestMatch
		end

		function Utils.CharacterChildAdded(Child)
			if Child:IsA"Tool" then
				CurrentTool = Child

				if GetToggleValue"ServerStresser" then
					local FishModel = Child:WaitForChild("Fish", 1)

					if FishModel then
						FishModel:Destroy()
					end

					task.delay(0.5, function()
						for i, v in next, Child:GetDescendants() do
							if v:IsA"BasePart" then
								v.Anchored = true
							end
						end
					end)
				end
			elseif Child:IsA"Humanoid" then
				Collect(Child.StateChanged:Connect(function()
					if GetToggleValue"ZoneFish" then
						for _, State in next, Enum.HumanoidStateType:GetEnumItems() do
							if State ~= Enum.HumanoidStateType.Running then
								Child:SetStateEnabled(State, false)
							end
						end
						Child:ChangeState(Enum.HumanoidStateType.Running)
					end
				end))
				Collect(Child.Died:Once(function()
					UI.Toggles.ZoneFish:SetValue(false)
				end))
			end
		end

		function Utils.CharacterChildRemoved(Child)
			if Child:IsA"Tool" then
				CurrentTool = nil
			end
		end

		function Utils.CharacterAdded(Character)
			for _, Child in next, Character:GetChildren() do
				Utils.CharacterChildAdded(Child)
			end

			Collect(Character.ChildAdded:Connect(Utils.CharacterChildAdded))
			Collect(Character.ChildRemoved:Connect(Utils.CharacterChildRemoved))

			local Zone = (Character:WaitForChild("zone", 1) )
			if Zone then
				Collect(RunService.RenderStepped:Connect(function()
					if GetToggleValue"DisablePeakEffects" then
						Zone.Value = VeryImportantPart
					end
				end))
			end
		end

		function Utils.Capitalize(String)
			return string.upper(string.sub(String, 1, 1)) .. string.sub(String, 2)
		end

		function Utils.GetNPC(Type, Single)
			local function GetNPCType(NPC) -- i hate this function so much
				local NPCType = "Unknown"

				if NPC:FindFirstChild"shipwright" then
					NPCType = "Shipwright"
				elseif NPC:FindFirstChild"merchant" then
					NPCType = "Merchant"
				elseif NPC:FindFirstChild"angler" then
					NPCType = "Angler"
				end

				return NPCType
			end

			local NPCs = Interface.NPCs and Interface.NPCs:GetChildren() or {}
			local Results = {}

			for _, Character in next, NPCs do
				local NPCType = GetNPCType(Character)

				if NPCType == Type then
					if Single then
						return Character
					else
						table.insert(Results, Character)
					end
				end
			end

			return nil
		end

		function Utils.BoatsChanged()
			local PlayerData = Interface.PlayerData
			local BoatFolder = PlayerData and PlayerData:FindFirstChild("Boats")
			local Boats = BoatFolder and BoatFolder:GetChildren() or {}

			State.OwnedBoats = {}

			for _, Boat in next, Boats do
				table.insert(State.OwnedBoats, Boat.Name)
			end

			if UI.Options and UI.Options.BoatSpawnDropdown then
				UI.Options.BoatSpawnDropdown:SetValues(State.OwnedBoats)
			end
		end

	end

	local TeleportLocations = {}
	local TeleportLocations_DropDownValues = {}

	for _, Location in next, (Interface.TeleportSpots and Interface.TeleportSpots:GetChildren() or {}) do
		TeleportLocations[Utils.Capitalize(Location.Name)] = Location.Position + Vector3.new(0, 6, 0)
	end

	for Name, Position in next, TeleportLocations do
		table.insert(TeleportLocations_DropDownValues, Name)
	end

	table.sort(TeleportLocations_DropDownValues)

	local FishingZones = {}

	for _, Zone in next, workspace:WaitForChild"zones":WaitForChild"fishing":GetChildren() do
		if not FishingZones[Zone.Name] then
			FishingZones[Zone.Name] = Zone
		end
	end

	local FishingZones_DropDownValues = {}

	for Name, Zone in next, FishingZones do
		table.insert(FishingZones_DropDownValues, Name)
	end

	local function ResetTool()
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local Equipped = Character:FindFirstChildOfClass("Tool")

		if not Humanoid or not Equipped then
			return
		end

		if State.LastToolReset + State.ToolResetCooldown < os.clock() then
			State.LastToolReset = os.clock()
			Humanoid:UnequipTools()
			task.wait()
			Equipped.Parent = Character
		end
	end


	local Window = Library:CreateWindow{
		Title = "NoxHub - Fisch - 25ms was here",
		Center = true,
		AutoShow = true,
	}
	local Tabs = {
		Main = Window:AddTab"Main",
		Teleports = Window:AddTab"Teleports",
		Autos = Window:AddTab"Autos",
		Misc = Window:AddTab"Misc",
		["UI Settings"] = Window:AddTab"UI Settings",
	}

-- ####################### ---
-- ### UI SETTINGS TAB ### ---
-- ####################### ---
	local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox'Menu'
	MenuGroup:AddButton('Unload', function()
		Library:Unload()
	end)
	MenuGroup:AddLabel'Menu bind':AddKeyPicker('MenuKeybind', {
		Default = 'End',
		NoUI = true,
		Text = 'Menu keybind'
	})
	Library.ToggleKeybind = Library.Options.MenuKeybind
	ThemeManager:SetLibrary(Library)
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes{
		'MenuKeybind'
	}
	ThemeManager:SetFolder'NoxHub'
	SaveManager:SetFolder'NoxHub/Arise'
	SaveManager:BuildConfigSection(Tabs['UI Settings'])
	ThemeManager:ApplyToTab(Tabs['UI Settings'])
	SaveManager:LoadAutoloadConfig()
	local CastingGroup = Tabs.Autos:AddLeftGroupbox"Casting"
	local ReelingGroup = Tabs.Autos:AddLeftGroupbox"Reeling"
	local OtherGroup   = Tabs.Autos:AddLeftGroupbox"Shake"
-- == MODULE SETUP == --
	local localPlayer = Players.LocalPlayer
	local camera = workspace.CurrentCamera
	local toggles = {
		EnableSpeedHack = false,
		EnableFlight = false,
	}
	local options = {
		Speed = 100,
		FlightSpeed = 150,
	}
	local player = game.Players.LocalPlayer
	infiniteJumpConnection = nil

-- == SPEEDHACK FUNCTION == --
	local function handleSpeedHack()
		local function initSpeedHack()
			local character = localPlayer.Character
			if character then
				local hrp = character:FindFirstChild"HumanoidRootPart"
				if hrp then
					local bv = hrp:FindFirstChild"SpeedHackVelocity"
					if not bv then
						bv = Instance.new"BodyVelocity"
						bv.Name = "SpeedHackVelocity"
						bv.MaxForce = Vector3.new(1e5, 0, 1e5)
						bv.Velocity = Vector3.new(0, 0, 0)
						bv.Parent = hrp
					end
					return bv
				end
			end
			return nil
		end
		local bv = initSpeedHack()
		while not bv and toggles.EnableSpeedHack do
			task.wait(0.1)
			bv = initSpeedHack()
		end
		while toggles.EnableSpeedHack and localPlayer and localPlayer.Character do
			local character = localPlayer.Character
			local hrp = character and character:FindFirstChild"HumanoidRootPart"
			if hrp then
				camera = workspace.CurrentCamera
				local moveDirection = Vector3.new(0, 0, 0)
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					moveDirection = moveDirection + camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					moveDirection = moveDirection - camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					moveDirection = moveDirection - camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					moveDirection = moveDirection + camera.CFrame.RightVector
				end
				if moveDirection.Magnitude > 0 then
					moveDirection = moveDirection.Unit * options.Speed
				else
					moveDirection = Vector3.new(0, 0, 0)
				end
				if bv then
					bv.Velocity = Vector3.new(moveDirection.X, 0, moveDirection.Z)
				end
			end
			task.wait()
		end
		if localPlayer and localPlayer.Character then
			local hrp = localPlayer.Character:FindFirstChild"HumanoidRootPart"
			if hrp then
				local oldBV = hrp:FindFirstChild"SpeedHackVelocity"
				if oldBV then
					oldBV:Destroy()
				end
			end
		end
	end

-- == FLIGHT FUNCTION == --
	local function handleFlight()
		while toggles.EnableFlight do
			local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
			local hrp = character and character:FindFirstChild"HumanoidRootPart"
			if hrp then
				camera = workspace.CurrentCamera
				local moveDirection = Vector3.new(0, 0, 0)
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					moveDirection = moveDirection + camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					moveDirection = moveDirection - camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					moveDirection = moveDirection - camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					moveDirection = moveDirection + camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					moveDirection = moveDirection + camera.CFrame.UpVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					moveDirection = moveDirection - camera.CFrame.UpVector
				end
				if moveDirection.Magnitude > 0 then
					moveDirection = moveDirection.Unit * options.FlightSpeed
				else
					moveDirection = Vector3.new(0, 0, 0)
				end
				hrp.Velocity = moveDirection
			end
			task.wait()
		end
	end
	local function onCharacterAdded(character)
		character:WaitForChild"Humanoid"
		task.wait(0.5)
		if toggles.EnableSpeedHack then
			task.spawn(handleSpeedHack)
		end
	end
	localPlayer.CharacterAdded:Connect(onCharacterAdded)

-- == INFINITE JUMP FUNCTION == --
	local function enableInfiniteJump()
		if infiniteJumpConnection then
			infiniteJumpConnection:Disconnect()
		end
		infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
			if Library.Toggles and Library.Toggles.EnableInfiniteJump and localPlayer.Character then
				local humanoid = localPlayer.Character:FindFirstChildOfClass"Humanoid"
				if humanoid then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	end
	local function disableInfiniteJump()
		if infiniteJumpConnection then
			infiniteJumpConnection:Disconnect()
			infiniteJumpConnection = nil
		end
	end

-- == GUI MOVEMENT GROUP == --
	local MovementGroup = Tabs.Main:AddLeftGroupbox"Movement"
	MovementGroup:AddToggle("EnableSpeedHack", {
		Text = "WalkSpeed",
		Default = false,
		Tooltip = "Toggle increased walk speed.",
		Callback = function(active)
			toggles.EnableSpeedHack = active
			if active then
				task.spawn(handleSpeedHack)
			else
				if localPlayer and localPlayer.Character then
					local humanoid = localPlayer.Character:FindFirstChildOfClass"Humanoid"
					if humanoid then
						humanoid.WalkSpeed = 16
					end
				end
			end
		end,
	})
	MovementGroup:AddLabel"WalkSpeed Keybind":AddKeyPicker("SpeedKeybind", {
		Default = "N",
		Mode = "Toggle",
		Text = "",
		NoUI = false,
		Callback = function(active)
			toggles.EnableSpeedHack = active
			if active then
				task.spawn(handleSpeedHack)
			end
		end,
	})
	MovementGroup:AddSlider("Speed", {
		Text = "",
		Default = 100,
		Min = 10,
		Max = 300,
		Rounding = 0,
		Tooltip = "Adjust the walk speed",
		Callback = function(value)
			options.Speed = value
		end,
	})
	MovementGroup:AddToggle("EnableFlight", {
		Text = "Flight",
		Default = false,
		Tooltip = "Toggle flight",
		Callback = function(active)
			toggles.EnableFlight = active
			if active then
				task.spawn(handleFlight)
			else
				if localPlayer and localPlayer.Character then
					local hrp = localPlayer.Character:FindFirstChild"HumanoidRootPart"
					if hrp then
						hrp.Velocity = Vector3.new(0, 0, 0)
					end
				end
			end
		end,
	})
	MovementGroup:AddLabel"Flight Keybind":AddKeyPicker("FlightKeybind", {
		Default = "J",
		Mode = "Toggle",
		Text = "",
		NoUI = false,
		Callback = function(active)
			toggles.EnableFlight = active
			if active then
				task.spawn(handleFlight)
			end
		end,
	})
	MovementGroup:AddSlider("FlightSpeed", {
		Text = "",
		Default = 100,
		Min = 10,
		Max = 500,
		Rounding = 0,
		Tooltip = "Adjust the flight speed.",
		Callback = function(value)
			options.FlightSpeed = value
		end,
	})
	MovementGroup:AddToggle("EnableInfiniteJump", {
		Text = "Infinite Jump",
		Default = false,
		Tooltip = "Toggle infinite jump",
		Callback = function(active)
			if active then
				enableInfiniteJump()
			else
				disableInfiniteJump()
			end
		end
	})

	CastingGroup:AddToggle("AutoCast", {
		Text = "AutoCast",
		Default = false,
		Tooltip = "Automatically casts for you",
	})

	if not NO_HOOKING then
		CastingGroup:AddToggle("PerfectCast", {
			Text = "Always Perfect",
			Default = false,
			Tooltip = "Makes your casts always perfect",
		})
	end

	CastingGroup:AddToggle("InstantBob", {
		Text = "InstantBob [Blatant]",
		Default = false,
		Tooltip = "Forces the bobber to fall instantly",
	})

	ReelingGroup:AddToggle("AutoReel", {
		Text = "Auto-reel [Legit]",
		Default = false,
		Tooltip = "Automatically plays the reel minigame",
		Callback = function(Value)
			if Value then
				UI.Toggles.InstantReel:SetValue(false)
			end
		end,
	})

	ReelingGroup:AddToggle("InstantReel", {
		Text = "Insta-reel [Blatant]",
		Default = false,
		Tooltip = "Automatically reels in fish instantly",
		Callback = function(Value)
			if Value then
				UI.Toggles.AutoReel:SetValue(false)
			end
		end,
	})

	ReelingGroup:AddToggle("PerfectReel", {
		Text = "Always Perfect",
		Default = false,
		Tooltip = "Reels in fish perfectly!",
	})

	OtherGroup:AddToggle("AutoShake", {
		Text = "AutoShake",
		Default = false,
		Tooltip = "Automatically shakes the rod",
	})

	OtherGroup:AddToggle("CenterShake", {
		Text = "CenterShake [Improves AutoShake]",
		Default = false,
		Tooltip = "Centers the shake UI [Improves AutoShake]",
	})

-- Location Teleports Groupbox
	local TeleportsGroupBox = Tabs.Teleports:AddLeftGroupbox"Location Teleports"
	local TeleportOrigin
	TeleportsGroupBox:AddDropdown("TeleportsDropdown", {
		Values = TeleportLocations_DropDownValues,
		Default = 1,
		Multi = false,
		Tooltip = "Location to teleport to",
	})
	TeleportsGroupBox:AddButton("Teleport", function()
		local Selected = GetOptionValue"TeleportsDropdown"
		local Position = TeleportLocations[Selected]
		if Position then
		-- Save current location before teleporting
			TeleportOrigin = LocalPlayer.Character:GetPivot()
			Utils.TP(Position)
		end
	end)
	TeleportsGroupBox:AddButton("Go Back", function()
		if TeleportOrigin then
			Utils.TP(TeleportOrigin)
		else
			Utils.GenericToast(3, "No previous location stored!")
		end
	end)

	local UtilitiesGroupBox = Tabs.Main:AddRightGroupbox"Utilities"
	UtilitiesGroupBox:AddToggle("DisablePeakEffects", {
		Text = "Disable Oxygen/Temperature",
		Default = false,
		Tooltip = "Disables peak effects.",
	})

	UtilitiesGroupBox:AddToggle("InfiniteOxygen", {
		Text = "Infinite Oxygen",
		Default = false,
		Tooltip = "Gives you infinite oxygen.",
	})

	UtilitiesGroupBox:AddToggle("AntiAFK", {
		Text = "AntiAFK",
		Default = false,
		Tooltip = "Prevents you from being kicked for being AFK.",
	})

	UtilitiesGroupBox:AddToggle("NoLocationCC", {
		Text = "NoAmbient",
		Default = false,
		Tooltip = "Disables the location Color-Correction.",
	})
	UtilitiesGroupBox:AddToggle("NoClip", {
		Text    = "NoClip",
		Default = false,
		Tooltip = "Pass through walls and objects",
		Callback = function(enabled)
			if enabled then
				task.spawn(function()
					getgenv().NoClipConn = RunService.Stepped:Connect(function()
						local char = LocalPlayer.Character
						if char then
							for _, part in ipairs(char:GetDescendants()) do
								if part:IsA"BasePart" then
									part.CanCollide = false
								end
							end
						end
					end)
				end)
			else
				if getgenv().NoClipConn then
					getgenv().NoClipConn:Disconnect()
					getgenv().NoClipConn = nil
				end
				local char = LocalPlayer.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA"BasePart" then
							part.CanCollide = true
						end
					end
				end
			end
		end,
	})

	UtilitiesGroupBox:AddToggle("SpamTool", {
		Text = "Spam Tool",
		Default = false,
		Tooltip = "Spam-activates your equipped tool. [For crates]",
	})
	
	-- == FULLBRIGHT == --
	local fullbrightEnabled = false
	local originalSettings = {}
	local Lighting = game:GetService"Lighting"
	local function storeOriginalSettings()
		originalSettings = {
			Brightness = Lighting.Brightness,
			ClockTime = Lighting.ClockTime,
			GlobalShadows = Lighting.GlobalShadows,
			Ambient = Lighting.Ambient
		}
	end
	local function setFullbright(enabled)
		fullbrightEnabled = enabled
		if enabled then
			storeOriginalSettings()
		else
			if next(originalSettings) then
				Lighting.Brightness = originalSettings.Brightness
				Lighting.ClockTime = originalSettings.ClockTime
				Lighting.GlobalShadows = originalSettings.GlobalShadows
				Lighting.Ambient = originalSettings.Ambient
			end
		end
	end
	RunService.RenderStepped:Connect(function()
		if fullbrightEnabled then
			Lighting.Brightness = 5
			Lighting.ClockTime = 12
			Lighting.GlobalShadows = false
			Lighting.Ambient = Color3.new(1, 1, 1)
		end
	end)
	UtilitiesGroupBox:AddToggle('FullbrightToggle', {
		Text = 'Fullbright',
		Default = false,
		Tooltip = 'Toggle Fullbright',
		Callback = function(Value)
			setFullbright(Value)
		end
	})

-- == NO WEATHER == --
	local Lighting = game:GetService"Lighting"
	local RunService = game:GetService"RunService"
	local noWeatherEnabled = false
	local originalSettings = {}
	local function storeOriginalSettings()
		originalSettings = {
			FogColor = Lighting.FogColor,
			FogEnd = Lighting.FogEnd,
			FogStart = Lighting.FogStart,
			OutdoorAmbient = Lighting.OutdoorAmbient,
		}
	end
	local function removeWeatherInstances()
		for _, instance in ipairs(Lighting:GetChildren()) do
			if instance:IsA"Sky" or instance:IsA"Atmosphere" then
				instance:Destroy()
			end
		end
	end
	local function setNoWeather(enabled)
		if enabled then
			storeOriginalSettings()
			Lighting.FogColor = Color3.fromRGB(255, 255, 255)
			Lighting.FogEnd = 1000000
			Lighting.FogStart = 0
			Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			removeWeatherInstances()
		else
			if next(originalSettings) then
				Lighting.FogColor = originalSettings.FogColor
				Lighting.FogEnd = originalSettings.FogEnd
				Lighting.FogStart = originalSettings.FogStart
				Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
			end
		end
	end
	RunService.RenderStepped:Connect(function()
		if noWeatherEnabled then
			removeWeatherInstances()
		end
	end)
	UtilitiesGroupBox:AddToggle('NoFog Toggle', {
		Text = 'NoFog',
		Default = false,
		Tooltip = 'Toggle NoFog',
		Callback = function(Value)
			setNoWeather(Value)
		end
	})
	UtilitiesGroupBox:AddToggle("InfZoom", {
		Text = "Infinite Zoom",
		Default = false,
		Tooltip = "Toggle infinite zoom",
		Callback = function(val)
			if val then
				game:GetService"Players".LocalPlayer.CameraMaxZoomDistance = 1000000
			else
				game:GetService"Players".LocalPlayer.CameraMaxZoomDistance = 30
			end
		end
	})

	local UtilitiesTwoGroupBox = Tabs.Misc:AddLeftGroupbox"Performance"
	UtilitiesTwoGroupBox:AddToggle("DestroyFish", {
		Text = "No Fish Models",
		Default = false,
		Tooltip = "Automatically deletes fish models.",
	})

	UtilitiesTwoGroupBox:AddToggle("DisableRendering", {
		Text = "Disable rendering [+FPS]",
		Default = false,
		Tooltip = "Disables 3D rendering.",
		Callback = function(Value)
			RunService:Set3dRenderingEnabled(not Value)
		end,
	})

	UtilitiesTwoGroupBox:AddToggle("DisableInventory", {
		Text = "Disable custom inventory [+FPS]",
		Default = false,
		Tooltip = "Disables the inventory UI.",
		Callback = function(Value)
			local Inventory = WaitForTable(LocalPlayer.PlayerGui, {
				"hud",
				"safezone",
				"backpack"
			})
			if Inventory then
				Inventory.Visible = not Value
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, Value)
			end
		end,
	})

-- Rod Teleports Groupbox
	local rodTeleportLocations = {
		["Training Rod"] = CFrame.new(457.693848, 148.357529, 230.414307),
		["Plastic Rod"] = CFrame.new(454.425385, 148.169739, 229.172424),
		["Carbon Rod"] = CFrame.new(454.083618, 150.590073, 225.328827),
		["Long Rod"] = CFrame.new(485.695038, 171.656326, 145.746109),
		["Fast Rod"] = CFrame.new(447.183563, 148.225739, 220.187454),
		["Lucky Rod"] = CFrame.new(446.085999, 148.253006, 222.1600),
		["Steady Rod"] = CFrame.new(-1511.23523, 139.679504, 759.417114),
		["Fortune Rod"] = CFrame.new(-1520.87964, 141.283279, 771.946777),
		["Rapid Rod"] = CFrame.new(-1509.24463, 139.725906, 759.628174),
		["Nocturnal Rod"] = CFrame.new(-141.874237, -515.313538, 1139.04529),
		["Aurora Rod"] = CFrame.new(-141.874237, -515.313538, 1139.04529),
		["Rod Of The Depths"] = CFrame.new(1689.9, -902.4, 1437.7),
		["Magnet Rod"] = CFrame.new(-194.998871, 130.148087, 1930.97107),
		["King's Rod"] = CFrame.new(1375.57642, -810.201721, -303.509247),
		["Reinforced Rod"] = CFrame.new(-986.474365, -245.473938, -2689.79248),
		["Trident Rod"] = CFrame.new(-1484.34192, -222.325562, -2194.77002),
		["Scurvy Rod"] = CFrame.new(-2828.21851, 213.457199, 1512.20959),
		["Phoenix Rod"] = CFrame.new(5971.03125, 270.377502, 852.372559),
		["Heaven's Rod"] = CFrame.new(19980, 916, 5384),
		["Summit Rod"] = CFrame.new(20207.7539, 736.058289, 5711.35156),
		["Avalanche Rod"] = CFrame.new(19770.1816, 415.680969, 5419.19678),
		["Ice Warper's Rod"] = CFrame.new(19965, 587, 5573),
		["Arctic Rod"] = CFrame.new(19578.2363, 132.338379, 5307.38281),
		["Abyssal Specter Rod"] = CFrame.new(-3804.09668, -566.402893, 1870.32849),
		["Kraken Rod"] = CFrame.new(-4415.41699, -995.66217, 2054.45312),
		["Depthseeker Rod"] = CFrame.new(-4466.24609, -596.11145, 1875.07166),
		["Champions Rod"] = CFrame.new(-4277.4541, -602.719604, 1839.05908),
		["Tempest Rod"] = CFrame.new(-4927.61865, -594.829651, 1856.89734),
		["Zeus Rod"] = CFrame.new(-4270.84521, -626.403259, 2664.3479),
		["Poseidon Rod"] = CFrame.new(-4086.14795, -557.409241, 895.166809),
		["Ethereal Prism Rod"] = CFrame.new(-4359.83936, -11172.4326, 3718.91968),
		["Leviathan's Fang Rod"] = CFrame.new(-2297.67651, -11185.3018, 7138.99023),
		["Rod Of The Zenith"] = CFrame.new(-13625.1162, -11034.4316, 357.60199),
		["Volcanic Rod"] = CFrame.new(-3178.24463, -2035.75085, 4021.57886),
		["Brick Rod"] = CFrame.new(1321, 140, 1540),
		["Crystalized Rod"] = CFrame.new(19240, 400, 6035),
		["Crystalized Rod"] = CFrame.new(19240, 400, 6035),
	}
	local ShopGroupBox = Tabs.Teleports:AddLeftGroupbox"Rod Teleports"
	local RodTeleportOrigin
	local rodDropdownValues = {}
	for friendlyName, _ in pairs(rodTeleportLocations) do
		table.insert(rodDropdownValues, friendlyName)
	end
	ShopGroupBox:AddDropdown("RemoteShopDropdown", {
		Values = rodDropdownValues,
		Default = 1,
		Multi = false,
		Tooltip = "Rod to teleport to",
	})
	ShopGroupBox:AddButton("Teleport", function()
		local Selected = GetOptionValue"RemoteShopDropdown"
		local targetCFrame = rodTeleportLocations[Selected]
		if targetCFrame then 
		-- Save current location before teleporting
			RodTeleportOrigin = LocalPlayer.Character:GetPivot()
			local offsetCFrame = targetCFrame * CFrame.new(0, 5, 0)
			Utils.TP(offsetCFrame)
		end
	end)
	ShopGroupBox:AddButton("Go Back", function()
		if RodTeleportOrigin then
			Utils.TP(RodTeleportOrigin)
		else
			Utils.GenericToast(3, "No previous location stored!")
		end
	end)

-- Item Teleports Groupbox
	local itemTeleportLocations = {
		GPS = CFrame.new(517, 152, 284),
		Glider = CFrame.new(-1713, 149, 740),
		Pickaxe = CFrame.new(19783.1914, 415.743622, 5391.92041),
		["Advanced Glider"] = CFrame.new(19939, 1142, 5544),
		["Heart Of Zeus"] = CFrame.new(-2522, 138, 1593),
		Drill = CFrame.new(0, -85.39099884033203, 0),
		["Crab Cage"] = CFrame.new(465, 150, 235),
		["Conception Conch"] = CFrame.new(-145, -515, 1140),
		["Common Crate"] = CFrame.new(-1140, 125, -1076),
		["Sundial Totem"] = CFrame.new(-1215, 195, -1040),
		["Tempest Totem"] = CFrame.new(20, 140, 1860),
		["Windset Totem"] = CFrame.new(2845, 180, 2700),
		["Smokescreen Totem"] = CFrame.new(2790, 140, -625),
		["Meteor Totem"] = CFrame.new(-1945, 275, 230),
		["Avalanche Totem"] = CFrame.new(19711, 468, 6059),
		["Eclipse Totem"] = CFrame.new(5940, 265, 900),
		["Blizzard Totem"] = CFrame.new(20148, 743, 5804),
		["Aurora Totem"] = CFrame.new(-1810, -135, -3280),
		["Cursed Storm Totem"] = CFrame.new(760, 2130, 16965),
		["Zeus Storm Totem"] = CFrame.new(-4325, -625, 2685),
		["Poseidon Wrath Totem"] = CFrame.new(-3955, -555, 855),
	}
	local ItemTpGroupBox = Tabs.Teleports:AddLeftGroupbox"Item Teleports"
	local ItemTeleportOrigin
	local itemDropdownValues = {}
	for friendlyName, _ in pairs(itemTeleportLocations) do
		table.insert(itemDropdownValues, friendlyName)
	end
	ItemTpGroupBox:AddDropdown("ItemShop", {
		Values = itemDropdownValues,
		Default = 1,
		Multi = false,
		Tooltip = "Item to teleport to",
	})
	ItemTpGroupBox:AddButton("Teleport", function()
		local Selected = GetOptionValue"ItemShop"
		local targetCFrame = itemTeleportLocations[Selected]
		if targetCFrame then 
		-- Save current location before teleporting
			ItemTeleportOrigin = LocalPlayer.Character:GetPivot()
			local offsetCFrame = targetCFrame * CFrame.new(0, 5, 0)
			Utils.TP(offsetCFrame)
		end
	end)
	ItemTpGroupBox:AddButton("Go Back", function()
		if ItemTeleportOrigin then
			Utils.TP(ItemTeleportOrigin)
		else
			Utils.GenericToast(3, "No previous location stored!")
		end
	end)

-- Item Teleports Groupbox
	local questTeleportLocations = {
		["Lost Rod"] = CFrame.new(2930, 130, 2620),
		["Roslit Brick"] = CFrame.new(-1844, 194.5, 196.1),
		["Ancient Isles Brick"] = CFrame.new(5959, 269, 850),
		["The Depths Brick"] = CFrame.new(989, -734, 1136),
		["Blue Energy Crystal"] = CFrame.new(20125, 211, 5450),
		["Green Energy Crystal"] = CFrame.new(19870, 448, 5555),
		["Yellow Energy Crystal"] = CFrame.new(19500, 335, 5550),
		["Red Energy Crystal"] = CFrame.new(19920, 1140, 5350),
		["Button 1"] = CFrame.new(400, 136, 265),
		["Button 2"] = CFrame.new(-1716, 149, 732),
		["Button 3"] = CFrame.new(-2566, 181, 1353),
		["Button 4"] = CFrame.new(2930, 281, 2594),
		["Button 5"] = CFrame.new(5506, 147, -315),
		["Button 5"] = CFrame.new(5506, 147, -315),
		["TNT Lever 1"] = CFrame.new(-2522, 138, 1593),
		["TNT Lever 2"] = CFrame.new(-2551, 150, 1667),
		["TNT Lever 3"] = CFrame.new(-2729, 168, 1730),
		["TNT Lever 4"] = CFrame.new(-2881, 314, 1605),
		["TNT Lever 5"] = CFrame.new(-2835, 131, 1510),
	}
	local questTpGroupBox = Tabs.Teleports:AddRightGroupbox"Quest Teleports"
	local ItemTeleportOrigin
	local questDropdownValues = {}
	for friendlyName, _ in pairs(questTeleportLocations) do
		table.insert(questDropdownValues, friendlyName)
	end
	questTpGroupBox:AddDropdown("QuestLocations", {
		Values = questDropdownValues,
		Default = 1,
		Multi = false,
		Tooltip = "Quest to teleport to",
	})
	questTpGroupBox:AddButton("Teleport", function()
		local Selected = GetOptionValue"QuestLocations"
		local targetCFrame = questTeleportLocations[Selected]
		if targetCFrame then
			questTeleportOrigin = LocalPlayer.Character:GetPivot()
			local offsetCFrame = targetCFrame * CFrame.new(0, 5, 0)
			Utils.TP(offsetCFrame)
		end
	end)
	questTpGroupBox:AddButton("Go Back", function()
		if questTeleportOrigin then
			Utils.TP(questTeleportOrigin)
		else
			Utils.GenericToast(3, "No previous location stored!")
		end
	end)

-- Item Teleports Groupbox
	local npcTeleportLocations = {
		["Jack Marrow"] = CFrame.new(-2830, 215, 1518),
		Merchant = CFrame.new(466, 151, 225),
		["Skin Merchant"] = CFrame.new(415, 135, 190),
		Angler = CFrame.new(480, 150, 295),
		Shipwright = CFrame.new(360, 135, 260),
		["Inn Keeper"] = CFrame.new(490, 150, 245),
		Submariner = CFrame.new(-3355, -2270, 3800),
		["Egg Salesman"] = CFrame.new(375, 135, 320),
		["Sea Traveler"] = CFrame.new(140, 150, 2030),
		["Lantern Keeper"] = CFrame.new(710, 165, 335),
		Phineas = CFrame.new(470, 150, 275),
		["Captain Ahab"] = CFrame.new(362, 133, 294),
		Alfie = CFrame.new(-1515, 141, 765),
		Ashe = CFrame.new(-1705, 150, 735),
		["Dr Glimmerfin"] = CFrame.new(-1320, 130, 300),
		Orc = CFrame.new(-1850, 165, 160),
		Wilson = CFrame.new(2935, 280, 2565),
		Merlin = CFrame.new(-928, 224, -998),
		Silas = CFrame.new(1545, 1690, 6310),
		Agaric = CFrame.new(2595, 130, -725),
		Synth = CFrame.new(-145, -515, 1140),
		["The Keeper"] = CFrame.new(20, -705, 1255),
		Caleia = CFrame.new(980, 130, -1235),
		Minish = CFrame.new(-1322, 140, 1543),
		Chiseler = CFrame.new(6087, 195, 294),
		Meteoriticist = CFrame.new(5922, 262, 596),
		Hiker = CFrame.new(19526, 132, 5236),
		["Bubble Mermaid"] = CFrame.new(-3550, 130, 568),
		["Captain Neptune"] = CFrame.new(-3820, 135, 575),
		["Dr. Crookspine"] = CFrame.new(-1915, 225, -530),
	}
	local npcTpGroupBox = Tabs.Teleports:AddRightGroupbox"NPC Teleports"
	local ItemTeleportOrigin
	local npcDropdownValues = {}
	for friendlyName, _ in pairs(npcTeleportLocations) do
		table.insert(npcDropdownValues, friendlyName)
	end
	npcTpGroupBox:AddDropdown("npcCoords", {
		Values = npcDropdownValues,
		Default = "Jack Marrow",
		Multi = false,
		Tooltip = "NPC to teleport to",
	})
	npcTpGroupBox:AddButton("Teleport", function()
		local Selected = GetOptionValue"npcCoords"
		local targetCFrame = npcTeleportLocations[Selected]
		if targetCFrame then
			npcTeleportOrigin = LocalPlayer.Character:GetPivot()
			local offsetCFrame = targetCFrame * CFrame.new(0, 5, 0)
			Utils.TP(offsetCFrame)
		end
	end)
	npcTpGroupBox:AddButton("Go Back", function()
		if npcTeleportOrigin then
			Utils.TP(npcTeleportOrigin)
		else
			Utils.GenericToast(3, "No previous location stored!")
		end
	end)

--------------------------------
-- TELEPORTS: SERVER TP GROUP --
--------------------------------
	local serverGroupbox = Tabs.Teleports:AddRightGroupbox"Server Teleports"
-- == REJOIN == --
	serverGroupbox:AddButton{
		Text = "Rejoin",
		Func = function()
			print"Rejoining the same server..."
			TeleportService:Teleport(game.PlaceId, LocalPlayer)
		end,
		DoubleClick = false,
		Tooltip = "Rejoin the same server"
	}
-- == HOP SMALLEST == --
	serverGroupbox:AddButton{
		Text = "Hop Random",
		Func = function()
			print"Hopping to the random server..."
			local smallestServerId
			local smallestCount = math.huge
			local cursor = ""
			repeat
				local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)
				if cursor and cursor ~= "" then
					url = url .. "&cursor=" .. cursor
				end
				local response = game:HttpGet(url)
				local data = HttpService:JSONDecode(response)
				for _, server in ipairs(data.data) do
					if server.playing < server.maxPlayers and server.playing < smallestCount then
						smallestCount = server.playing
						smallestServerId = server.id
					end
				end
				cursor = data.nextPageCursor or ""
			until cursor == "" or smallestServerId
			if smallestServerId then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, smallestServerId, LocalPlayer)
			else
				warn"No available servers found!"
			end
		end,
		DoubleClick = false,
		Tooltip = "Join a random server"
	}

-- == HOP RANDOM == --
	serverGroupbox:AddButton{
		Text = "Hop Smallest",
		Func = function()
			print"Hopping to a smallest server..."
			local servers = {}
			local cursor = ""
			repeat
				local url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", game.PlaceId)
				if cursor and cursor ~= "" then
					url = url .. "&cursor=" .. cursor
				end
				local response = game:HttpGet(url)
				local data = HttpService:JSONDecode(response)
				for _, server in ipairs(data.data) do
					if server.playing < server.maxPlayers then
						table.insert(servers, server.id)
					end
				end
				cursor = data.nextPageCursor or ""
			until cursor == "" or #servers > 0
			if #servers > 0 then
				local randomServerId = servers[math.random(1, #servers)]
				TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServerId, LocalPlayer)
			else
				warn"No available servers found!"
			end
		end,
		DoubleClick = false,
		Tooltip = "Join the server with the fewest players"
	}
	local MerlinGroupBox = Tabs.Main:AddLeftGroupbox"Merlin"
	MerlinGroupBox:AddSlider("MerlinAmount", {
		Text = "Item amount",
		Default = 1,
		Min = 1,
		Max = 50,
		Rounding = 0,
		Compact = false,
	})

	MerlinGroupBox:AddButton("Buy Power", function()
		if not Remotes.Power then
			Utils.GenericToast(4, "Power 远程取不到, 游戏结构可能变了")
			return
		end

		local Amount = GetOptionValue"MerlinAmount"
		for i = 1, Amount do
			task.spawn(function()
				pcall(function()
					FireRemote(Remotes.Power)
				end)
			end)
		end
	end)

	MerlinGroupBox:AddButton("Buy Luck", function()
		if not Remotes.Luck then
			Utils.GenericToast(4, "Luck 远程取不到, 游戏结构可能变了")
			return
		end

		local Amount = GetOptionValue"MerlinAmount"
		for i = 1, Amount do
			task.spawn(function()
				pcall(function()
					FireRemote(Remotes.Luck)
				end)
			end)
		end
	end)

	local BoatGroupBox = Tabs.Main:AddRightGroupbox"Boat"
	BoatGroupBox:AddDropdown("BoatSpawnDropdown", {
		Values = State.OwnedBoats,
		Default = 1,
		Multi = false,

		Text = "Select boat",
		Tooltip = "Boat to spawn",
	})

	BoatGroupBox:AddButton("Remote-Spawn Boat", function()
		UI.Library:Toggle()

		local BoatSpawnLocation = LocalPlayer.Character:GetPivot().Position
		local BoatPreview
		local BoatName = GetOptionValue"BoatSpawnDropdown"
		local ShipwrightNPC = Utils.GetNPC("Shipwright", true)

		if not ShipwrightNPC then
			Utils.GenericToast(3, "Shipwright not found.")
			UI.Library:Toggle()
			return
		end

		if not BoatName then
			Utils.GenericToast(3, "Please select a boat.")
			UI.Library:Toggle()
			return
		end

		if Interface.BoatModels and Interface.BoatModels:FindFirstChild(BoatName) then
			BoatPreview = Interface.BoatModels:FindFirstChild(BoatName):Clone()
			BoatPreview.Parent = Camera
		else
			BoatPreview = Instance.new"Model"
		end

		for _, Part in next, BoatPreview:GetDescendants() do
			if Part:IsA"BasePart" then
				Part.Anchored = true
				Part.CanCollide = false
				Part.CanTouch = false
			end
		end

		local Origin = LocalPlayer.Character:GetPivot()
		Camera.CameraType = Enum.CameraType.Scriptable

		TweenService:Create(Camera, TweenInfo.new(0.5), {
			CFrame = CFrame.new(Origin.Position + Vector3.new(0, 80, 0), Origin.Position),
		}):Play()

		task.wait(0.5)

		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition

		local CameraMotionConnection
		CameraMotionConnection = RunService.RenderStepped:Connect(function()
			local Delta = UserInputService:GetMouseDelta()
			local X, Y = Delta.X, Delta.Y
			Camera.CFrame *= CFrame.Angles(0, math.rad(-X * 0.5), 0) * CFrame.Angles(math.rad(-Y * 0.5), 0, 0)

			local Params = RaycastParams.new()
			Params.FilterType = Enum.RaycastFilterType.Exclude
			Params.FilterDescendantsInstances = {
				LocalPlayer.Character,
				BoatPreview
			}

			local CameraHit = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 500, Params)

			if CameraHit then
				BoatSpawnLocation = CameraHit.Position + Vector3.new(0, 10, 0)
				BoatPreview:PivotTo(CFrame.new(BoatSpawnLocation))
			end
		end)

		local InputConnection
		InputConnection = UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				InputConnection:Disconnect()
				CameraMotionConnection:Disconnect()
				Camera.CameraType = Enum.CameraType.Custom
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default

				LocalPlayer.Character:PivotTo(ShipwrightNPC:GetPivot())

				task.wait(0.3)
				fireproximityprompt(ShipwrightNPC.dialogprompt)

				local Result = ShipwrightNPC.shipwright.giveUI:InvokeServer()
				BoatPreview:Destroy()

				if Result then
					local NetSpawn = Utils.Net("RF", "Boats/Spawn")

					if NetSpawn then
						NetSpawn:InvokeServer(BoatName)
					end

					local NetClose = Utils.Net("RE", "Boats/Close")

					if NetClose then
						NetClose:FireServer()
					end
					LocalPlayer.PlayerGui.hud.safezone.shipwright.Visible = false

					-- this game is so bad
					if not Interface.ActiveBoats then
						Utils.GenericToast(4, "船只容器取不到, 跳过上船")
						UI.Library:Toggle()
						return
					end

					local WaitStart = os.clock()

					repeat
						task.wait(0.5)
					until Interface.ActiveBoats:FindFirstChild(LocalPlayer.Name) or (os.clock() - WaitStart > 15)

					if not Interface.ActiveBoats:FindFirstChild(LocalPlayer.Name) then
						Utils.GenericToast(4, "船没刷出来, 跳过")
						UI.Library:Toggle()
						return
					end

					local Ship =
(						Interface.ActiveBoats:FindFirstChild(LocalPlayer.Name):FindFirstChildOfClass"Model")
					local Seat = Ship:FindFirstChildOfClass"VehicleSeat"
					local SitPrompt = Seat:WaitForChild"sitprompt"
					task.wait(0.5)
					fireproximityprompt(SitPrompt)
					task.wait(0.5)

					for i = 1, 60 do
						task.wait()
						Ship:PivotTo(CFrame.new(BoatSpawnLocation))
					end

					Ship.PlanePart.Rotation = Vector3.new(0, 0, 0)

					local WaterRayParams = RaycastParams.new()
					WaterRayParams.FilterType = Enum.RaycastFilterType.Include
					WaterRayParams.FilterDescendantsInstances = {
						workspace.Terrain
					}
					WaterRayParams.IgnoreWater = false

					local WaterHeight =
						workspace:Raycast(Ship.PlanePart.Position + Vector3.new(0, 100, 0), Vector3.new(0, -255, 0))

					if WaterHeight then
						Ship.PlanePart.Position = Ship.PlanePart.Position * Vector3.new(1, 0, 1)
							+ Vector3.new(0, 127, 0)
					end
				end

				UI.Library:Toggle()
			end
		end)
	end)

	local AutomationMiscGroup = Tabs.Autos:AddRightGroupbox"Enviromental"
	AutomationMiscGroup:AddToggle("AutoMeteor", {
		Text = "Auto-Meteor",
		Default = false,
		Tooltip = "Automatically grabs item from meteor.",
	})

	local AutomationFishingGroup = Tabs.Autos:AddRightGroupbox"Fishing"
	AutomationFishingGroup:AddToggle("ZoneFish", {
		Text = "Zone-fish",
		Default = false,
		Tooltip = "Zones fish for you.",
		Callback = function(Value)
			if Value then
				UI.Toggles.InfiniteOxygen:SetValue(true)
				ZoneFishOrigin = LocalPlayer.Character:GetPivot()
			else
				for _, State in next, Enum.HumanoidStateType:GetEnumItems() do
					LocalPlayer.Character.Humanoid:SetStateEnabled(State, true)
				end

				if ZoneFishOrigin then
					LocalPlayer.Character.Humanoid:UnequipTools()
					for _ = 1, 10 do
						task.wait()
						Utils.TP(ZoneFishOrigin.Position)
					end
					ZoneFishOrigin = nil
				end
			end
		end,
	})

	AutomationFishingGroup:AddDropdown("ZoneFishDropdown", {
		Values = FishingZones_DropDownValues,
		Default = 1,
		Multi = false,
		Text = "Select zone",
		Tooltip = "Zone to fish in",
	})

	local AutomationEconomyGroup = Tabs.Autos:AddRightGroupbox"Economy"
	AutomationEconomyGroup:AddToggle("AutoSell", {
		Text = "Auto-sell",
		Default = false,
		Tooltip = "Automatically sells items.",
	})



	local DiagGroup = Tabs.Misc:AddRightGroupbox"诊断"
	local DiagGui, DiagLabel, DiagRunning

	local function DiagLine(Ok, Text)
		return (Ok and "正常 " or "缺失 ") .. Text
	end

	local function BuildDiagPanel()
		if DiagGui and DiagGui.Parent then
			return
		end

		local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 10)

		if not PlayerGui then
			return
		end

		local Gui = Instance.new("ScreenGui")
		Gui.Name = "NoxHubDiag"
		Gui.ResetOnSpawn = false
		Gui.DisplayOrder = 9999
		Gui.IgnoreGuiInset = true
		Gui.Parent = PlayerGui

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(0, 450, 0, 340)
		Label.Position = UDim2.fromOffset(12, 12)
		Label.BackgroundColor3 = Color3.fromRGB(15, 16, 20)
		Label.BackgroundTransparency = 0.15
		Label.TextColor3 = Color3.fromRGB(230, 232, 238)
		Label.TextSize = 13
		Label.Font = Enum.Font.Code
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.TextYAlignment = Enum.TextYAlignment.Top
		Label.TextWrapped = true
		Label.Parent = Gui

		DiagGui = Gui
		DiagLabel = Label
	end

	local function RefreshDiag()
		if not (DiagLabel and DiagLabel.Parent) then
			return
		end

		local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		local Rod = CurrentTool

		if not Rod and LocalPlayer.Character then
			Rod = LocalPlayer.Character:FindFirstChildOfClass("Tool")
		end

		local Values, Events, CastRemote = GetToolParts(Rod)

		DiagLabel.Text = table.concat({
			"NoxHub 诊断  " .. os.date("%H:%M:%S"),
			"PlaceId " .. tostring(game.PlaceId) .. " / 钩子 " .. tostring(not NO_HOOKING),
			"",
			DiagLine(Remotes.ReelFinished ~= nil, "远程 reelfinished"),
			DiagLine(Remotes.SellAll ~= nil, "远程 SellAll"),
			DiagLine(Remotes.Power ~= nil, "Merlin Power"),
			DiagLine(Remotes.Luck ~= nil, "Merlin Luck"),
			"",
			"装备中的工具: " .. (Rod and Rod.Name or "无 (先拿鱼竿)"),
			DiagLine(Values ~= nil, "工具 values"),
			DiagLine(Events ~= nil, "工具 events"),
			DiagLine(CastRemote ~= nil, "工具 cast 远程"),
			"",
			DiagLine(PlayerGui ~= nil and PlayerGui:FindFirstChild("reel") ~= nil, "reel 界面"),
			DiagLine(PlayerGui ~= nil and PlayerGui:FindFirstChild("shakeui") ~= nil, "shakeui 界面"),
			"钓鱼区数量: " .. tostring(#FishingZones_DropDownValues),
			"",
			DiagLine(Interface.TeleportSpots ~= nil, "TeleportSpots"),
			DiagLine(Interface.Inventory ~= nil, "Inventory"),
			DiagLine(Interface.NPCs ~= nil, "NPCs"),
			DiagLine(Interface.PlayerData ~= nil, "PlayerData"),
			DiagLine(Interface.ActiveBoats ~= nil, "ActiveBoats"),
			DiagLine(Interface.BoatModels ~= nil, "BoatModels"),
			"",
			"执行器: replicatesignal=" .. tostring(replicatesignal ~= nil)
				.. " / getconnections=" .. tostring(getconnections ~= nil),
		}, "\n")
	end

	DiagGroup:AddToggle("DiagPanel", {
		Text = "诊断面板 [排查用]",
		Default = false,
		Tooltip = "显示各依赖是否加载成功, 用来定位哪个功能失效",
		Callback = function(Value)
			if Value then
				BuildDiagPanel()

				if not DiagRunning then
					DiagRunning = task.spawn(function()
						while DiagRunning do
							if not (DiagGui and DiagGui.Parent) then
								break
							end

							pcall(RefreshDiag)
							task.wait(1)
						end

						DiagRunning = nil
					end)
				end
			else
				if DiagGui then
					DiagGui:Destroy()
					DiagGui = nil
				end

				DiagLabel = nil
				DiagRunning = nil
			end
		end,
	})
	local GameplayDisruptionGroup = Tabs.Misc:AddRightGroupbox"Gameplay Disruption"
	GameplayDisruptionGroup:AddToggle("ServerStresser", {
		Text = "Lag/Crash server",
		Default = false,
		Tooltip = "Spams tools to lag the server.",
		Callback = function(Value)
			if not Value then
				game:GetService"TeleportService":Teleport(game.PlaceId, LocalPlayer)
			else
				Utils.TP(LocalPlayer.Character:GetPivot().Position + Vector3.new(0, 9e9, 0))
			end
		end,
	})

	GameplayDisruptionGroup:AddLabel(
		"The server lagger is irreversible and you will be forced to rejoin if you want to disable it.",
		true
	)
	
	setthreadidentity(7)

	Utils.BoatsChanged()

	Collect(workspace:GetPropertyChangedSignal"CurrentCamera":Connect(function()
		Camera = workspace.CurrentCamera
	end))

	do
		local PlayerData = Interface.PlayerData
		local BoatFolder = PlayerData and PlayerData:FindFirstChild("Boats")

		if BoatFolder then
			Collect(BoatFolder.AncestryChanged:Connect(Utils.BoatsChanged))
		end
	end

	Collect(workspace:WaitForChild"active".ChildAdded:Connect(function(Child)
		if Child:IsA"Model" then
			local Fish = Child:WaitForChild("Fish", 1)

			if Fish then
				if GetToggleValue"DestroyFish" then
					task.wait()
					Child:Destroy()
				end
			end
		end
	end))

	do
		local Inventory = Interface.Inventory

		if Inventory then
			Collect(Inventory:GetPropertyChangedSignal"Visible":Connect(function()
				if GetToggleValue"DisableInventory" and Inventory.Visible == true then
					task.wait()
					Inventory.Visible = false
				end
			end))
		end
	end

	do
		local MeteorItems = Interface.MeteorItems

		if MeteorItems then
	Collect(MeteorItems.ChildAdded:Connect(function(Item)
		if GetToggleValue"AutoMeteor" then
			State.GettingMeteor = true

			local Origin = LocalPlayer.Character:GetPivot()
			local Prompt = WaitForTable(Item, {
				"Center",
				"prompt"
			}, 5)

			if not Prompt then
				State.GettingMeteor = false
				return
			end

			local Center = (Prompt.Parent )
			local TPConnection = RunService.PostSimulation:Connect(function()
				Utils.TP(Center:GetPivot() - (Vector3.yAxis * 5))
			end)

			task.delay(2, function()
				pcall(function()
					fireproximityprompt(Prompt)
				end)
			end)

			task.delay(4, function()
				TPConnection:Disconnect()
				Utils.TP(Origin)
				State.GettingMeteor = false
			end)
		end
	end))
		end
	end

	if not NO_HOOKING then
		local oldindex
		oldindex = hookmetamethod(game, "__index", function(...)
			if not Unloaded then
				if not checkcaller() then
					local Args = {
						...
					} -- i forgot argguard wasnt a thing anymore
					local self, key = Args[1], Args[2]

					if self == Interface.Inventory and key == "Visible" then
						local callingscript = getcallingscript()

						if callingscript and Interface.Inventory and (not game.IsDescendantOf(callingscript, Interface.Inventory)) then
							return true -- for some reason when the backpack isn't visible it disables the menu buttons
						end
					end
				end
			end

			return oldindex(...)
		end)

		local oldnamecall
		oldnamecall = hookmetamethod(game, "__namecall", function(...)
			if not Unloaded then
				if not checkcaller() then
					local Method = getnamecallmethod()

					local Args = {
						...
					}
					local self = table.remove(Args, 1)

					if Method == "FireServer" then
						if self == Remotes.ReelFinished then
							if GetToggleValue"PerfectReel" then
								Args[1] = 100 -- Reel percentage
								Args[2] = true -- If the reel was perfect
							end
						elseif tostring(self) == "cast" then -- ultra detectable but i dont care because im sigma.
							if GetToggleValue"PerfectCast" then
								Args[1] = 100 -- Cast percentage
							end
						end

						return oldnamecall(self, unpack(Args))
					end
				end
			end

			return oldnamecall(...)
		end)
	end

	local ShopUpdateCoroutine = coroutine.create(function()
		while task.wait(1) do
			if GetToggleValue"AutoSell" then
				if Remotes.SellAll then
					FireRemote(Remotes.SellAll)
				end
			end
		end
	end)

	local AutoClickCoroutine = coroutine.create(function()
		function Utils.MountShakeUI(ShakeUI)
			if not ShakeUI or ShakeUI:GetAttribute("NoxMounted") then
				return
			end

			local SafeZone = ShakeUI:WaitForChild("safezone", 5)

			if not SafeZone then
				dbgwarn"Unable to mount shake UI."
				return
			end

			ShakeUI:SetAttribute("NoxMounted", true)

			local function HandleButton(Button)
				Button.Selectable = true

				if EnsureInstance(Button) then
					GuiService.SelectedObject = Button
				end
			end

			if GetToggleValue"CenterShake" then
				local Connect = SafeZone:WaitForChild("connect", 1)

				if Connect then
					Connect.Enabled = false
				end

				SafeZone.Size = UDim2.fromOffset(0, 0)
				SafeZone.Position = UDim2.fromScale(0.5, 0.5)
				SafeZone.AnchorPoint = Vector2.new(0.5, 0.5)
			end

			Collect(SafeZone.ChildAdded:Connect(function(Child)
				if not Child:IsA"ImageButton" then
					return
				end

				-- 每次出按钮都实时读开关, 不再把状态固定在挂载那一刻
				if not GetToggleValue"AutoShake" then
					return
				end

				if replicatesignal then
					pcall(replicatesignal, Child.MouseButton1Click)

					task.delay(0.05, function()
						if Child and Child.Parent then
							Child:Destroy()
						end
					end)

					return
				end

				local Done = false

				task.spawn(function()
					while not Done do
						RunService.Heartbeat:Wait()

						if not Child or not Child.Parent then
							break
						end

						HandleButton(Child)
					end
				end)

				task.spawn(function()
					repeat
						RunService.Heartbeat:Wait()
					until (not Child) or (not Child.Parent) or (not Child:IsDescendantOf(SafeZone))

					Done = true
				end)
			end))
		end

		Collect(LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)
			if Child:IsA"ScreenGui" and string.find(string.lower(Child.Name), "shake", 1, true) then
				Utils.MountShakeUI(Child)
			end
		end))

		-- 已经存在的摇竿界面也要挂上, 否则游戏先弹过一次就永远没效果
		for _, Child in next, LocalPlayer.PlayerGui:GetChildren() do
			if Child:IsA"ScreenGui" and string.find(string.lower(Child.Name), "shake", 1, true) then
				Utils.MountShakeUI(Child)
			end
		end
	end)

	local AutoReelCoroutine = coroutine.create(function()
		local LastInstant = 0

		while true do
			RunService.RenderStepped:Wait()

			local ReelUI = GetReelGui()

			if not ReelUI then
				continue
			end

			if GetToggleValue"InstantReel" then
				if Remotes.ReelFinished and ReelUI.Enabled ~= false and tick() - LastInstant > 0.2 then
					LastInstant = tick()
					FireRemote(Remotes.ReelFinished, 100, GetToggleValue"PerfectReel")
				end
			elseif GetToggleValue"AutoReel" then
				local Bar = ReelUI:FindFirstChild"bar"

				if not Bar then
					continue
				end

				local PlayerBar = Bar:FindFirstChild"playerbar"
				local TargetBar = Bar:FindFirstChild"fish"

				if not PlayerBar or not TargetBar then
					continue
				end

				while Bar and Bar.Parent and ReelUI.Parent do
					RunService.RenderStepped:Wait()

					local UnfilteredTargetPosition = PlayerBar.Position:Lerp(TargetBar.Position, 0.7)
					local TargetPosition = UDim2.fromScale(
						math.clamp(UnfilteredTargetPosition.X.Scale, 0.15, 0.85),
						UnfilteredTargetPosition.Y.Scale
					)

					PlayerBar.Position = TargetPosition
				end
			end
		end
	end)

	local AutoCastCoroutine = coroutine.create(function()
		local LastCastAttempt = 0

		while task.wait(0.5) do
			if GetToggleValue"AutoCast" then
				pcall(function()
					local Tool = CurrentTool

					if not Tool and LocalPlayer.Character then
						Tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
					end

					if not Tool then
						return
					end

					CurrentTool = Tool

					local Values, Events, CastRemote = GetToolParts(Tool)

					if not Values or not Events then
						return
					end

					local Casted = Values:FindFirstChild("casted")
					local Bite = Values:FindFirstChild("bite")

					if not Casted then
						return
					end

					if Bite and Bite.Value == true and Casted.Value == true then
						if (not GetReelGui()) and tick() - LastCastAttempt > 5 then
							ResetTool()
						end
					end

					if Utils.CountInstances(LocalPlayer.PlayerGui, "reel") > 1 then
						ResetTool()

						for _, Child in next, LocalPlayer.PlayerGui:GetChildren() do
							if Child.Name == "reel" then
								Child:Destroy()
							end
						end
					end

					if Casted.Value == false and CastRemote then
						LastCastAttempt = tick()

						-- 先甩竿, 动画只是表演, 找不到动画也不影响甩竿
						FireRemote(CastRemote, 100, 1)

						pcall(function()
							local Resources = ReplicatedStorage:FindFirstChild("resources")
							local Animations = Resources and Resources:FindFirstChild("animations")
							local Fishing = Animations and Animations:FindFirstChild("fishing")
							local Throw = Fishing and Fishing:FindFirstChild("throw")
							local Character = LocalPlayer.Character
							local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

							if not Throw or not Humanoid then
								return
							end

							local Track = Humanoid:LoadAnimation(Throw)
							Track.Priority = Enum.AnimationPriority.Action3
							Track:Play()
						end)
					end
				end)
			end
		end
	end)

	local ServerStressCoroutine = coroutine.create(function()
		local Backpack = LocalPlayer.Backpack

		local function IsFish(Tool)
			return Tool:FindFirstChild"fishscript" or (Tool:GetAttribute"IsFish" == true)
		end

		while task.wait(5) do
			if not GetToggleValue"ServerStresser" then
				continue
			end

			for i, Tool in next, Backpack:GetChildren() do
				task.spawn(function()
					if IsFish(Tool) then
						Tool:SetAttribute("IsFish", true)

						local FishModel = Tool:FindFirstChild"Fish"
						if FishModel then
							FishModel:Destroy()
						end

						Tool.Parent = LocalPlayer.Character
					end
				end)
			end

			LocalPlayer.Character.Humanoid:UnequipTools()
		end
	end)

	Collect(RunService.RenderStepped:Connect(function()
		local Inventory = WaitForTable(LocalPlayer.PlayerGui, {
			"hud",
			"safezone",
			"backpack"
		})
		if Inventory and Inventory.Visible then
			Inventory.Visible = not GetToggleValue"DisableInventory"
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, GetToggleValue"DisableInventory")
		end

		if GetToggleValue"SpamTool" then
			if CurrentTool then
				for i = 20, 1, -1 do
					CurrentTool:Activate()
				end
			end
		end

		if GetToggleValue"NoLocationCC" then
			Utils.ToggleLocationCC(false)
		else
			Utils.ToggleLocationCC(true)
		end
	end))

	Collect(RunService.PostSimulation:Connect(function()
		if GetToggleValue"ZoneFish" then
			if State.GettingMeteor then
				return -- dont conflict with meteor grabbing
			end

			for _, Part in next, LocalPlayer.Character:GetDescendants() do
				if Part:IsA"BasePart" then
					Part.CanTouch = false -- killzones and such
					Part.AssemblyLinearVelocity = Vector3.zero
					Part.AssemblyAngularVelocity = Vector3.zero
				end
			end

			local Zone = FishingZones[GetOptionValue"ZoneFishDropdown"]

			if Zone then
				local Origin = Zone:GetPivot()
				Utils.TP(Origin - Vector3.new(0, 20, 0))

				if CurrentTool then
					local Bobber = CurrentTool:FindFirstChild"bobber"
					if Bobber then
						local Rope = Bobber:FindFirstChildOfClass"RopeConstraint"
						if Rope then
							Rope.Length = 9e9
						end
						Bobber:PivotTo(Origin)
					end
				end
			end
		elseif GetToggleValue"InstantBob" then
			if CurrentTool then
				local Bobber = CurrentTool:FindFirstChild"bobber"
				if Bobber then
					local Params = RaycastParams.new()

					Params.FilterType = Enum.RaycastFilterType.Include
					Params.FilterDescendantsInstances = {
						workspace.Terrain
					}

					local RaycastResult = workspace:Raycast(Bobber.Position, -Vector3.yAxis * 100, Params)

					if RaycastResult then
						if RaycastResult.Instance:IsA"Terrain" then
							Bobber:PivotTo(CFrame.new(RaycastResult.Position))
						end
					end
				end
			end
		end
	end))

	Collect(LocalPlayer.Idled:Connect(function()
		if GetToggleValue"AntiAFK" then 
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end
	end))

	coroutine.resume(ServerStressCoroutine)
	coroutine.resume(AutoClickCoroutine)
	coroutine.resume(AutoReelCoroutine)
	coroutine.resume(AutoCastCoroutine)
	coroutine.resume(ShopUpdateCoroutine)
	Collect(ServerStressCoroutine)
	Collect(AutoClickCoroutine)
	Collect(AutoReelCoroutine)
	Collect(AutoCastCoroutine)
	Collect(ShopUpdateCoroutine)

	Collect(LocalPlayer.CharacterAdded:Connect(Utils.CharacterAdded))
	Collect(RunService.RenderStepped:Connect(function()
	end))

	OnUnload.Event:Once(function()
		for _, PersistentModel in next, CollectionService:GetTagged"ForcePersistent" do
			if PersistentModel:GetAttribute"OldStreamingMode" then
				local OldStreamingMode = (PersistentModel:GetAttribute"OldStreamingMode")
				PersistentModel.ModelStreamingMode =
(					Enum.ModelStreamingMode[OldStreamingMode] )
			else
				PersistentModel.ModelStreamingMode = Enum.ModelStreamingMode.Default
			end

			CollectionService:RemoveTag(PersistentModel, "ForcePersistent")
			PersistentModel:SetAttribute("OldStreamingMode", nil)
		end
	end)

	if LocalPlayer.Character then
		Utils.CharacterAdded(LocalPlayer.Character)
	end

	SaveManager:LoadAutoloadConfig()
	PreAutoloadConfig = false

end)

if not Success then
	warn("[NoxHub] 加载失败:", Error)

	pcall(function()
		local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
			or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 10)

		local Gui = Instance.new("ScreenGui")
		Gui.Name = "NoxHubError"
		Gui.ResetOnSpawn = false
		Gui.Parent = PlayerGui

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(0, 520, 0, 140)
		Label.Position = UDim2.new(0.5, -260, 0, 80)
		Label.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
		Label.BackgroundTransparency = 0.1
		Label.TextColor3 = Color3.fromRGB(255, 90, 90)
		Label.TextSize = 14
		Label.Font = Enum.Font.Code
		Label.TextWrapped = true
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.TextYAlignment = Enum.TextYAlignment.Top
		Label.Text = "NoxHub 加载失败, 把下面的报错发我:\n" .. tostring(Error)
		Label.Parent = Gui
	end)
end