-- ======================================================
--             ALINUR SCRIPT
-- ======================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clean old GUI
local oldGui = PlayerGui:FindFirstChild("AlinurHub")
if oldGui then oldGui:Destroy() end

-- Instant Steal (ProximityPrompt hold time removal)
local function applyInstantPrompt(prompt)
    if prompt:IsA("ProximityPrompt") then
        prompt.HoldDuration = 0
    end
end

pcall(function()
    for _, prompt in ipairs(workspace:GetDescendants()) do
        applyInstantPrompt(prompt)
    end
end)

workspace.DescendantAdded:Connect(applyInstantPrompt)

-- Sound Effect
local SoundFolder = Instance.new("Folder")
SoundFolder.Name = "AlinurSounds"
SoundFolder.Parent = SoundService

local ClickSound = Instance.new("Sound")
ClickSound.Name = "AlinurClick"
ClickSound.SoundId = "rbxassetid://6026984224"
ClickSound.Volume = 0.35
ClickSound.Parent = SoundFolder

local function PlayClick(speed, volume)
    pcall(function()
        ClickSound:Stop()
        ClickSound.TimePosition = 0
        ClickSound.PlaybackSpeed = speed or 1
        ClickSound.Volume = volume or 0.35
        ClickSound:Play()
    end)
end

local GuiParent = (gethui and gethui()) or (syn and syn.protect_gui and PlayerGui) or PlayerGui

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AlinurHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

local Scale = Instance.new("UIScale")
Scale.Scale = 0.88
Scale.Parent = ScreenGui

-- ======================================================
-- 1. INTRO ANIMATION
-- ======================================================
local DarkOverlay = Instance.new("Frame")
DarkOverlay.Size = UDim2.fromScale(1, 1)
DarkOverlay.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
DarkOverlay.BackgroundTransparency = 1
DarkOverlay.ZIndex = 100
DarkOverlay.Parent = ScreenGui

local IntroCard = Instance.new("Frame")
IntroCard.AnchorPoint = Vector2.new(0.5, 0.5)
IntroCard.Position = UDim2.fromScale(0.5, 0.54)
IntroCard.Size = UDim2.fromOffset(320, 230)
IntroCard.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IntroCard.BackgroundTransparency = 1
IntroCard.ClipsDescendants = true
IntroCard.ZIndex = 101
IntroCard.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 16)
IntroCorner.Parent = IntroCard

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(220, 38, 38)
IntroStroke.Transparency = 1
IntroStroke.Thickness = 1.5
IntroStroke.Parent = IntroCard

-- Intro Logo
local IntroLogo = Instance.new("TextLabel")
IntroLogo.AnchorPoint = Vector2.new(0.5, 0)
IntroLogo.Position = UDim2.new(0.5, 0, 0.04, 0)
IntroLogo.Size = UDim2.fromOffset(60, 60)
IntroLogo.BackgroundTransparency = 1
IntroLogo.Text = "A"
IntroLogo.Font = Enum.Font.FredokaOne
IntroLogo.TextSize = 54
IntroLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroLogo.TextTransparency = 1
IntroLogo.ZIndex = 102
IntroLogo.Parent = IntroCard

local IntroLogoGrad = Instance.new("UIGradient")
IntroLogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 70, 70)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(220, 20, 20)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(120, 0, 0))
})
IntroLogoGrad.Rotation = 90
IntroLogoGrad.Parent = IntroLogo

local IntroLogoStroke = Instance.new("UIStroke")
IntroLogoStroke.Color = Color3.fromRGB(255, 0, 0)
IntroLogoStroke.Thickness = 2
IntroLogoStroke.Transparency = 1
IntroLogoStroke.Parent = IntroLogo

local IntroTitle = Instance.new("TextLabel")
IntroTitle.AnchorPoint = Vector2.new(0.5, 0)
IntroTitle.Position = UDim2.new(0.5, 0, 0.36, 0)
IntroTitle.Size = UDim2.new(0.9, 0, 0, 30)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "ALINUR SCRIPT"
IntroTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroTitle.TextTransparency = 1
IntroTitle.Font = Enum.Font.FredokaOne
IntroTitle.TextSize = 24
IntroTitle.ZIndex = 102
IntroTitle.Parent = IntroCard

local IntroGrad = Instance.new("UIGradient")
IntroGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(239, 68, 68)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(185, 28, 28))
})
IntroGrad.Parent = IntroTitle

local IntroSub = Instance.new("TextLabel")
IntroSub.AnchorPoint = Vector2.new(0.5, 0)
IntroSub.Position = UDim2.new(0.5, 0, 0.52, 0)
IntroSub.Size = UDim2.new(0.9, 0, 0, 18)
IntroSub.BackgroundTransparency = 1
IntroSub.Text = ""
IntroSub.TextColor3 = Color3.fromRGB(148, 163, 184)
IntroSub.TextTransparency = 1
IntroSub.Font = Enum.Font.FredokaOne
IntroSub.TextSize = 12
IntroSub.ZIndex = 102
IntroSub.Parent = IntroCard

local ProgressBg = Instance.new("Frame")
ProgressBg.AnchorPoint = Vector2.new(0.5, 0)
ProgressBg.Position = UDim2.new(0.5, 0, 0.72, 0)
ProgressBg.Size = UDim2.new(0.8, 0, 0, 5)
ProgressBg.BackgroundColor3 = Color3.fromRGB(35, 25, 30)
ProgressBg.BackgroundTransparency = 1
ProgressBg.ZIndex = 102
ProgressBg.Parent = IntroCard

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = ProgressBg

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
ProgressFill.BackgroundTransparency = 1
ProgressFill.ZIndex = 103
ProgressFill.Parent = ProgressBg

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = ProgressFill

local StatusText = Instance.new("TextLabel")
StatusText.AnchorPoint = Vector2.new(0.5, 0)
StatusText.Position = UDim2.new(0.5, 0, 0.82, 0)
StatusText.Size = UDim2.new(0.8, 0, 0, 14)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Loading..."
StatusText.TextColor3 = Color3.fromRGB(156, 163, 175)
StatusText.TextTransparency = 1
StatusText.Font = Enum.Font.GothamBold
StatusText.TextSize = 11
StatusText.ZIndex = 102
StatusText.Parent = IntroCard

-- ======================================================
-- 2. MAIN FRAME
-- ======================================================
local Themes = {
    {Name = "Crimson Red", Main = Color3.fromRGB(15, 15, 20), Panel = Color3.fromRGB(30, 25, 30), Accent = Color3.fromRGB(220, 38, 38), DarkBtn = Color3.fromRGB(153, 27, 27)},
    {Name = "Neon Cyan", Main = Color3.fromRGB(15, 23, 42), Panel = Color3.fromRGB(30, 41, 59), Accent = Color3.fromRGB(6, 182, 212), DarkBtn = Color3.fromRGB(14, 116, 144)},
    {Name = "Cyber Purple", Main = Color3.fromRGB(18, 16, 38), Panel = Color3.fromRGB(33, 29, 66), Accent = Color3.fromRGB(168, 85, 247), DarkBtn = Color3.fromRGB(126, 34, 206)},
    {Name = "Emerald Green", Main = Color3.fromRGB(15, 23, 20), Panel = Color3.fromRGB(24, 46, 37), Accent = Color3.fromRGB(16, 185, 129), DarkBtn = Color3.fromRGB(4, 120, 87)},
    {Name = "Alinur Gold", Main = Color3.fromRGB(28, 25, 18), Panel = Color3.fromRGB(48, 41, 26), Accent = Color3.fromRGB(245, 158, 11), DarkBtn = Color3.fromRGB(180, 83, 9)},
}
local CurrentThemeIndex = 1
local SizeIndex = 2
local Sizes = {
    UDim2.fromOffset(300, 280),
    UDim2.fromOffset(340, 330),
    UDim2.fromOffset(390, 380),
}

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.48)
MainFrame.Size = Sizes[SizeIndex]
MainFrame.BackgroundColor3 = Themes[CurrentThemeIndex].Main
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Themes[CurrentThemeIndex].Accent
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

-- TopBar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1
TopBar.Parent = MainFrame

local HeaderLogo = Instance.new("TextLabel")
HeaderLogo.Position = UDim2.fromOffset(14, 11)
HeaderLogo.Size = UDim2.fromOffset(26, 26)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Text = "A"
HeaderLogo.Font = Enum.Font.FredokaOne
HeaderLogo.TextSize = 24
HeaderLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderLogo.Parent = TopBar

local HeaderLogoGrad = Instance.new("UIGradient")
HeaderLogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 0, 0))
})
HeaderLogoGrad.Rotation = 90
HeaderLogoGrad.Parent = HeaderLogo

local HeaderLogoStroke = Instance.new("UIStroke")
HeaderLogoStroke.Color = Color3.fromRGB(255, 0, 0)
HeaderLogoStroke.Thickness = 1.2
HeaderLogoStroke.Transparency = 0.2
HeaderLogoStroke.Parent = HeaderLogo

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Position = UDim2.fromOffset(46, 14)
TitleLabel.Size = UDim2.new(0.55, 0, 0, 22)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ALINUR SCRIPT"
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Themes[CurrentThemeIndex].Accent
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local function createTopBtn(txt, xOffset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(28, 28)
    btn.Position = UDim2.new(1, xOffset, 0, 10)
    btn.AnchorPoint = Vector2.new(1, 0)
    btn.BackgroundColor3 = Themes[CurrentThemeIndex].Panel
    btn.BorderSizePixel = 0
    btn.Text = txt
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false
    btn.Parent = TopBar
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    return btn
end

local MinBtn = createTopBtn("—", -48)
local CloseBtn = createTopBtn("×", -12)

-- Content Container
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Position = UDim2.new(0, 12, 0, 52)
ContentArea.Size = UDim2.new(1, -24, 1, -64)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 3
ContentArea.ScrollBarImageColor3 = Themes[CurrentThemeIndex].Accent
ContentArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentArea.ScrollingDirection = Enum.ScrollingDirection.Y
ContentArea.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentArea

local ContentPad = Instance.new("UIPadding")
ContentPad.PaddingRight = UDim.new(0, 4)
ContentPad.PaddingBottom = UDim.new(0, 10)
ContentPad.Parent = ContentArea

local function addSectionHeader(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 18)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.FredokaOne
    l.TextSize = 11
    l.TextColor3 = Color3.fromRGB(148, 163, 184)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = ContentArea
    return l
end

-- ======================================================
-- 3. SCRIPTS / FEATURES SECTION
-- ======================================================
addSectionHeader("SCRIPTS & FEATURES")

local AntiHitEnabled = false
local IsAntiHitRunning = false
local ANTI_HIT_SPEED = 0.005

local TeleportPoints = {
    Vector3.new(500.62, 241.28, -366.64),
    Vector3.new(504.45, 155.80, -366.35),
    Vector3.new(508.30, 70.28, -366.03),
    Vector3.new(513.86, 70.28, -366.25),
    Vector3.new(519.43, 70.28, -366.47),
    Vector3.new(524.32, 70.28, -366.59),
    Vector3.new(529.22, 70.28, -366.71),
    Vector3.new(538.01, 70.28, -365.55),
    Vector3.new(546.80, 70.28, -364.40)
}

local function TeleportRoute(character)
    if not character then return end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    IsAntiHitRunning = true
    for _, position in ipairs(TeleportPoints) do
        if not AntiHitEnabled or not root.Parent then
            IsAntiHitRunning = false
            return
        end
        root.CFrame = CFrame.new(position)
        task.wait(ANTI_HIT_SPEED)
    end
    IsAntiHitRunning = false
end

ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
    if player ~= LocalPlayer then return end
    if not AntiHitEnabled or IsAntiHitRunning then return end
    local character = LocalPlayer.Character
    if character then
        task.spawn(function() TeleportRoute(character) end)
    end
end)

-- Anti-Hit Card Button
local AntiHitCard = Instance.new("TextButton")
AntiHitCard.Size = UDim2.new(1, 0, 0, 52)
AntiHitCard.BackgroundColor3 = Themes[CurrentThemeIndex].DarkBtn
AntiHitCard.BorderSizePixel = 0
AntiHitCard.Text = ""
AntiHitCard.AutoButtonColor = false
AntiHitCard.Parent = ContentArea

local AntiHitCorner = Instance.new("UICorner")
AntiHitCorner.CornerRadius = UDim.new(0, 10)
AntiHitCorner.Parent = AntiHitCard

local AntiHitTitle = Instance.new("TextLabel")
AntiHitTitle.Position = UDim2.fromOffset(12, 6)
AntiHitTitle.Size = UDim2.new(1, -24, 0, 20)
AntiHitTitle.BackgroundTransparency = 1
AntiHitTitle.Text = "🛡 ANTI-HIT"
AntiHitTitle.Font = Enum.Font.FredokaOne
AntiHitTitle.TextSize = 13
AntiHitTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiHitTitle.TextXAlignment = Enum.TextXAlignment.Left
AntiHitTitle.Parent = AntiHitCard

local AntiHitStatus = Instance.new("TextLabel")
AntiHitStatus.Position = UDim2.fromOffset(12, 26)
AntiHitStatus.Size = UDim2.new(1, -24, 0, 16)
AntiHitStatus.BackgroundTransparency = 1
AntiHitStatus.Text = "STATUS: OFF"
AntiHitStatus.Font = Enum.Font.FredokaOne
AntiHitStatus.TextSize = 10
AntiHitStatus.TextColor3 = Color3.fromRGB(239, 68, 68)
AntiHitStatus.TextXAlignment = Enum.TextXAlignment.Left
AntiHitStatus.Parent = AntiHitCard

AntiHitCard.Activated:Connect(function()
    PlayClick()
    AntiHitEnabled = not AntiHitEnabled
    if AntiHitEnabled then
        AntiHitStatus.Text = "STATUS: ON ✓"
        AntiHitStatus.TextColor3 = Color3.fromRGB(34, 197, 94)
        AntiHitCard.BackgroundColor3 = Color3.fromRGB(22, 101, 52)
    else
        AntiHitStatus.Text = "STATUS: OFF"
        AntiHitStatus.TextColor3 = Color3.fromRGB(239, 68, 68)
        AntiHitCard.BackgroundColor3 = Themes[CurrentThemeIndex].DarkBtn
    end
end)

-- ======================================================
-- 4. SETTINGS & CONFIG SECTION
-- ======================================================
addSectionHeader("SETTINGS & CONFIG")

addSectionHeader("UI SIZE")
local SizeRow = Instance.new("Frame")
SizeRow.Size = UDim2.new(1, 0, 0, 34)
SizeRow.BackgroundTransparency = 1
SizeRow.Parent = ContentArea

local SizeNames = {"SMALL", "MEDIUM", "LARGE"}
for i, name in ipairs(SizeNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.31, 0, 1, 0)
    btn.Position = UDim2.new((i - 1) * 0.34, 0, 0, 0)
    btn.BackgroundColor3 = Themes[CurrentThemeIndex].Panel
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 10
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = SizeRow

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    btn.Activated:Connect(function()
        PlayClick()
        SizeIndex = i
        MainFrame.Size = Sizes[SizeIndex]
    end)
end

addSectionHeader("THEME SELECT")
for i, th in ipairs(Themes) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = th.Accent
    btn.BorderSizePixel = 0
    btn.Text = th.Name
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = ContentArea

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn

    btn.Activated:Connect(function()
        PlayClick()
        CurrentThemeIndex = i
        MainFrame.BackgroundColor3 = th.Main
        MainStroke.Color = th.Accent
        TitleLabel.TextColor3 = th.Accent
        ContentArea.ScrollBarImageColor3 = th.Accent
        MinBtn.BackgroundColor3 = th.Panel
        CloseBtn.BackgroundColor3 = th.Panel
        OpenStroke.Color = th.Accent
        if not AntiHitEnabled then
            AntiHitCard.BackgroundColor3 = th.DarkBtn
        end
    end)
end

-- ======================================================
-- 5. TOGGLE BUTTON & DRAGGING
-- ======================================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenAlinur"
OpenBtn.AnchorPoint = Vector2.new(1, 0.5)
OpenBtn.Position = UDim2.new(1, -16, 0.5, 0)
OpenBtn.Size = UDim2.fromOffset(58, 58)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
OpenBtn.BorderSizePixel = 0
OpenBtn.Text = "A"
OpenBtn.Font = Enum.Font.FredokaOne
OpenBtn.TextSize = 34
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false
OpenBtn.ZIndex = 85
OpenBtn.Parent = ScreenGui

local OpenGrad = Instance.new("UIGradient")
OpenGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 70, 70)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 0, 0))
})
OpenGrad.Rotation = 90
OpenGrad.Parent = OpenBtn

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 2
OpenStroke.Color = Themes[CurrentThemeIndex].Accent
OpenStroke.Parent = OpenBtn

local Dragging = false
local DragStart, StartPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

CloseBtn.Activated:Connect(function()
    PlayClick()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

MinBtn.Activated:Connect(function()
    PlayClick()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.Activated:Connect(function()
    PlayClick()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- ======================================================
-- 6. INTRO ANIMATION & DISPLAY
-- ======================================================
local tweenFast = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenPop = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

TweenService:Create(DarkOverlay, tweenFast, {BackgroundTransparency = 0.4}):Play()
TweenService:Create(IntroCard, tweenPop, {Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 0.05}):Play()
TweenService:Create(IntroStroke, tweenFast, {Transparency = 0.2}):Play()
task.wait(0.15)

TweenService:Create(IntroLogo, tweenFast, {TextTransparency = 0}):Play()
TweenService:Create(IntroLogoStroke, tweenFast, {Transparency = 0}):Play()
TweenService:Create(IntroTitle, tweenFast, {TextTransparency = 0}):Play()
TweenService:Create(IntroSub, tweenFast, {TextTransparency = 0}):Play()
TweenService:Create(ProgressBg, tweenFast, {BackgroundTransparency = 0}):Play()
TweenService:Create(ProgressFill, tweenFast, {BackgroundTransparency = 0}):Play()
TweenService:Create(StatusText, tweenFast, {TextTransparency = 0}):Play()

StatusText.Text = "Loading script..."
TweenService:Create(ProgressFill, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.8)

StatusText.Text = "ALINUR STUDIO • READY"
StatusText.TextColor3 = Color3.fromRGB(34, 197, 94)
task.wait(0.6)

TweenService:Create(IntroCard, tweenFast, {BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.45)}):Play()
TweenService:Create(DarkOverlay, tweenFast, {BackgroundTransparency = 1}):Play()
TweenService:Create(IntroLogo, tweenFast, {TextTransparency = 1}):Play()
TweenService:Create(IntroLogoStroke, tweenFast, {Transparency = 1}):Play()
TweenService:Create(IntroTitle, tweenFast, {TextTransparency = 1}):Play()
TweenService:Create(IntroSub, tweenFast, {TextTransparency = 1}):Play()
TweenService:Create(ProgressBg, tweenFast, {BackgroundTransparency = 1}):Play()
TweenService:Create(ProgressFill, tweenFast, {BackgroundTransparency = 1}):Play()
TweenService:Create(StatusText, tweenFast, {TextTransparency = 1}):Play()

task.wait(0.4)
DarkOverlay:Destroy()
IntroCard:Destroy()

MainFrame.Visible = true
