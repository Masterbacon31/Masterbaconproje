-- [[ MASTER BACON ULTIMATE | FIXED VERSION ]]
local Library = {Tabs = {}, Pages = {}}
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = game.Players.LocalPlayer

function Library:Init(ProjectName)
    if CoreGui:FindFirstChild("MasterBaconUI") then CoreGui.MasterBaconUI:Destroy() end
    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "MasterBaconUI"
    
    local Main = Instance.new("Frame", sg)
    Main.Size = UDim2.new(0, 520, 0, 380)
    Main.Position = UDim2.new(0.5, -260, 0.5, -190)
    Main.BackgroundColor3 = Color3.fromRGB(15, 12, 12)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
    Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 80, 80)

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size, Sidebar.Position = UDim2.new(0, 140, 1, -60), UDim2.new(0, 12, 0, 50)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 18, 18)
    Instance.new("UICorner", Sidebar)
    local layout = Instance.new("UIListLayout", Sidebar)
    layout.Padding = UDim.new(0, 5)

    local Container = Instance.new("Frame", Main)
    Container.Size, Container.Position = UDim2.new(1, -175, 1, -65), UDim2.new(0, 162, 0, 52)
    Container.BackgroundTransparency = 1

    function Library:CreateTab(Name)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size, TabBtn.Text = UDim2.new(1, 0, 0, 35), Name
        TabBtn.BackgroundColor3, TabBtn.TextColor3 = Color3.fromRGB(35, 25, 25), Color3.new(1,1,1)
        Instance.new("UICorner", TabBtn)

        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size, Page.Visible = UDim2.new(1, 0, 1, 0), false
        Page.BackgroundTransparency, Page.ScrollBarThickness = 1, 0
        Instance.new("UIListLayout", Page).Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(Library.Pages) do p.Visible = false end
            Page.Visible = true
        end)
        table.insert(Library.Pages, Page)
        if #Library.Pages == 1 then Page.Visible = true end

        local Elements = {}
        function Elements:AddButton(Txt, Callback)
            local Btn = Instance.new("TextButton", Page)
            Btn.Size, Btn.Text = UDim2.new(1, -10, 0, 35), Txt
            Btn.BackgroundColor3, Btn.TextColor3 = Color3.fromRGB(45, 30, 30), Color3.new(1,1,1)
            Instance.new("UICorner", Btn)
            Btn.MouseButton1Click:Connect(function() pcall(Callback) end)
        end
        function Elements:AddToggle(Txt, Callback)
            local Tgl = Instance.new("TextButton", Page)
            Tgl.Size, Tgl.Text = UDim2.new(1, -10, 0, 35), "[OFF] " .. Txt
            Tgl.BackgroundColor3, Tgl.TextColor3 = Color3.fromRGB(30, 30, 30), Color3.new(0.6, 0.6, 0.6)
            Instance.new("UICorner", Tgl)
            local State = false
            Tgl.MouseButton1Click:Connect(function()
                State = not State
                Tgl.Text = State and "[ON] " .. Txt or "[OFF] " .. Txt
                Tgl.TextColor3 = State and Color3.fromRGB(255, 80, 80) or Color3.new(0.6, 0.6, 0.6)
                pcall(Callback, State)
            end)
        end
        return Elements
    end
    return Library
end

local Bacon = Library:Init("MASTER BACON PRO")
local Hacks = Bacon:CreateTab("Combat")
local Visuals = Bacon:CreateTab("Visuals")

Hacks:AddButton("Speed 100", function() LP.Character.Humanoid.WalkSpeed = 100 end)
Hacks:AddButton("Jump 100", function() LP.Character.Humanoid.JumpPower = 100 end)

Visuals:AddToggle("FPS Booster", function(v)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if v and obj:IsA("BasePart") and not obj:IsDescendantOf(LP.Character) then
            obj.Transparency = 1
        elseif not v and obj:IsA("BasePart") then
            obj.Transparency = 0
        end
    end
end)

