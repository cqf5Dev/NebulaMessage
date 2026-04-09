local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function ShowNebulaExecuted()
    local gui = Instance.new("ScreenGui")
    gui.Name = "NebulaMiniNotify"
    gui.Parent = playerGui

    -- Kompakter Hauptframe
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 280, 0, 45) 
    main.Position = UDim2.new(1, 350, 1, -20) -- Startet rechts außen
    main.AnchorPoint = Vector2.new(1, 1)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    main.BorderSizePixel = 0
    main.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = main

    -- Lila Glow Umrandung
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.2
    stroke.Color = Color3.fromRGB(100, 0, 255)
    stroke.Parent = main

    -- NEBULA Text (Links)
    local nebulaLabel = Instance.new("TextLabel")
    nebulaLabel.Size = UDim2.new(0, 80, 1, 0)
    nebulaLabel.Position = UDim2.new(0, 10, 0, 0)
    nebulaLabel.Text = "NEBULA"
    nebulaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nebulaLabel.Font = Enum.Font.GothamBold
    nebulaLabel.TextSize = 14
    nebulaLabel.TextXAlignment = Enum.TextXAlignment.Left
    nebulaLabel.BackgroundTransparency = 1
    nebulaLabel.Parent = main

    -- Trennlinie
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(0, 1, 0, 20)
    divider.Position = UDim2.new(0, 85, 0.5, 0)
    divider.AnchorPoint = Vector2.new(0, 0.5)
    divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    divider.BorderSizePixel = 0
    divider.Parent = main

    -- Status Text (Rechts)
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -100, 1, 0)
    statusLabel.Position = UDim2.new(0, 95, 0, 0)
    statusLabel.Text = "SCRIPT EXECUTED"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.BackgroundTransparency = 1
    statusLabel.Parent = main

    -- Animation: Reinsliden
    local tInfoIn = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(main, tInfoIn, {Position = UDim2.new(1, -20, 1, -20)}):Play()

    -- Warten und Verschwinden
    task.wait(3)

    local tInfoOut = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    local fade = TweenService:Create(main, tInfoOut, {Position = UDim2.new(1, 350, 1, -20)})
    
    fade:Play()
    fade.Completed:Connect(function()
        gui:Destroy()
    end)
end

-- Start
ShowNebulaExecuted()
