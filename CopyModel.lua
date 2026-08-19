-- ============================================
-- Ash Model Copier v6.1
-- Пепельная подсветка + спавн перед камерой
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

for _, v in CoreGui:GetChildren() do
	if v:IsA("ScreenGui") and v.Name == "AshModelCopier" then v:Destroy() end
end
pcall(function()
	local pg = LocalPlayer:FindFirstChild("PlayerGui")
	if pg then for _, v in pg:GetChildren() do
		if v:IsA("ScreenGui") and v.Name == "AshModelCopier" then v:Destroy() end
	end end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AshModelCopier"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local guiOk = pcall(function() screenGui.Parent = CoreGui end)
if not guiOk then screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local T = 0.5
local C = {
	Bg = Color3.fromRGB(60, 58, 56), Sidebar = Color3.fromRGB(48, 46, 44),
	Content = Color3.fromRGB(68, 65, 62), Header = Color3.fromRGB(42, 40, 38),
	Card = Color3.fromRGB(76, 72, 68), CardHover = Color3.fromRGB(88, 84, 80),
	Accent = Color3.fromRGB(180, 170, 160), Text = Color3.fromRGB(230, 224, 218),
	TextDim = Color3.fromRGB(160, 152, 144), TextDark = Color3.fromRGB(115, 110, 104),
	Divider = Color3.fromRGB(85, 80, 76),
	Blue = Color3.fromRGB(90, 130, 180), BlueHover = Color3.fromRGB(110, 150, 200),
	Green = Color3.fromRGB(70, 190, 100), GreenHover = Color3.fromRGB(90, 210, 120),
	Red = Color3.fromRGB(190, 80, 80), RedHover = Color3.fromRGB(210, 95, 95),
	Orange = Color3.fromRGB(200, 150, 70), OrangeHover = Color3.fromRGB(220, 170, 90),
	Purple = Color3.fromRGB(140, 110, 190), PurpleHover = Color3.fromRGB(160, 130, 210),
	SideBtn = Color3.fromRGB(55, 52, 50), SideBtnActive = Color3.fromRGB(82, 78, 74),
	SideBtnHover = Color3.fromRGB(68, 64, 60),
	-- Пепельная подсветка
	HLFill = Color3.fromRGB(160, 155, 148),
	HLOutline = Color3.fromRGB(255, 200, 80),
}

local function tw(o, p, d) TweenService:Create(o, TweenInfo.new(d or 0.18, Enum.EasingStyle.Quad), p):Play() end
local function corner(p, r) local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 10); c.Parent = p end
local function makePad(p, t, b, l, r)
	local pd = Instance.new("UIPadding")
	pd.PaddingTop = UDim.new(0, t or 0); pd.PaddingBottom = UDim.new(0, b or 0)
	pd.PaddingLeft = UDim.new(0, l or 0); pd.PaddingRight = UDim.new(0, r or 0); pd.Parent = p
end

-- MAIN
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 640, 0, 500)
Main.Position = UDim2.new(0.5, -320, 0.5, -250)
Main.BackgroundColor3 = C.Bg; Main.BackgroundTransparency = T
Main.BorderSizePixel = 0; Main.ClipsDescendants = true
Main.Parent = screenGui; corner(Main, 12)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = C.Header; Header.BackgroundTransparency = T
Header.BorderSizePixel = 0; Header.Parent = Main

local headerDot = Instance.new("Frame")
headerDot.Size = UDim2.new(0, 10, 0, 10); headerDot.Position = UDim2.new(0, 16, 0.5, -5)
headerDot.BackgroundColor3 = C.Accent; headerDot.BackgroundTransparency = 0.2
headerDot.BorderSizePixel = 0; headerDot.Parent = Header; corner(headerDot, 5)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 300, 1, 0); titleLabel.Position = UDim2.new(0, 34, 0, 0)
titleLabel.BackgroundTransparency = 1; titleLabel.Text = "📦 Model Copier v6.1"
titleLabel.TextColor3 = C.Text; titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold; titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = Header

local hintLabel = Instance.new("TextLabel")
hintLabel.Size = UDim2.new(0, 240, 1, 0); hintLabel.Position = UDim2.new(1, -256, 0, 0)
hintLabel.BackgroundTransparency = 1; hintLabel.Text = "[Q] hide [H] pick [G] mode"
hintLabel.TextColor3 = C.TextDark; hintLabel.TextSize = 10; hintLabel.Font = Enum.Font.Gotham
hintLabel.TextXAlignment = Enum.TextXAlignment.Right; hintLabel.Parent = Header

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, 0, 0, 1); headerLine.Position = UDim2.new(0, 0, 1, 0)
headerLine.BackgroundColor3 = C.Divider; headerLine.BackgroundTransparency = 0.4
headerLine.BorderSizePixel = 0; headerLine.Parent = Header

do
	local dragging, dragStart, startPos
	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = Main.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -42); Body.Position = UDim2.new(0, 0, 0, 42)
Body.BackgroundTransparency = 1; Body.Parent = Main

local SIDE_W = 140
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, SIDE_W, 1, 0)
Sidebar.BackgroundColor3 = C.Sidebar; Sidebar.BackgroundTransparency = T
Sidebar.BorderSizePixel = 0; Sidebar.Parent = Body

local sideLineDiv = Instance.new("Frame")
sideLineDiv.Size = UDim2.new(0, 1, 1, 0); sideLineDiv.Position = UDim2.new(1, 0, 0, 0)
sideLineDiv.BackgroundColor3 = C.Divider; sideLineDiv.BackgroundTransparency = 0.4
sideLineDiv.BorderSizePixel = 0; sideLineDiv.Parent = Sidebar

local SideContainer = Instance.new("Frame")
SideContainer.Size = UDim2.new(1, -16, 1, -16); SideContainer.Position = UDim2.new(0, 8, 0, 8)
SideContainer.BackgroundTransparency = 1; SideContainer.Parent = Sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder; sideLayout.Padding = UDim.new(0, 4)
sideLayout.Parent = SideContainer

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -SIDE_W, 1, 0); ContentArea.Position = UDim2.new(0, SIDE_W, 0, 0)
ContentArea.BackgroundColor3 = C.Content; ContentArea.BackgroundTransparency = T
ContentArea.BorderSizePixel = 0; ContentArea.ClipsDescendants = true; ContentArea.Parent = Body

local pages = {}
local activeName = nil

local function createPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1
	page.BorderSizePixel = 0; page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = C.Accent; page.ScrollBarImageTransparency = 0.4
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = false; page.Parent = ContentArea
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0, 4)
	layout.Parent = page
	makePad(page, 12, 12, 12, 12)
	pages[name] = page
end

local sideButtons = {}
local sideOrder = 0

local function switchPage(name)
	activeName = name
	for _, p in pairs(pages) do p.Visible = false end
	if pages[name] then pages[name].Visible = true end
	for _, sb in pairs(sideButtons) do
		if sb.name == name then
			tw(sb.frame, {BackgroundColor3 = C.SideBtnActive, BackgroundTransparency = 0.25})
			sb.label.TextColor3 = C.Text; tw(sb.indicator, {BackgroundTransparency = 0.1})
		else
			tw(sb.frame, {BackgroundColor3 = C.SideBtn, BackgroundTransparency = T + 0.15})
			sb.label.TextColor3 = C.TextDim; tw(sb.indicator, {BackgroundTransparency = 1})
		end
	end
end

local function createSideButton(icon, name)
	sideOrder += 1
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 32); btn.BackgroundColor3 = C.SideBtn
	btn.BackgroundTransparency = T + 0.15; btn.BorderSizePixel = 0; btn.Text = ""
	btn.LayoutOrder = sideOrder; btn.AutoButtonColor = false; btn.Parent = SideContainer; corner(btn, 8)
	local indicator = Instance.new("Frame")
	indicator.Size = UDim2.new(0, 3, 0, 16); indicator.Position = UDim2.new(0, 3, 0.5, -8)
	indicator.BackgroundColor3 = C.Accent; indicator.BackgroundTransparency = 1
	indicator.BorderSizePixel = 0; indicator.Parent = btn; corner(indicator, 2)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -14, 1, 0); lbl.Position = UDim2.new(0, 14, 0, 0)
	lbl.BackgroundTransparency = 1; lbl.Text = icon.." "..name; lbl.TextColor3 = C.TextDim
	lbl.TextSize = 12; lbl.Font = Enum.Font.GothamMedium; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = btn
	btn.MouseEnter:Connect(function()
		if activeName ~= name then tw(btn, {BackgroundColor3 = C.SideBtnHover, BackgroundTransparency = T}) end
	end)
	btn.MouseLeave:Connect(function()
		if activeName ~= name then tw(btn, {BackgroundColor3 = C.SideBtn, BackgroundTransparency = T + 0.15}) end
	end)
	btn.MouseButton1Click:Connect(function() switchPage(name) end)
	table.insert(sideButtons, {frame = btn, label = lbl, indicator = indicator, name = name})
end

createSideButton("🎯", "Picker")
createSideButton("🔍", "Explorer")
createPage("Picker")
createPage("Explorer")

-- ============================================
-- ПОДСВЕТКА — пепельная, 90% прозрачная, яркий контур
-- ============================================
local highlight = Instance.new("Highlight")
highlight.Name = "AshHL"
highlight.FillColor = C.HLFill
highlight.FillTransparency = 0.92
highlight.OutlineColor = C.HLOutline
highlight.OutlineTransparency = 0
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Enabled = false
highlight.Parent = screenGui

-- ============================================
-- РЕЖИМЫ
-- ============================================
local pickMode = "model"
local currentTarget = nil
local lastMouseTarget = nil
local hlClock = 0

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

-- ============================================
-- PICKER PAGE
-- ============================================
local pickerPage = pages["Picker"]
local pOrd = 0

-- Режимы
pOrd += 1
local modeCard = Instance.new("Frame")
modeCard.Size = UDim2.new(1, 0, 0, 38); modeCard.BackgroundColor3 = C.Card
modeCard.BackgroundTransparency = T - 0.1; modeCard.BorderSizePixel = 0
modeCard.LayoutOrder = pOrd; modeCard.Parent = pickerPage; corner(modeCard, 8)

local modeLbl = Instance.new("TextLabel")
modeLbl.Size = UDim2.new(0, 52, 1, 0); modeLbl.Position = UDim2.new(0, 8, 0, 0)
modeLbl.BackgroundTransparency = 1; modeLbl.Text = "Режим:"
modeLbl.TextColor3 = C.TextDim; modeLbl.TextSize = 11; modeLbl.Font = Enum.Font.GothamBold
modeLbl.TextXAlignment = Enum.TextXAlignment.Left; modeLbl.Parent = modeCard

local modes = {{key="part",label="Part"},{key="model",label="Model"},{key="parent",label="Parent"},{key="root",label="Root"}}
local modeButtons = {}
for i, m in modes do
	local mb = Instance.new("TextButton")
	mb.Size = UDim2.new(0, 82, 0, 24)
	mb.Position = UDim2.new(0, 56 + (i-1)*88, 0.5, -12)
	mb.BackgroundColor3 = (m.key == pickMode) and C.Accent or C.Content
	mb.BackgroundTransparency = 0.25; mb.BorderSizePixel = 0; mb.Text = m.label
	mb.TextColor3 = (m.key == pickMode) and C.Text or C.TextDim
	mb.TextSize = 11; mb.Font = Enum.Font.GothamBold; mb.AutoButtonColor = false
	mb.Parent = modeCard; corner(mb, 6)
	modeButtons[m.key] = mb
end

local function updateModeUI()
	for k, b in modeButtons do
		if k == pickMode then tw(b, {BackgroundColor3 = C.Accent, BackgroundTransparency = 0.2}); b.TextColor3 = C.Text
		else tw(b, {BackgroundColor3 = C.Content, BackgroundTransparency = 0.25}); b.TextColor3 = C.TextDim end
	end
end
for _, m in modes do
	modeButtons[m.key].MouseButton1Click:Connect(function() pickMode = m.key; updateModeUI() end)
end

-- Info panel
pOrd += 1
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 56); infoFrame.BackgroundColor3 = C.Card
infoFrame.BackgroundTransparency = T - 0.1; infoFrame.BorderSizePixel = 0
infoFrame.LayoutOrder = pOrd; infoFrame.Parent = pickerPage; corner(infoFrame, 8)

local targetName = Instance.new("TextLabel")
targetName.Size = UDim2.new(1, -16, 0, 20); targetName.Position = UDim2.new(0, 10, 0, 6)
targetName.BackgroundTransparency = 1; targetName.Text = "🎯 Наведи мышку..."
targetName.TextColor3 = C.TextDim; targetName.TextSize = 13; targetName.Font = Enum.Font.GothamBold
targetName.TextXAlignment = Enum.TextXAlignment.Left; targetName.TextTruncate = Enum.TextTruncate.AtEnd
targetName.Parent = infoFrame

local targetInfo = Instance.new("TextLabel")
targetInfo.Size = UDim2.new(1, -16, 0, 14); targetInfo.Position = UDim2.new(0, 10, 0, 26)
targetInfo.BackgroundTransparency = 1; targetInfo.Text = "Нажми H"
targetInfo.TextColor3 = C.TextDark; targetInfo.TextSize = 10; targetInfo.Font = Enum.Font.Gotham
targetInfo.TextXAlignment = Enum.TextXAlignment.Left; targetInfo.TextTruncate = Enum.TextTruncate.AtEnd
targetInfo.Parent = infoFrame

local targetPath = Instance.new("TextLabel")
targetPath.Size = UDim2.new(1, -16, 0, 12); targetPath.Position = UDim2.new(0, 10, 0, 40)
targetPath.BackgroundTransparency = 1; targetPath.Text = ""
targetPath.TextColor3 = C.TextDark; targetPath.TextSize = 9; targetPath.Font = Enum.Font.Code
targetPath.TextXAlignment = Enum.TextXAlignment.Left; targetPath.TextTruncate = Enum.TextTruncate.AtEnd
targetPath.Parent = infoFrame

pOrd += 1
local pdiv = Instance.new("Frame"); pdiv.Size = UDim2.new(1, 0, 0, 1)
pdiv.BackgroundColor3 = C.Divider; pdiv.BackgroundTransparency = 0.5; pdiv.BorderSizePixel = 0
pdiv.LayoutOrder = pOrd; pdiv.Parent = pickerPage

pOrd += 1
local pickerStatus = Instance.new("TextLabel")
pickerStatus.Size = UDim2.new(1, 0, 0, 18); pickerStatus.BackgroundTransparency = 1
pickerStatus.Text = "Захвачено: 0"; pickerStatus.TextColor3 = C.TextDim
pickerStatus.TextSize = 11; pickerStatus.Font = Enum.Font.GothamBold
pickerStatus.TextXAlignment = Enum.TextXAlignment.Left; pickerStatus.LayoutOrder = pOrd
pickerStatus.Parent = pickerPage

-- Подсветка без лагов
RunService.Heartbeat:Connect(function(dt)
	hlClock += dt
	if hlClock < 0.1 then return end
	hlClock = 0
	local mt = Mouse.Target
	if mt == lastMouseTarget then return end
	lastMouseTarget = mt
	local tgt = getTarget(mt, pickMode)
	if tgt and tgt ~= workspace and tgt ~= currentTarget then
		currentTarget = tgt
		highlight.Adornee = tgt; highlight.Enabled = true
		targetName.Text = "🎯 "..tgt.Name; targetName.TextColor3 = C.Accent
		targetInfo.Text = "["..pickMode:upper().."] "..tgt.ClassName.." • "..countAll(tgt).." obj • "..countParts(tgt).." parts"
		targetInfo.TextColor3 = C.Text; targetPath.Text = tgt:GetFullName()
	elseif not tgt or tgt == workspace then
		if currentTarget then
			currentTarget = nil; highlight.Enabled = false
			targetName.Text = "🎯 Наведи мышку..."; targetName.TextColor3 = C.TextDim
			targetInfo.Text = "["..pickMode:upper().."]"; targetInfo.TextColor3 = C.TextDark; targetPath.Text = ""
		end
	end
end)

-- ============================================
-- СЕРИАЛИЗАЦИЯ (с pivot перед камерой)
-- ============================================
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

-- Получить pivot модели
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
		-- CFrame относительно pivot → размещается перед камерой
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
	L[#L+1] = "-- Ash v6.1 | "..obj.Name
	L[#L+1] = "-- Модель появится перед камерой в Studio"
	L[#L+1] = "local R = {}"
	L[#L+1] = "local cam = workspace.CurrentCamera"
	L[#L+1] = "local spawnCF = cam.CFrame * CFrame.new(0, 0, -25)"
	L[#L+1] = ""
	local cnt = processObj(obj, 0, L, 0, pivotCF)
	L[#L+1] = "print(\"[Ash] Spawned "..cnt.." obj in front of camera\")"
	return table.concat(L, "\n"), cnt
end

-- ============================================
-- КАРТОЧКИ PICKER
-- ============================================
local copiedCards = {}
local copiedOrder = 0

local function updatePickerStatus() pickerStatus.Text = "Захвачено: "..#copiedCards end

local function createPickerCard(obj)
	for _, c in copiedCards do
		if c.object == obj then
			if c.card and c.card.Parent then
				tw(c.card, {BackgroundColor3 = C.Accent, BackgroundTransparency = 0.2}, 0.15)
				task.delay(0.4, function() if c.card and c.card.Parent then tw(c.card, {BackgroundColor3 = C.Card, BackgroundTransparency = T-0.1}, 0.3) end end)
			end; return
		end
	end
	copiedOrder += 1
	local total = countAll(obj); local parts = countParts(obj)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 100); card.BackgroundColor3 = C.Card
	card.BackgroundTransparency = 1; card.BorderSizePixel = 0
	card.LayoutOrder = 100 + copiedOrder; card.Parent = pickerPage; corner(card, 8)
	tw(card, {BackgroundTransparency = T - 0.1}, 0.3)

	local nm = Instance.new("TextLabel")
	nm.Size = UDim2.new(1, -16, 0, 18); nm.Position = UDim2.new(0, 10, 0, 6)
	nm.BackgroundTransparency = 1; nm.Text = "📦 "..obj.Name; nm.TextColor3 = C.Text
	nm.TextSize = 13; nm.Font = Enum.Font.GothamBold; nm.TextXAlignment = Enum.TextXAlignment.Left
	nm.TextTruncate = Enum.TextTruncate.AtEnd; nm.Parent = card

	local inf = Instance.new("TextLabel")
	inf.Size = UDim2.new(1, -16, 0, 14); inf.Position = UDim2.new(0, 10, 0, 24)
	inf.BackgroundTransparency = 1; inf.Text = obj.ClassName.." • "..total.." obj • "..parts.." parts"
	inf.TextColor3 = C.TextDim; inf.TextSize = 10; inf.Font = Enum.Font.Gotham
	inf.TextXAlignment = Enum.TextXAlignment.Left; inf.Parent = card

	local pth = Instance.new("TextLabel")
	pth.Size = UDim2.new(1, -16, 0, 11); pth.Position = UDim2.new(0, 10, 0, 38)
	pth.BackgroundTransparency = 1; pth.Text = obj:GetFullName(); pth.TextColor3 = C.TextDark
	pth.TextSize = 9; pth.Font = Enum.Font.Code; pth.TextXAlignment = Enum.TextXAlignment.Left
	pth.TextTruncate = Enum.TextTruncate.AtEnd; pth.Parent = card

	local copyBtn = Instance.new("TextButton")
	copyBtn.Size = UDim2.new(0.62, -4, 0, 28); copyBtn.Position = UDim2.new(0, 8, 0, 58)
	copyBtn.BackgroundColor3 = C.Blue; copyBtn.BackgroundTransparency = 0.2; copyBtn.BorderSizePixel = 0
	copyBtn.Text = "📋 Копировать код"; copyBtn.TextColor3 = C.Text; copyBtn.TextSize = 11
	copyBtn.Font = Enum.Font.GothamBold; copyBtn.AutoButtonColor = false; copyBtn.Parent = card; corner(copyBtn, 7)
	copyBtn.MouseEnter:Connect(function() tw(copyBtn, {BackgroundColor3 = C.BlueHover, BackgroundTransparency = 0.1}) end)
	copyBtn.MouseLeave:Connect(function() tw(copyBtn, {BackgroundColor3 = C.Blue, BackgroundTransparency = 0.2}) end)
	copyBtn.MouseButton1Click:Connect(function()
		copyBtn.Text = "⏳..."; copyBtn.BackgroundColor3 = C.Accent; task.wait()
		if not obj or not obj.Parent then copyBtn.Text = "⚠ Удалён"; copyBtn.BackgroundColor3 = C.Red
			task.delay(2, function() if copyBtn.Parent then copyBtn.Text = "📋 Копировать код"; copyBtn.BackgroundColor3 = C.Blue end end); return end
		local code, cnt = genCode(obj)
		local ok = pcall(function() setclipboard(code) end)
		if ok then copyBtn.Text = "✓ "..cnt.." obj!"; copyBtn.BackgroundColor3 = C.Green
		else copyBtn.Text = "⚠ F9"; print(code) end
		task.delay(2.5, function() if copyBtn.Parent then copyBtn.Text = "📋 Копировать код"; copyBtn.BackgroundColor3 = C.Blue end end)
	end)

	local rmBtn = Instance.new("TextButton")
	rmBtn.Size = UDim2.new(0.38, -4, 0, 28); rmBtn.Position = UDim2.new(0.62, 4, 0, 58)
	rmBtn.BackgroundColor3 = C.Red; rmBtn.BackgroundTransparency = 0.2; rmBtn.BorderSizePixel = 0
	rmBtn.Text = "✕ Убрать"; rmBtn.TextColor3 = C.Text; rmBtn.TextSize = 11
	rmBtn.Font = Enum.Font.GothamBold; rmBtn.AutoButtonColor = false; rmBtn.Parent = card; corner(rmBtn, 7)
	rmBtn.MouseEnter:Connect(function() tw(rmBtn, {BackgroundColor3 = C.RedHover, BackgroundTransparency = 0.1}) end)
	rmBtn.MouseLeave:Connect(function() tw(rmBtn, {BackgroundColor3 = C.Red, BackgroundTransparency = 0.2}) end)
	rmBtn.MouseButton1Click:Connect(function()
		tw(card, {BackgroundTransparency = 1}, 0.2)
		for _, ch in card:GetChildren() do if ch:IsA("TextLabel") or ch:IsA("TextButton") then tw(ch, {TextTransparency = 1}, 0.2) end end
		task.delay(0.25, function() card:Destroy()
			for i, c in copiedCards do if c.card == card then table.remove(copiedCards, i); break end end
			updatePickerStatus()
		end)
	end)

	table.insert(copiedCards, {card = card, object = obj})
	updatePickerStatus()
end

-- ============================================
-- EXPLORER PAGE
-- ============================================
local explorerPage = pages["Explorer"]
local eOrd = 0
local explorerCards = {}
local allFoundModels = {}
local spawnedPreviews = {}

eOrd += 1
local searchBg = Instance.new("Frame")
searchBg.Size = UDim2.new(1, 0, 0, 30); searchBg.BackgroundColor3 = Color3.fromRGB(52,50,48)
searchBg.BackgroundTransparency = T - 0.1; searchBg.BorderSizePixel = 0
searchBg.LayoutOrder = eOrd; searchBg.Parent = explorerPage; corner(searchBg, 8)

local sIcon = Instance.new("TextLabel")
sIcon.Size = UDim2.new(0, 24, 1, 0); sIcon.Position = UDim2.new(0, 6, 0, 0)
sIcon.BackgroundTransparency = 1; sIcon.Text = "⌕"; sIcon.TextColor3 = C.TextDim
sIcon.TextSize = 14; sIcon.Font = Enum.Font.GothamBold; sIcon.Parent = searchBg

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -36, 1, 0); searchBox.Position = UDim2.new(0, 32, 0, 0)
searchBox.BackgroundTransparency = 1; searchBox.Text = ""; searchBox.PlaceholderText = "Поиск моделей..."
searchBox.PlaceholderColor3 = C.TextDark; searchBox.TextColor3 = C.Text; searchBox.TextSize = 12
searchBox.Font = Enum.Font.Gotham; searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false; searchBox.Parent = searchBg

eOrd += 1
local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(1, 0, 0, 34); scanBtn.BackgroundColor3 = C.Purple
scanBtn.BackgroundTransparency = 0.15; scanBtn.BorderSizePixel = 0
scanBtn.Text = "🔍 Найти все модели"; scanBtn.TextColor3 = C.Text
scanBtn.TextSize = 13; scanBtn.Font = Enum.Font.GothamBold; scanBtn.AutoButtonColor = false
scanBtn.LayoutOrder = eOrd; scanBtn.Parent = explorerPage; corner(scanBtn, 8)
scanBtn.MouseEnter:Connect(function() tw(scanBtn, {BackgroundColor3 = C.PurpleHover, BackgroundTransparency = 0.1}) end)
scanBtn.MouseLeave:Connect(function() tw(scanBtn, {BackgroundColor3 = C.Purple, BackgroundTransparency = 0.15}) end)

eOrd += 1
local eStatus = Instance.new("TextLabel")
eStatus.Size = UDim2.new(1, 0, 0, 18); eStatus.BackgroundTransparency = 1; eStatus.Text = "Модели: 0"
eStatus.TextColor3 = C.TextDim; eStatus.TextSize = 11; eStatus.Font = Enum.Font.GothamBold
eStatus.TextXAlignment = Enum.TextXAlignment.Left; eStatus.LayoutOrder = eOrd; eStatus.Parent = explorerPage

eOrd += 1
local ediv = Instance.new("Frame"); ediv.Size = UDim2.new(1, 0, 0, 1)
ediv.BackgroundColor3 = C.Divider; ediv.BackgroundTransparency = 0.5; ediv.BorderSizePixel = 0
ediv.LayoutOrder = eOrd; ediv.Parent = explorerPage

local function deletePreview(p) if p and p.Parent then p:Destroy() end
	for i, v in spawnedPreviews do if v == p then table.remove(spawnedPreviews, i); break end end
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
	table.insert(spawnedPreviews, clone); return clone
end

local function clearExplorerCards()
	for _, card in explorerCards do if card and card.Parent then card:Destroy() end end
	explorerCards = {}
end

local function createExplorerCard(obj, idx)
	local total = countAll(obj); local parts = countParts(obj)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(1, 0, 0, 110); card.BackgroundColor3 = C.Card
	card.BackgroundTransparency = T - 0.1; card.BorderSizePixel = 0
	card.LayoutOrder = 200 + idx; card.Parent = explorerPage; corner(card, 8)

	local nm = Instance.new("TextLabel")
	nm.Size = UDim2.new(1, -16, 0, 18); nm.Position = UDim2.new(0, 10, 0, 6)
	nm.BackgroundTransparency = 1; nm.Text = "📦 "..obj.Name; nm.TextColor3 = C.Text
	nm.TextSize = 13; nm.Font = Enum.Font.GothamBold; nm.TextXAlignment = Enum.TextXAlignment.Left
	nm.TextTruncate = Enum.TextTruncate.AtEnd; nm.Parent = card

	local inf = Instance.new("TextLabel")
	inf.Size = UDim2.new(1, -16, 0, 14); inf.Position = UDim2.new(0, 10, 0, 24)
	inf.BackgroundTransparency = 1; inf.Text = obj.ClassName.." • "..total.." obj • "..parts.." parts"
	inf.TextColor3 = C.TextDim; inf.TextSize = 10; inf.Font = Enum.Font.Gotham
	inf.TextXAlignment = Enum.TextXAlignment.Left; inf.Parent = card

	local pth = Instance.new("TextLabel")
	pth.Size = UDim2.new(1, -16, 0, 11); pth.Position = UDim2.new(0, 10, 0, 38)
	pth.BackgroundTransparency = 1; pth.Text = obj:GetFullName(); pth.TextColor3 = C.TextDark
	pth.TextSize = 9; pth.Font = Enum.Font.Code; pth.TextXAlignment = Enum.TextXAlignment.Left
	pth.TextTruncate = Enum.TextTruncate.AtEnd; pth.Parent = card

	local previewRef = nil

	local spawnBtn = Instance.new("TextButton")
	spawnBtn.Size = UDim2.new(0.32, -3, 0, 26); spawnBtn.Position = UDim2.new(0, 8, 0, 56)
	spawnBtn.BackgroundColor3 = C.Green; spawnBtn.BackgroundTransparency = 0.2; spawnBtn.BorderSizePixel = 0
	spawnBtn.Text = "👁 Призвать"; spawnBtn.TextColor3 = C.Text; spawnBtn.TextSize = 11
	spawnBtn.Font = Enum.Font.GothamBold; spawnBtn.AutoButtonColor = false; spawnBtn.Parent = card; corner(spawnBtn, 7)
	spawnBtn.MouseEnter:Connect(function() tw(spawnBtn, {BackgroundColor3 = C.GreenHover, BackgroundTransparency = 0.1}) end)
	spawnBtn.MouseLeave:Connect(function() tw(spawnBtn, {BackgroundColor3 = C.Green, BackgroundTransparency = 0.2}) end)
	spawnBtn.MouseButton1Click:Connect(function()
		if previewRef and previewRef.Parent then
			deletePreview(previewRef); previewRef = nil; spawnBtn.Text = "👁 Призвать"
		else
			previewRef = spawnPreview(obj)
			if previewRef then spawnBtn.Text = "🗑 Убрать" else spawnBtn.Text = "⚠" end
		end
	end)

	local copyBtn = Instance.new("TextButton")
	copyBtn.Size = UDim2.new(0.36, -3, 0, 26); copyBtn.Position = UDim2.new(0.32, 3, 0, 56)
	copyBtn.BackgroundColor3 = C.Blue; copyBtn.BackgroundTransparency = 0.2; copyBtn.BorderSizePixel = 0
	copyBtn.Text = "📋 Код"; copyBtn.TextColor3 = C.Text; copyBtn.TextSize = 11
	copyBtn.Font = Enum.Font.GothamBold; copyBtn.AutoButtonColor = false; copyBtn.Parent = card; corner(copyBtn, 7)
	copyBtn.MouseEnter:Connect(function() tw(copyBtn, {BackgroundColor3 = C.BlueHover, BackgroundTransparency = 0.1}) end)
	copyBtn.MouseLeave:Connect(function() tw(copyBtn, {BackgroundColor3 = C.Blue, BackgroundTransparency = 0.2}) end)
	copyBtn.MouseButton1Click:Connect(function()
		copyBtn.Text = "⏳"; copyBtn.BackgroundColor3 = C.Accent; task.wait()
		if not obj or not obj.Parent then copyBtn.Text = "⚠"; copyBtn.BackgroundColor3 = C.Red
			task.delay(2, function() if copyBtn.Parent then copyBtn.Text = "📋 Код"; copyBtn.BackgroundColor3 = C.Blue end end); return end
		local code, cnt = genCode(obj)
		local ok = pcall(function() setclipboard(code) end)
		if ok then copyBtn.Text = "✓ "..cnt; copyBtn.BackgroundColor3 = C.Green
		else copyBtn.Text = "⚠"; print(code) end
		task.delay(2, function() if copyBtn.Parent then copyBtn.Text = "📋 Код"; copyBtn.BackgroundColor3 = C.Blue end end)
	end)

	local tpBtn = Instance.new("TextButton")
	tpBtn.Size = UDim2.new(0.32, -3, 0, 26); tpBtn.Position = UDim2.new(0.68, 3, 0, 56)
	tpBtn.BackgroundColor3 = C.Orange; tpBtn.BackgroundTransparency = 0.2; tpBtn.BorderSizePixel = 0
	tpBtn.Text = "📍 TP"; tpBtn.TextColor3 = C.Text; tpBtn.TextSize = 11
	tpBtn.Font = Enum.Font.GothamBold; tpBtn.AutoButtonColor = false; tpBtn.Parent = card; corner(tpBtn, 7)
	tpBtn.MouseEnter:Connect(function() tw(tpBtn, {BackgroundColor3 = C.OrangeHover, BackgroundTransparency = 0.1}) end)
	tpBtn.MouseLeave:Connect(function() tw(tpBtn, {BackgroundColor3 = C.Orange, BackgroundTransparency = 0.2}) end)
	tpBtn.MouseButton1Click:Connect(function()
		local char = LocalPlayer.Character; if not char then return end
		local hr = char:FindFirstChild("HumanoidRootPart"); if not hr then return end
		local tp = nil
		if obj:IsA("BasePart") then tp = obj
		elseif obj:IsA("Model") then
			if obj.PrimaryPart then tp = obj.PrimaryPart end
			if not tp then for _, d in obj:GetDescendants() do if d:IsA("BasePart") then tp = d; break end end end
		end
		if tp then hr.CFrame = tp.CFrame + Vector3.new(0, 5, 0)
			tpBtn.Text = "✓"; task.delay(1, function() if tpBtn.Parent then tpBtn.Text = "📍 TP" end end) end
	end)

	local delBtn = Instance.new("TextButton")
	delBtn.Size = UDim2.new(1, -16, 0, 22); delBtn.Position = UDim2.new(0, 8, 0, 86)
	delBtn.BackgroundColor3 = C.Red; delBtn.BackgroundTransparency = 0.35; delBtn.BorderSizePixel = 0
	delBtn.Text = "🗑 Удалить превью"; delBtn.TextColor3 = C.TextDim; delBtn.TextSize = 10
	delBtn.Font = Enum.Font.GothamMedium; delBtn.AutoButtonColor = false; delBtn.Parent = card; corner(delBtn, 6)
	delBtn.MouseEnter:Connect(function() tw(delBtn, {BackgroundColor3 = C.RedHover, BackgroundTransparency = 0.2}) end)
	delBtn.MouseLeave:Connect(function() tw(delBtn, {BackgroundColor3 = C.Red, BackgroundTransparency = 0.35}) end)
	delBtn.MouseButton1Click:Connect(function()
		if previewRef and previewRef.Parent then
			deletePreview(previewRef); previewRef = nil; spawnBtn.Text = "👁 Призвать"
			delBtn.Text = "✓"; task.delay(1, function() if delBtn.Parent then delBtn.Text = "🗑 Удалить превью" end end)
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
	for i, card in explorerCards do
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
	eStatus.Text = query ~= "" and ("Показано: "..visible.." / "..#allFoundModels) or ("Модели: "..#allFoundModels)
end

scanBtn.MouseButton1Click:Connect(function()
	scanBtn.Text = "⏳..."; scanBtn.BackgroundColor3 = C.Accent; task.wait()
	clearExplorerCards(); allFoundModels = scanModels()
	for i, obj in allFoundModels do createExplorerCard(obj, i) end
	eStatus.Text = "Модели: "..#allFoundModels
	scanBtn.Text = "🔍 Найти все модели"; scanBtn.BackgroundColor3 = C.Purple
end)

searchBox:GetPropertyChangedSignal("Text"):Connect(applyExplorerFilter)

-- ============================================
-- HOTKEYS
-- ============================================
UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.H then
		if currentTarget and currentTarget ~= workspace then
			highlight.FillTransparency = 0.5
			task.delay(0.15, function() highlight.FillTransparency = 0.92 end)
			switchPage("Picker"); createPickerCard(currentTarget)
		end
	end
	if input.KeyCode == Enum.KeyCode.Q then screenGui.Enabled = not screenGui.Enabled end
	if input.KeyCode == Enum.KeyCode.G then
		local order = {"part","model","parent","root"}; local ci = 1
		for i, k in order do if k == pickMode then ci = i end end
		pickMode = order[(ci % #order) + 1]; updateModeUI()
	end
end)

switchPage("Picker")
