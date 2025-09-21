-- Load UI Redz V2
loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua"))()

-- Cấu hình tính năng tự động lưu key
local KEY_CACHE_FILE = "thái_vũ_key_data.txt"
local EXPIRATION_TIME = 12 * 60 * 60 -- 12 giờ tính bằng giây

-- Kiểm tra xem có key đã lưu và còn hạn không
local is_key_valid_from_cache = false
local current_time = os.time()

if isfile(KEY_CACHE_FILE) then
    local saved_time = tonumber(readfile(KEY_CACHE_FILE))
    if saved_time and (current_time - saved_time < EXPIRATION_TIME) then
        is_key_valid_from_cache = true
    end
end

-- Tạo Window chính
local Window = MakeWindow({
    Hub = {
        Title = "Thái Vũ",
        Animation = "Thái Vũ Đẹp Zai"
    },
    Key = {
        KeySystem = not is_key_valid_from_cache,
        Title = "Key System",
        Description = "",
        KeyLink = "https://link4m.com/lCSiF",
        Keys = {"Thái Vũ 2012"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            IncorrectKey = "The key is incorrect",
            CopyKeyLink = "Link đã copy vào clipboard!"
        }
    }
})

-- Nút Minimize
MinimizeButton({
    Image = "http://www.roblox.com/asset/?id=ID_ANH_MOI",
    Size = {60, 60},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = false,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- Hàm để lưu lại thời gian khi chạy script
local function save_key_timestamp()
    if is_key_valid_from_cache == false then
        writefile(KEY_CACHE_FILE, tostring(os.time()))
    end
end

-- Hàm hiện thông báo xác nhận
local function showConfirmation(scriptName, callback)
    local player = game.Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")
    
    -- Tạo UI thông báo
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    frame.BorderSizePixel = 0
    frame.ZIndex = 10
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Xác nhận"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame
    
    local message = Instance.new("TextLabel")
    message.Size = UDim2.new(1, -20, 0, 50)
    message.Position = UDim2.new(0, 10, 0, 40)
    message.BackgroundTransparency = 1
    message.Text = "Bạn có muốn mở " .. scriptName .. " không?"
    message.TextColor3 = Color3.fromRGB(200, 200, 200)
    message.Font = Enum.Font.Gotham
    message.TextSize = 14
    message.TextWrapped = true
    message.Parent = frame
    
    local yesBtn = Instance.new("TextButton")
    yesBtn.Size = UDim2.new(0, 100, 0, 30)
    yesBtn.Position = UDim2.new(0.5, -110, 1, -40)
    yesBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    yesBtn.BorderSizePixel = 0
    yesBtn.Text = "Có"
    yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextSize = 14
    yesBtn.Parent = frame
    
    local noBtn = Instance.new("TextButton")
    noBtn.Size = UDim2.new(0, 100, 0, 30)
    noBtn.Position = UDim2.new(0.5, 10, 1, -40)
    noBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    noBtn.BorderSizePixel = 0
    noBtn.Text = "Không"
    noBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextSize = 14
    noBtn.Parent = frame
    
    frame.Parent = gui
    
    yesBtn.MouseButton1Click:Connect(function()
        callback(true)
        frame:Destroy()
    end)
    
    noBtn.MouseButton1Click:Connect(function()
        callback(false)
        frame:Destroy()
    end)
end

-- Tab Thông tin (tab đầu tiên)
local InfoTab = MakeTab({Name = "Thông tin"})

-- Nhóm Zalo
AddButton(InfoTab, {
    Name = "Tham gia nhóm Zalo",
    Callback = function()
        setclipboard("https://zalo.me/g/gxnivk802")
        local hint = Instance.new("Hint")
        hint.Text = "Đã copy link nhóm Zalo vào clipboard!"
        hint.Parent = game.Players.LocalPlayer.PlayerGui
        game:GetService("Debris"):AddItem(hint, 3)
    end
})

-- Nhóm Messenger
AddButton(InfoTab, {
    Name = "Tham gia nhóm Messenger",
    Callback = function()
        setclipboard("https://m.me/j/AbZwT1jUyrKvW2Bd/")
        local hint = Instance.new("Hint")
        hint.Text = "Đã copy link nhóm Messenger vào clipboard!"
        hint.Parent = game.Players.LocalPlayer.PlayerGui
        game:GetService("Debris"):AddItem(hint, 3)
    end
})

-- Tab chính với script
local Tab1o = MakeTab({Name = "Script ở đây"})

-- Button chạy script Min gaming
AddButton(Tab1o, {
    Name = "Min gaming",
    Callback = function()
        showConfirmation("Min gaming", function(confirmed)
            if confirmed then
                save_key_timestamp()
                getgenv().Team = "Marines"
                loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinUp27Vn"))()
            end
        end)
    end
})

-- Button chạy script Xeter Hub
AddButton(Tab1o, {
    Name = "Xeter Hub",
    Callback = function()
        showConfirmation("Xeter Hub", function(confirmed)
            if confirmed then
                save_key_timestamp()
                getgenv().Version = "V3"
                getgenv().Team = "Marines"
                loadstring(game:HttpGet("https://raw.githubusercontent.com/TlDinhKhoi/Xeter/refs/heads/main/Main.lua"))()
            end
        end)
    end
})

-- Button chạy script Teddy Hub
AddButton(Tab1o, {
    Name = "Teddy Hub",
    Callback = function()
        showConfirmation("Teddy Hub", function(confirmed)
            if confirmed then
                save_key_timestamp()
                repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM"))()
            end
        end)
    end
})

-- Tab Thêm (tab cuối)
local ExtraTab = MakeTab({Name = "Thêm"})

-- Slider chỉnh tốc độ chạy
AddSlider(ExtraTab, {
    Name = "Tốc độ chạy",
    Min = 16,
    Max = 300,
    Default = 25,
    Callback = function(value)
        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
})

-- Nút Fix lag + FPS ẢO
AddButton(ExtraTab, {
    Name = "Fix lag + FPS ẢO",
    Callback = function()
        -- Script Premium bởi Roblox Studio Hub
        local Players = game:GetService("Players")
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local VirtualUser = game:GetService("VirtualUser")

        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- Tạo UI cao cấp
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PremiumGameHub"
        ScreenGui.Parent = playerGui

        -- Hiển thị FPS chuyên nghiệp
        local FPSDisplay = Instance.new("Frame")
        FPSDisplay.Name = "FPSDisplay"
        FPSDisplay.Size = UDim2.new(0, 90, 0, 30)
        FPSDisplay.Position = UDim2.new(1, -100, 0, 10)
        FPSDisplay.AnchorPoint = Vector2.new(1, 0)
        FPSDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        FPSDisplay.BackgroundTransparency = 0.3
        FPSDisplay.BorderSizePixel = 0
        FPSDisplay.Parent = ScreenGui

        local UICornerFPS = Instance.new("UICorner")
        UICornerFPS.CornerRadius = UDim.new(0, 8)
        UICornerFPS.Parent = FPSDisplay

        local FPSLabel = Instance.new("TextLabel")
        FPSLabel.Name = "FPSLabel"
        FPSLabel.Size = UDim2.new(1, 0, 1, 0)
        FPSLabel.BackgroundTransparency = 1
        FPSLabel.Text = "FPS: 0"
        FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        FPSLabel.Font = Enum.Font.GothamBold
        FPSLabel.TextSize = 14
        FPSLabel.Parent = FPSDisplay

        -- Nút toggle UI
        local ToggleButton = Instance.new("ImageButton")
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Size = UDim2.new(0, 30, 0, 30)
        ToggleButton.Position = UDim2.new(0, 10, 0, 10)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Image = "rbxassetid://3926305904"
        ToggleButton.ImageColor3 = Color3.fromRGB(200, 200, 200)
        ToggleButton.ImageRectOffset = Vector2.new(884, 4)
        ToggleButton.ImageRectSize = Vector2.new(36, 36)
        ToggleButton.Parent = ScreenGui

        local UICornerToggle = Instance.new("UICorner")
        UICornerToggle.CornerRadius = UDim.new(1, 0)
        UICornerToggle.Parent = ToggleButton

        -- Khung chính với hiệu ứng bóng đổ
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 370, 0, 280)
        MainFrame.Position = UDim2.new(0.5, -185, 0.5, -140)
        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        MainFrame.BackgroundTransparency = 0.1
        MainFrame.BorderSizePixel = 0
        MainFrame.Parent = ScreenGui

        local UICornerMain = Instance.new("UICorner")
        UICornerMain.CornerRadius = UDim.new(0, 12)
        UICornerMain.Parent = MainFrame

        local DropShadow = Instance.new("ImageLabel")
        DropShadow.Name = "DropShadow"
        DropShadow.Size = UDim2.new(1, 10, 1, 10)
        DropShadow.Position = UDim2.new(0, -5, 0, -5)
        DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
        DropShadow.BackgroundTransparency = 1
        DropShadow.Image = "rbxassetid://5234388158"
        DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        DropShadow.ImageTransparency = 0.8
        DropShadow.ScaleType = Enum.ScaleType.Slice
        DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)
        DropShadow.Parent = MainFrame

        -- Thanh tiêu đề với gradient
        local TopBar = Instance.new("Frame")
        TopBar.Name = "TopBar"
        TopBar.Size = UDim2.new(1, 0, 0, 35)
        TopBar.Position = UDim2.new(0, 0, 0, 0)
        TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        TopBar.BorderSizePixel = 0
        TopBar.Parent = MainFrame

        local UICornerTop = Instance.new("UICorner")
        UICornerTop.CornerRadius = UDim.new(0, 12)
        UICornerTop.Parent = TopBar

        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Size = UDim2.new(0, 200, 1, 0)
        Title.Position = UDim2.new(0, 15, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "PREMIUM GAME HUB"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 15
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = TopBar

        -- Nút đóng với hiệu ứng hover
        local CloseButton = Instance.new("ImageButton")
        CloseButton.Name = "CloseButton"
        CloseButton.Size = UDim2.new(0, 25, 0, 25)
        CloseButton.Position = UDim2.new(1, -30, 0.5, -12)
        CloseButton.AnchorPoint = Vector2.new(1, 0.5)
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        CloseButton.BorderSizePixel = 0
        CloseButton.Image = "rbxassetid://3926305904"
        CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.ImageRectOffset = Vector2.new(284, 4)
        CloseButton.ImageRectSize = Vector2.new(24, 24)
        CloseButton.Parent = TopBar

        local UICornerClose = Instance.new("UICorner")
        UICornerClose.CornerRadius = UDim.new(1, 0)
        UICornerClose.Parent = CloseButton

        -- Các tab với hiệu ứng chuyển động
        local TabButtons = Instance.new("Frame")
        TabButtons.Name = "TabButtons"
        TabButtons.Size = UDim2.new(1, -20, 0, 35)
        TabButtons.Position = UDim2.new(0, 10, 0, 40)
        TabButtons.BackgroundTransparency = 1
        TabButtons.Parent = MainFrame

        local tabs = {
            {name = "MainTabButton", text = "GIẢM LAG", icon = "rbxassetid://3926305904", rect = Vector2.new(124, 364)},
            {name = "SpeedTabButton", text = "TỐC ĐỘ", icon = "rbxassetid://3926305904", rect = Vector2.new(324, 124)},
            {name = "SettingsTabButton", text = "CÀI ĐẶT", icon = "rbxassetid://3926305904", rect = Vector2.new(604, 684)},
            {name = "InfoTabButton", text = "THÔNG TIN", icon = "rbxassetid://3926305904", rect = Vector2.new(964, 324)}
        }

        local tabButtons = {}
        local tabIndicator = Instance.new("Frame")
        tabIndicator.Name = "TabIndicator"
        tabIndicator.Size = UDim2.new(0.25, -5, 0, 3)
        tabIndicator.Position = UDim2.new(0, 0, 1, -3)
        tabIndicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        tabIndicator.BorderSizePixel = 0
        tabIndicator.Parent = TabButtons

        local UICornerIndicator = Instance.new("UICorner")
        UICornerIndicator.CornerRadius = UDim.new(0, 2)
        UICornerIndicator.Parent = tabIndicator

        for i, tab in ipairs(tabs) do
            local button = Instance.new("TextButton")
            button.Name = tab.name
            button.Size = UDim2.new(0.25, -5, 1, 0)
            button.Position = UDim2.new((i-1)*0.25, 0, 0, 0)
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            button.BorderSizePixel = 0
            button.Text = ""
            button.Parent = TabButtons
            
            local icon = Instance.new("ImageLabel")
            icon.Name = "Icon"
            icon.Size = UDim2.new(0, 18, 0, 18)
            icon.Position = UDim2.new(0, 10, 0.5, -9)
            icon.BackgroundTransparency = 1
            icon.Image = tab.icon
            icon.ImageRectOffset = tab.rect
            icon.ImageRectSize = Vector2.new(36, 36)
            icon.ImageColor3 = i == 1 and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(150, 150, 150)
            icon.Parent = button
            
            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Size = UDim2.new(1, -35, 1, 0)
            label.Position = UDim2.new(0, 35, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = tab.text
            label.TextColor3 = i == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
            label.Font = Enum.Font.GothamMedium
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = button
            
            tabButtons[tab.name] = button
        end

        -- Nội dung các tab
        local TabContent = Instance.new("Frame")
        TabContent.Name = "TabContent"
        TabContent.Size = UDim2.new(1, -20, 0, 200)
        TabContent.Position = UDim2.new(0, 10, 0, 80)
        TabContent.BackgroundTransparency = 1
        TabContent.Parent = MainFrame

        -- Tab Giảm Lag
        local MainTab = Instance.new("Frame")
        MainTab.Name = "MainTab"
        MainTab.Size = UDim2.new(1, 0, 1, 0)
        MainTab.BackgroundTransparency = 1
        MainTab.Visible = true
        MainTab.Parent = TabContent

        local ReduceLagButton = Instance.new("TextButton")
        ReduceLagButton.Name = "ReduceLagButton"
        ReduceLagButton.Size = UDim2.new(1, 0, 0, 40)
        ReduceLagButton.Position = UDim2.new(0, 0, 0, 0)
        ReduceLagButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        ReduceLagButton.BorderSizePixel = 0
        ReduceLagButton.Text = "BẬT GIẢM LAG"
        ReduceLagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ReduceLagButton.Font = Enum.Font.GothamBold
        ReduceLagButton.TextSize = 14
        ReduceLagButton.Parent = MainTab

        local UICornerLag = Instance.new("UICorner")
        UICornerLag.CornerRadius = UDim.new(0, 6)
        UICornerLag.Parent = ReduceLagButton

        -- Tab Tốc Độ
        local SpeedTab = Instance.new("Frame")
        SpeedTab.Name = "SpeedTab"
        SpeedTab.Size = UDim2.new(1, 0, 1, 0)
        SpeedTab.BackgroundTransparency = 1
        SpeedTab.Visible = false
        SpeedTab.Parent = TabContent

        local SpeedLabel = Instance.new("TextLabel")
        SpeedLabel.Name = "SpeedLabel"
        SpeedLabel.Size = UDim2.new(0.5, -5, 0, 20)
        SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
        SpeedLabel.BackgroundTransparency = 1
        SpeedLabel.Text = "Tốc độ:"
        SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        SpeedLabel.Font = Enum.Font.Gotham
        SpeedLabel.TextSize = 12
        SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
        SpeedLabel.Parent = SpeedTab

        local SpeedValue = Instance.new("TextLabel")
        SpeedValue.Name = "SpeedValue"
        SpeedValue.Size = UDim2.new(0.5, -5, 0, 20)
        SpeedValue.Position = UDim2.new(0.5, 5, 0, 0)
        SpeedValue.BackgroundTransparency = 1
        SpeedValue.Text = "16 (mặc định)"
        SpeedValue.TextColor3 = Color3.fromRGB(255, 255, 255)
        SpeedValue.Font = Enum.Font.GothamBold
        SpeedValue.TextSize = 12
        SpeedValue.TextXAlignment = Enum.TextXAlignment.Right
        SpeedValue.Parent = SpeedTab

        local SpeedSlider = Instance.new("TextButton")
        SpeedSlider.Name = "SpeedSlider"
        SpeedSlider.Size = UDim2.new(1, 0, 0, 20)
        SpeedSlider.Position = UDim2.new(0, 0, 0, 25)
        SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        SpeedSlider.BorderSizePixel = 0
        SpeedSlider.Text = ""
        SpeedSlider.Parent = SpeedTab

        local SpeedFill = Instance.new("Frame")
        SpeedFill.Name = "SpeedFill"
        SpeedFill.Size = UDim2.new(0.5, 0, 1, 0)
        SpeedFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        SpeedFill.BorderSizePixel = 0
        SpeedFill.Parent = SpeedSlider

        local UICornerFill = Instance.new("UICorner")
        UICornerFill.CornerRadius = UDim.new(0, 4)
        UICornerFill.Parent = SpeedFill

        local SpeedMinus = Instance.new("TextButton")
        SpeedMinus.Name = "SpeedMinus"
        SpeedMinus.Size = UDim2.new(0, 40, 0, 30)
        SpeedMinus.Position = UDim2.new(0, 0, 0, 50)
        SpeedMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        SpeedMinus.BorderSizePixel = 0
        SpeedMinus.Text = "-"
        SpeedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
        SpeedMinus.Font = Enum.Font.GothamBold
        SpeedMinus.TextSize = 16
        SpeedMinus.Parent = SpeedTab

        local SpeedPlus = Instance.new("TextButton")
        SpeedPlus.Name = "SpeedPlus"
        SpeedPlus.Size = UDim2.new(0, 40, 0, 30)
        SpeedPlus.Position = UDim2.new(1, -40, 0, 50)
        SpeedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        SpeedPlus.BorderSizePixel = 0
        SpeedPlus.Text = "+"
        SpeedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
        SpeedPlus.Font = Enum.Font.GothamBold
        SpeedPlus.TextSize = 16
        SpeedPlus.Parent = SpeedTab

        local ApplySpeedButton = Instance.new("TextButton")
        ApplySpeedButton.Name = "ApplySpeedButton"
        ApplySpeedButton.Size = UDim2.new(1, 0, 0, 35)
        ApplySpeedButton.Position = UDim2.new(0, 0, 0, 90)
        ApplySpeedButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        ApplySpeedButton.BorderSizePixel = 0
        ApplySpeedButton.Text = "ÁP DỤNG TỐC ĐỘ"
        ApplySpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ApplySpeedButton.Font = Enum.Font.GothamBold
        ApplySpeedButton.TextSize = 14
        ApplySpeedButton.Parent = SpeedTab

        -- Tab Cài Đặt
        local SettingsTab = Instance.new("Frame")
        SettingsTab.Name = "SettingsTab"
        SettingsTab.Size = UDim2.new(1, 0, 1, 0)
        SettingsTab.BackgroundTransparency = 1
        SettingsTab.Visible = false
        SettingsTab.Parent = TabContent

        local AntiAFKButton = Instance.new("TextButton")
        AntiAFKButton.Name = "AntiAFKButton"
        AntiAFKButton.Size = UDim2.new(1, 0, 0, 35)
        AntiAFKButton.Position = UDim2.new(0, 0, 0, 0)
        AntiAFKButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        AntiAFKButton.BorderSizePixel = 0
        AntiAFKButton.Text = "CHỐNG AFK: TẮT"
        AntiAFKButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        AntiAFKButton.Font = Enum.Font.GothamBold
        AntiAFKButton.TextSize = 14
        AntiAFKButton.Parent = SettingsTab

        local AntiBandButton = Instance.new("TextButton")
        AntiBandButton.Name = "AntiBandButton"
        AntiBandButton.Size = UDim2.new(1, 0, 0, 35)
        AntiBandButton.Position = UDim2.new(0, 0, 0, 45)
        AntiBandButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        AntiBandButton.BorderSizePixel = 0
        AntiBandButton.Text = "CHỐNG BAND: TẮT"
        AntiBandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        AntiBandButton.Font = Enum.Font.GothamBold
        AntiBandButton.TextSize = 14
        AntiBandButton.Parent = SettingsTab

        local SaveSettingsButton = Instance.new("TextButton")
        SaveSettingsButton.Name = "SaveSettingsButton"
        SaveSettingsButton.Size = UDim2.new(1, 0, 0, 35)
        SaveSettingsButton.Position = UDim2.new(0, 0, 0, 90)
        SaveSettingsButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        SaveSettingsButton.BorderSizePixel = 0
        SaveSettingsButton.Text = "LƯU CÀI ĐẶT"
        SaveSettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        SaveSettingsButton.Font = Enum.Font.GothamBold
        SaveSettingsButton.TextSize = 14
        SaveSettingsButton.Parent = SettingsTab

        -- Tab Thông Tin
        local InfoTab = Instance.new("Frame")
        InfoTab.Name = "InfoTab"
        InfoTab.Size = UDim2.new(1, 0, 1, 0)
        InfoTab.BackgroundTransparency = 1
        InfoTab.Visible = false
        InfoTab.Parent = TabContent

        local InfoText = Instance.new("TextLabel")
        InfoText.Name = "InfoText"
        InfoText.Size = UDim2.new(1, 0, 0, 100)
        InfoText.Position = UDim2.new(0, 0, 0, 0)
        InfoText.BackgroundTransparency = 1
        InfoText.Text = "Công cụ hỗ trợ game:\n- Giảm lag tối đa\n- Tăng tốc độ chạy (tối đa 350)\n- Chống AFK/Band\n- Hiển thị FPS thời gian thực"
        InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
        InfoText.Font = Enum.Font.Gotham
        InfoText.TextSize = 12
        InfoText.TextWrapped = true
        InfoText.TextXAlignment = Enum.TextXAlignment.Left
        InfoText.TextYAlignment = Enum.TextYAlignment.Top
        InfoText.Parent = InfoTab

        local ZaloButton = Instance.new("TextButton")
        ZaloButton.Name = "ZaloButton"
        ZaloButton.Size = UDim2.new(1, 0, 0, 35)
        ZaloButton.Position = UDim2.new(0, 0, 0, 110)
        ZaloButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        ZaloButton.BorderSizePixel = 0
        ZaloButton.Text = "NHÓM ZALO (COPY LINK)"
        ZaloButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ZaloButton.Font = Enum.Font.GothamBold
        ZaloButton.TextSize = 12
        ZaloButton.Parent = InfoTab

        -- Tính năng FPS
        local fps = 0
        local lastTime = tick()
        local frameCount = 0

        RunService.Heartbeat:Connect(function()
            frameCount = frameCount + 1
            local currentTime = tick()
            if currentTime - lastTime >= 1 then
                fps = math.floor(frameCount / (currentTime - lastTime))
                frameCount = 0
                lastTime = currentTime
                
                local color = if fps > 60 then Color3.fromRGB(0, 255, 0)
                    elseif fps > 30 then Color3.fromRGB(255, 255, 0)
                    else Color3.fromRGB(255, 0, 0)
                
                TweenService:Create(FPSLabel, TweenInfo.new(0.3), {TextColor3 = color}):Play()
                FPSLabel.Text = "FPS: " .. fps
            end
        end)

        -- Tính năng giảm lag
        local isReducingLag = false
        local originalSettings = {}

        local function toggleLagReduction()
            isReducingLag = not isReducingLag
            
            if isReducingLag then
                -- Lưu cài đặt gốc
                originalSettings.Atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
                originalSettings.Sky = Lighting:FindFirstChildOfClass("Sky")
                originalSettings.FogEnd = Lighting.FogEnd
                originalSettings.GlobalShadows = Lighting.GlobalShadows
                originalSettings.OutdoorAmbient = Lighting.OutdoorAmbient
                originalSettings.Terrain = workspace.Terrain
                
                -- Ẩn môi trường
                if originalSettings.Atmosphere then originalSettings.Atmosphere.Parent = nil end
                if originalSettings.Sky then originalSettings.Sky.Parent = nil end
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                if originalSettings.Terrain then
                    originalSettings.Terrain.Decoration = false
                    originalSettings.Terrain.WaterReflection = false
                    originalSettings.Terrain.WaterWaveSize = 0
                end
                
                -- Tắt hiệu ứng
                for _, effect in ipairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then effect.Enabled = false end
                end
                
                TweenService:Create(ReduceLagButton, TweenInfo.new(0.3), {
                    Text = "TẮT GIẢM LAG",
                    BackgroundColor3 = Color3.fromRGB(255, 80, 80)
                }):Play()
            else
                -- Khôi phục cài đặt
                if originalSettings.Atmosphere then originalSettings.Atmosphere.Parent = Lighting end
                if originalSettings.Sky then originalSettings.Sky.Parent = Lighting end
                Lighting.FogEnd = originalSettings.FogEnd or 10000
                Lighting.GlobalShadows = originalSettings.GlobalShadows or true
                Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient or Color3.fromRGB(128, 128, 128)
                if originalSettings.Terrain then
                    originalSettings.Terrain.Decoration = true
                    originalSettings.Terrain.WaterReflection = true
                    originalSettings.Terrain.WaterWaveSize = 0.15
                end
                
                -- Bật lại hiệu ứng
                for _, effect in ipairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then effect.Enabled = true end
                end
                
                TweenService:Create(ReduceLagButton, TweenInfo.new(0.3), {
                    Text = "BẬT GIẢM LAG",
                    BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                }):Play()
            end
        end

        -- Tính năng tốc độ (tối đa 350)
        local currentSpeed = 16
        local minSpeed = 16
        local maxSpeed = 350
        local speedStep = 10

        local function updateSpeedDisplay()
            SpeedValue.Text = currentSpeed .. " (mặc định: 16)"
            TweenService:Create(SpeedFill, TweenInfo.new(0.2), {
                Size = UDim2.new((currentSpeed - minSpeed) / (maxSpeed - minSpeed), 0, 1, 0)
            }):Play()
        end

        local function changeSpeed(amount)
            currentSpeed = math.clamp(currentSpeed + amount, minSpeed, maxSpeed)
            updateSpeedDisplay()
        end

        local function applySpeed()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = currentSpeed
                TweenService:Create(ApplySpeedButton, TweenInfo.new(0.3), {
                    Text = "ÁP DỤNG THÀNH CÔNG!"
                }):Play()
                wait(1.5)
                TweenService:Create(ApplySpeedButton, TweenInfo.new(0.3), {
                    Text = "ÁP DỤNG TỐC ĐỘ"
                }):Play()
            end
        end

        -- Tính năng chống AFK
        local isAntiAFK = false
        local antiAFKConnection

        local function toggleAntiAFK()
            isAntiAFK = not isAntiAFK
            
            if isAntiAFK then
                TweenService:Create(AntiAFKButton, TweenInfo.new(0.3), {
                    Text = "CHỐNG AFK: BẬT",
                    BackgroundColor3 = Color3.fromRGB(0, 200, 80)
                }):Play()
                
                antiAFKConnection = RunService.Heartbeat:Connect(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            else
                TweenService:Create(AntiAFKButton, TweenInfo.new(0.3), {
                    Text = "CHỐNG AFK: TẮT",
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                }):Play()
                
                if antiAFKConnection then
                   antiAFKConnection:Disconnect()
                    antiAFKConnection = nil
                end
            end
        end

        -- Tính năng chống Band
        local isAntiBand = false

        local function toggleAntiBand()
            isAntiBand = not isAntiBand
            
            if isAntiBand then
                TweenService:Create(AntiBandButton, TweenInfo.new(0.3), {
                    Text = "CHỐNG BAND: BẬT",
                    BackgroundColor3 = Color3.fromRGB(0, 200, 80)
                }):Play()
            else
                TweenService:Create(AntiBandButton, TweenInfo.new(0.3), {
                    Text = "CHỐNG BAND: TẮT",
                    BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                }):Play()
            end
        end

        -- Lưu cài đặt
        local function saveSettings()
            TweenService:Create(SaveSettingsButton, TweenInfo.new(0.3), {
                Text = "ĐÃ LƯU CÀI ĐẶT!"
            }):Play()
            wait(1.5)
            TweenService:Create(SaveSettingsButton, TweenInfo.new(0.3), {
                Text = "LƯU CÀI ĐẶT"
            }):Play()
        end

        -- Chuyển tab với hiệu ứng
        local function switchTab(tabName)
            MainTab.Visible = (tabName == "MainTab")
            SpeedTab.Visible = (tabName == "SpeedTab")
            SettingsTab.Visible = (tabName == "SettingsTab")
            InfoTab.Visible = (tabName == "InfoTab")
            
            -- Cập nhật chỉ báo tab
            local index = 1
            for i, tab in ipairs(tabs) do
                if tab.name == tabName then
                    index = i
                    break
                end
            end
            
            TweenService:Create(tabIndicator, TweenInfo.new(0.3), {
                Position = UDim2.new((index-1)*0.25, 0, 1, -3)
            }):Play()
        end

        -- Kết nối sự kiện
        ReduceLagButton.MouseButton1Click:Connect(toggleLagReduction)
        SpeedMinus.MouseButton1Click:Connect(function() changeSpeed(-speedStep) end)
        SpeedPlus.MouseButton1Click:Connect(function() changeSpeed(speedStep) end)
        ApplySpeedButton.MouseButton1Click:Connect(applySpeed)
        AntiAFKButton.MouseButton1Click:Connect(toggleAntiAFK)
        AntiBandButton.MouseButton1Click:Connect(toggleAntiBand)
        SaveSettingsButton.MouseButton1Click:Connect(saveSettings)
        ZaloButton.MouseButton1Click:Connect(function()
            setclipboard("https://zalo.me/g/gxnivk802")
        end)
        
        for name, button in pairs(tabButtons) do
            button.MouseButton1Click:Connect(function()
                switchTab(name)
            end)
        end
        
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
        
        ToggleButton.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)
        
        -- Khởi tạo
        updateSpeedDisplay()
    end
})

-- Nút Wall Hack
AddButton(ExtraTab, {
    Name = "Wall Hack",
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                wait(0.1)
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            end
        end
    end
})

-- Tele người chơi
AddButton(ExtraTab, {
    Name = "Tele đến người chơi",
    Callback = function()
        local players = game.Players:GetPlayers()
        local playerNames = {}
        
        for _, player in ipairs(players) do
            if player ~= game.Players.LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        
        -- Hiển thị danh sách người chơi
        local player = game.Players.LocalPlayer
        local gui = player:WaitForChild("PlayerGui")
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 250, 0, 300)
        frame.Position = UDim2.new(0.5, -125, 0.5, -150)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        frame.BorderSizePixel = 0
        frame.ZIndex = 10
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Position = UDim2.new(0, 0, 0, 10)
        title.BackgroundTransparency = 1
        title.Text = "Chọn người chơi"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 18
        title.Parent = frame
        
        local scroll = Instance.new("ScrollingFrame")
        scroll.Size = UDim2.new(1, -20, 1, -80)
        scroll.Position = UDim2.new(0, 10, 0, 40)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.Parent = frame
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Parent = scroll
        
        for i, name in ipairs(playerNames) do
            local playerBtn = Instance.new("TextButton")
            playerBtn.Size = UDim2.new(1, 0, 0, 30)
            playerBtn.Position = UDim2.new(0, 0, 0, (i-1)*35)
            playerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
            playerBtn.BorderSizePixel = 0
            playerBtn.Text = name
            playerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            playerBtn.Font = Enum.Font.Gotham
            playerBtn.TextSize = 14
            playerBtn.Parent = scroll
            
            playerBtn.MouseButton1Click:Connect(function()
                _G.SelectedPlayer = name
                frame:Destroy()
                
                -- Tele đến người chơi
                local target = game.Players[name]
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
                    root.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                end
            end)
        end
        
        local resetBtn = Instance.new("TextButton")
        resetBtn.Size = UDim2.new(0, 100, 0, 30)
        resetBtn.Position = UDim2.new(0.5, -110, 1, -40)
        resetBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        resetBtn.BorderSizePixel = 0
        resetBtn.Text = "Reset"
        resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        resetBtn.Font = Enum.Font.GothamBold
        resetBtn.TextSize = 14
        resetBtn.Parent = frame
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 100, 0, 30)
        closeBtn.Position = UDim2.new(0.5, 10, 1, -40)
        closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        closeBtn.BorderSizePixel = 0
        closeBtn.Text = "Đóng"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 14
        closeBtn.Parent = frame
        
        frame.Parent = gui
        
        resetBtn.MouseButton1Click:Connect(function()
            _G.SelectedPlayer = nil
            frame:Destroy()
        end)
        
        closeBtn.MouseButton1Click:Connect(function()
            frame:Destroy()
        end)
    end
})

-- Nút AntiBand 100%
AddButton(ExtraTab, {
    Name = "AntiBand 100%",
    Callback = function()
        -- Code AntiBand
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        
        -- Kết nối sự kiện respawn
        player.CharacterAdded:Connect(function(newCharacter)
            local newHumanoid = newCharacter:WaitForChild("Humanoid")
            newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            newHumanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end)
    end
})
