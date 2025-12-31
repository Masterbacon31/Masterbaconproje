-- [[ MASTER BACON LIBRARY | DELTA FIX ]]
-- Sorun: Obje yüklenmemesi ve Boş kutu hatası.

local Library = {Tabs = {}, Pages = {}}
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

function Library:Init(ProjectName)
    -- Temizlik
    if CoreGui:FindFirstChild("MasterBaconUI") then CoreGui.MasterBaconUI:Destroy() end

    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "MasterBaconUI"
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- [GİRİŞ PERDESİ - EN BASİT HALİ]
    local Intro = Instance.new("Frame", sg)
    Intro.Size = UDim2.new(1, 0, 1, 0)
    Intro.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Intro.ZIndex = 10 -- En üstte durması şart

    local IntroText = Instance.new("TextLabel", Intro)
    IntroText.Size = UDim2.new(1, 0, 1, 0)
    IntroText.BackgroundTransparency = 1
    IntroText.Text = "MASTER BACON LIBRARY"
    IntroText.TextColor3 = Color3.fromRGB(255, 80, 80)
    IntroText.Font = Enum.Font.SourceSansBold
    IntroText.TextSize = 30

    -- [ANA PANEL - BAŞTA GİZLİ]
    local Main = Instance.new("Frame", sg)
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(20, 18, 18)
    Main.Visible = false -- Giriş bitene kadar gizli
    Main.ZIndex = 5
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 80, 80)

    -- [HEADER / ÜST KISIM]
    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1

    local Title = Instance.new("TextLabel", Header)
    Title.Text = ProjectName or "MASTER BACON"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.TextColor3 = Color3.fromRGB(255, 100, 100)
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = 0
    Title.BackgroundTransparency = 1

    -- [BUTONLAR: - ve X]
    local ExitBtn = Instance.new("TextButton", Header)
    ExitBtn.Size = UDim2.new(0, 30, 0, 30)
    ExitBtn.Position = UDim2.new(1, -35, 0.5, -15)
    ExitBtn.Text = "X"
    ExitBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    ExitBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", ExitBtn)

    local MinBtn = Instance.new("TextButton", Header)
    MinBtn.Size = UDim2.new(0, 30, 0, 30)
    MinBtn.Position = UDim2.new(1, -70, 0.5, -15)
    MinBtn.Text = "-"
    MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MinBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", MinBtn)

    -- [KÜÇÜK BACON İKONU]
    local BaconIcon = Instance.new("TextButton", sg)
    BaconIcon.Size = UDim2.new(0, 50, 0, 50)
    BaconIcon.Position = UDim2.new(0, 15, 0.5, -25)
    BaconIcon.Text = "🥓"
    BaconIcon.Visible = false
    BaconIcon.BackgroundColor3 = Color3.fromRGB(20, 18, 18)
    Instance.new("UICorner", BaconIcon).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", BaconIcon).Color = Color3.fromRGB(255, 80, 80)

    -- [GİRİŞ SİSTEMİ - DELTA GARANTİ]
    task.spawn(function()
        task.wait(1.5) -- Yazıyı göster
        Intro:Destroy() -- Siyahlığı çat diye sil
        Main.Visible = true -- Hub'ı aç
    end)

    -- [MANTIK]
    local function Toggle()
        Main.Visible = not Main.Visible
        BaconIcon.Visible = not Main.Visible
    end

    ExitBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
    MinBtn.MouseButton1Click:Connect(Toggle)
    BaconIcon.MouseButton1Click:Connect(Toggle)

    -- [SEKME SİSTEMİ (İÇERİSİ)]
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 130, 1, -55)
    Sidebar.Position = UDim2.new(0, 10, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(30, 25, 25)
    Instance.new("UICorner", Sidebar)

    function Library:CreateTab(Name)
        local t = Instance.new("TextButton", Sidebar)
        t.Size = UDim2.new(1, -10, 0, 30)
        t.Text = Name
        t.BackgroundColor3 = Color3.fromRGB(45, 35, 35)
        t.TextColor3 = Color3.new(1,1,1)
        Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)
        Instance.new("UICorner", t)
        print("Tab Created: " .. Name)
        return t
    end

    -- Sürükleme (Drag)
    local function Drag(gui)
        local dragging, dragInput, dragStart, startPos
        gui.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = Main.Position end end)
        gui.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
        UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    end
    Drag(Header)

    return Library
end

-- BAŞLAT
local Bacon = Library:Init("MASTER BACON")
Bacon:CreateTab("Genel")
Bacon:CreateTab("Ayarlar")
