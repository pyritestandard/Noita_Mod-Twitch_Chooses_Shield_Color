# Noita Mod – Twitch Chooses Shield Color

This mod lets Twitch viewers redeem a **channel point reward** that changes your shield color by shifting magical liquid to a chosen material.

---

## Requirements

* [Config Lib](https://steamcommunity.com/sharedfiles/filedetails/?id=2287710542)
* [Twitch Extended](https://steamcommunity.com/sharedfiles/filedetails/?id=2258441901)

---

## Installation

1. Drop the `twitch_picks_shield_color` folder into your Noita `mods` directory.
2. In Noita, enable **Unsafe Mods** in the mod menu.

---

## Setup

1. Open the **Config** menu → **Twitch Extended** tab.
2. Scroll to the bottom of the tab to find this mod’s configuration settings.
3. Create a **Channel Point Reward** on Twitch.

   * **Note:** Input is required for this mod to work.
4. Link the reward in-game.
5. Redeem the reward on Twitch.

At this point, the mod should be working.

---

## Default Colors

Enabled by default:

```
blood, blue, darkblue, flum, green, grey, lava, lime, mint, orange, pink,
player, poo, purple, rainbow, red, scarlet, silver, skyblue, teal, white, yellow
```

Disabled by default *(cause lanterns and creatures that bleed magical liquid to instead bleed solid material, creating walls)*:

```
foolsgold, mint
```

* Any color can be disabled.
* Trigger keywords can be customized per word.

---

## Custom Colors

Adding custom colors is straightforward:

1. Open the mod folder.
2. Find and open `add_channel_reward.lua` in a code editor (or Notepad).
3. In the **material choices list** at the top, copy an existing entry and modify it.

**Example:** Adding gold as a shield color

```lua
{ material_id = "gold", display_name = "Gold", default_keyword = "gold", default_enabled = true },
```

Note: Using `gold` will cause lanterns and some enemies to bleed **gold powder**.

---
