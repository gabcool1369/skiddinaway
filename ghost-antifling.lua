local run = game:GetService("RunService")
local plrs = game:GetService("Players")
local me = plrs.LocalPlayer

local work = true

game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "Anti-fling by Ghost",
      Icon = "rbxassetid://83501732181441",
      Text = "Join to discord \n https://discord.gg/5XAn83XFJP",
      Duration = 10
})

wait(1)
run.RenderStepped:Connect(function()
      local char = me.Character
      if not char then return end
      local hrp = char:FindFirstChild("HumanoidRootPart")
      if not hrp then return end

      local oldVelocity = hrp.Velocity

      for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                  part.CanTouch = false
                  if part.Velocity.Magnitude > oldVelocity.Magnitude * 3 then
                        part.Velocity = Vector3.zero
                  end
            end
      end

      for _, player in pairs(plrs:GetPlayers()) do
            if player ~= me then
                  local plrChar = player.Character
                  if plrChar then
                        for _, part in pairs(plrChar:GetChildren()) do
                              if part:IsA("BasePart") then
                                    if part.Velocity.Magnitude > oldVelocity.Magnitude * 3 then
                                          part.Velocity = Vector3.zero
                                          part.CanTouch = false
                                    end
                              end
                        end
                  end
            end
      end
end)
