local REWARD_ID = "shield_color_shift"
local INPUT_MATERIAL = "plasma_fading"
local REWARD_IMAGE = "mods/twitch_extended/files/gfx/reward_images/fungal_shift.png"

local MATERIAL_CHOICES = {
    { material_id = "material_confusion", display_name = "Flummoxium", default_keyword = "flum", default_enabled = true },
    { material_id = "rainbow_gas", display_name = "Rainbow Gas", default_keyword = "rainbow", default_enabled = true  },
    { material_id = "blood", display_name = "Blood", default_keyword = "blood", default_enabled = true  },
    { material_id = "templebrick_golden_static", display_name = "Fool's Gold", default_keyword = "foolsgold", default_enabled = true  },
    { material_id = "silver", display_name = "Silver", default_keyword = "silver", default_enabled = true  },
    { material_id = "lava", display_name = "Lava", default_keyword = "lava", default_enabled = true  },
    { material_id = "spark_electric", display_name = "Electric Sparks", default_keyword = "blue", default_enabled = true  },
    { material_id = "fire_blue", display_name = "Blue Fire", default_keyword = "skyblue", default_enabled = true  },
    { material_id = "spark_purple", display_name = "Purple Sparks", default_keyword = "purple", default_enabled = true  },
    { material_id = "spark_blue_dark", display_name = "Dark Blue Sparks", default_keyword = "darkblue", default_enabled = true  },
    { material_id = "spark_player", display_name = "Player Sparkles", default_keyword = "player", default_enabled = true  },
    { material_id = "spark_green", display_name = "Green Sparks", default_keyword = "green", default_enabled = true  },
    { material_id = "spark_teal", display_name = "Teal Sparks", default_keyword = "teal", default_enabled = true  },
    { material_id = "spark_red", display_name = "Red Sparks", default_keyword = "red", default_enabled = true  },
    { material_id = "spark_yellow", display_name = "Yellow Sparks", default_keyword = "yellow", default_enabled = true  },
    { material_id = "spark_white", display_name = "White Sparks", default_keyword = "white", default_enabled = true  },
    { material_id = "spark", display_name = "Spark", default_keyword = "orange" , default_enabled = true },
    { material_id = "glowstone_altar_hdr", display_name = "Glowstone Altar HDR", default_keyword = "mint", default_enabled = true  },
    { material_id = "plasma_fading_green", display_name = "Green Fading Plasma", default_keyword = "lime", default_enabled = true  },
    { material_id = "plasma_fading_pink", display_name = "Pink Fading Plasma", default_keyword = "pink", default_enabled = true  },
    { material_id = "plastic_red", display_name = "Red Plastic", default_keyword = "scarlet", default_enabled = true  },
    { material_id = "plastic_grey", display_name = "Grey Plastic", default_keyword = "grey", default_enabled = true  },
    { material_id = "poo", display_name = "Poo", default_keyword = "poo", default_enabled = true  },
}

local function enable_setting_id(choice)
    return string.format("enabled_%s", choice.material_id)
end

local function keyword_setting_id(choice)
    return string.format("keyword_%s", choice.material_id)
end

local function reward_setting_key(flag)
    return string.format("twitch_extended_link_rewards_%s_%s", REWARD_ID, flag)
end



local function notify_success(username, source_name, target_name)
    local title = string.format("%s changed the shield color to %s", username, target_name)
    local description = string.format("%s shifted %s into %s.", username, source_name, target_name)
    GamePrintImportant(title, description, REWARD_IMAGE)
end

local function get_material_name(material_id)
    local material_type = CellFactory_GetType(material_id)
    if material_type == -1 then
        return material_id
    end

    local ui_name = CellFactory_GetUIName(material_type)
    return GameTextGetTranslatedOrNot(ui_name)
end

local function material_type_or_nil(material_id)
    local t = CellFactory_GetType(material_id)
    if t == -1 then
        return nil
    end
    return t
end

local function apply_shift(choice)
    if not material_type_or_nil(choice.material_id) then
        return nil
    end

    shift_materials({ INPUT_MATERIAL }, choice.material_id)

    local pretty_input = get_material_name(INPUT_MATERIAL)
    local pretty_output = choice.display_name or get_material_name(choice.material_id)

    return pretty_input, pretty_output
end

local function build_custom_options()
    local options = {}

    for _, choice in ipairs(MATERIAL_CHOICES) do
        table.insert(options, {
            type = "toggle",
            flag = enable_setting_id(choice),
            name = string.format("Enable %s", choice.display_name),
            description = string.format("Allow chat to shift shields into %s.", choice.display_name),
            default = choice.default_enabled,
        })

        table.insert(options, {
            type = "input",
            flag = keyword_setting_id(choice),
            name = string.format("Keyword for %s", choice.display_name),
            description = "Chat must type this word to pick this material.",
            default_text = choice.default_keyword or choice.material_id,
            text_max_length = 24,
            allowed_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789",
        })
        table.insert(options, { type = "spacer" })
    end

    return options
end

local CUSTOM_OPTIONS = build_custom_options()

local function ensure_default_flags()
    for _, choice in ipairs(MATERIAL_CHOICES) do
        if choice.default_enabled then
            local sentinel_key = reward_setting_key(enable_setting_id(choice) .. "_default_set")
            if not ModSettingGet(sentinel_key) then
                AddSettingFlag(reward_setting_key(enable_setting_id(choice)))
                ModSettingSet(sentinel_key, true)
            end
        end
    end
end

local function get_configured_keyword(choice)
    local setting = ModSettingGet(reward_setting_key(keyword_setting_id(choice)))
    local keyword = setting or choice.default_keyword or choice.material_id
    if keyword == nil then
        return nil
    end
    keyword = keyword:match("%S+") or ""
    if keyword == "" then
        return nil
    end
    return string.lower(keyword)
end

local function build_keyword_map()
    ensure_default_flags()

    local map = {}

    for _, choice in ipairs(MATERIAL_CHOICES) do
        if HasSettingFlag(reward_setting_key(enable_setting_id(choice))) then
            local keyword = get_configured_keyword(choice)
            if keyword then
                map[keyword] = choice
            end
        end
    end

    return map
end

table.insert(channel_rewards, {
    reward_id = REWARD_ID,
    reward_name = "Shield Color Shift",
    reward_description = "Let chat recolor the shield by shifting magical liquid into a custom one.",
    reward_image = REWARD_IMAGE,
    required_flag = "",
    custom_options = CUSTOM_OPTIONS,
    no_display_message = true,
    func = function(reward, userdata)
        local map = build_keyword_map()
        if next(map) == nil then
            return
        end

        local keyword
        if type(userdata.message) == "string" then
            keyword = userdata.message:match("%S+")
        end
        local choice = map[string.lower(keyword)]
        local pretty_input, pretty_output = apply_shift(choice)
        if pretty_input then
            local username = userdata.username or "Chat"
            notify_success(username, pretty_input, pretty_output)
        end
    end,
})