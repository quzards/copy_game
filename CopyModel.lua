-- =============================================================
-- Ash Model Copier v7.0 — Obsidian Edition
-- Полный редизайн интерфейса + улучшенный UX
-- =============================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Cleanup old
for _, v in CoreGui:GetChildren() do
	if v:IsA("ScreenGui") and (v.Name == "AshModelCopier" or v.Name == "AshCopierV7") then v:Destroy() end
end
pcall(function()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if pg then for _, v in pg:GetChildren() do
		if v:IsA("ScreenGui") and (v.Name == "AshModelCopier" or v.Name == "AshCopierV7") then v:Destroy() end
	end end
end)

-- Root GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AshCopierV7"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
local ok = pcall(function() screenGui.Parent = CoreGui end)
if not ok then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- THEME — Obsidian + Violet + Amber
local C = {
	Bg0 = Color3.fromRGB(13,13,16),
	Bg1 = Color3.fromRGB(20,20,24),
	Bg2 = Color3.fromRGB(26,26,32),
	Bg3 = Color3.fromRGB(33,33,40),
	Card = Color3.fromRGB(38,38,46),
	CardHover = Color3.fromRGB(48,48,58),
	CardActive = Color3.fromRGB(54,54,66),
	Border = Color3.fromRGB(48,48,58),
	BorderLight = Color3.fromRGB(72,72,84),
	Accent = Color3.fromRGB(124,92,255),
	AccentHover = Color3.fromRGB(142,112,255),
	Accent2 = Color3.fromRGB(255,203,87),
	Accent2Hover = Color3.fromRGB(255,215,120),
	Text = Color3.fromRGB(242,242,250),
	TextDim = Color3.fromRGB(152,152,172),
	TextDark = Color3.fromRGB(98,98,115),
	Success = Color3.fromRGB(52,211,153),
	SuccessHover = Color3.fromRGB(72,231,173),
	Danger = Color3.fromRGB(248,113,113),
	DangerHover = Color3.fromRGB(255,135,135),
	Warning = Color3.fromRGB(251,191,36),
	Info = Color3.fromRGB(96,165,250),
	InfoHover = Color3.fromRGB(120,185,255),
	Purple = Color3.fromRGB(168,85,247),
	PurpleHover = Color3.fromRGB(188,110,255),
	HLFill = Color3.fromRGB(124,92,255),
	HLOutline = Color3.fromRGB(255,203,87),
}

-- Helpers
local function tw(o, props, dur, style, dir)
	TweenService:Create(o, TweenInfo.new(dur or 0.22, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end
local function corner(p, r)
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 10); c.Parent = p; return c
end
local function stroke(p, col, thick, transp)
	local s = Instance.new("UIStroke"); s.Color = col or C.Border; s.Thickness = thick or 1; s.Transparency = transp or 0.15; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = p; return s
end
local function pad(p, t, b, l, r)
	local pd = Instance.new("UIPadding")
	pd.PaddingTop = UDim.new(0, t or 0); pd.PaddingBottom = UDim.new(0, b or 0)
	pd.PaddingLeft = UDim.new(0, l or 0); pd.PaddingRight = UDim.new(0, r or 0); pd.Parent = p; return pd
end
local function grad(p, c1, c2, rot)
	local g = Instance.new("UIGradient"); g.Color = ColorSequence.new(c1, c2); g.Rotation = rot or 90; g.Parent = p; return g
end

-- Shadow behind main
local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(0, 760, 0, 560)
Shadow.Position = UDim2.new(0.5, -380, 0.5, -270)
Shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
Shadow.BackgroundTransparency = 0.55
Shadow.BorderSizePixel = 0
Shadow.Parent = screenGui
corner(Shadow, 22)

-- Main window
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 720, 0, 520)
Main.Position = UDim2.new(0.5, -360, 0.5, -260)
Main.BackgroundColor3 = C.Bg1
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = screenGui
corner(Main, 16)
stroke(Main, C.BorderLight, 1, 0.35)

-- Subtle inner glow top
local TopGlow = Instance.new("Frame")
TopGlow.Size = UDim2.new(1, 0, 0, 1)
TopGlow.Position = UDim2.new(0,0,0,0)
TopGlow.BackgroundColor3 = Color3.fromRGB(255,255,255)
TopGlow.BackgroundTransparency = 0.92
TopGlow.BorderSizePixel = 0
TopGlow.Parent = Main

-- HEADER — 56px
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 56)
Header.BackgroundColor3 = C.Bg0
Header.BorderSizePixel = 0
Header.Parent = Main

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.Position = UDim2.new(0,0,1,-1)
headerLine.BackgroundColor3 = C.Border
headerLine.BackgroundTransparency = 0.2
headerLine.BorderSizePixel = 0
headerLine.Parent = Header

-- Logo
local Logo = Instance.new("Frame")
Logo.Size = UDim2.new(0, 36, 0, 36)
Logo.Position = UDim2.new(0, 16, 0.5, -18)
Logo.BackgroundColor3 = C.Accent
Logo.BorderSizePixel = 0
Logo.Parent = Header
corner(Logo, 10)
grad(Logo, C.Accent, C.Purple, 45)
stroke(Logo, Color3.fromRGB(255,255,255), 1, 0.85)

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1,0,1,0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "A"
LogoText.TextColor3 = Color3.fromRGB(255,255,255)
LogoText.TextSize = 18
LogoText.Font = Enum.Font.GothamBlack
LogoText.Parent = Logo

-- Title block
local TitleWrap = Instance.new("Frame")
TitleWrap.Size = UDim2.new(0, 220, 0, 36)
TitleWrap.Position = UDim2.new(0, 62, 0.5, -18)
TitleWrap.BackgroundTransparency = 1
TitleWrap.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 120, 0, 18)
TitleLabel.Position = UDim2.new(0,0,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ASH COPIER"
TitleLabel.TextColor3 = C.Text
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleWrap

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 200, 0, 14)
SubTitle.Position = UDim2.new(0,0,0,18)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "MODEL INTELLIGENCE  •  OBSIDIAN"
SubTitle.TextColor3 = C.TextDark
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleWrap

-- Version badge
local VerBadge = Instance.new("Frame")
VerBadge.Size = UDim2.new(0, 72, 0, 22)
VerBadge.Position = UDim2.new(0, 190, 0.5, -11)
VerBadge.BackgroundColor3 = C.Card
VerBadge.BorderSizePixel = 0
VerBadge.Parent = Header
corner(VerBadge, 7)
stroke(VerBadge, C.Border, 1, 0.3)

local VerLabel = Instance.new("TextLabel")
VerLabel.Size = UDim2.new(1,0,1,0)
VerLabel.BackgroundTransparency = 1
VerLabel.Text = "v7.0  PRO"
VerLabel.TextColor3 = C.Accent
VerLabel.TextSize = 10
VerLabel.Font = Enum.Font.GothamBold
VerLabel.Parent = VerBadge

-- Right controls
local RightBar = Instance.new("Frame")
RightBar.Size = UDim2.new(0, 260, 0, 32)
RightBar.Position = UDim2.new(1, -276, 0.5, -16)
RightBar.BackgroundTransparency = 1
RightBar.Parent = Header

local function createHotkeyPill(text, posX)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(0, 52, 0, 22)
	f.Position = UDim2.new(0, posX, 0.5, -11)
	f.BackgroundColor3 = C.Bg2
	f.BorderSizePixel = 0
	f.Parent = RightBar
	corner(f, 6)
	stroke(f, C.Border, 1, 0.4)
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(1,0,1,0)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = C.TextDim
	l.TextSize = 10
	l.Font = Enum.Font.Code
	l.Parent = f
	return f
end

createHotkeyPill("[Q] Hide", 0)
createHotkeyPill("[H] Pick", 58)
createHotkeyPill("[G] Mode", 116)

local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 32, 0, 32)
HideBtn.Position = UDim2.new(0, 184, 0, 0)
HideBtn.BackgroundColor3 = C.Bg2
HideBtn.BorderSizePixel = 0
HideBtn.Text = "—"
HideBtn.TextColor3 = C.TextDim
HideBtn.TextSize = 14
HideBtn.Font = Enum.Font.GothamBold
HideBtn.AutoButtonColor = false
HideBtn.Parent = RightBar
corner(HideBtn, 8)
stroke(HideBtn, C.Border, 1, 0.3)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(0, 220, 0, 0)
CloseBtn.BackgroundColor3 = C.Bg2
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.TextDim
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = RightBar
corner(CloseBtn, 8)
stroke(CloseBtn, C.Border, 1, 0.3)

HideBtn.MouseEnter:Connect(function() tw(HideBtn, {BackgroundColor3 = C.CardHover}) tw(HideBtn:FindFirstChildOfClass("UIStroke"), {Transparency = 0.1}) end)
HideBtn.MouseLeave:Connect(function() tw(HideBtn, {BackgroundColor3 = C.Bg2}) end)
CloseBtn.MouseEnter:Connect(function() tw(CloseBtn, {BackgroundColor3 = C.Danger, BackgroundTransparency = 0.2}) CloseBtn.TextColor3 = C.Danger end)
CloseBtn.MouseLeave:Connect(function() tw(CloseBtn, {BackgroundColor3 = C.Bg2}) CloseBtn.TextColor3 = C.TextDim end)

-- Drag logic
do
	local dragging, dragStart, startPos
	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = Main.Position
			tw(Shadow, {BackgroundTransparency = 0.45}, 0.2)
			tw(Main, {BackgroundColor3 = C.Bg1}, 0.2)
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false; tw(Shadow, {BackgroundTransparency = 0.55}, 0.2) end end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			Shadow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X - 20, startPos.Y.Scale, startPos.Y.Offset + d.Y - 10)
		end
	end)
end

-- BODY
local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -56)
Body.Position = UDim2.new(0,0,0,56)
Body.BackgroundTransparency = 1
Body.Parent = Main

local SIDE_W = 172
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, SIDE_W, 1, 0)
Sidebar.BackgroundColor3 = C.Bg0
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Body

local sideDiv = Instance.new("Frame")
sideDiv.Size = UDim2.new(0,1,1,0)
sideDiv.Position = UDim2.new(1,0,0,0)
sideDiv.BackgroundColor3 = C.Border
sideDiv.BackgroundTransparency = 0.25
sideDiv.BorderSizePixel = 0
sideDiv.Parent = Sidebar

local SideScroll = Instance.new("ScrollingFrame")
SideScroll.Size = UDim2.new(1,0,1,0)
SideScroll.BackgroundTransparency = 1
SideScroll.BorderSizePixel = 0
SideScroll.ScrollBarThickness = 0
SideScroll.CanvasSize = UDim2.new(0,0,0,0)
SideScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SideScroll.Parent = Sidebar

local SideContainer = Instance.new("Frame")
SideContainer.Size = UDim2.new(1,0,0,0)
SideContainer.AutomaticSize = Enum.AutomaticSize.Y
SideContainer.BackgroundTransparency = 1
SideContainer.Parent = SideScroll
pad(SideContainer, 12, 12, 12, 12)
local sideLayout = Instance.new("UIListLayout")
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Padding = UDim.new(0, 8)
sideLayout.Parent = SideContainer

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -SIDE_W, 1, 0)
ContentArea.Position = UDim2.new(0, SIDE_W, 0, 0)
ContentArea.BackgroundColor3 = C.Bg2
ContentArea.BorderSizePixel = 0
ContentArea.ClipsDescendants = true
ContentArea.Parent = Body

-- Pages
local pages = {}
local function createPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name
	page.Size = UDim2.new(1,0,1,0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = C.Accent
	page.ScrollBarImageTransparency = 0.5
	page.CanvasSize = UDim2.new(0,0,0,0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = false
	page.Parent = ContentArea
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = page
	pad(page, 14, 14, 14, 14)
	pages[name] = page
	return page
end

local pickerPage = createPage("Picker")
local explorerPage = createPage("Explorer")
local settingsPage = createPage("Settings")

-- Sidebar buttons
local sideButtons = {}
local activeName = nil

local function switchPage(name)
	activeName = name
	for _, p in pairs(pages) do p.Visible = false end
	if pages[name] then pages[name].Visible = true end
	for _, sb in pairs(sideButtons) do
		if sb.name == name then
			tw(sb.frame, {BackgroundColor3 = C.CardActive}, 0.2)
			sb.label.TextColor3 = C.Text
			sb.icon.TextColor3 = C.Accent
			tw(sb.indicator, {BackgroundTransparency = 0, BackgroundColor3 = C.Accent}, 0.2)
			tw(sb.frame:FindFirstChildOfClass("UIStroke"), {Color = C.Accent, Transparency = 0.4}, 0.2)
		else
			tw(sb.frame, {BackgroundColor3 = C.Bg0}, 0.2)
			sb.label.TextColor3 = C.TextDim
			sb.icon.TextColor3 = C.TextDark
			tw(sb.indicator, {BackgroundTransparency = 1}, 0.2)
			tw(sb.frame:FindFirstChildOfClass("UIStroke"), {Color = C.Border, Transparency = 0.6}, 0.2)
		end
	end
end

local function sectionLabel(text, order)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,0,0,16)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = C.TextDark
	lbl.TextSize = 9
	lbl.Font = Enum.Font.GothamBold
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.LayoutOrder = order
	lbl.Parent = SideContainer
	return lbl
end

local sideOrder = 0
local function createSideButton(iconChar, name, order)
	sideOrder += 1
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,0,42)
	btn.BackgroundColor3 = C.Bg0
	btn.BorderSizePixel = 0
	btn.Text = ""
	btn.LayoutOrder = order or sideOrder
	btn.AutoButtonColor = false
	btn.Parent = SideContainer
	corner(btn, 10)
	local st = stroke(btn, C.Border, 1, 0.6)

	local indicator = Instance.new("Frame")
	indicator.Size = UDim2.new(0,3,0,18)
	indicator.Position = UDim2.new(0,6,0.5,-9)
	indicator.BackgroundColor3 = C.Accent
	indicator.BackgroundTransparency = 1
	indicator.BorderSizePixel = 0
	indicator.Parent = btn
	corner(indicator, 2)

	local icon = Instance.new("TextLabel")
	icon.Size = UDim2.new(0, 24, 0, 24)
	icon.Position = UDim2.new(0, 16, 0.5, -12)
	icon.BackgroundTransparency = 1
	icon.Text = iconChar
	icon.TextColor3 = C.TextDark
	icon.TextSize = 14
	icon.Font = Enum.Font.GothamBold
	icon.Parent = btn

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -56, 1, 0)
	lbl.Position = UDim2.new(0, 44, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = name
	lbl.TextColor3 = C.TextDim
	lbl.TextSize = 12
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = btn

	local badge = Instance.new("Frame")
	badge.Name = "Badge"
	badge.Size = UDim2.new(0, 0, 0, 18)
	badge.Position = UDim2.new(1, -8, 0.5, -9)
	badge.AnchorPoint = Vector2.new(1,0)
	badge.BackgroundColor3 = C.Bg3
	badge.BorderSizePixel = 0
	badge.Visible = false
	badge.Parent = btn
	corner(badge, 6)
	local badgeLabel = Instance.new("TextLabel")
	badgeLabel.Size = UDim2.new(1,0,1,0)
	badgeLabel.BackgroundTransparency = 1
	badgeLabel.Text = "0"
	badgeLabel.TextColor3 = C.TextDim
	badgeLabel.TextSize = 10
	badgeLabel.Font = Enum.Font.GothamBold
	badgeLabel.Parent = badge
	pad(badge, 0,0,6,6)

	btn.MouseEnter:Connect(function()
		if activeName ~= name then tw(btn, {BackgroundColor3 = C.Card}, 0.15) end
	end)
	btn.MouseLeave:Connect(function()
		if activeName ~= name then tw(btn, {BackgroundColor3 = C.Bg0}, 0.15) end
	end)
	btn.MouseButton1Click:Connect(function() switchPage(name) end)

	local entry = {frame = btn, label = lbl, icon = icon, indicator = indicator, name = name, badge = badge, badgeLabel = badgeLabel}
	table.insert(sideButtons, entry)
	return entry
end

sectionLabel("NAVIGATION", 1)
local pickerBtn = createSideButton("◉", "Picker", 2)
local explorerBtn = createSideButton("⬡", "Explorer", 3)
local settingsBtn = createSideButton("⚙", "Settings", 4)

sectionLabel("STATUS", 5)
local StatusCard = Instance.new("Frame")
StatusCard.Size = UDim2.new(1,0,0,92)
StatusCard.BackgroundColor3 = C.Card
StatusCard.BorderSizePixel = 0
StatusCard.LayoutOrder = 6
StatusCard.Parent = SideContainer
corner(StatusCard, 10)
stroke(StatusCard, C.Border, 1, 0.3)
pad(StatusCard, 10,10,10,10)

local statusLayout = Instance.new("UIListLayout")
statusLayout.SortOrder = Enum.SortOrder.LayoutOrder
statusLayout.Padding = UDim.new(0,6)
statusLayout.Parent = StatusCard

local function statusRow(label, value)
	local r = Instance.new("Frame")
	r.Size = UDim2.new(1,0,0,16)
	r.BackgroundTransparency = 1
	r.Parent = StatusCard
	local l1 = Instance.new("TextLabel")
	l1.Size = UDim2.new(0.6,0,1,0)
	l1.BackgroundTransparency = 1
	l1.Text = label
	l1.TextColor3 = C.TextDark
	l1.TextSize = 10
	l1.Font = Enum.Font.Gotham
	l1.TextXAlignment = Enum.TextXAlignment.Left
	l1.Parent = r
	local l2 = Instance.new("TextLabel")
	l2.Size = UDim2.new(0.4,0,1,0)
	l2.Position = UDim2.new(0.6,0,0,0)
	l2.BackgroundTransparency = 1
	l2.Text = value
	l2.TextColor3 = C.Text
	l2.TextSize = 10
	l2.Font = Enum.Font.GothamBold
	l2.TextXAlignment = Enum.TextXAlignment.Right
	l2.Parent = r
	return l2
end

local statusCaptured = statusRow("Captured", "0")
local statusPreviews = statusRow("Previews", "0")
local statusTarget = statusRow("Target", "none")

-- Toast system
local ToastContainer = Instance.new("Frame")
ToastContainer.Size = UDim2.new(0, 320, 1, 0)
ToastContainer.Position = UDim2.new(1, -336, 0, 16)
ToastContainer.BackgroundTransparency = 1
ToastContainer.Parent = screenGui
local toastLayout = Instance.new("UIListLayout")
toastLayout.SortOrder = Enum.SortOrder.LayoutOrder
toastLayout.Padding = UDim.new(0, 8)
toastLayout.VerticalAlignment = Enum.VerticalAlignment.Top
toastLayout.Parent = ToastContainer

local function showToast(text, kind, dur)
	kind = kind or "info"
	dur = dur or 2.5
	local col = C.Info
	if kind == "success" then col = C.Success elseif kind == "error" then col = C.Danger elseif kind == "warn" then col = C.Warning end
	local toast = Instance.new("Frame")
	toast.Size = UDim2.new(1,0,0,44)
	toast.BackgroundColor3 = C.Card
	toast.BorderSizePixel = 0
	toast.BackgroundTransparency = 1
	toast.Parent = ToastContainer
	corner(toast, 10)
	stroke(toast, col, 1, 0.3)
	pad(toast, 0,0,12,12)
	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(0,3,1,0)
	accent.BackgroundColor3 = col
	accent.BorderSizePixel = 0
	accent.Parent = toast
	corner(accent, 2)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -24, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = C.Text
	label.TextSize = 12
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextTruncate = Enum.TextTruncate.AtEnd
	label.Parent = toast
	toast.BackgroundTransparency = 1
	label.TextTransparency = 1
	tw(toast, {BackgroundTransparency = 0}, 0.25)
	tw(label, {TextTransparency = 0}, 0.25)
	task.delay(dur, function()
		tw(toast, {BackgroundTransparency = 1}, 0.25)
		tw(label, {TextTransparency = 1}, 0.25)
		task.wait(0.3)
		toast:Destroy()
	end)
end

-- Highlight — modern violet/amber
local highlight = Instance.new("Highlight")
highlight.Name = "AshHL_V7"
highlight.FillColor = C.HLFill
highlight.FillTransparency = 0.85
highlight.OutlineColor = C.HLOutline
highlight.OutlineTransparency = 0
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Enabled = false
highlight.Parent = screenGui

-- Modes
local pickMode = "model"
local currentTarget = nil
local lastMouseTarget = nil
local hlClock = 0
local spawnDistance = 25

local function isPC(obj)
	if not obj then return false end
	for _, p in Players:GetPlayers() do
		if p.Character and (obj == p.Character or obj:IsDescendantOf(p.Character)) then return true end
	end
	return false
end

local function getTarget(part, mode)
	if not part then return nil end
	if isPC(part) then return nil end
	if mode == "part" then return part end
	if mode == "model" then
		local cur = part
		while cur and cur.Parent and cur.Parent ~= workspace and cur.Parent ~= game do
			if cur:IsA("Model") then return cur end
			cur = cur.Parent
		end
		return part
	end
	if mode == "parent" then
		local p = part.Parent
		if p and p ~= workspace and p ~= game then return p end
		return part
	end
	if mode == "root" then
		local cur = part
		while cur.Parent and cur.Parent ~= workspace and cur.Parent ~= game do
			if cur.Parent:IsA("Model") or cur.Parent:IsA("Folder") then cur = cur.Parent else break end
		end
		return cur
	end
	return part
end

local function countAll(obj)
	if not obj then return 0 end
	local ok, d = pcall(function() return obj:GetDescendants() end)
	return ok and (1 + #d) or 1
end
local function countParts(obj)
	if not obj then return 0 end
	local c = 0; if obj:IsA("BasePart") then c = 1 end
	local ok, d = pcall(function() return obj:GetDescendants() end)
	if ok then for _, v in d do if v:IsA("BasePart") then c += 1 end end end
	return c
end

-- =============================================
-- PICKER PAGE — Modern Redesign
-- =============================================
local pOrd = 0

-- Mode selector — segmented control
pOrd += 1
local modeCard = Instance.new("Frame")
modeCard.Size = UDim2.new(1,0,0,64)
modeCard.BackgroundColor3 = C.Card
modeCard.BorderSizePixel = 0
modeCard.LayoutOrder = pOrd
modeCard.Parent = pickerPage
corner(modeCard, 12)
stroke(modeCard, C.Border, 1, 0.25)
pad(modeCard, 10,10,14,14)

local modeHeader = Instance.new("Frame")
modeHeader.Size = UDim2.new(1,0,0,18)
modeHeader.BackgroundTransparency = 1
modeHeader.Parent = modeCard

local modeTitle = Instance.new("TextLabel")
modeTitle.Size = UDim2.new(0,80,1,0)
modeTitle.BackgroundTransparency = 1
modeTitle.Text = "PICK MODE"
modeTitle.TextColor3 = C.TextDark
modeTitle.TextSize = 10
modeTitle.Font = Enum.Font.GothamBold
modeTitle.TextXAlignment = Enum.TextXAlignment.Left
modeTitle.Parent = modeHeader

local modeDesc = Instance.new("TextLabel")
modeDesc.Size = UDim2.new(1,-90,1,0)
modeDesc.Position = UDim2.new(0,90,0,0)
modeDesc.BackgroundTransparency = 1
modeDesc.Text = "Choose what H will capture"
modeDesc.TextColor3 = C.TextDark
modeDesc.TextSize = 10
modeDesc.Font = Enum.Font.Gotham
modeDesc.TextXAlignment = Enum.TextXAlignment.Right
modeDesc.Parent = modeHeader

local segWrap = Instance.new("Frame")
segWrap.Size = UDim2.new(1,0,0,36)
segWrap.Position = UDim2.new(0,0,0,24)
segWrap.BackgroundColor3 = C.Bg2
segWrap.BorderSizePixel = 0
segWrap.Parent = modeCard
corner(segWrap, 10)
stroke(segWrap, C.Border, 1, 0.25)
pad(segWrap, 3,3,3,3)

local segLayout = Instance.new("UIListLayout")
segLayout.FillDirection = Enum.FillDirection.Horizontal
segLayout.SortOrder = Enum.SortOrder.LayoutOrder
segLayout.Padding = UDim.new(0,3)
segLayout.Parent = segWrap

local modes = {
	{key="part", label="Part", icon="◧"},
	{key="model", label="Model", icon="⬙"},
	{key="parent", label="Parent", icon="⬗"},
	{key="root", label="Root", icon="⬣"},
}
local modeButtons = {}
local segIndicator = nil

-- create indicator behind
segIndicator = Instance.new("Frame")
segIndicator.Size = UDim2.new(0, 100, 1, 0)
segIndicator.BackgroundColor3 = C.Accent
segIndicator.BorderSizePixel = 0
segIndicator.ZIndex = 1
segIndicator.Parent = segWrap
corner(segIndicator, 8)
grad(segIndicator, C.Accent, C.Purple, 90)

for i, m in ipairs(modes) do
	local mb = Instance.new("TextButton")
	mb.Size = UDim2.new(0.25, -3, 1, 0)
	mb.BackgroundTransparency = 1
	mb.BorderSizePixel = 0
	mb.Text = ""
	mb.LayoutOrder = i
	mb.ZIndex = 2
	mb.AutoButtonColor = false
	mb.Parent = segWrap
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1,0,1,0)
	lbl.BackgroundTransparency = 1
	lbl.Text = m.icon.." "..m.label
	lbl.TextColor3 = (m.key == pickMode) and Color3.fromRGB(255,255,255) or C.TextDim
	lbl.TextSize = 11
	lbl.Font = Enum.Font.GothamBold
	lbl.ZIndex = 2
	lbl.Parent = mb
	modeButtons[m.key] = {btn = mb, label = lbl, data = m}
end

local function updateModeUI(animated)
	animated = animated == nil and true or animated
	for k, b in pairs(modeButtons) do
		if k == pickMode then
			tw(b.label, {TextColor3 = Color3.fromRGB(255,255,255)}, animated and 0.2 or 0)
		else
			tw(b.label, {TextColor3 = C.TextDim}, animated and 0.2 or 0)
		end
	end
	-- move indicator
	local idx = 1
	for i, m in ipairs(modes) do if m.key == pickMode then idx = i break end end
	local totalW = segWrap.AbsoluteSize.X - 6
	if totalW <= 0 then totalW = 400 end
	local btnW = (totalW - 9) / 4
	local x = 3 + (idx-1)*(btnW+3)
	-- use scale instead of offset for responsiveness: we tween via UDim2
	if animated then
		tw(segIndicator, {Position = UDim2.new(0, x, 0, 0), Size = UDim2.new(0, btnW, 1, 0)}, 0.28, Enum.EasingStyle.Back)
	else
		segIndicator.Position = UDim2.new(0, x, 0, 0)
		segIndicator.Size = UDim2.new(0, btnW, 1, 0)
	end
	statusTarget.Text = pickMode
end

-- delay initial indicator positioning
task.defer(function()
	task.wait(0.1)
	updateModeUI(false)
end)

for _, m in ipairs(modes) do
	modeButtons[m.key].btn.MouseButton1Click:Connect(function()
		pickMode = m.key
		updateModeUI(true)
		showToast("Mode: "..m.label.." • [G] to cycle", "info", 1.5)
	end)
end

segWrap:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() updateModeUI(false) end)

-- Live inspector
pOrd += 1
local inspector = Instance.new("Frame")
inspector.Size = UDim2.new(1,0,0,118)
inspector.BackgroundColor3 = C.Bg1
inspector.BorderSizePixel = 0
inspector.LayoutOrder = pOrd
inspector.Parent = pickerPage
corner(inspector, 12)
stroke(inspector, C.Border, 1, 0.25)

local inspGrad = Instance.new("Frame")
inspGrad.Size = UDim2.new(1,0,0,1)
inspGrad.Position = UDim2.new(0,0,0,0)
inspGrad.BackgroundColor3 = C.Accent
inspGrad.BackgroundTransparency = 0.7
inspGrad.BorderSizePixel = 0
inspGrad.Parent = inspector
corner(inspGrad, 12)

pad(inspector, 12,12,12,12)

local inspIconWrap = Instance.new("Frame")
inspIconWrap.Size = UDim2.new(0, 52, 0, 52)
inspIconWrap.Position = UDim2.new(0,0,0,0)
inspIconWrap.BackgroundColor3 = C.Bg3
inspIconWrap.BorderSizePixel = 0
inspIconWrap.Parent = inspector
corner(inspIconWrap, 14)
stroke(inspIconWrap, C.Border, 1, 0.3)

local inspIcon = Instance.new("TextLabel")
inspIcon.Size = UDim2.new(1,0,1,0)
inspIcon.BackgroundTransparency = 1
inspIcon.Text = "◉"
inspIcon.TextColor3 = C.TextDark
inspIcon.TextSize = 22
inspIcon.Font = Enum.Font.GothamBold
inspIcon.Parent = inspIconWrap

local inspName = Instance.new("TextLabel")
inspName.Size = UDim2.new(1, -64, 0, 20)
inspName.Position = UDim2.new(0, 64, 0, 0)
inspName.BackgroundTransparency = 1
inspName.Text = "No target"
inspName.TextColor3 = C.TextDark
inspName.TextSize = 14
inspName.Font = Enum.Font.GothamBold
inspName.TextXAlignment = Enum.TextXAlignment.Left
inspName.TextTruncate = Enum.TextTruncate.AtEnd
inspName.Parent = inspector

local inspBadges = Instance.new("Frame")
inspBadges.Size = UDim2.new(1, -64, 0, 20)
inspBadges.Position = UDim2.new(0, 64, 0, 22)
inspBadges.BackgroundTransparency = 1
inspBadges.Parent = inspector
local badgeLayout = Instance.new("UIListLayout")
badgeLayout.FillDirection = Enum.FillDirection.Horizontal
badgeLayout.Padding = UDim.new(0,6)
badgeLayout.SortOrder = Enum.SortOrder.LayoutOrder
badgeLayout.Parent = inspBadges

local function makeBadge(text, color, order)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(0,0,0,18)
	f.AutomaticSize = Enum.AutomaticSize.X
	f.BackgroundColor3 = C.Bg3
	f.BorderSizePixel = 0
	f.LayoutOrder = order
	f.Parent = inspBadges
	corner(f, 6)
	stroke(f, color or C.Border, 1, 0.4)
	pad(f, 0,0,8,8)
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(0,0,1,0)
	l.AutomaticSize = Enum.AutomaticSize.X
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = color or C.TextDim
	l.TextSize = 10
	l.Font = Enum.Font.GothamBold
	l.Parent = f
	return f, l
end

local classBadge, classBadgeLabel = makeBadge("—", C.TextDark, 1)
local modeBadge, modeBadgeLabel = makeBadge("MODEL", C.Accent, 2)
local statsBadge, statsBadgeLabel = makeBadge("0 obj • 0 parts", C.TextDim, 3)

local inspPath = Instance.new("TextLabel")
inspPath.Size = UDim2.new(1, -64, 0, 14)
inspPath.Position = UDim2.new(0, 64, 0, 46)
inspPath.BackgroundTransparency = 1
inspPath.Text = "Hover over any object in workspace"
inspPath.TextColor3 = C.TextDark
inspPath.TextSize = 10
inspPath.Font = Enum.Font.Code
inspPath.TextXAlignment = Enum.TextXAlignment.Left
inspPath.TextTruncate = Enum.TextTruncate.AtEnd
inspPath.Parent = inspector

local inspHint = Instance.new("Frame")
inspHint.Size = UDim2.new(1,0,0,26)
inspHint.Position = UDim2.new(0,0,1,-26)
inspHint.BackgroundColor3 = C.Bg2
inspHint.BorderSizePixel = 0
inspHint.Parent = inspector
corner(inspHint, 8)
stroke(inspHint, C.Border, 1, 0.25)

local inspHintLabel = Instance.new("TextLabel")
inspHintLabel.Size = UDim2.new(1,-12,1,0)
inspHintLabel.Position = UDim2.new(0,12,0,0)
inspHintLabel.BackgroundTransparency = 1
inspHintLabel.Text = "Press [H] to capture  •  [G] cycle mode  •  [Q] hide"
inspHintLabel.TextColor3 = C.TextDark
inspHintLabel.TextSize = 10
inspHintLabel.Font = Enum.Font.Gotham
inspHintLabel.TextXAlignment = Enum.TextXAlignment.Left
inspHintLabel.Parent = inspHint

local liveDot = Instance.new("Frame")
liveDot.Size = UDim2.new(0,8,0,8)
liveDot.Position = UDim2.new(1,-20,0,6)
liveDot.BackgroundColor3 = C.Success
liveDot.BorderSizePixel = 0
liveDot.Parent = inspHint
corner(liveDot, 4)

-- pulse animation
task.spawn(function()
	while true do
		if highlight.Enabled then
			tw(liveDot, {BackgroundTransparency = 0.2}, 0.5)
			task.wait(0.5)
			tw(liveDot, {BackgroundTransparency = 0}, 0.5)
			task.wait(0.5)
		else
			task.wait(0.2)
		end
	end
end)

pOrd += 1
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1,0,0,28)
divider.BackgroundTransparency = 1
divider.LayoutOrder = pOrd
divider.Parent = pickerPage

local divLine = Instance.new("Frame")
divLine.Size = UDim2.new(1,0,0,1)
divLine.Position = UDim2.new(0,0,0.5,0)
divLine.BackgroundColor3 = C.Border
divLine.BackgroundTransparency = 0.4
divLine.BorderSizePixel = 0
divLine.Parent = divider

local divLabel = Instance.new("TextLabel")
divLabel.Size = UDim2.new(0,140,1,0)
divLabel.Position = UDim2.new(0,12,0,0)
divLabel.BackgroundColor3 = C.Bg2
divLabel.Text = "  CAPTURED ASSETS"
divLabel.TextColor3 = C.TextDark
divLabel.TextSize = 10
divLabel.Font = Enum.Font.GothamBold
divLabel.TextXAlignment = Enum.TextXAlignment.Left
divLabel.Parent = divider

local pickerStatusRow = Instance.new("Frame")
pickerStatusRow.Size = UDim2.new(1,0,0,28)
pickerStatusRow.BackgroundTransparency = 1
pickerStatusRow.LayoutOrder = pOrd+1
pickerStatusRow.Parent = pickerPage
pOrd += 1

local pickerStatus = Instance.new("TextLabel")
pickerStatus.Size = UDim2.new(0.6,0,1,0)
pickerStatus.BackgroundTransparency = 1
pickerStatus.Text = "Captured: 0"
pickerStatus.TextColor3 = C.TextDim
pickerStatus.TextSize = 11
pickerStatus.Font = Enum.Font.GothamBold
pickerStatus.TextXAlignment = Enum.TextXAlignment.Left
pickerStatus.Parent = pickerStatusRow

local clearAllBtn = Instance.new("TextButton")
clearAllBtn.Size = UDim2.new(0.4,-6,1,0)
clearAllBtn.Position = UDim2.new(0.6,6,0,0)
clearAllBtn.BackgroundColor3 = C.Bg3
clearAllBtn.BorderSizePixel = 0
clearAllBtn.Text = "Clear all"
clearAllBtn.TextColor3 = C.TextDim
clearAllBtn.TextSize = 11
clearAllBtn.Font = Enum.Font.GothamMedium
clearAllBtn.AutoButtonColor = false
clearAllBtn.Parent = pickerStatusRow
corner(clearAllBtn, 8)
stroke(clearAllBtn, C.Border, 1, 0.3)

clearAllBtn.MouseEnter:Connect(function() tw(clearAllBtn, {BackgroundColor3 = C.Danger, BackgroundTransparency = 0.8}) clearAllBtn.TextColor3 = C.Danger end)
clearAllBtn.MouseLeave:Connect(function() tw(clearAllBtn, {BackgroundColor3 = C.Bg3}) clearAllBtn.TextColor3 = C.TextDim end)

-- serialization
local function qs(s) if not s or s == "" then return '""' end return string.format("%q", tostring(s)) end
local function serCF(cf)
	local p = {cf:GetComponents()}; local s = {}
	for i, v in ipairs(p) do s[i] = i <= 3 and string.format("%.8f",v) or string.format("%.10f",v) end
	return "CFrame.new("..table.concat(s,",")..")"
end
local function serV3(v) return string.format("Vector3.new(%.8f,%.8f,%.8f)",v.X,v.Y,v.Z) end
local function serC3(c) return string.format("Color3.fromRGB(%d,%d,%d)",math.floor(c.R*255+.5),math.floor(c.G*255+.5),math.floor(c.B*255+.5)) end
local function serUDim(u) return string.format("UDim.new(%.8f,%d)",u.Scale,u.Offset) end
local function serNR(n) return string.format("NumberRange.new(%.8f,%.8f)",n.Min,n.Max) end
local function serNS(ns) local p = {}; for _, kp in ipairs(ns.Keypoints) do table.insert(p, string.format("NumberSequenceKeypoint.new(%.8f,%.8f,%.8f)",kp.Time,kp.Value,kp.Envelope)) end; return "NumberSequence.new({"..table.concat(p,",").."})" end
local function serCS(cs) local p = {}; for _, kp in ipairs(cs.Keypoints) do table.insert(p, string.format("ColorSequenceKeypoint.new(%.8f,%s)",kp.Time,serC3(kp.Value))) end; return "ColorSequence.new({"..table.concat(p,",").."})" end
local function sg(obj, prop) local s, v = pcall(function() return obj[prop] end); if s then return v end; return nil end

local SKIP = {
	SurfaceAppearance=1,Weld=1,WeldConstraint=1,Snap=1,Motor=1,Motor6D=1,ManualWeld=1,
	AlignPosition=1,AlignOrientation=1,BallSocketConstraint=1,HingeConstraint=1,
	SpringConstraint=1,CylindricalConstraint=1,PrismaticConstraint=1,
	AngularVelocity=1,LinearVelocity=1,Torque=1,VectorForce=1,Bone=1,IKControl=1,
	Humanoid=1,HumanoidDescription=1,Accessory=1,Shirt=1,Pants=1,ShirtGraphic=1,
	CharacterMesh=1,Hat=1,BodyColors=1,Animator=1,AnimationController=1,
	Script=1,LocalScript=1,ModuleScript=1,Terrain=1,Camera=1,Player=1,
	BodyVelocity=1,BodyPosition=1,BodyGyro=1,BodyAngularVelocity=1,BodyForce=1,BodyThrust=1,Rope=1,Rod=1,
}
local function shouldSkip(obj)
	if SKIP[obj.ClassName] then return true end
	if obj:IsA("LuaSourceContainer") or obj:IsA("Camera") or obj:IsA("Terrain") then return true end
	if obj:IsA("Humanoid") or obj:IsA("Accessory") or obj:IsA("Clothing") then return true end
	if obj:IsA("BodyMover") or obj:IsA("Constraint") or obj:IsA("JointInstance") then return true end
	return isPC(obj)
end
local RPL = {MeshPart=1,UnionOperation=1,NegateOperation=1,PartOperation=1,IntersectOperation=1}
local ccache = {}
local function canCreate(cls)
	if RPL[cls] then return true end
	if ccache[cls] ~= nil then return ccache[cls] end
	local s = pcall(function() local t = Instance.new(cls); t:Destroy() end); ccache[cls] = s; return s
end

local function getPivot(obj)
	if obj:IsA("Model") then
		local ok, cf = pcall(function() return obj:GetPivot() end)
		if ok then return cf end
		if obj.PrimaryPart then return obj.PrimaryPart.CFrame end
	end
	if obj:IsA("BasePart") then return obj.CFrame end
	for _, d in obj:GetDescendants() do
		if d:IsA("BasePart") then return d.CFrame end
	end
	return CFrame.new()
end

local function writeProps(L, idx, obj, pivotCF)
	local id = "R["..idx.."]"
	L[#L+1] = id..".Name = "..qs(obj.Name)
	if obj:IsA("BasePart") then
		L[#L+1] = id..".Size = "..serV3(obj.Size)
		local relCF = pivotCF:ToObjectSpace(obj.CFrame)
		L[#L+1] = id..".CFrame = spawnCF * "..serCF(relCF)
		local m = sg(obj,"Material"); if m then L[#L+1] = id..".Material = "..tostring(m) end
		local c = sg(obj,"Color"); if c then L[#L+1] = id..".Color = "..serC3(c) end
		local tr = sg(obj,"Transparency"); if tr and tr > 0 then L[#L+1] = id..".Transparency = "..string.format("%.8f",tr) end
		local rf = sg(obj,"Reflectance"); if rf and rf > 0 then L[#L+1] = id..".Reflectance = "..string.format("%.8f",rf) end
		L[#L+1] = id..".Anchored = true"
		local cc = sg(obj,"CanCollide"); if cc ~= nil then L[#L+1] = id..".CanCollide = "..tostring(cc) end
		local cs = sg(obj,"CastShadow"); if cs == false then L[#L+1] = id..".CastShadow = false" end
		if obj:IsA("Part") then local sh = sg(obj,"Shape"); if sh and sh ~= Enum.PartType.Block then L[#L+1] = id..".Shape = "..tostring(sh) end end
		local ts = sg(obj,"TopSurface"); if ts then L[#L+1] = id..".TopSurface = "..tostring(ts) end
		local bs = sg(obj,"BottomSurface"); if bs then L[#L+1] = id..".BottomSurface = "..tostring(bs) end
	end
	if obj:IsA("SpecialMesh") or obj:IsA("BlockMesh") or obj:IsA("CylinderMesh") then
		local mt = sg(obj,"MeshType"); if mt then L[#L+1] = id..".MeshType = "..tostring(mt) end
		local mid = sg(obj,"MeshId"); if mid and mid ~= "" then L[#L+1] = id..".MeshId = "..qs(mid) end
		local tid = sg(obj,"TextureId"); if tid and tid ~= "" then L[#L+1] = id..".TextureId = "..qs(tid) end
		local sc = sg(obj,"Scale"); if sc then L[#L+1] = id..".Scale = "..serV3(sc) end
		local off = sg(obj,"Offset"); if off then L[#L+1] = id..".Offset = "..serV3(off) end
	end
	if obj:IsA("Decal") then
		local tex = sg(obj,"Texture"); if tex and tex ~= "" then L[#L+1] = id..".Texture = "..qs(tex) end
		local face = sg(obj,"Face"); if face then L[#L+1] = id..".Face = "..tostring(face) end
		local col = sg(obj,"Color3"); if col then L[#L+1] = id..".Color3 = "..serC3(col) end
		local tr = sg(obj,"Transparency"); if tr and tr > 0 then L[#L+1] = id..".Transparency = "..string.format("%.8f",tr) end
	end
	if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
		local col = sg(obj,"Color"); if col then L[#L+1] = id..".Color = "..serC3(col) end
		local br = sg(obj,"Brightness"); if br then L[#L+1] = id..".Brightness = "..string.format("%.8f",br) end
		local rn = sg(obj,"Range"); if rn then L[#L+1] = id..".Range = "..string.format("%.8f",rn) end
		local en = sg(obj,"Enabled"); if en ~= nil then L[#L+1] = id..".Enabled = "..tostring(en) end
	end
	if obj:IsA("Fire") then
		local h = sg(obj,"Heat"); if h then L[#L+1] = id..".Heat = "..string.format("%.8f",h) end
		local sz = sg(obj,"Size"); if sz then L[#L+1] = id..".Size = "..string.format("%.8f",sz) end
		local col = sg(obj,"Color"); if col then L[#L+1] = id..".Color = "..serC3(col) end
	end
	if obj:IsA("Smoke") then
		local col = sg(obj,"Color"); if col then L[#L+1] = id..".Color = "..serC3(col) end
		local op = sg(obj,"Opacity"); if op then L[#L+1] = id..".Opacity = "..string.format("%.8f",op) end
		local sz = sg(obj,"Size"); if sz then L[#L+1] = id..".Size = "..string.format("%.8f",sz) end
	end
	if obj:IsA("ParticleEmitter") then
		local tex = sg(obj,"Texture"); if tex and tex ~= "" then L[#L+1] = id..".Texture = "..qs(tex) end
		local rate = sg(obj,"Rate"); if rate then L[#L+1] = id..".Rate = "..string.format("%.8f",rate) end
		local en = sg(obj,"Enabled"); if en ~= nil then L[#L+1] = id..".Enabled = "..tostring(en) end
		local lt = sg(obj,"Lifetime"); if lt then L[#L+1] = id..".Lifetime = "..serNR(lt) end
		local spd = sg(obj,"Speed"); if spd then L[#L+1] = id..".Speed = "..serNR(spd) end
		local sz = sg(obj,"Size"); if sz then pcall(function() L[#L+1] = id..".Size = "..serNS(sz) end) end
		local tp = sg(obj,"Transparency"); if tp then pcall(function() L[#L+1] = id..".Transparency = "..serNS(tp) end) end
		local col = sg(obj,"Color"); if col then pcall(function() L[#L+1] = id..".Color = "..serCS(col) end) end
	end
	if obj:IsA("Attachment") then local cf = sg(obj,"CFrame"); if cf then L[#L+1] = id..".CFrame = "..serCF(cf) end end
	if obj:IsA("UICorner") then local cr = sg(obj,"CornerRadius"); if cr then L[#L+1] = id..".CornerRadius = "..serUDim(cr) end end
	if obj:IsA("Sound") then
		local sid = sg(obj,"SoundId"); if sid and sid ~= "" then L[#L+1] = id..".SoundId = "..qs(sid) end
		local vol = sg(obj,"Volume"); if vol then L[#L+1] = id..".Volume = "..string.format("%.8f",vol) end
		local lp = sg(obj,"Looped"); if lp ~= nil then L[#L+1] = id..".Looped = "..tostring(lp) end
	end
	if obj:IsA("ProximityPrompt") then
		local at = sg(obj,"ActionText"); if at then L[#L+1] = id..".ActionText = "..qs(at) end
		local ot = sg(obj,"ObjectText"); if ot then L[#L+1] = id..".ObjectText = "..qs(ot) end
	end
end

local function processObj(obj, parentIdx, L, counter, pivotCF)
	if shouldSkip(obj) then return counter end
	local cls = obj.ClassName; local cc2 = cls
	local isMPR = RPL[cls]; if isMPR then cc2 = "Part" end
	if not canCreate(cc2) then
		if #obj:GetChildren() > 0 then cc2 = "Folder" else return counter end
	end
	counter += 1; local idx = counter
	local pRef = parentIdx == 0 and "workspace" or ("R["..parentIdx.."]")
	L[#L+1] = "R["..idx.."] = Instance.new("..qs(cc2)..")"
	pcall(writeProps, L, idx, obj, pivotCF)
	if cls == "MeshPart" then
		local mid = sg(obj,"MeshId"); local tid = sg(obj,"TextureID")
		if mid and mid ~= "" then
			counter += 1; local mi = counter
			L[#L+1] = "R["..mi.."] = Instance.new(\"SpecialMesh\")"
			L[#L+1] = "R["..mi.."].MeshType = Enum.MeshType.FileMesh"
			L[#L+1] = "R["..mi.."].MeshId = "..qs(mid)
			if tid and tid ~= "" then L[#L+1] = "R["..mi.."].TextureId = "..qs(tid) end
			local ms = sg(obj,"MeshSize")
			if ms and ms.Magnitude > 0 then
				local s = obj.Size
				L[#L+1] = "R["..mi.."].Scale = "..serV3(Vector3.new(s.X/math.max(ms.X,.001),s.Y/math.max(ms.Y,.001),s.Z/math.max(ms.Z,.001)))
			end
			L[#L+1] = "R["..mi.."].Parent = R["..idx.."]"
		end
	end
	L[#L+1] = "R["..idx.."].Parent = "..pRef; L[#L+1] = ""
	for _, child in obj:GetChildren() do
		if isMPR and child.ClassName == "SurfaceAppearance" then continue end
		counter = processObj(child, idx, L, counter, pivotCF)
	end
	return counter
end

local function genCode(obj)
	local pivotCF = getPivot(obj)
	local L = {}
	L[#L+1] = "-- Ash v7.0 Obsidian | "..obj.Name
	L[#L+1] = "-- Spawn distance: "..spawnDistance.." studs in front of camera"
	L[#L+1] = "local R = {}"
	L[#L+1] = "local cam = workspace.CurrentCamera"
	L[#L+1] = "local spawnCF = cam.CFrame * CFrame.new(0, 0, -"..spawnDistance..")"
	L[#L+1] = ""
	local cnt = processObj(obj, 0, L, 0, pivotCF)
	L[#L+1] = "print(\"[Ash v7] Spawned "..cnt.." obj | "..obj.Name.." in front of camera\")"
	return table.concat(L, "\n"), cnt
end

-- Picker cards storage
local copiedCards = {}
local copiedOrder = 0

local function updatePickerStatus()
	pickerStatus.Text = "Captured: "..#copiedCards
	statusCaptured.Text = tostring(#copiedCards)
	if #copiedCards > 0 then
		pickerBtn.badge.Visible = true
		pickerBtn.badge.Size = UDim2.new(0, 20 + #tostring(#copiedCards)*6, 0, 18)
		pickerBtn.badgeLabel.Text = tostring(#copiedCards)
		tw(pickerBtn.badge, {BackgroundColor3 = C.Accent}, 0.2)
		pickerBtn.badgeLabel.TextColor3 = Color3.fromRGB(255,255,255)
	else
		pickerBtn.badge.Visible = false
	end
end

local function createPickerCard(obj)
	for _, c in copiedCards do
		if c.object == obj then
			if c.card and c.card.Parent then
				tw(c.card, {BackgroundColor3 = C.Accent, BackgroundTransparency = 0.6}, 0.12)
				task.delay(0.18, function() if c.card and c.card.Parent then tw(c.card, {BackgroundColor3 = C.Card, BackgroundTransparency = 0}, 0.25) end end)
			end
			showToast("Already captured: "..obj.Name, "warn", 1.5)
			return
		end
	end
	copiedOrder += 1
	local total = countAll(obj); local parts = countParts(obj)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1,0,0,118)
	card.BackgroundColor3 = C.Card
	card.BorderSizePixel = 0
	card.LayoutOrder = 100 + copiedOrder
	card.Parent = pickerPage
	card.BackgroundTransparency = 1
	corner(card, 12)
	local st = stroke(card, C.Border, 1, 0.25)
	pad(card, 10,10,10,10)
	tw(card, {BackgroundTransparency = 0}, 0.25)

	local accentBar = Instance.new("Frame")
	accentBar.Size = UDim2.new(0,4,1,-20)
	accentBar.Position = UDim2.new(0,0,0,10)
	accentBar.BackgroundColor3 = C.Accent
	accentBar.BorderSizePixel = 0
	accentBar.Parent = card
	corner(accentBar, 2)
	grad(accentBar, C.Accent, C.Purple, 90)

	local iconWrap = Instance.new("Frame")
	iconWrap.Size = UDim2.new(0,32,0,32)
	iconWrap.Position = UDim2.new(0,14,0,0)
	iconWrap.BackgroundColor3 = C.Bg3
	iconWrap.BorderSizePixel = 0
	iconWrap.Parent = card
	corner(iconWrap, 8)
	local iconLbl = Instance.new("TextLabel")
	iconLbl.Size = UDim2.new(1,0,1,0)
	iconLbl.BackgroundTransparency = 1
	iconLbl.Text = "⬙"
	iconLbl.TextColor3 = C.Accent
	iconLbl.TextSize = 16
	iconLbl.Font = Enum.Font.GothamBold
	iconLbl.Parent = iconWrap

	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(1, -110, 0, 18)
	nameLbl.Position = UDim2.new(0, 54, 0, 0)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text = obj.Name
	nameLbl.TextColor3 = C.Text
	nameLbl.TextSize = 13
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextXAlignment = Enum.TextXAlignment.Left
	nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
	nameLbl.Parent = card

	local classPill = Instance.new("Frame")
	classPill.Size = UDim2.new(0,0,0,18)
	classPill.AutomaticSize = Enum.AutomaticSize.X
	classPill.Position = UDim2.new(1, -6, 0, 2)
	classPill.AnchorPoint = Vector2.new(1,0)
	classPill.BackgroundColor3 = C.Bg2
	classPill.BorderSizePixel = 0
	classPill.Parent = card
	corner(classPill, 6)
	stroke(classPill, C.Border, 1, 0.3)
	pad(classPill, 0,0,8,8)
	local classLbl = Instance.new("TextLabel")
	classLbl.Size = UDim2.new(0,0,1,0)
	classLbl.AutomaticSize = Enum.AutomaticSize.X
	classLbl.BackgroundTransparency = 1
	classLbl.Text = obj.ClassName
	classLbl.TextColor3 = C.TextDim
	classLbl.TextSize = 10
	classLbl.Font = Enum.Font.GothamBold
	classLbl.Parent = classPill

	local infoLbl = Instance.new("TextLabel")
	infoLbl.Size = UDim2.new(1, -16, 0, 14)
	infoLbl.Position = UDim2.new(0, 8, 0, 36)
	infoLbl.BackgroundTransparency = 1
	infoLbl.Text = total.." objects • "..parts.." parts • "..obj:GetFullName():len().." chars path"
	infoLbl.TextColor3 = C.TextDim
	infoLbl.TextSize = 11
	infoLbl.Font = Enum.Font.Gotham
	infoLbl.TextXAlignment = Enum.TextXAlignment.Left
	infoLbl.TextTruncate = Enum.TextTruncate.AtEnd
	infoLbl.Parent = card

	local pathLbl = Instance.new("TextLabel")
	pathLbl.Size = UDim2.new(1, -16, 0, 12)
	pathLbl.Position = UDim2.new(0, 8, 0, 52)
	pathLbl.BackgroundTransparency = 1
	pathLbl.Text = obj:GetFullName()
	pathLbl.TextColor3 = C.TextDark
	pathLbl.TextSize = 9
	pathLbl.Font = Enum.Font.Code
	pathLbl.TextXAlignment = Enum.TextXAlignment.Left
	pathLbl.TextTruncate = Enum.TextTruncate.AtEnd
	pathLbl.Parent = card

	local btnRow = Instance.new("Frame")
	btnRow.Size = UDim2.new(1, -16, 0, 32)
	btnRow.Position = UDim2.new(0, 8, 0, 72)
	btnRow.BackgroundTransparency = 1
	btnRow.Parent = card

	local copyBtn = Instance.new("TextButton")
	copyBtn.Size = UDim2.new(0.62, -4, 1, 0)
	copyBtn.BackgroundColor3 = C.Info
	copyBtn.BorderSizePixel = 0
	copyBtn.Text = "⧉  Copy Code"
	copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
	copyBtn.TextSize = 11
	copyBtn.Font = Enum.Font.GothamBold
	copyBtn.AutoButtonColor = false
	copyBtn.Parent = btnRow
	corner(copyBtn, 8)
	grad(copyBtn, C.Info, C.Accent, 15)

	local rmBtn = Instance.new("TextButton")
	rmBtn.Size = UDim2.new(0.38, -4, 1, 0)
	rmBtn.Position = UDim2.new(0.62, 4, 0, 0)
	rmBtn.BackgroundColor3 = C.Bg3
	rmBtn.BorderSizePixel = 0
	rmBtn.Text = "✕ Remove"
	rmBtn.TextColor3 = C.TextDim
	rmBtn.TextSize = 11
	rmBtn.Font = Enum.Font.GothamMedium
	rmBtn.AutoButtonColor = false
	rmBtn.Parent = btnRow
	corner(rmBtn, 8)
	stroke(rmBtn, C.Border, 1, 0.3)

	copyBtn.MouseEnter:Connect(function() tw(copyBtn, {BackgroundColor3 = C.InfoHover}) end)
	copyBtn.MouseLeave:Connect(function() tw(copyBtn, {BackgroundColor3 = C.Info}) end)
	rmBtn.MouseEnter:Connect(function() tw(rmBtn, {BackgroundColor3 = C.Danger, BackgroundTransparency = 0.8}) rmBtn.TextColor3 = C.Danger end)
	rmBtn.MouseLeave:Connect(function() tw(rmBtn, {BackgroundColor3 = C.Bg3}) rmBtn.TextColor3 = C.TextDim end)

	card.MouseEnter:Connect(function() tw(card, {BackgroundColor3 = C.CardHover}, 0.15) tw(st, {Transparency = 0.1}, 0.15) end)
	card.MouseLeave:Connect(function() tw(card, {BackgroundColor3 = C.Card}, 0.15) tw(st, {Transparency = 0.25}, 0.15) end)

	copyBtn.MouseButton1Click:Connect(function()
		copyBtn.Text = "⏳ Generating..."
		task.wait()
		if not obj or not obj.Parent then
			copyBtn.Text = "⚠ Deleted"
			tw(copyBtn, {BackgroundColor3 = C.Danger})
			task.delay(1.5, function() if copyBtn.Parent then copyBtn.Text = "⧉  Copy Code"; tw(copyBtn, {BackgroundColor3 = C.Info}) end end)
			return
		end
		local code, cnt = genCode(obj)
		local ok = pcall(function() setclipboard(code) end)
		if ok then
			copyBtn.Text = "✓ Copied "..cnt.." objs"
			tw(copyBtn, {BackgroundColor3 = C.Success})
			showToast("Copied "..obj.Name.." ("..cnt.." objects) to clipboard", "success", 2)
		else
			copyBtn.Text = "⚠ Check F9"
			print(code)
			showToast("Code printed to console (F9)", "warn", 2.5)
		end
		task.delay(2.2, function() if copyBtn.Parent then copyBtn.Text = "⧉  Copy Code"; tw(copyBtn, {BackgroundColor3 = C.Info}) end end)
	end)

	rmBtn.MouseButton1Click:Connect(function()
		tw(card, {BackgroundTransparency = 1, BackgroundColor3 = C.Danger}, 0.2)
		for _, ch in card:GetChildren() do if ch:IsA("TextLabel") or ch:IsA("TextButton") then tw(ch, {TextTransparency = 1}, 0.2) end end
		task.delay(0.22, function()
			card:Destroy()
			for i, c in ipairs(copiedCards) do if c.card == card then table.remove(copiedCards, i); break end end
			updatePickerStatus()
		end)
	end)

	table.insert(copiedCards, {card = card, object = obj})
	updatePickerStatus()
	showToast("Captured: "..obj.Name, "success", 1.5)
end

clearAllBtn.MouseButton1Click:Connect(function()
	if #copiedCards == 0 then showToast("Nothing to clear", "warn", 1) return end
	for _, c in ipairs(copiedCards) do if c.card and c.card.Parent then c.card:Destroy() end end
	copiedCards = {}
	updatePickerStatus()
	showToast("Cleared all captured assets", "info", 1.5)
end)

-- Live highlight loop
RunService.Heartbeat:Connect(function(dt)
	hlClock += dt
	if hlClock < 0.08 then return end
	hlClock = 0
	local mt = Mouse.Target
	if mt == lastMouseTarget then return end
	lastMouseTarget = mt
	local tgt = getTarget(mt, pickMode)
	if tgt and tgt ~= workspace and tgt ~= currentTarget then
		currentTarget = tgt
		highlight.Adornee = tgt
		highlight.Enabled = true
		inspName.Text = tgt.Name
		inspName.TextColor3 = C.Text
		inspIcon.TextColor3 = C.Accent
		tw(inspIconWrap, {BackgroundColor3 = C.CardActive}, 0.15)
		classBadgeLabel.Text = tgt.ClassName
		modeBadgeLabel.Text = pickMode:upper()
		statsBadgeLabel.Text = countAll(tgt).." obj • "..countParts(tgt).." parts"
		inspPath.Text = tgt:GetFullName()
		liveDot.BackgroundColor3 = C.Success
		statusTarget.Text = tgt.Name:sub(1,14)
	elseif not tgt or tgt == workspace then
		if currentTarget then
			currentTarget = nil
			highlight.Enabled = false
			inspName.Text = "No target"
			inspName.TextColor3 = C.TextDark
			inspIcon.TextColor3 = C.TextDark
			tw(inspIconWrap, {BackgroundColor3 = C.Bg3}, 0.15)
			classBadgeLabel.Text = "—"
			statsBadgeLabel.Text = "0 obj • 0 parts"
			inspPath.Text = "Hover over any object in workspace"
			liveDot.BackgroundColor3 = C.TextDark
			statusTarget.Text = "none"
		end
	end
end)

-- =============================================
-- EXPLORER PAGE
-- =============================================
local eOrd = 0

-- Search bar
eOrd += 1
local searchCard = Instance.new("Frame")
searchCard.Size = UDim2.new(1,0,0,46)
searchCard.BackgroundColor3 = C.Card
searchCard.BorderSizePixel = 0
searchCard.LayoutOrder = eOrd
searchCard.Parent = explorerPage
corner(searchCard, 12)
stroke(searchCard, C.Border, 1, 0.25)
pad(searchCard, 0,0,0,0)

local searchIcon = Instance.new("TextLabel")
searchIcon.Size = UDim2.new(0, 40, 1, 0)
searchIcon.Position = UDim2.new(0,0,0,0)
searchIcon.BackgroundTransparency = 1
searchIcon.Text = "⌕"
searchIcon.TextColor3 = C.TextDark
searchIcon.TextSize = 16
searchIcon.Font = Enum.Font.GothamBold
searchIcon.Parent = searchCard

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -84, 1, 0)
searchBox.Position = UDim2.new(0, 40, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.Text = ""
searchBox.PlaceholderText = "Search models by name or path..."
searchBox.PlaceholderColor3 = C.TextDark
searchBox.TextColor3 = C.Text
searchBox.TextSize = 12
searchBox.Font = Enum.Font.Gotham
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.Parent = searchCard

local searchClear = Instance.new("TextButton")
searchClear.Size = UDim2.new(0, 32, 0, 32)
searchClear.Position = UDim2.new(1, -38, 0.5, -16)
searchClear.BackgroundColor3 = C.Bg3
searchClear.BorderSizePixel = 0
searchClear.Text = "✕"
searchClear.TextColor3 = C.TextDark
searchClear.TextSize = 10
searchClear.Font = Enum.Font.GothamBold
searchClear.Visible = false
searchClear.AutoButtonColor = false
searchClear.Parent = searchCard
corner(searchClear, 8)

searchClear.MouseButton1Click:Connect(function() searchBox.Text = "" end)
searchBox:GetPropertyChangedSignal("Text"):Connect(function() searchClear.Visible = searchBox.Text ~= "" end)

-- Controls row
eOrd += 1
local ctrlRow = Instance.new("Frame")
ctrlRow.Size = UDim2.new(1,0,0,42)
ctrlRow.BackgroundTransparency = 1
ctrlRow.LayoutOrder = eOrd
ctrlRow.Parent = explorerPage

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0.6, -4, 1, 0)
scanBtn.BackgroundColor3 = C.Purple
scanBtn.BorderSizePixel = 0
scanBtn.Text = "⬡  Scan Workspace"
scanBtn.TextColor3 = Color3.fromRGB(255,255,255)
scanBtn.TextSize = 12
scanBtn.Font = Enum.Font.GothamBold
scanBtn.AutoButtonColor = false
scanBtn.Parent = ctrlRow
corner(scanBtn, 10)
grad(scanBtn, C.Purple, C.Accent, 20)

local clearPrevBtn = Instance.new("TextButton")
clearPrevBtn.Size = UDim2.new(0.4, -4, 1, 0)
clearPrevBtn.Position = UDim2.new(0.6, 4, 0, 0)
clearPrevBtn.BackgroundColor3 = C.Card
clearPrevBtn.BorderSizePixel = 0
clearPrevBtn.Text = "🗑 Clear Previews"
clearPrevBtn.TextColor3 = C.TextDim
clearPrevBtn.TextSize = 11
clearPrevBtn.Font = Enum.Font.GothamMedium
clearPrevBtn.AutoButtonColor = false
clearPrevBtn.Parent = ctrlRow
corner(clearPrevBtn, 10)
stroke(clearPrevBtn, C.Border, 1, 0.3)

scanBtn.MouseEnter:Connect(function() tw(scanBtn, {BackgroundColor3 = C.PurpleHover}) end)
scanBtn.MouseLeave:Connect(function() tw(scanBtn, {BackgroundColor3 = C.Purple}) end)
clearPrevBtn.MouseEnter:Connect(function() tw(clearPrevBtn, {BackgroundColor3 = C.Danger, BackgroundTransparency = 0.8}) clearPrevBtn.TextColor3 = C.Danger end)
clearPrevBtn.MouseLeave:Connect(function() tw(clearPrevBtn, {BackgroundColor3 = C.Card}) clearPrevBtn.TextColor3 = C.TextDim end)

-- Stats bar
eOrd += 1
local statsBar = Instance.new("Frame")
statsBar.Size = UDim2.new(1,0,0,36)
statsBar.BackgroundColor3 = C.Bg1
statsBar.BorderSizePixel = 0
statsBar.LayoutOrder = eOrd
statsBar.Parent = explorerPage
corner(statsBar, 10)
stroke(statsBar, C.Border, 1, 0.25)
pad(statsBar, 8,8,12,12)

local statsLayout = Instance.new("UIListLayout")
statsLayout.FillDirection = Enum.FillDirection.Horizontal
statsLayout.SortOrder = Enum.SortOrder.LayoutOrder
statsLayout.Padding = UDim.new(0,12)
statsLayout.Parent = statsBar

local function statItem(name, val, order)
	local f = Instance.new("Frame")
	f.Size = UDim2.new(0,0,1,0)
	f.AutomaticSize = Enum.AutomaticSize.X
	f.BackgroundTransparency = 1
	f.LayoutOrder = order
	f.Parent = statsBar
	local l1 = Instance.new("TextLabel")
	l1.Size = UDim2.new(0,0,1,0)
	l1.AutomaticSize = Enum.AutomaticSize.X
	l1.BackgroundTransparency = 1
	l1.Text = name:upper().." "
	l1.TextColor3 = C.TextDark
	l1.TextSize = 10
	l1.Font = Enum.Font.GothamBold
	l1.Parent = f
	local l2 = Instance.new("TextLabel")
	l2.Name = "Value"
	l2.Size = UDim2.new(0,0,1,0)
	l2.AutomaticSize = Enum.AutomaticSize.X
	l2.Position = UDim2.new(0, l1.TextBounds.X + 2, 0, 0)
	l2.BackgroundTransparency = 1
	l2.Text = val
	l2.TextColor3 = C.Text
	l2.TextSize = 11
	l2.Font = Enum.Font.GothamBold
	l2.Parent = f
	-- we will update via finding Value label
	return l2
end

-- simpler stats
local statTotal = Instance.new("TextLabel")
statTotal.Size = UDim2.new(0.33,0,1,0)
statTotal.BackgroundTransparency = 1
statTotal.Text = "TOTAL: 0"
statTotal.TextColor3 = C.TextDim
statTotal.TextSize = 10
statTotal.Font = Enum.Font.GothamBold
statTotal.TextXAlignment = Enum.TextXAlignment.Left
statTotal.LayoutOrder = 1
statTotal.Parent = statsBar

local statFiltered = Instance.new("TextLabel")
statFiltered.Size = UDim2.new(0.33,0,1,0)
statFiltered.BackgroundTransparency = 1
statFiltered.Text = "FILTERED: 0"
statFiltered.TextColor3 = C.TextDim
statFiltered.TextSize = 10
statFiltered.Font = Enum.Font.GothamBold
statFiltered.TextXAlignment = Enum.TextXAlignment.Center
statFiltered.LayoutOrder = 2
statFiltered.Parent = statsBar

local statPrev = Instance.new("TextLabel")
statPrev.Size = UDim2.new(0.34,0,1,0)
statPrev.BackgroundTransparency = 1
statPrev.Text = "PREVIEWS: 0"
statPrev.TextColor3 = C.TextDim
statPrev.TextSize = 10
statPrev.Font = Enum.Font.GothamBold
statPrev.TextXAlignment = Enum.TextXAlignment.Right
statPrev.LayoutOrder = 3
statPrev.Parent = statsBar

eOrd += 1
local eDiv = Instance.new("Frame")
eDiv.Size = UDim2.new(1,0,0,1)
eDiv.BackgroundColor3 = C.Border
eDiv.BackgroundTransparency = 0.5
eDiv.BorderSizePixel = 0
eDiv.LayoutOrder = eOrd
eDiv.Parent = explorerPage

-- Explorer logic
local explorerCards = {}
local allFoundModels = {}
local spawnedPreviews = {}

local function updateExplorerStats(filtered)
	statTotal.Text = "TOTAL: "..#allFoundModels
	statFiltered.Text = "FILTERED: "..(filtered or #allFoundModels)
	statPrev.Text = "PREVIEWS: "..#spawnedPreviews
	statusPreviews.Text = tostring(#spawnedPreviews)
	if #spawnedPreviews > 0 then
		explorerBtn.badge.Visible = true
		explorerBtn.badgeLabel.Text = tostring(#spawnedPreviews)
		explorerBtn.badge.Size = UDim2.new(0, 20 + #tostring(#spawnedPreviews)*6, 0, 18)
	else
		if #allFoundModels == 0 then explorerBtn.badge.Visible = false end
	end
end

local function deletePreview(p)
	if p and p.Parent then p:Destroy() end
	for i, v in ipairs(spawnedPreviews) do if v == p then table.remove(spawnedPreviews, i); break end end
	updateExplorerStats()
end

local function spawnPreview(obj)
	local char = LocalPlayer.Character; if not char then return nil end
	local root = char:FindFirstChild("HumanoidRootPart"); if not root then return nil end
	local spawnCF = root.CFrame * CFrame.new(0, 0, -15)
	local clone; local ok = pcall(function() clone = obj:Clone() end)
	if not ok or not clone then return nil end
	if clone:IsA("Model") then
		pcall(function() clone:PivotTo(spawnCF) end)
		if not clone.PrimaryPart then
			for _, d in clone:GetDescendants() do if d:IsA("BasePart") then clone.PrimaryPart = d; break end end
		end
		if clone.PrimaryPart then pcall(function() clone:SetPrimaryPartCFrame(spawnCF) end) end
	elseif clone:IsA("BasePart") then clone.CFrame = spawnCF end
	for _, d in clone:GetDescendants() do if d:IsA("BasePart") then d.Anchored = true end end
	if clone:IsA("BasePart") then clone.Anchored = true end
	clone.Name = "PREVIEW_"..obj.Name; clone.Parent = workspace
	table.insert(spawnedPreviews, clone)
	updateExplorerStats()
	return clone
end

local function clearExplorerCards()
	for _, card in ipairs(explorerCards) do if card and card.Parent then card:Destroy() end end
	explorerCards = {}
end

local function createExplorerCard(obj, idx)
	local total = countAll(obj); local parts = countParts(obj)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1,0,0,128)
	card.BackgroundColor3 = C.Card
	card.BorderSizePixel = 0
	card.LayoutOrder = 200 + idx
	card.Parent = explorerPage
	corner(card, 12)
	local st = stroke(card, C.Border, 1, 0.25)
	pad(card, 10,10,10,10)

	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(0,4,1,-20)
	accent.Position = UDim2.new(0,0,0,10)
	accent.BackgroundColor3 = C.Purple
	accent.BorderSizePixel = 0
	accent.Parent = card
	corner(accent, 2)
	grad(accent, C.Purple, C.Accent, 90)

	local iconWrap = Instance.new("Frame")
	iconWrap.Size = UDim2.new(0,32,0,32)
	iconWrap.Position = UDim2.new(0,14,0,0)
	iconWrap.BackgroundColor3 = C.Bg3
	iconWrap.BorderSizePixel = 0
	iconWrap.Parent = card
	corner(iconWrap, 8)
	local iconLbl = Instance.new("TextLabel")
	iconLbl.Size = UDim2.new(1,0,1,0)
	iconLbl.BackgroundTransparency = 1
	iconLbl.Text = "⬡"
	iconLbl.TextColor3 = C.Purple
	iconLbl.TextSize = 16
	iconLbl.Font = Enum.Font.GothamBold
	iconLbl.Parent = iconWrap

	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(1, -110, 0, 18)
	nameLbl.Position = UDim2.new(0, 54, 0, 0)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text = obj.Name
	nameLbl.TextColor3 = C.Text
	nameLbl.TextSize = 13
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextXAlignment = Enum.TextXAlignment.Left
	nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
	nameLbl.Parent = card

	local classPill = Instance.new("Frame")
	classPill.Size = UDim2.new(0,0,0,18)
	classPill.AutomaticSize = Enum.AutomaticSize.X
	classPill.Position = UDim2.new(1, -6, 0, 2)
	classPill.AnchorPoint = Vector2.new(1,0)
	classPill.BackgroundColor3 = C.Bg2
	classPill.BorderSizePixel = 0
	classPill.Parent = card
	corner(classPill, 6)
	stroke(classPill, C.Border, 1, 0.3)
	pad(classPill, 0,0,8,8)
	local classLbl = Instance.new("TextLabel")
	classLbl.Size = UDim2.new(0,0,1,0)
	classLbl.AutomaticSize = Enum.AutomaticSize.X
	classLbl.BackgroundTransparency = 1
	classLbl.Text = obj.ClassName.." • "..parts.."p"
	classLbl.TextColor3 = C.TextDim
	classLbl.TextSize = 10
	classLbl.Font = Enum.Font.GothamBold
	classLbl.Parent = classPill

	local infoLbl = Instance.new("TextLabel")
	infoLbl.Size = UDim2.new(1, -16, 0, 14)
	infoLbl.Position = UDim2.new(0, 8, 0, 36)
	infoLbl.BackgroundTransparency = 1
	infoLbl.Text = total.." objects • "..parts.." parts"
	infoLbl.TextColor3 = C.TextDim
	infoLbl.TextSize = 11
	infoLbl.Font = Enum.Font.Gotham
	infoLbl.TextXAlignment = Enum.TextXAlignment.Left
	infoLbl.Parent = card

	local pathLbl = Instance.new("TextLabel")
	pathLbl.Size = UDim2.new(1, -16, 0, 12)
	pathLbl.Position = UDim2.new(0, 8, 0, 52)
	pathLbl.BackgroundTransparency = 1
	pathLbl.Text = obj:GetFullName()
	pathLbl.TextColor3 = C.TextDark
	pathLbl.TextSize = 9
	pathLbl.Font = Enum.Font.Code
	pathLbl.TextXAlignment = Enum.TextXAlignment.Left
	pathLbl.TextTruncate = Enum.TextTruncate.AtEnd
	pathLbl.Parent = card

	local btnRow = Instance.new("Frame")
	btnRow.Size = UDim2.new(1, -16, 0, 30)
	btnRow.Position = UDim2.new(0, 8, 0, 70)
	btnRow.BackgroundTransparency = 1
	btnRow.Parent = card

	local function smallBtn(text, col, hover, pos, size)
		local b = Instance.new("TextButton")
		b.Size = size
		b.Position = pos
		b.BackgroundColor3 = col
		b.BorderSizePixel = 0
		b.Text = text
		b.TextColor3 = Color3.fromRGB(255,255,255)
		b.TextSize = 11
		b.Font = Enum.Font.GothamBold
		b.AutoButtonColor = false
		b.Parent = btnRow
		corner(b, 8)
		b.MouseEnter:Connect(function() tw(b, {BackgroundColor3 = hover}, 0.15) end)
		b.MouseLeave:Connect(function() tw(b, {BackgroundColor3 = col}, 0.15) end)
		return b
	end

	local previewRef = nil

	local spawnBtn = smallBtn("◉ Summon", C.Success, C.SuccessHover, UDim2.new(0,0,0,0), UDim2.new(0.32, -4, 1, 0))
	local copyBtn = smallBtn("⧉ Code", C.Info, C.InfoHover, UDim2.new(0.32, 2, 0, 0), UDim2.new(0.36, -4, 1, 0))
	local tpBtn = smallBtn("◎ TP", C.Warning, C.Accent2Hover, UDim2.new(0.68, 2, 0, 0), UDim2.new(0.32, -2, 1, 0))
	tpBtn.TextColor3 = C.Bg0

	card.MouseEnter:Connect(function() tw(card, {BackgroundColor3 = C.CardHover}, 0.15) tw(st, {Transparency = 0.1}, 0.15) end)
	card.MouseLeave:Connect(function() tw(card, {BackgroundColor3 = C.Card}, 0.15) tw(st, {Transparency = 0.25}, 0.15) end)

	spawnBtn.MouseButton1Click:Connect(function()
		if previewRef and previewRef.Parent then
			deletePreview(previewRef); previewRef = nil; spawnBtn.Text = "◉ Summon"
			tw(spawnBtn, {BackgroundColor3 = C.Success})
			showToast("Removed preview: "..obj.Name, "info", 1.2)
		else
			previewRef = spawnPreview(obj)
			if previewRef then
				spawnBtn.Text = "🗑 Unsummon"
				tw(spawnBtn, {BackgroundColor3 = C.Danger})
				showToast("Summoned "..obj.Name.." in front of you", "success", 1.5)
			else
				spawnBtn.Text = "⚠ Failed"
				task.delay(1, function() if spawnBtn.Parent then spawnBtn.Text = "◉ Summon" end end)
			end
		end
	end)

	copyBtn.MouseButton1Click:Connect(function()
		copyBtn.Text = "⏳..."
		task.wait()
		if not obj or not obj.Parent then copyBtn.Text = "⚠ Gone"; task.delay(1, function() if copyBtn.Parent then copyBtn.Text = "⧉ Code" end end); return end
		local code, cnt = genCode(obj)
		local ok = pcall(function() setclipboard(code) end)
		if ok then
			copyBtn.Text = "✓ "..cnt
			showToast("Copied "..obj.Name.." ("..cnt.." objs)", "success", 1.5)
		else
			copyBtn.Text = "⚠ F9"
			print(code)
			showToast("Printed to console F9", "warn", 2)
		end
		task.delay(1.5, function() if copyBtn.Parent then copyBtn.Text = "⧉ Code" end end)
	end)

	tpBtn.MouseButton1Click:Connect(function()
		local char = LocalPlayer.Character; if not char then return end
		local hr = char:FindFirstChild("HumanoidRootPart"); if not hr then return end
		local tp = nil
		if obj:IsA("BasePart") then tp = obj
		elseif obj:IsA("Model") then
			if obj.PrimaryPart then tp = obj.PrimaryPart end
			if not tp then for _, d in obj:GetDescendants() do if d:IsA("BasePart") then tp = d; break end end end
		end
		if tp then
			hr.CFrame = tp.CFrame + Vector3.new(0, 5, 0)
			tpBtn.Text = "✓ TP'd"
			showToast("Teleported to "..obj.Name, "success", 1.2)
			task.delay(1, function() if tpBtn.Parent then tpBtn.Text = "◎ TP" end end)
		end
	end)

	table.insert(explorerCards, card)
end

local function scanModels()
	local results = {}; local seen = {}
	local function addC(name) local ok, svc = pcall(function() return game:GetService(name) end); if ok and svc then
		local desc = {}; pcall(function() desc = svc:GetDescendants() end)
		for _, obj in desc do
			if obj:IsA("Model") and not isPC(obj) then
				local path = ""; pcall(function() path = obj:GetFullName() end)
				if not seen[path] then seen[path] = true; table.insert(results, obj) end
			end
		end
	end end
	addC("Workspace"); addC("ReplicatedStorage"); addC("ReplicatedFirst")
	addC("StarterGui"); addC("StarterPack"); addC("StarterPlayer")
	addC("Lighting"); addC("ServerStorage"); addC("ServerScriptService"); addC("SoundService")
	table.sort(results, function(a, b) return a.Name:lower() < b.Name:lower() end)
	return results
end

local function applyExplorerFilter()
	local query = searchBox.Text:lower(); local visible = 0
	for i, card in ipairs(explorerCards) do
		if not card or not card.Parent then continue end
		local obj = allFoundModels[i]; if not obj then continue end
		local show = true
		if query ~= "" then
			local mn = obj.Name:lower():find(query, 1, true)
			local mp = ""; pcall(function() mp = obj:GetFullName():lower() end)
			show = mn or mp:find(query, 1, true)
		end
		card.Visible = show; if show then visible += 1 end
	end
	statFiltered.Text = "FILTERED: "..visible
	if query ~= "" then
		showToast("Found "..visible.." matching '"..searchBox.Text.."'", "info", 1)
	end
end

scanBtn.MouseButton1Click:Connect(function()
	scanBtn.Text = "⏳ Scanning..."
	task.wait()
	clearExplorerCards()
	allFoundModels = scanModels()
	for i, obj in ipairs(allFoundModels) do createExplorerCard(obj, i) end
	updateExplorerStats(#allFoundModels)
	scanBtn.Text = "⬡  Scan Workspace"
	showToast("Scan complete: "..#allFoundModels.." models found", "success", 2)
	if #allFoundModels > 0 then
		explorerBtn.badge.Visible = true
		explorerBtn.badge.Size = UDim2.new(0, 22 + #tostring(#allFoundModels)*6, 0, 18)
		explorerBtn.badgeLabel.Text = tostring(#allFoundModels)
	end
end)

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	if searchBox.Text == "" then
		for _, card in ipairs(explorerCards) do card.Visible = true end
		updateExplorerStats()
	else
		applyExplorerFilter()
	end
end)

clearPrevBtn.MouseButton1Click:Connect(function()
	if #spawnedPreviews == 0 then showToast("No previews to clear", "warn", 1) return end
	for _, p in ipairs(spawnedPreviews) do if p and p.Parent then p:Destroy() end end
	spawnedPreviews = {}
	updateExplorerStats()
	for _, card in ipairs(explorerCards) do
		-- reset summon buttons text if needed (we don't track refs easily, so just show toast)
	end
	showToast("Cleared all previews", "info", 1.5)
end)

-- =============================================
-- SETTINGS PAGE
-- =============================================
local sOrd = 0

local function settingsCard(title, desc, order, height)
	local c = Instance.new("Frame")
	c.Size = UDim2.new(1,0,0,height or 80)
	c.BackgroundColor3 = C.Card
	c.BorderSizePixel = 0
	c.LayoutOrder = order
	c.Parent = settingsPage
	corner(c, 12)
	stroke(c, C.Border, 1, 0.25)
	pad(c, 14,14,14,14)

	local t = Instance.new("TextLabel")
	t.Size = UDim2.new(1,0,0,16)
	t.BackgroundTransparency = 1
	t.Text = title
	t.TextColor3 = C.Text
	t.TextSize = 12
	t.Font = Enum.Font.GothamBold
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.Parent = c

	local d = Instance.new("TextLabel")
	d.Size = UDim2.new(1,0,0,14)
	d.Position = UDim2.new(0,0,0,18)
	d.BackgroundTransparency = 1
	d.Text = desc
	d.TextColor3 = C.TextDark
	d.TextSize = 10
	d.Font = Enum.Font.Gotham
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.Parent = c

	return c
end

sOrd += 1
local spawnCard = settingsCard("SPAWN DISTANCE", "Distance in front of camera where code will spawn models in Studio", sOrd, 88)

local spawnRow = Instance.new("Frame")
spawnRow.Size = UDim2.new(1,0,0,36)
spawnRow.Position = UDim2.new(0,0,0,40)
spawnRow.BackgroundTransparency = 1
spawnRow.Parent = spawnCard

local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0,36,0,32)
minusBtn.BackgroundColor3 = C.Bg3
minusBtn.BorderSizePixel = 0
minusBtn.Text = "−"
minusBtn.TextColor3 = C.Text
minusBtn.TextSize = 16
minusBtn.Font = Enum.Font.GothamBold
minusBtn.AutoButtonColor = false
minusBtn.Parent = spawnRow
corner(minusBtn, 8)
stroke(minusBtn, C.Border, 1, 0.3)

local distLabel = Instance.new("TextLabel")
distLabel.Size = UDim2.new(0,80,0,32)
distLabel.Position = UDim2.new(0,44,0,0)
distLabel.BackgroundColor3 = C.Bg2
distLabel.BorderSizePixel = 0
distLabel.Text = tostring(spawnDistance).." studs"
distLabel.TextColor3 = C.Accent
distLabel.TextSize = 12
distLabel.Font = Enum.Font.GothamBold
distLabel.Parent = spawnRow
corner(distLabel, 8)
stroke(distLabel, C.Border, 1, 0.25)

local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0,36,0,32)
plusBtn.Position = UDim2.new(0,132,0,0)
plusBtn.BackgroundColor3 = C.Bg3
plusBtn.BorderSizePixel = 0
plusBtn.Text = "+"
plusBtn.TextColor3 = C.Text
plusBtn.TextSize = 16
plusBtn.Font = Enum.Font.GothamBold
plusBtn.AutoButtonColor = false
plusBtn.Parent = spawnRow
corner(plusBtn, 8)
stroke(plusBtn, C.Border, 1, 0.3)

local function updDist()
	distLabel.Text = tostring(spawnDistance).." studs"
end
minusBtn.MouseButton1Click:Connect(function() spawnDistance = math.max(5, spawnDistance - 5); updDist(); showToast("Spawn distance: "..spawnDistance, "info", 1) end)
plusBtn.MouseButton1Click:Connect(function() spawnDistance = math.min(100, spawnDistance + 5); updDist(); showToast("Spawn distance: "..spawnDistance, "info", 1) end)

sOrd += 1
local hlCard = settingsCard("HIGHLIGHT", "Customize selection highlight appearance", sOrd, 88)

local hlRow = Instance.new("Frame")
hlRow.Size = UDim2.new(1,0,0,32)
hlRow.Position = UDim2.new(0,0,0,40)
hlRow.BackgroundTransparency = 1
hlRow.Parent = hlCard

local hlToggle = Instance.new("TextButton")
hlToggle.Size = UDim2.new(0,120,0,32)
hlToggle.BackgroundColor3 = C.Accent
hlToggle.BorderSizePixel = 0
hlToggle.Text = "◉ Highlight ON"
hlToggle.TextColor3 = Color3.fromRGB(255,255,255)
hlToggle.TextSize = 11
hlToggle.Font = Enum.Font.GothamBold
hlToggle.AutoButtonColor = false
hlToggle.Parent = hlRow
corner(hlToggle, 8)

hlToggle.MouseButton1Click:Connect(function()
	highlight.Enabled = not highlight.Enabled
	hlToggle.Text = highlight.Enabled and "◉ Highlight ON" or "○ Highlight OFF"
	tw(hlToggle, {BackgroundColor3 = highlight.Enabled and C.Accent or C.Bg3}, 0.2)
	hlToggle.TextColor3 = highlight.Enabled and Color3.fromRGB(255,255,255) or C.TextDim
	showToast("Highlight "..(highlight.Enabled and "enabled" or "disabled"), "info", 1)
end)

sOrd += 1
local actCard = settingsCard("ACTIONS", "Quick tools and cleanup", sOrd, 120)

local actRow1 = Instance.new("Frame")
actRow1.Size = UDim2.new(1,0,0,32)
actRow1.Position = UDim2.new(0,0,0,40)
actRow1.BackgroundTransparency = 1
actRow1.Parent = actCard

local actRow2 = Instance.new("Frame")
actRow2.Size = UDim2.new(1,0,0,32)
actRow2.Position = UDim2.new(0,0,0,78)
actRow2.BackgroundTransparency = 1
actRow2.Parent = actCard

local function actionBtn(text, col, hover, parent, size, pos)
	local b = Instance.new("TextButton")
	b.Size = size
	b.Position = pos
	b.BackgroundColor3 = col
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = Color3.fromRGB(255,255,255)
	b.TextSize = 11
	b.Font = Enum.Font.GothamBold
	b.AutoButtonColor = false
	b.Parent = parent
	corner(b, 8)
	b.MouseEnter:Connect(function() tw(b, {BackgroundColor3 = hover}, 0.15) end)
	b.MouseLeave:Connect(function() tw(b, {BackgroundColor3 = col}, 0.15) end)
	return b
end

local clearAllPrevBtn = actionBtn("🗑 Clear All Previews", C.Bg3, C.Danger, actRow1, UDim2.new(0.5, -4, 1, 0), UDim2.new(0,0,0,0))
clearAllPrevBtn.TextColor3 = C.TextDim
local clearAllCapBtn = actionBtn("✕ Clear Captured", C.Bg3, C.Danger, actRow1, UDim2.new(0.5, -4, 1, 0), UDim2.new(0.5, 4, 0, 0))
clearAllCapBtn.TextColor3 = C.TextDim

local destroyBtn = actionBtn("⚠ Destroy UI", C.Danger, C.DangerHover, actRow2, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0))

clearAllPrevBtn.MouseButton1Click:Connect(function()
	for _, p in ipairs(spawnedPreviews) do if p and p.Parent then p:Destroy() end end
	spawnedPreviews = {}
	updateExplorerStats()
	showToast("All previews cleared", "info", 1.5)
end)
clearAllCapBtn.MouseButton1Click:Connect(function()
	for _, c in ipairs(copiedCards) do if c.card and c.card.Parent then c.card:Destroy() end end
	copiedCards = {}
	updatePickerStatus()
	showToast("Captured list cleared", "info", 1.5)
end)
destroyBtn.MouseButton1Click:Connect(function()
	tw(Main, {BackgroundTransparency = 1}, 0.2)
	tw(Shadow, {BackgroundTransparency = 1}, 0.2)
	task.wait(0.25)
	screenGui:Destroy()
end)

sOrd += 1
local aboutCard = settingsCard("ABOUT", "Ash Model Copier — Obsidian Edition", sOrd, 92)
local aboutText = Instance.new("TextLabel")
aboutText.Size = UDim2.new(1,0,0,40)
aboutText.Position = UDim2.new(0,0,0,36)
aboutText.BackgroundTransparency = 1
aboutText.Text = "v7.0 • Modern UI • Violet/Amber theme • Spawn in front of camera • Improved cards • Toasts • Settings\nMade for builders • Press Q to hide, H to pick, G to cycle mode"
aboutText.TextColor3 = C.TextDim
aboutText.TextSize = 10
aboutText.Font = Enum.Font.Gotham
aboutText.TextXAlignment = Enum.TextXAlignment.Left
aboutText.TextYAlignment = Enum.TextYAlignment.Top
aboutText.TextWrapped = true
aboutText.Parent = aboutCard

-- Hotkeys
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.H then
		if currentTarget and currentTarget ~= workspace then
			tw(highlight, {FillTransparency = 0.4}, 0.08)
			task.delay(0.12, function() tw(highlight, {FillTransparency = 0.85}, 0.18) end)
			switchPage("Picker")
			createPickerCard(currentTarget)
		else
			showToast("No target to capture — hover over a model first", "warn", 1.5)
		end
	end
	if input.KeyCode == Enum.KeyCode.Q then
		screenGui.Enabled = not screenGui.Enabled
		if screenGui.Enabled then
			showToast("Ash Copier visible — [Q] to hide", "info", 1.2)
		end
	end
	if input.KeyCode == Enum.KeyCode.G then
		local order = {"part","model","parent","root"}; local ci = 1
		for i, k in ipairs(order) do if k == pickMode then ci = i end end
		pickMode = order[(ci % #order) + 1]
		updateModeUI(true)
		showToast("Mode switched to "..pickMode:upper(), "info", 1.2)
	end
end)

HideBtn.MouseButton1Click:Connect(function() screenGui.Enabled = false end)
CloseBtn.MouseButton1Click:Connect(function() screenGui.Enabled = false; showToast("Hidden — press [Q] to show again", "info", 2) end)

-- Open animation
Main.Size = UDim2.new(0, 680, 0, 480)
Main.Position = UDim2.new(0.5, -340, 0.5, -240)
Main.BackgroundTransparency = 1
Shadow.BackgroundTransparency = 1
for _, v in ipairs(Main:GetDescendants()) do
	if v:IsA("TextLabel") or v:IsA("TextButton") then v.TextTransparency = 1 end
	if v:IsA("Frame") then
		if v.BackgroundTransparency < 1 then
			v:SetAttribute("OrigTrans", v.BackgroundTransparency)
			v.BackgroundTransparency = 1
		end
	end
end
tw(Main, {Size = UDim2.new(0,720,0,520), Position = UDim2.new(0.5,-360,0.5,-260), BackgroundTransparency = 0}, 0.35, Enum.EasingStyle.Back)
tw(Shadow, {BackgroundTransparency = 0.55}, 0.35)
task.delay(0.15, function()
	for _, v in ipairs(Main:GetDescendants()) do
		if v:IsA("TextLabel") then tw(v, {TextTransparency = 0}, 0.25) end
		if v:IsA("TextButton") then tw(v, {TextTransparency = 0}, 0.25) end
		if v:IsA("Frame") and v:GetAttribute("OrigTrans") ~= nil then
			tw(v, {BackgroundTransparency = v:GetAttribute("OrigTrans")}, 0.25)
		end
	end
end)

switchPage("Picker")
updatePickerStatus()
updateExplorerStats(0)
showToast("Ash Copier v7.0 loaded — Obsidian UI ready", "success", 2.5)
