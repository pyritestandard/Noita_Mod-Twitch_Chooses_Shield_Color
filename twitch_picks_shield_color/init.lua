if not ModIsEnabled("twitch_extended") then
    ModLog("[twitch_picks_shield_color] twitch_extended not enabled; reward not registered.")
    return
end

ModLuaFileAppend("mods/twitch_extended/config/rewards.lua", "mods/twitch_picks_shield_color/files/scripts/add_channel_reward.lua")

