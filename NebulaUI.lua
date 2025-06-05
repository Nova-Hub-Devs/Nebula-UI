local NebulaUI = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

function NebulaUI:CreateWindow()
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	ScreenGui.Name = "NebulaUI"
	ScreenGui.ResetOnSpawn = false

	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Size = UDim2.new(0, 500, 0, 400)
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	MainFrame.BorderSizePixel = 0
	MainFrame.Name = "MainFrame"
	MainFrame.Active = true
	MainFrame.Draggable = true

	local TitleBar = Instance.new("Frame", MainFrame)
	TitleBar.Size = UDim2.new(1, 0, 0, 40)
	TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	TitleBar.BorderSizePixel = 0
	TitleBar.Name = "TitleBar"

	local Title = Instance.new("TextLabel", TitleBar)
	Title.Size = UDim2.new(1, -80, 0, 25)
	Title.Position = UDim2.new(0, 10, 0, 5)
	Title.Text = "Nebula UI Example"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18
	Title.Font = Enum.Font.GothamSemibold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.BackgroundTransparency = 1

	local Subtitle = Instance.new("TextLabel", TitleBar)
	Subtitle.Size = UDim2.new(1, -80, 0, 15)
	Subtitle.Position = UDim2.new(0, 10, 0, 25)
	Subtitle.Text = ", by ttvkaiser"
	Subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
	Subtitle.TextSize = 12
	Subtitle.Font = Enum.Font.Gotham
	Subtitle.TextXAlignment = Enum.TextXAlignment.Left
	Subtitle.BackgroundTransparency = 1

	local closeButton = Instance.new("TextButton", TitleBar)
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -35, 0, 5)
	closeButton.Text = "X"
	closeButton.Font = Enum.Font.Gotham
	closeButton.TextColor3 = Color3.fromRGB(255, 80, 80)
	closeButton.TextSize = 14
	closeButton.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
	closeButton.BorderSizePixel = 0
	closeButton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	local minimizeButton = Instance.new("TextButton", TitleBar)
	minimizeButton.Size = UDim2.new(0, 30, 0, 30)
	minimizeButton.Position = UDim2.new(1, -70, 0, 5)
	minimizeButton.Text = "_"
	minimizeButton.Font = Enum.Font.Gotham
	minimizeButton.TextColor3 = Color3.fromRGB(180, 180, 180)
	minimizeButton.TextSize = 14
	minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	minimizeButton.BorderSizePixel = 0

	local Content = Instance.new("Frame", MainFrame)
	Content.Size = UDim2.new(1, 0, 1, -40)
	Content.Position = UDim2.new(0, 0, 0, 40)
	Content.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
	Content.BorderSizePixel = 0

	local mainTab = Instance.new("ScrollingFrame", Content)
	mainTab.Name = "MainTab"
	mainTab.Size = UDim2.new(1, 0, 1, 0)
	mainTab.CanvasSize = UDim2.new(0, 0, 0, 0)
	mainTab.ScrollBarThickness = 6
	mainTab.BackgroundTransparency = 1
	local layout = Instance.new("UIListLayout", mainTab)
	layout.Padding = UDim.new(0, 6)

	-- Hide/show with minimize
	local isMinimized = false
	minimizeButton.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized
		Content.Visible = not isMinimized
	end)

	-- Tab methods
	local function AddButton(text, callback)
		local btn = Instance.new("TextButton", mainTab)
		btn.Size = UDim2.new(1, -10, 0, 30)
		btn.Position = UDim2.new(0, 5, 0, 0)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
		btn.BorderSizePixel = 0
		btn.Text = text
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.Gotham
		btn.TextSize = 14
		btn.MouseButton1Click:Connect(callback)
	end

	local function AddToggle(text, callback)
		local state = false
		local toggle = Instance.new("TextButton", mainTab)
		toggle.Size = UDim2.new(1, -10, 0, 30)
		toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
		toggle.BorderSizePixel = 0
		toggle.Text = text .. ": OFF"
		toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		toggle.Font = Enum.Font.Gotham
		toggle.TextSize = 14
		toggle.MouseButton1Click:Connect(function()
			state = not state
			toggle.Text = text .. ": " .. (state and "ON" or "OFF")
			callback(state)
		end)
	end

	local function AddTextBox(placeholder, callback)
		local box = Instance.new("TextBox", mainTab)
		box.Size = UDim2.new(1, -10, 0, 30)
		box.PlaceholderText = placeholder
		box.Text = ""
		box.Font = Enum.Font.Gotham
		box.TextSize = 14
		box.TextColor3 = Color3.fromRGB(255, 255, 255)
		box.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
		box.BorderSizePixel = 0
		box.FocusLost:Connect(function(enterPressed)
			if enterPressed then
				callback(box.Text)
			end
		end)
	end

	local function AddSlider(name, min, max, callback)
		local holder = Instance.new("Frame", mainTab)
		holder.Size = UDim2.new(1, -10, 0, 30)
		holder.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
		holder.BorderSizePixel = 0

		local label = Instance.new("TextLabel", holder)
		label.Size = UDim2.new(0.4, 0, 1, 0)
		label.Text = name .. ": " .. min
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.BackgroundTransparency = 1
		label.Font = Enum.Font.Gotham
		label.TextSize = 14
		label.TextXAlignment = Enum.TextXAlignment.Left

		local slider = Instance.new("TextButton", holder)
		slider.Position = UDim2.new(0.45, 0, 0.2, 0)
		slider.Size = UDim2.new(0.5, 0, 0.6, 0)
		slider.Text = tostring(min)
		slider.TextColor3 = Color3.fromRGB(255, 255, 255)
		slider.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
		slider.BorderSizePixel = 0
		slider.Font = Enum.Font.Gotham
		slider.TextSize = 14

		slider.MouseButton1Click:Connect(function()
			local next = math.clamp(tonumber(slider.Text) + 1, min, max)
			if next then
				slider.Text = tostring(next)
				label.Text = name .. ": " .. next
				callback(next)
			end
		end)
	end

	return {
		AddButton = AddButton,
		AddToggle = AddToggle,
		AddTextBox = AddTextBox,
		AddSlider = AddSlider
	}
end

return NebulaUI
