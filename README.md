# Noita Mod – Twitch Chooses Shield Color

![banner img](https://img001.prntscr.com/file/img001/5eSTvAbpRD2sC4Mv_P-h_g.png)

This mod lets Twitch viewers redeem a channel point reward that changes your shield color by shifting magical liquid to a chosen material.

**Download:** [Zip File](https://github.com/pyritestandard/Noita_Mod-Twitch_Chooses_Shield_Color/releases/download/v1.0.1/Twitch_Picks_Shield_Color_v1.0.1.zip)

## Requirements

* [Config Lib](https://github.com/EvaisaDev/Config-Lib) | [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2287710542)
* [Twitch Extended](https://github.com/EvaisaDev/Twitch-Extended?tab=readme-ov-file) | [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2258441901)

## Installation

1. Drop the `twitch_picks_shield_color` folder into your Noita `mods` directory.
2. In Noita, enable unsafe mods in the mod menu.

## Setup

1. Open the **Config** menu → **Twitch Extended** tab.
2. Scroll to the bottom of the tab to find this mod’s configuration settings.
3. Create a **Channel Point Reward** on Twitch. (Input is required for this mod to work.)
4. Click link the reward, in-game.
5. Redeem the reward on Twitch.

![Config Menu](https://img001.prntscr.com/file/img001/CFMRHJwhQiKPXhC835KyMQ.png)

At this point, the mod should be working.

## Default Colors

Enabled by default:

```
blood, blue, darkblue, flum, green, grey, lava, lime, orange, pink,
player, poo, purple, rainbow, red, scarlet, silver, skyblue, teal, white, yellow
```

Disabled by default *(because lanterns and creatures that bleed magical liquid will bleed solid material, creating walls)*:

```
foolsgold, mint
```

* Any color can be disabled.
* Trigger keywords can be customized per word.

---

**NOTE**: It might help to give the viewers a list of words they can type, here's an example channel point reward description:
```
Type one of these to change my shield color: 
blood, blue, darkblue, flum, green, grey, lava, lime, orange, pink, player, poo, purple, rainbow, red, scarlet, silver, skyblue, teal, white, or yellow
```
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/M4M81GXWZK)

---

## Custom Colors

Adding custom colors is pretty easy:

1. Open the mod folder.
2. Find and open `add_channel_reward.lua` in a code editor (or even notepad).
3. In the material choices list near the top, copy and paste an existing entry and modify it.

For example, to add gold as an option you'd just add this line to the list under poo:

```lua
    { material_id = "gold", display_name = "Gold", default_keyword = "gold", default_enabled = true },
```

Though, it's worth noting, using *gold* will cause lanterns and some enemies to bleed gold powder. So, in case it's not clear, polymorphine will cause some enemies to bleed poly, ambrosia would cause them to bleed ambrosia.

[You can find material ID's here.](https://noita.wiki.gg/wiki/Materials)
