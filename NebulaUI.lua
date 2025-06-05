local NebulaUI = {}

function NebulaUI:CreateWindow(title, config)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "NebulaUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.CoreGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = config and config.size or UDim2.new(0, 500, 0, 400)
	mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = ScreenGui

	local titleBar = Instance.new("TextLabel")
	titleBar.Size = UDim2.new(1, 0, 0, 40)
	titleBar.BackgroundTransparency = 1
	titleBar.Text = title or "Nebula UI"
	titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleBar.Font = Enum.Font.GothamSemibold
	titleBar.TextSize = 20
	titleBar.Parent = mainFrame

	local tabContainer = Instance.new("Frame")
	tabContainer.Position = UDim2.new(0, 0, 0, 40)
	tabContainer.Size = UDim2.new(0, 120, 1, -40)
	tabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
	tabContainer.BorderSizePixel = 0
	tabContainer.Parent = mainFrame

	local contentFrame = Instance.new("Frame")
	contentFrame.Position = UDim2.new(0, 120, 0, 40)
	contentFrame.Size = UDim2.new(1, -120, 1, -40)
	contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	contentFrame.BorderSizePixel = 0
	contentFrame.Parent = mainFrame

	local function createTab(name)
		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(1, 0, 0, 30)
		tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
		tabButton.BorderSizePixel = 0
		tabButton.Text = name
		tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		tabButton.Font = Enum.Font.Gotham
		tabButton.TextSize = 14
		tabButton.Parent = tabContainer

		local tabContent = Instance.new("ScrollingFrame")
		tabContent.Size = UDim2.new(1, 0, 1, 0)
		tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabContent.ScrollBarThickness = 6
		tabContent.BackgroundTransparency = 1
		tabContent.Visible = false
		tabContent.Parent = contentFrame

		local layout = Instance.new("UIListLayout", tabContent)
		layout.Padding = UDim.new(0, 5)

		tabButton.MouseButton1Click:Connect(function()
			for _, child in pairs(contentFrame:GetChildren()) do
				if child:IsA("ScrollingFrame") then
					child.Visible = false
				end
			end
			tabContent.Visible = true
		end)

		return {
			AddButton = function(_, text, callback)
				local button = Instance.new("TextButton")
				button.Size = UDim2.new(1, -10, 0, 30)
				button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
				button.BorderSizePixel = 0
				button.Text = text
				button.TextColor3 = Color3.fromRGB(255, 255, 255)
				button.Font = Enum.Font.Gotham
				button.TextSize = 14
				button.Parent = tabContent
				button.MouseButton1Click:Connect(callback)
			end,

			AddSwitch = function(_, text, callback)
				local switch = Instance.new("TextButton")
				switch.Size = UDim2.new(1, -10, 0, 30)
				switch.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
				switch.BorderSizePixel = 0
				switch.Text = text .. ": OFF"
				switch.TextColor3 = Color3.fromRGB(255, 255, 255)
				switch.Font = Enum.Font.Gotham
				switch.TextSize = 14
				switch.Parent = tabContent

				local state = false
				switch.MouseButton1Click:Connect(function()
					state = not state
					switch.Text = text .. ": " .. (state and "ON" or "OFF")
					callback(state)
				end)
			end,
		}
	end

	return {
		AddTab = createTab
	}
end

return NebulaUI
