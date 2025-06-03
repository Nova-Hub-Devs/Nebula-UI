-- NebulaLib.lua
local Nebula = {}
Nebula.__index = Nebula

function Nebula:CreateWindow(settings)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NebulaUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = game:GetService("CoreGui")

	local main = Instance.new("Frame")
	main.Name = "MainWindow"
	main.Size = settings.Size or UDim2.new(0, 500, 0, 300)
	main.Position = UDim2.new(0.5, -main.Size.X.Offset/2, 0.5, -main.Size.Y.Offset/2)
	main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	main.BorderSizePixel = 0
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.ClipsDescendants = true
	main.Parent = screenGui

	-- Add this inside your CreateWindow function, right after creating `main`:

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundTransparency = 1
topBar.Parent = main

-- Button base styling helper
local function createTopButton(name, symbol, position)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Text = symbol
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(200, 200, 255)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	btn.Size = UDim2.new(0, 30, 0, 30)
	btn.Position = position
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.BackgroundTransparency = 0.1
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	btn.Parent = topBar

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 6)

	return btn
end

-- Create the buttons
local padding = 10
local closeBtn = createTopButton("CloseButton", "X", UDim2.new(1, -padding, 0.5, 0))
local minimizeBtn = createTopButton("MinimizeButton", "_", UDim2.new(1, -padding - 35, 0.5, 0))
local restoreBtn = createTopButton("RestoreButton", "☐", UDim2.new(1, -padding - 70, 0.5, 0))

-- Functionality
closeBtn.MouseButton1Click:Connect(function()
	main.Visible = false -- or screenGui:Destroy() to fully close
end)

minimizeBtn.MouseButton1Click:Connect(function()
	main.Visible = false -- optional: toggle button elsewhere to show again
end)

local originalSize = main.Size
local originalPosition = main.Position
local isRestored = true

restoreBtn.MouseButton1Click:Connect(function()
	if isRestored then
		main.Size = UDim2.new(0, 300, 0, 200)
		restoreBtn.Text = "🗖" -- visually indicate "maximize"
	else
		main.Size = originalSize
		main.Position = originalPosition
		restoreBtn.Text = "☐" -- back to restore icon
	end
	isRestored = not isRestored
end)

	local uicorner = Instance.new("UICorner", main)
	uicorner.CornerRadius = UDim.new(0, 12)

	local dropShadow = Instance.new("ImageLabel")
	dropShadow.Name = "Shadow"
	dropShadow.Size = UDim2.new(1, 60, 1, 60)
	dropShadow.Position = UDim2.new(0, -30, 0, -30)
	dropShadow.BackgroundTransparency = 1
	dropShadow.Image = "rbxassetid://1316045217" -- soft shadow
	dropShadow.ImageTransparency = 0.5
	dropShadow.ZIndex = 0
	dropShadow.Parent = main

	local title = Instance.new("TextLabel")
	title.Text = settings.Name or "Nebula Window"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 20
	title.TextColor3 = Color3.fromRGB(200, 200, 255)
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0, 10, 0, 8)
	title.Size = UDim2.new(1, -20, 0, 25)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = main

	local subtitle = Instance.new("TextLabel")
	subtitle.Text = settings.Subtitle or ""
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextSize = 14
	subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
	subtitle.BackgroundTransparency = 1
	subtitle.Position = UDim2.new(0, 10, 0, 30)
	subtitle.Size = UDim2.new(1, -20, 0, 20)
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.Parent = main

	-- Dragging Logic
	local dragging, dragInput, dragStart, startPos

	main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

	main.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)

	return setmetatable({}, Nebula)
end

return Nebula
