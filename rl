local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local tool = character:WaitForChild("OfficerPistol")

-- Function to halve the reload duration
local function halveReloadDuration()
    -- Locate the ToolData inside ReplicatedStorage
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local toolData = replicatedStorage:FindFirstChild("ToolData")
    
    if toolData then
        local officerPistolData = toolData:FindFirstChild("OfficerPistol")
        
        if officerPistolData then
            -- Iterate through all the animation data and halve the durations
            for _, animation in pairs(officerPistolData:GetChildren()) do
                if animation:IsA("ModuleScript") then
                    local animationData = require(animation)
                    
                    -- Modify the Duration values
                    for _, stage in ipairs(animationData) do
                        for _, joint in ipairs(stage) do
                            if joint.Duration then
                                joint.Duration = joint.Duration / 2  -- Halve the duration
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Connect to the tool's Equipped event to trigger the duration adjustment
tool.Equipped:Connect(halveReloadDuration)
