-- NebulaUI.lua
local NebulaUI = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create main window
function NebulaUI:CreateWindow(title, config)
	local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
	ScreenGui.Name = "NebulaUI"
	ScreenGui.ResetOnSpawn = false

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 600, 0, 400)
	MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	MainFrame.BorderSizePixel = 0
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner", MainFrame)
	UICorner.CornerRadius = UDim.new(0, 10)

	local Title = Instance.new("TextLabel", MainFrame)
	Title.Text = title or "Nebula UI"
	Title.Font = Enum.Font.GothamSemibold
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.TextSize = 22

	return {
		Main = MainFrame,
		AddButton = function(_, text, callback)
			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, -20, 0, 40)
			Button.Position = UDim2.new(0, 10, 0, #MainFrame:GetChildren() * 45)
			Button.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
			Button.Text = text
			Button.Font = Enum.Font.Gotham
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 18
			Button.Parent = MainFrame

			local Corner = Instance.new("UICorner", Button)
			Corner.CornerRadius = UDim.new(0, 6)

			Button.MouseButton1Click:Connect(function()
				if callback then
					callback()
				end
			end)
		end
	}
end

return NebulaUI
