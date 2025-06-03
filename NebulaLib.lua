-- NebulaLib.lua
local Nebula = {}
Nebula.__index = Nebula

function Nebula:CreateWindow()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NebulaUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = game:GetService("CoreGui")

	-- Main Window
	local main = Instance.new("Frame")
	main.Name = "MainWindow"
	main.Size = UDim2.new(0, 550, 0, 375)
	main.Position = UDim2.new(0.5, -275, 0.5, -187)
	main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	main.BorderSizePixel = 0
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.ClipsDescendants = true
	main.Parent = screenGui

	local uicorner = Instance.new("UICorner", main)
	uicorner.CornerRadius = UDim.new(0, 12)

	-- Drop Shadow
	local dropShadow = Instance.new("ImageLabel")
	dropShadow.Name = "Shadow"
	dropShadow.Size = UDim2.new(1, 60, 1, 60)
	dropShadow.Position = UDim2.new(0, -30, 0, -30)
	dropShadow.BackgroundTransparency = 1
	dropShadow.Image = "rbxassetid://1316045217"
	dropShadow.ImageTransparency = 0.5
	dropShadow.ZIndex = 0
	dropShadow.Parent = main

	-- Title Bar
	local titleBar = Instance.new("Frame")
	titleBar.Name = "TitleBar"
	titleBar.Size = UDim2.new(1, 0, 0, 40)
	titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
	titleBar.BorderSizePixel = 0
	titleBar.Parent = main

	local titleCorner = Instance.new("UICorner", titleBar)
	titleCorner.CornerRadius = UDim.new(0, 12)

	local title = Instance.new("TextLabel")
	title.Text = "Nebula UI Example"
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18
	title.TextColor3 = Color3.fromRGB(200, 200, 255)
	title.BackgroundTransparency = 1
	title.Position = UDim2.new(0, 10, 0, 4)
	title.Size = UDim2.new(1, -100, 0, 20)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = titleBar

	local subtitle = Instance.new("TextLabel")
	subtitle.Text = "by ttvkaiser"
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextSize = 13
	subtitle.TextColor3 = Color3.fromRGB(140, 140, 200)
	subtitle.BackgroundTransparency = 1
	subtitle.Position = UDim2.new(0, 10, 0, 22)
	subtitle.Size = UDim2.new(1, -100, 0, 16)
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.Parent = titleBar

	-- Control Buttons
	local function createTopButton(text, offset)
		local btn = Instance.new("TextButton")
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 14
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
		btn.Size = UDim2.new(0, 30, 0, 30)
		btn.Position = UDim2.new(1, -offset, 0.5, 0)
		btn.AnchorPoint = Vector2.new(1, 0.5)
		btn.BorderSizePixel = 0
		btn.Parent = titleBar

		local corner = Instance.new("UICorner", btn)
		corner.CornerRadius = UDim.new(0, 6)

		return btn
	end

	local closeBtn = createTopButton("X", 10)
	local minimizeBtn = createTopButton("_", 50)
	local restoreBtn = createTopButton("☐", 90)

	-- Button functionality
	closeBtn.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	minimizeBtn.MouseButton1Click:Connect(function()
		main.Visible = false -- optionally toggle this elsewhere
	end)

	local originalSize = main.Size
	local originalPosition = main.Position
	local restored = true

	restoreBtn.MouseButton1Click:Connect(function()
		if restored then
			main.Size = UDim2.new(0, 300, 0, 200)
			restoreBtn.Text = "🗖"
		else
			main.Size = originalSize
			main.Position = originalPosition
			restoreBtn.Text = "☐"
		end
		restored = not restored
	end)

	-- Dragging logic (titleBar only)
	local dragging, dragInput, dragStart, startPos
	titleBar.InputBegan:Connect(function(input)
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

	titleBar.InputChanged:Connect(function(input)
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
