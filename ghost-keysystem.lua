local me = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")
local input = game:GetService("UserInputService")
local tween = game:GetService("TweenService")
local run = game:GetService("RunService")

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

local api_link = "https://weareghost.glitch.me/"
local auto_hooklink = api_link .. "api/check-nickname"
local hooklink = api_link .. "api/validate-key"
local discordlink = "https://discord.gg/5XAn83XFJP"
local pc = "ghost-criminality-pc"
local mobile = "ghost-criminality-mobile"

local admin_key = "PalkaNigga"

local loadingInProgress = false

function Decrypt()
	local result = ""
	for i = 1, 20 do
		result = result .. string.char(math.random(1, 120))
	end
	return result
end

repeat wait() until game:IsLoaded()

local gui = Instance.new("ScreenGui")
local success, err = pcall(function() gui.Parent = game.CoreGui end)
if not success then
	gui.Parent = me.PlayerGui
end
gui.Name = Decrypt()
gui.ResetOnSpawn = false

local Menu = Instance.new("Frame")
Menu.Parent = gui
Menu.Name = Decrypt()
Menu.BackgroundColor3 = Color3.new(0.0588, 0.0588, 0.0588)
Menu.Position = UDim2.new(0.391, 0, 0.358, 0)
Menu.Size = UDim2.new(0.218, 0, 0.283, 0)
Menu.Visible = true

local UICMenu = Instance.new("UICorner", Menu)
UICMenu.CornerRadius = UDim.new(0, 5)

local icon = Instance.new("ImageLabel", Menu)
icon.Name = Decrypt()
icon.BackgroundTransparency = 1
icon.Position = UDim2.new(0, 0, 0, 0)
icon.Size = UDim2.new(0.119, 0, 0.168, 0)
icon.Image = "rbxassetid://83501732181441"

local title = Instance.new("TextLabel", Menu)
title.Name = Decrypt()
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.135, 0, 0, 0)
title.Size = UDim2.new(0.242, 0, 0.168, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Text = "Ghost"
title.Font = Enum.Font.TitilliumWeb

local line = Instance.new("Frame", Menu)
line.Name = Decrypt()
line.BackgroundColor3 = Color3.new(1, 0, 0)
line.Position = UDim2.new(0, 0, 0.168, 0)
line.Size = UDim2.new(1, 0, 0.01, 0)

local KeyBox = Instance.new("TextBox", Menu)
KeyBox.Name = Decrypt()
KeyBox.BackgroundColor3 = Color3.new(1, 1, 1)
KeyBox.Position = UDim2.new(0.171, 0, 0.306, 0)
KeyBox.Size = UDim2.new(0.658, 0, 0.121, 0)
KeyBox.ClearTextOnFocus = false
KeyBox.PlaceholderColor3 = Color3.new(0.3451, 0.3451, 0.3451)
KeyBox.PlaceholderText = "Your key here"
KeyBox.TextColor3 = Color3.new(0, 0, 0)
KeyBox.TextScaled = true
KeyBox.Text = ""

local UICKeyBox = Instance.new("UICorner", KeyBox)
UICKeyBox.CornerRadius = UDim.new(8, 8)

local GetKey = Instance.new("TextButton", Menu)
GetKey.Name = Decrypt()
GetKey.BackgroundColor3 = Color3.new(1, 1, 1)
GetKey.Position = UDim2.new(0.17, 0, 0.578, 0)
GetKey.Size = UDim2.new(0.306, 0, 0.109, 0)
GetKey.TextColor3 = Color3.new(0, 0, 0)
GetKey.TextScaled = true
GetKey.Text = "Get key"

local UICGetKey = Instance.new("UICorner", GetKey)
UICGetKey.CornerRadius = UDim.new(8, 8)

local CheckKey = Instance.new("TextButton", Menu)
CheckKey.Name = Decrypt()
CheckKey.BackgroundColor3 = Color3.new(1, 1, 1)
CheckKey.Position = UDim2.new(0.523, 0, 0.578, 0)
CheckKey.Size = UDim2.new(0.306, 0, 0.109, 0)
CheckKey.TextColor3 = Color3.new(0, 0, 0)
CheckKey.TextScaled = true
CheckKey.Text = "Check key"

local UICCheckKey = Instance.new("UICorner", CheckKey)
UICCheckKey.CornerRadius = UDim.new(8, 8)

local discord = Instance.new("TextButton", Menu)
discord.Name = Decrypt()
discord.BackgroundColor3 = Color3.new(0.1373, 0.1373, 1)
discord.Position = UDim2.new(0.346, 0, 0.754, 0)
discord.Size = UDim2.new(0.306, 0, 0.109, 0)
discord.TextColor3 = Color3.new(1, 1, 1)
discord.TextScaled = true
discord.Text = "Discord"

local UICdiscrod = Instance.new("UICorner", discord)
UICdiscrod.CornerRadius = UDim.new(8, 8)

local LoadingIndicator = Instance.new("Frame", Menu)
LoadingIndicator.Name = Decrypt()
LoadingIndicator.BackgroundColor3 = Color3.new(0, 0, 0)
LoadingIndicator.BackgroundTransparency = 0.3
LoadingIndicator.Position = UDim2.new(0, 0, 0, 0)
LoadingIndicator.Size = UDim2.new(1, 0, 1, 0)
LoadingIndicator.Visible = false
LoadingIndicator.ZIndex = 10

local LoadingText = Instance.new("TextLabel", LoadingIndicator)
LoadingText.Name = Decrypt()
LoadingText.BackgroundTransparency = 1
LoadingText.Position = UDim2.new(0, 0, 0.4, 0)
LoadingText.Size = UDim2.new(1, 0, 0.2, 0)
LoadingText.TextColor3 = Color3.new(1, 1, 1)
LoadingText.TextScaled = true
LoadingText.Text = "Loading..."
LoadingText.Font = Enum.Font.TitilliumWeb
LoadingText.ZIndex = 11

local function ShowLoading(show)
	LoadingIndicator.Visible = show
	loadingInProgress = show
end

local function Notif(title, text, duration)
	for _, child in pairs(gui:GetChildren()) do
		if child.Name == "Notif" then
			child:Destroy()
		end
	end

	local notif = Instance.new("Frame")
	notif.Parent = gui
	notif.Name = "Notif"
	notif.BackgroundColor3 = Color3.new(1, 1, 1)
	notif.Position = UDim2.new(1, 0, 0.833, 0)
	notif.Size = UDim2.new(0.167, 0, 0.105, 0)
	notif.Visible = true

	local UICnotifFrame = Instance.new("UICorner", notif)
	UICnotifFrame.CornerRadius = UDim.new(0, 5)

	local UISnotifFrame = Instance.new("UIStroke", notif)
	UISnotifFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UISnotifFrame.Color = Color3.new(0, 0, 0)
	UISnotifFrame.Thickness = 1

	local UIGnotifFrame = Instance.new("UIGradient", notif)
	UIGnotifFrame.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(0.0667, 0.0667, 0.0667)),
		ColorSequenceKeypoint.new(0.505, Color3.new(0.2706, 0.0510, 0.0510)),
		ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
	})
	UIGnotifFrame.Rotation = 60
	UIGnotifFrame.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.363),
		NumberSequenceKeypoint.new(0.216, 0.269),
		NumberSequenceKeypoint.new(0.7, 0.556),
		NumberSequenceKeypoint.new(1, 0.55)
	})

	local notifsound = Instance.new("Sound", notif)
	notifsound.SoundId = "rbxassetid://17208361335"
	notifsound.Volume = 1.5

	local notiftitle = Instance.new("TextLabel", notif)
	notiftitle.Name = Decrypt()
	notiftitle.BackgroundTransparency = 1
	notiftitle.Position = UDim2.new(0, 0, 0, 0)
	notiftitle.Size = UDim2.new(1, 0, 0.325, 0)
	notiftitle.TextColor3 = Color3.new(1, 1, 1)
	notiftitle.TextScaled = true
	notiftitle.Font = Enum.Font.FredokaOne
	notiftitle.Text = title

	local notificon = Instance.new("ImageLabel", notif)
	notificon.Name = Decrypt()
	notificon.BackgroundTransparency = 1
	notificon.Position = UDim2.new(0, 0, 0.338, 0)
	notificon.Size = UDim2.new(0.217, 0, 0.65, 0)
	notificon.Image = "rbxassetid://71723095763813"
	notificon.Visible = true

	local notiftext = Instance.new("TextLabel", notif)
	notiftext.Name = Decrypt()
	notiftext.BackgroundTransparency = 1
	notiftext.Position = UDim2.new(0.217, 0, 0.35, 0)
	notiftext.Size = UDim2.new(0.783, 0, 0.65, 0)
	notiftext.TextColor3 = Color3.new(1, 1, 1)
	notiftext.TextScaled = true
	notiftext.Text = text

	tween:Create(notif, TweenInfo.new(0.5), { Position = UDim2.new(0.821, 0, 0.833, 0) }):Play()
	notifsound:Play()
	task.delay(duration, function()
		notif:Destroy()
	end)
end

Notif("🔍 Auto check", "Checking for existing key...", 3)
ShowLoading(true)

local function LoadScript()
	if input.MouseEnabled and not input.TouchEnabled then
		local result1 = game:HttpGetAsync(api_link.."/load/"..pc)
		local body1 = HttpService:JSONDecode(result1)
		
		if body1 then
			loadstring(game:HttpGet(body1.url))()
		end
	else
		local result2 = game:HttpGetAsync(api_link.."/load/"..mobile)
		local body2 = HttpService:JSONDecode(result2)
		
		if body2 then
			loadstring(game:HttpGet(body2.url))()
		end
	end
end

Notif("🔍 Auto check", "Checking for existing key...", 3)
ShowLoading(true)

local post

local s1, n1 = pcall(function()
	local result1 = HR({
		Url = auto_hooklink,
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/x-www-form-urlencoded"
		},
		Body = "nickname="..me.Name
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
			Body = "nickname="..me.Name
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
			ShowLoading(false)
			Notif("✅ Key found", "Loading script...", 3)
			ShowLoading(true)
			LoadScript()
			gui:Destroy()
		elseif status == "expired" then
			ShowLoading(false)
			Notif("⚠️ Key expired", "Please get a new key", 5)
		elseif status == "no_key" then
			ShowLoading(false)
			Notif("ℹ️ No key found", "Please get a key to continue", 5)
		else
			ShowLoading(false)
			LoadScript()
			gui:Destroy()
		end
	else
		ShowLoading(false)
		Notif("Error...", "Failed to get data", 5)
	end
else
	ShowLoading(false)
	Notif("Server connection", "failed to connect, please try again", 5)
end

discord.MouseButton1Click:Connect(function()
	if loadingInProgress then return end

	local InviteCode = discordlink:match("discord%.gg/(.+)") or ""
	local s = pcall(function()
		HR({
			Url = "http://127.0.0.1:6463/rpc?v=1",
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				["Origin"] = "https://discord.com"
			},
			Body = HttpService:JSONEncode({
				cmd = "INVITE_BROWSER",
				args = { code = InviteCode },
				nonce = HttpService:GenerateGUID(false)
			})
		})
	end)
	if not s then
		pcall(SB, discordlink)
	end
	Notif("Discord 👻", "Link copied to clipboard", 5)
end)

GetKey.MouseButton1Click:Connect(function()
	if loadingInProgress then return end
	local ok = pcall(SB, api_link)
	if not ok then
		KeyBox.Text = api_link
	end
	Notif("🔑 Link copied", "Key link copied to clipboard", 5)
end)

CheckKey.MouseButton1Click:Connect(function()
	if loadingInProgress then return end

	if KeyBox.Text == admin_key then
		Notif("✅ Admin access", "Loading script...", 2)
		LoadScript()
		gui:Destroy()
		return
	end

	if KeyBox.Text == "" or not KeyBox.Text then
		Notif("⚠️ Empty key", "Please enter a key first", 3)
		return
	end

	ShowLoading(true)
	Notif("🔍 Validating", "Checking your key...", 3)
	
	local post2
	
	local sc3, n3 = pcall(function()
		local result3 = HR({
			Url = hooklink,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/x-www-form-urlencoded"
			},
			Body = "nickname="..me.Name.."&".."key="..KeyBox.Text
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
				Body = "nickname="..me.Name.."&".."key="..KeyBox.Text
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
				ShowLoading(false)
				Notif("✅ Key valid", "Loading script...", 2)
				ShowLoading(true)
				LoadScript()
				gui:Destroy()
			elseif status2 == "wrong_nickname" then
				ShowLoading(false)
				Notif("⚠️ Wrong nickname", "Key registered for another user", 5)
			elseif status2 == "expired" then
				ShowLoading(false)
				Notif("⚠️ Key expired", "Please get a new key", 5)
			elseif status2 == "invalid" then
				ShowLoading(false)
				Notif("⚠️ Invalid key", "Key not found", 5)
			else
				LoadScript()
				gui:Destroy()
			end
		else
			ShowLoading(false)
			Notif("Error...", "Failed to get data", 5)
		end
	else
		ShowLoading(false)
		Notif("Server connection", "failed to connect, please try again", 5)
	end
end)
