
-- change here for admin
local admin = {
    ["Jazaa"] = true,
    ["Jazho"] = true,
    ["Jazvo"] = true,
    ["Jazsu"] = true
}

-- addon commands
-- !lagerlager status 'playername'
-- Show player's owed cases
-- !lagerlager 'playername'
-- Add one case for the player
-- !lagerlager deduct 'playername'
-- removes one case from the player
-- !lagerlager top
-- prints top 5

-- deduct and add are available only for the admin

-- register event listener
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("CHAT_MSG_GUILD")
frame:RegisterEvent("PLAYER_LOGIN")

function frame:PLAYER_LOGIN()
    print("LagerLager loaded!")
end



-- function to get guild chat messages
function frame:CHAT_MSG_GUILD(message, sender, language, channelString, target, flags, unknown, channelNumber,
                              channelName, unknown, counter, guid)
    local player = string.match(message, "!lagerlager (.+)")

    if player ~= nil then

        msgSender = (trim_gehennas(sender))

        -- basic logic is that checks if the message sender is Admin. If not skip the first if but if it is admin checks if trying to use top or status
        --checks if it's the admin's command or not
        if admin[msgSender] == true and string.find(player, "top") == nil and string.find(player, "status") == nil then

            -- adds points to the player
            if LagerLagerDB[player] ~= nil then
                LagerLagerDB[player] = LagerLagerDB[player] + 1
                SendChatMessage(player .. " on nyt velkaa " .. LagerLagerDB[player] .. " lavaa lagerlageria", "GUILD")

                -- error message if can't find the player
            elseif LagerLagerDB[player] == nil and string.find(player, "deduct") == nil then
                print(player .. " pelaajaa ei löytynyt!1")

                -- deduct function, first trims stuff so it can get the name, then deduct one point from player
            elseif string.find(player, "deduct") ~= nil then
                local playerNameActual = trim_deduct(player)
                local playerNameActualTrim = trim_spaces(playerNameActual)
                local playerName = trim_numbers(playerNameActualTrim)
                if LagerLagerDB[playerName] ~= nil then
                    LagerLagerDB[playerName] = LagerLagerDB[playerName] - 1
                    SendChatMessage(playerName .. " on nyt velkaa " .. LagerLagerDB[playerName] .. " lavaa lagerlageria"
                        , "GUILD")

                    -- checks if the player is present in saved variables, if not prints message
                elseif LagerLagerDB[playerName] == nil then
                    print(playerName .. " pelaajaa ei löytynyt!")
                end
            end
        end

        -- below this are code for commands that other people beside the admin can use aswell
        -- first checks for top command
        -- then prints top 5 highest
        if player == "top" then

            SendChatMessage("TOP 5 LAGERLAGERIA", "GUILD")
            local top = {}

            for k, v in pairs(LagerLagerDB) do
                table.insert(top, { k, v })
                table.sort(top, function(a, b)
                    return a[2] > b[2]
                end)
            end
            for i = 1, 5 do
                SendChatMessage(top[i][1] .. " " .. top[i][2], "GUILD")
            end

            -- this checks for status command
            -- if player doesn't exist in saved variables = error in guild chat
            -- if player exists tells the players amount
        elseif string.find(player, "status") ~= nil then
            newName = trim_status(player)

            if LagerLagerDB[newName] == nil then
                SendChatMessage(newName .. "? nevähööd.", "GUILD")
            else
                SendChatMessage(newName .. " on velkaa " .. LagerLagerDB[newName] .. " lavaa lagerlageria", "GUILD")
            end

        end
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)

-- function to trim -Gehennas from sender name
function trim_gehennas(s)
    return string.gsub(s, "-Gehennas", "")
end

-- trims status
function trim_status(s)
    return string.gsub(s, "status ", "")
end

-- trims deduct
function trim_deduct(s)
    return string.gsub(s, "deduct", "")
end

-- lua function trim all numbers from string
function trim_numbers(s)
    return string.gsub(s, "%d", "")
end

-- trim " " from
function trim_spaces(s)
    return string.gsub(s, " ", "")
end

-- trims remaining letters
function trim_letters(s)
    return string.gsub(s, "%a", "")
end

function frame:ADDON_LOADED()
    -- first time load
    -- adds guild to the saved variables
        if LagerLagerDB == nil then
            LagerLagerDB = {}
            LagerLagerDB["Jazaa"] = 0
            LagerLagerDB["Eliah"] = 0
            LagerLagerDB["Ikeris"] = 0
            LagerLagerDB["Keppi"] = 0
            LagerLagerDB["Muilu"] = 0
            LagerLagerDB["Rarre"] = 0
            LagerLagerDB["Sammana"] = -1
            LagerLagerDB["Ava"] = 0
            LagerLagerDB["Betoni"] = 0
            LagerLagerDB["Bigzzy"] = 0
            LagerLagerDB["Bulli"] = 0
            LagerLagerDB["Frace"] = 0
            LagerLagerDB["Fuutonje"] = 0
            LagerLagerDB["Jaamon"] = -1
            LagerLagerDB["Jatsor"] = 0
            LagerLagerDB["Lidyo"] = 0
            LagerLagerDB["Marsu"] = 0
            LagerLagerDB["Mehu"] = 0
            LagerLagerDB["Nässy"] = 0
            LagerLagerDB["Gilwin"] = 0
            LagerLagerDB["Sipuli"] = 0
            LagerLagerDB["Snajder"] = 0
            LagerLagerDB["Tattipappi"] = 0
            LagerLagerDB["Viljami"] = 0
            LagerLagerDB["Yentil"] = 0
            LagerLagerDB["Zaela"] = 0
            LagerLagerDB["Bahis"] = 0
            LagerLagerDB["Gosujumala"] = 0
            LagerLagerDB["Jope"] = 0
            LagerLagerDB["Neponaattori"] = 0
            LagerLagerDB["Sonats"] = 0
            LagerLagerDB["Sotkaz"] = 0
            LagerLagerDB["Stankvag"] = 0
            LagerLagerDB["Sylvi"] = 0
            LagerLagerDB["Sähköjohto"] = 0
            LagerLagerDB["Munahaukka"] = 0
            LagerLagerDB["Plive"] = 0
            LagerLagerDB["Parru"] = 0
            LagerLagerDB["Halleballe"] = 0
            LagerLagerDB["Bere"] = 0
            LagerLagerDB["Bouneri"] = 0

        end
    end