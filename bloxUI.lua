local BLOXHubUI = {}

    --== WINDOW CREATION ==--
function BLOXHubUI:MakeWindow(config)
    config = config or {}
    local Title = config.Title or "BLOXHub"
    local SubTitle = config.SubTitle or "Menu"
    local TabWidth = config.TabWidth or 80
    local Size = config.Size or UDim2.new(0, 100, 0, 200)
    local ThemeName = config.Theme or "Dark"
    local ToggleKey = config.MinimizeKey or Enum.KeyCode.RightShift

    -- Màu sắc theo chủ đề
    local themeColors = {
        Red      = Color3.fromRGB(220, 20, 60),
        Green    = Color3.fromRGB(34, 139, 34),
        Blue     = Color3.fromRGB(30, 144, 255),
        Pink     = Color3.fromRGB(255, 105, 180),
        Orange   = Color3.fromRGB(255, 140, 0),
        Purple   = Color3.fromRGB(138, 43, 226),
        Yellow   = Color3.fromRGB(255, 215, 0),
        Cyan     = Color3.fromRGB(0, 255, 255),
        Teal     = Color3.fromRGB(0, 128, 128),
        Magenta  = Color3.fromRGB(255, 0, 255),
        White    = Color3.fromRGB(240, 240, 240),
        Gray     = Color3.fromRGB(100, 100, 100),
        Dark     = Color3.fromRGB(40, 40, 40),
        Light    = Color3.fromRGB(220, 220, 220),
        Black    = Color3.fromRGB(10, 10, 10),
        Amethyst = Color3.fromRGB(153, 102, 204),
    }

    local Theme = themeColors[ThemeName] or themeColors.Dark
    local TweenService = game:GetService("TweenService")
    local UIS = game:GetService("UserInputService")
    
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "BLOXHubUILib"
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = Size
    Main.Position = UDim2.new(0.5, -Size.X.Offset/2, 0.5, -Size.Y.Offset/2)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme
    Main.BorderSizePixel = 0
    Main.Name = "Main"
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

    local TitleBar = Instance.new("TextLabel", Main)
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundTransparency = 1
    TitleBar.Text = Title .. " - " .. SubTitle
    TitleBar.Font = Enum.Font.GothamBold
    TitleBar.TextSize = 18
    TitleBar.TextColor3 = Color3.new(1, 1, 1)

    local TabHolder = Instance.new("Frame", Main)
    TabHolder.Size = UDim2.new(0, TabWidth, 1, -40)
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.BackgroundColor3 = Theme
    TabHolder.BorderSizePixel = 0

    local TabsLayout = Instance.new("UIListLayout", TabHolder)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 4)

    local ContentHolder = Instance.new("Frame", Main)
    ContentHolder.Size = UDim2.new(1, -TabWidth, 1, -40)
    ContentHolder.Position = UDim2.new(0, TabWidth, 0, 40)
    ContentHolder.BackgroundTransparency = 1

    local Tabs = {}

    local function ShowTab(name)
        for tabTitle, tabData in pairs(Tabs) do
            tabData.Frame.Visible = (tabTitle == Title)
        end
    end

    -- AddTab function
    local window = {}
    function window:AddTab(Title)
        local tabButton = Instance.new("TextButton", TabHolder)
        tabButton.Size = UDim2.new(1, -10, 0, 30)
        tabButton.Text = name
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        tabButton.TextScaled = true
        tabButton.Font = Enum.Font.GothamBold
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6)

        local tabFrame = Instance.new("ScrollingFrame", ContentHolder)
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.ScrollBarThickness = 6
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local layout = Instance.new("UIListLayout", tabFrame)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)

        local tab = {}

        function tab:AddButton(text, callback, imageId)
            local btn = Instance.new("TextButton", tabFrame)
            btn.Size = UDim2.new(1, -10, 0, 40)
            btn.Text = text
            btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.TextScaled = true
            btn.Font = Enum.Font.GothamBold
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

            local Content = Instance.new("Frame")
           Content.Parent = TabButton
           Content.Size = UDim2.new(1, 0, 1, 0)
           Content.BackgroundTransparency = 1

           local Icon = Instance.new("ImageLabel")
           Icon.Name = "Icon"
           Icon.Parent = Content
           Icon.Size = UDim2.new(0, 20, 0, 20)
           Icon.Position = UDim2.new(0, 10, 0.5, -10)
           Icon.BackgroundTransparency = 1
           Icon.Image = TabInfo.Icon or "rbxassetid://6031071050" -- fallback icon
           Icon.ImageColor3 = TabInfo.Color or Color3.new(1, 1, 1)

            btn.MouseButton1Click:Connect(callback)
        end

        function tab:AddToggle(text, default, callback)
            local toggle = Instance.new("TextButton", tabFrame)
            toggle.Size = UDim2.new(1, -10, 0, 40)
            toggle.Text = (default and "[ON] " or "[OFF] ") .. text
            toggle.TextScaled = true
            toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            toggle.TextColor3 = Color3.new(1,1,1)
            toggle.Font = Enum.Font.GothamBold
            Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

            local state = default or false

            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = (state and "[ON] " or "[OFF] ") .. text
                if callback then callback(state) end
            end)
        end

        function tab:AddDropdown(text, items, callback)
            local dropdown = Instance.new("TextButton", tabFrame)
            dropdown.Size = UDim2.new(1, -10, 0, 40)
            dropdown.Text = text .. " ▼"
            dropdown.BackgroundColor3 = Color3.fromRGB(70,70,70)
            dropdown.TextColor3 = Color3.new(1,1,1)
            dropdown.TextScaled = true
            dropdown.Font = Enum.Font.GothamBold
            Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 6)

            local list = Instance.new("Frame", tabFrame)
            list.Size = UDim2.new(1, -10, 0, #items * 32)
            list.BackgroundColor3 = Color3.fromRGB(50,50,50)
            list.Visible = false
            Instance.new("UICorner", list).CornerRadius = UDim.new(0, 6)

            local layout = Instance.new("UIListLayout", list)
            layout.SortOrder = Enum.SortOrder.LayoutOrder

            for _, item in pairs(items) do
                local option = Instance.new("TextButton", list)
                option.Size = UDim2.new(1, 0, 0, 30)
                option.Text = item
                option.BackgroundColor3 = Color3.fromRGB(40,40,40)
                option.TextColor3 = Color3.new(1,1,1)
                option.TextScaled = true
                option.Font = Enum.Font.GothamBold

                option.MouseButton1Click:Connect(function()
                    dropdown.Text = item .. " ▼"
                    list.Visible = false
                    callback(item)
                end)
            end

            dropdown.MouseButton1Click:Connect(function()
                list.Visible = not list.Visible
            end)
        end

        Tabs[name] = {Button = tabButton, Frame = tabFrame}
        tabButton.MouseButton1Click:Connect(function()
            ShowTab(name)
        end)

        if not next(Tabs) then
            ShowTab(name)
        end

        return tab
    end

    -- Tạo nút bật/tắt menu
    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    ToggleButton.Position = UDim2.new(0, 10, 0, 100)
    ToggleButton.Image = "http://www.roblox.com/asset/?id=123186873082762"
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Name = "ToggleUIButton"
    ToggleButton.Parent = ScreenGui

local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

local function SetupToggleMenu(Main, ToggleButton, Size)
    local isOpen = true
    local animLock = false
    local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    -- Tạo Blur nền
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = Lighting

    -- Âm thanh
    local clickSound = Instance.new("Sound", SoundService)
    clickSound.SoundId = "rbxassetid://9118823103" -- Click

    local openSound = Instance.new("Sound", SoundService)
    openSound.SoundId = "rbxassetid://6070890154" -- Open

    local closeSound = Instance.new("Sound", SoundService)
    closeSound.SoundId = "rbxassetid://541909867" -- Close

    -- Container scale
    local ScaleFrame = Instance.new("Frame")
    ScaleFrame.Size = UDim2.new(1, 0, 1, 0)
    ScaleFrame.BackgroundTransparency = 1
    ScaleFrame.BackgroundColor3 = Main.BackgroundColor3
    ScaleFrame.ClipsDescendants = true
    ScaleFrame.Parent = Main

    for _, child in ipairs(Main:GetChildren()) do
        if child ~= ScaleFrame and not child:IsA("UICorner") then
            child.Parent = ScaleFrame
        end
    end

    ScaleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ScaleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.BackgroundTransparency = 1
    Main.Visible = true
    ScaleFrame.Size = UDim2.new(0, 0, 0, 0)

    -- Toggle rotation effect
    local toggleRotation = Instance.new("NumberValue")
    toggleRotation.Value = 0
    toggleRotation:GetPropertyChangedSignal("Value"):Connect(function()
        ToggleButton.Rotation = toggleRotation.Value
    end)

    local function AnimateMenu(open)
        if animLock then return end
        animLock = true
        clickSound:Play()

        -- Rotate toggle icon
        TweenService:Create(toggleRotation, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Value = open and 0 or 180
        }):Play()

        if open then
            Main.Visible = true
            openSound:Play()
            blur.Enabled = true
            TweenService:Create(blur, TweenInfo.new(0.3), { Size = 12 }):Play()

            ScaleFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
            ScaleFrame.Position = UDim2.new(0.5, 0, 0.5, 10)
            Main.BackgroundTransparency = 1

            TweenService:Create(ScaleFrame, tweenInfo, {
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()

            TweenService:Create(Main, tweenInfo, {
                BackgroundTransparency = 0
            }):Play()
        else
            closeSound:Play()
            TweenService:Create(blur, TweenInfo.new(0.3), { Size = 0 }):Play()
            ScaleFrame.Size = UDim2.new(1, 0, 1, 0)

            local scaleTween = TweenService:Create(ScaleFrame, tweenInfo, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 10)
            })

            local fadeTween = TweenService:Create(Main, tweenInfo, {
                BackgroundTransparency = 1
            })

            scaleTween:Play()
            fadeTween:Play()

            scaleTween.Completed:Wait()
            Main.Visible = false
            blur.Enabled = false
        end

        animLock = false
    end

    ToggleButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        AnimateMenu(isOpen)
    end)
end

    -- Tạo khung menu
    local Main = Instance.new("Frame")
    Main.Size = Size
    Main.Position = UDim2.new(0.5, -Size.X.Offset / 2, 0.5, -Size.Y.Offset / 2)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme
    Main.BorderSizePixel = 0
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

    -- Kéo thả menu
    local UIS = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Chuyển trạng thái ẩn/hiện của menu khi nhấn nút toggle
    ToggleButton.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
    
    --thông báo MENU---
    ToggleUI = function()
    MainUI.Enabled = not MainUI.Enabled
    if MainUI.Enabled then
        BLOXHubUI:Notify({
            Title = "Menu Activated!",
            Description = "Chào mừng bạn đã đến với bản SCRIPT của mình!",
            Duration = 4
        })
    end
end

BLOXHubUI.Notify = function(opts)
    local Title = opts.Title or "Notification"
    local Desc = opts.Description or ""
    local Duration = opts.Duration or 3

    local note = Instance.new("TextLabel")
    note.Size = UDim2.new(0, 300, 0, 40)
    note.Position = UDim2.new(0.5, -150, 0, -50)
    note.AnchorPoint = Vector2.new(0.5, 0)
    note.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    note.BorderSizePixel = 0
    note.TextColor3 = Color3.new(1, 1, 1)
    note.Text = Title .. " - " .. Desc
    note.Font = Enum.Font.GothamBold
    note.TextSize = 14
    note.Parent = MainUI
    note.ZIndex = 999

    game:GetService("TweenService"):Create(note, TweenInfo.new(0.3), {
        Position = UDim2.new(0.5, -150, 0, 20)
    }):Play()

    task.delay(Duration, function()
        game:GetService("TweenService"):Create(note, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -150, 0, -50)
        }):Play()
        task.wait(0.3)
        note:Destroy()
    end)
end

    return BLOXHubUI
end

return BLOXHubUI
