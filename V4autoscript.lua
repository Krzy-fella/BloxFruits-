-- 🌟 Nana's Blox Fruits V4 Auto Handler with Progress Bar 🌟
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local playerGui = lp:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "V4Controller"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 180, 0, 80)
frame.Position = UDim2.new(0.5, -90, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true

-- Toggle Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, 0, 0.5, 0)
button.Position = UDim2.new(0, 0, 0, 0)
button.Text = "V4: OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

-- Progress Bar
local progressFrame = Instance.new("Frame", frame)
progressFrame.Position = UDim2.new(0, 10, 0.55, 0)
progressFrame.Size = UDim2.new(1, -20, 0, 20)
progressFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

local progressBar = Instance.new("Frame", progressFrame)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Position = UDim2.new(0, 0, 1, -20)
statusLabel.Size = UDim2.new(1, 0, 0, 20)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Status: Waiting..."

-- State
local v4Active = false
local killAuraRunning = false

-- Kill Aura
function killAura(radius)
    killAuraRunning = true
    spawn(function()
        while killAuraRunning and v4Active do
            for _, npc in pairs(workspace.Enemies:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    if (npc.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude < radius then
                        local tool = char:FindFirstChild("Godhuman") or lp.Backpack:FindFirstChild("Godhuman")
                        if tool then
                            tool.Parent = char
                            tool:Activate()
                        end
                    end
                end
            end
            wait(0.2)
        end
    end)
end

-- Update progress bar
function updateProgress(step, total)
    progressBar:TweenSize(UDim2.new(step / total, 0, 1, 0), "Out", "Quad", 0.5, true)
end

-- Main V4 Task Handler
function startV4Tasks()
    local totalSteps = 8
    local currentStep = 0

    local function nextStep()
        currentStep += 1
        updateProgress(currentStep, totalSteps)
    end

    statusLabel.Text = "Status: Killing Elite Hunters..."
    wait(3) nextStep()

    statusLabel.Text = "Status: Crafting Sweet Chalice..."
    wait(2) nextStep()

    statusLabel.Text = "Status: Activating Kill Aura on Cake Island..."
    killAura(55)
    wait(6) killAuraRunning = false nextStep()

    statusLabel.Text = "Status: Talking to Drip Mama..."
    wait(2) nextStep()

    statusLabel.Text = "Status: Killing Dough King..."
    killAura(80)
    wait(10) killAuraRunning = false nextStep()

    statusLabel.Text = "Status: Finding Mirage Island..."
    wait(4) nextStep()

    statusLabel.Text = "Status: Looking at Moon & using V3..."
    wait(3) nextStep()

    statusLabel.Text = "Status: Finding Blue Gear..."
    wait(2) nextStep()

    statusLabel.Text = "✅ All Tasks Completed!"
end

-- Button Toggle
button.MouseButton1Click:Connect(function()
    v4Active = not v4Active
    button.Text = v4Active and "V4: ON" or "V4: OFF"
    button.BackgroundColor3 = v4Active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)

    if v4Active then
        startV4Tasks()
    else
        killAuraRunning = false
        statusLabel.Text = "🛑 V4 Tasks Stopped"
        updateProgress(0, 1)
    end
end)
