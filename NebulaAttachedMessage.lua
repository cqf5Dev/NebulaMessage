local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "NebulaAdvancedNotify"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function CreateNotification()
	-- 1. Haupt-Frame mit Schatten-Effekt (UIStroke Missbrauch für Glow)
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 420, 0, 100)
	mainFrame.Position = UDim2.new(1, 500, 1, -20) -- Startet weit rechts
	mainFrame.AnchorPoint = Vector2.new(1, 1)
	mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = mainFrame

	-- Subtiles Leuchten (Glow)
	local glow = Instance.new("UIStroke")
	glow.Thickness = 3
	glow.Color = Color3.fromRGB(80, 0, 200) -- Lila-Glow (passend zu Nebula)
	glow.Transparency = 0.5
	glow.Parent = mainFrame

	-- 2. Avatar & Info
	local avatarImage = Instance.new("ImageLabel")
	avatarImage.Size = UDim2.new(0, 60, 0, 60)
	avatarImage.Position = UDim2.new(0, 15, 0.5, 0)
	avatarImage.AnchorPoint = Vector2.new(0, 0.5)
	avatarImage.BackgroundTransparency = 1
	avatarImage.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	avatarImage.Parent = mainFrame

	local avatarCorner = Instance.new("UICorner")
	avatarCorner.CornerRadius = UDim.new(1, 0)
	avatarCorner.Parent = avatarImage

	local textContainer = Instance.new("Frame")
	textContainer.Size = UDim2.new(0, 200, 1, 0)
	textContainer.Position = UDim2.new(0, 90, 0, 0)
	textContainer.BackgroundTransparency = 1
	textContainer.Parent = mainFrame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0.5, 0)
	title.Position = UDim2.new(0, 0, 0.2, 0)
	title.Text = "[NEBULA] ATTACHED"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = textContainer

	local user = Instance.new("TextLabel")
	user.Size = UDim2.new(1, 0, 0.5, 0)
	user.Position = UDim2.new(0, 0, 0.5, 0)
	user.Text = "Welcome, " .. player.DisplayName
	user.TextColor3 = Color3.fromRGB(150, 150, 150)
	user.Font = Enum.Font.Gotham
	user.TextSize = 14
	user.TextXAlignment = Enum.TextXAlignment.Left
	user.BackgroundTransparency = 1
	user.Parent = textContainer

	-- 3. Das Ketten-Icon (mit Puls-Animation)
	local chainIcon = Instance.new("ImageLabel")
	chainIcon.Size = UDim2.new(0, 35, 0, 35)
	chainIcon.Position = UDim2.new(1, -40, 0.5, 0)
	chainIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	chainIcon.BackgroundTransparency = 1
	chainIcon.Image = "rbxassetid://6034287525"
	chainIcon.ImageColor3 = Color3.fromRGB(200, 200, 200)
	chainIcon.Parent = mainFrame

	return mainFrame, chainIcon, glow
end

local function Show()
	local frame, icon, glow = CreateNotification()
	
	-- 1. Animation: Elastic Slide-In (Federt leicht nach)
	local slideInInfo = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
	TweenService:Create(frame, slideInInfo, {Position = UDim2.new(1, -20, 1, -20)}):Play()

	-- 2. Animation: Pulsierendes Icon & Glow
	local pulseInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	TweenService:Create(icon, pulseInfo, {Size = UDim2.new(0, 42, 0, 42), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(glow, pulseInfo, {Transparency = 0.2, Thickness = 5}):Play()

	task.wait(4)

	-- 3. Animation: Slide-Out (Schnell nach rechts weg)
	local slideOutInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In)
	local hide = TweenService:Create(frame, slideOutInfo, {Position = UDim2.new(1, 500, 1, -20)})
	hide:Play()
	hide.Completed:Connect(function() frame:Destroy() end)
end

-- Start
task.wait(1)
Show()
