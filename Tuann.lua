local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()
local Window = redzlib:MakeWindow({
    Title = "redz Hub : Blox Fruits",
    SubTitle = "by redz9999",
    SaveFolder = "testando | redz lib v5.lua"
})

-- Thêm nút thu nhỏ
Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://71014873973869", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

-- Tạo các tab
local Tab1 = Window:AddTab("Tổng hợp")
local Tab2 = Window:AddTab("Tùy chỉnh")

-- Thiết lập theme
redzlib:SetTheme("Dark")
redzlib:SetTheme("Purple")
redzlib:SetTheme("Darker")

-- TAB TỔNG HỢP
Tab1:AddDiscordInvite({
    Name = "Redz Hub",
    Description = "Join our Discord server",
    Logo = "rbxassetid://18751483361",
    Invite = "https://discord.gg/your-invite-link", -- Thay bằng link Discord thật
})

local RedzBetaToggle = Tab1:AddToggle({
    Name = "redz beta",
    Default = false,
    Callback = function(Value)
        if Value then
            local Settings = {
                JoinTeam = "Pirates",
                Translator = true
            }
            getgenv().BETA_VERSION = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))(Settings)
        end
    end
})

-- Thêm một số phần tử khác để tab không trống
Tab1:AddSection({"Tính năng chính"})

Tab1:AddButton({
    Name = "Kiểm tra phiên bản",
    Callback = function()
        print("Redz Hub Version 1.0")
    end
})

-- TAB TÙY CHỈNH
local AntiBandToggle = Tab2:AddToggle({
    Name = "Chống band 100%",
    Default = true,
    Callback = function(Value)
        -- Code chống band ở đây
        print("Chống band:", Value)
        -- Ví dụ implementation
        if Value then
            game:GetService("Players").LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
                if child.Name == "ErrorMessage" then
                    child:Destroy()
                end
            end)
        end
    end
})

local SpeedSlider = Tab2:AddSlider({
    Name = "Tốc độ",
    Min = 1,
    Max = 300,
    Increase = 1,
    Default = 25,
    Callback = function(Value)
        -- Code thay đổi tốc độ
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Value
        end
    end
})

local WallHackToggle = Tab2:AddToggle({
    Name = "Wall hack",
    Default = false,
    Callback = function(Value)
        -- Code wall hack ở đây
        print("Wall hack:", Value)
        if Value then
            -- Kích hoạt wall hack
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Transparency < 1 and part.Name ~= "HumanoidRootPart" then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        else
            -- Tắt wall hack
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.LocalTransparencyModifier = 0
                end
            end
        end
    end
})

-- Dropdown cho người chơi
local function updatePlayerList()
    local players = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    return players
end

local SelectedPlayer = nil
local PlayerDropdown = Tab2:AddDropdown({
    Name = "Danh sách người chơi",
    Options = updatePlayerList(),
    Default = "Chọn người chơi",
    Callback = function(Value)
        SelectedPlayer = Value
        print("Đã chọn:", Value)
    end
})

-- Toggle dịch chuyển đến người chơi
local TeleportToggle = Tab2:AddToggle({
    Name = "Dịch chuyển tới người chơi",
    Default = false,
    Callback = function(Value)
        if Value and SelectedPlayer then
            spawn(function()
                while TeleportToggle.Value and SelectedPlayer do
                    wait(0.1)
                    local targetChar = game.Players[SelectedPlayer].Character
                    local localChar = game.Players.LocalPlayer.Character
                    
                    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and
                       localChar and localChar:FindFirstChild("HumanoidRootPart") then
                        localChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                    end
                end
            end)
        end
    end
})

-- Nút làm mới dropdown
Tab2:AddButton({
    Name = "Làm mới danh sách",
    Callback = function()
        PlayerDropdown:Refresh(updatePlayerList())
        print("Đã làm mới danh sách người chơi")
    end
})

-- Chọn tab mặc định khi mở UI
Window:SelectTab(Tab1)

-- Thêm phần xử lý sự kiện để cập nhật danh sách người chơi tự động
game.Players.PlayerAdded:Connect(function()
    wait(1) -- Chờ một chút để player được thêm hoàn toàn
    PlayerDropdown:Refresh(updatePlayerList())
end)

game.Players.PlayerRemoving:Connect(function()
    wait(0.5) -- Chờ một chút để player được xóa hoàn toàn
    PlayerDropdown:Refresh(updatePlayerList())
end)
