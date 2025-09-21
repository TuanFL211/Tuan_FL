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

-- TAB TÙY CHỈNH
local AntiBandToggle = Tab2:AddToggle({
    Name = "Chống band 100%",
    Default = true,
    Callback = function(Value)
        -- Code chống band ở đây
        print("Chống band:", Value)
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
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local WallHackToggle = Tab2:AddToggle({
    Name = "Wall hack",
    Default = false,
    Callback = function(Value)
        -- Code wall hack ở đây
        print("Wall hack:", Value)
    end
})

-- Dropdown cho người chơi
local players = {}
for i, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        table.insert(players, player.Name)
    end
end

local SelectedPlayer = nil
local PlayerDropdown = Tab2:AddDropdown({
    Name = "Danh sách người chơi",
    Options = players,
    Default = "Chọn người chơi",
    Callback = function(Value)
        SelectedPlayer = Value
    end
})

-- Toggle dịch chuyển đến người chơi
local TeleportToggle = Tab2:AddToggle({
    Name = "Dịch chuyển tới người chơi",
    Default = false,
    Callback = function(Value)
        if Value and SelectedPlayer then
            -- Code dịch chuyển
            while Value do
                wait()
                local target = game.Players[SelectedPlayer].Character.HumanoidRootPart
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame
            end
        end
    end
})

-- Nút làm mới dropdown
Tab2:AddButton({
    Name = "Làm mới danh sách",
    Callback = function()
        players = {}
        for i, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                table.insert(players, player.Name)
            end
        end
        PlayerDropdown:Refresh(players)
    end
})

Window:SelectTab(Tab1)
