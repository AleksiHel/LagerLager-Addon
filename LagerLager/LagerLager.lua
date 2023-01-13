print("LagerLager loaded!")

admin = "Jaamon"
-- register event listener
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
frame:RegisterEvent("CHAT_MSG_GUILD") -- Fired when guild chat message is received

function frame:OnEvent(event, arg1)

    if event == "ADDON_LOADED" and arg1 == "LagerLager" then
        if LagerLagerDB == nil then
            LagerLagerDB = {}
            LagerLagerDB["Avadin"] = 0
            LagerLagerDB["Enoozaela"] = 0
            LagerLagerDB["Menehdyin"] = 0
            LagerLagerDB["Rarré"] = 0
            LagerLagerDB["Jampe"] = 0
            LagerLagerDB["Sammana"] = 0
            LagerLagerDB["Ampijaine"] = 0
            LagerLagerDB["Jatsor"] = 0
            LagerLagerDB["Mehukisu"] = 0
            LagerLagerDB["Snajderdk"] = 0
            LagerLagerDB["Tattipappi"] = 0
            LagerLagerDB["Jaamon"] = 0
            LagerLagerDB["Pronssine"] = 0
            LagerLagerDB["Muiluu"] = 0
            LagerLagerDB["Vilijami"] = 0
            LagerLagerDB["Bigzzy"] = 0
            LagerLagerDB["Sotkaz"] = 0
            LagerLagerDB["Usram"] = 0
            LagerLagerDB["Sonats"] = 0
            LagerLagerDB["Stankvag"] = 0
            LagerLagerDB["Sipuligød"] = 0
            LagerLagerDB["Nässy"] = 0
            LagerLagerDB["Fuutonje"] = 0
            LagerLagerDB["Lidyo"] = 0
            LagerLagerDB["Jazaa"] = 0
            LagerLagerDB["Bercbilu"] = 0
            LagerLagerDB["Mylvy"] = 0
            LagerLagerDB["Ceppi"] = 0
            LagerLagerDB["Bulli"] = 0
            LagerLagerDB["Rotalock"] = 0

        end

    elseif event == "PLAYER_LOGOUT" then
        LagerLagerDBchar = LagerLagerDB;
    end

end

-- function to get guild chat messages
-- if message is !lagerlager <playername> and player is in LagerLagerDB add one to playername's value

function frame:CHAT_MSG_GUILD(event, message, sender, language, channelString, target, flags, unknown, channelNumber,
    channelName, unknown, counter, guid)
    local player = string.match(message, "!lagerlager (.+)")
    local msgsender = sender
    if player ~= nil then
        print(player)
        if player ~= "status" or player ~= "top" and trim_gehennas(sender) == Admin then
            if LagerLagerDBchar[player] ~= nil then
                LagerLagerDB[player] = LagerLagerDB[player] + 999
                SendChatMessage(player .. " on nyt velkaa " .. LagerLagerDB[player] .. " lavaa lagerlageria", "GUILD")

            elseif string.find(player, "delete") then
                local playerNameActual = trim_delete(player)
                local playerNameActualTrim = trim_spaces(playerNameActual)
                local playerName = trim_numbers(playerNameActualTrim)
                print(playerName)

                if LagerLagerDB[playerName] ~= nil then
                    LagerLagerDB[playerName] = LagerLagerDB[playerName] - 1
                    SendChatMessage(playerName .. " on nyt velkaa " .. LagerLagerDB[playerName] ..
                                        " lavaa lagerlageria", "GUILD")
                elseif LagerLagerDB[playerName] == nil then
                    print(playerName .. " pelaajaa ei löytynyt! Tarkista oikeinkirjoitus ja käytä mainin nimeä!")
                elseif LagerLagerDBchar[player] == nil then
                    print(player .. " pelaajaa ei löytynyt! Tarkista oikeinkirjoitus ja käytä mainin nimeä!")
                end

            elseif player == "top" then

                SendChatMessage("TOP 5 LAGERLAGERIA", "GUILD")
                local top = {}

                for k, v in pairs(LagerLagerDB) do
                    table.insert(top, {k, v})
                    table.sort(top, function(a, b)
                        return a[2] > b[2]
                    end)
                end
                for i = 1, 5 do
                    SendChatMessage(top[i][1] .. " " .. top[i][2], "GUILD")
                end

            elseif string.find(player, "status") then
                newName = trim_status(player)

                if LagerLagerDB[newName] == nil then
                    SendChatMessage(newName .. " pelaajaa ei löytynyt!", "GUILD")
                else
                    SendChatMessage(newName .. " on velkaa " .. LagerLagerDB[newName] .. " lavaa lagerlageria", "GUILD")
                end

            end
        end
    end
end
frame:SetScript("OnEvent", frame.OnEvent)
frame:SetScript("OnEvent", frame.CHAT_MSG_GUILD)

-- function to trim -Gehennas from sender name
function trim_gehennas(s)
    return string.gsub(s, "-Mograine", "")
end

function trim_status(s)
    return string.gsub(s, "status ", "")
end

function trim_delete(s)
    return string.gsub(s, "delete", "")
end

-- lua function trim all numbers from string
function trim_numbers(s)
    return string.gsub(s, "%d", "")
end

-- trim " " from
function trim_spaces(s)
    return string.gsub(s, " ", "")
end

function trim_letters(s)
    return string.gsub(s, "%a", "")
end
