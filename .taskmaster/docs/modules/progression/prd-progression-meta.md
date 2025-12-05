# Sarimanok Survivor - Shop & Score Systems (Week 5)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Feature 9: Shop System

**What It Does:**
Between runs, player can spend gold on permanent stat upgrades that apply to ALL future runs.

**Why It's Important:**
This is the roguelite progression. It's why dying doesn't feel pointless—you always make progress.

## Shop Screen

```
┌─────────────────────────────────────┐
│              SHOP                   │
│                                     │
│   Your Gold: 350                    │
│                                     │
├─────────────────────────────────────┤
│                                     │
│   Damage +2%         100g    [BUY]  │
│   Current: +6%                      │
│                                     │
│   Max HP +5          100g    [BUY]  │
│   Current: +15                      │
│                                     │
│   Move Speed +1%     100g    [BUY]  │
│   Current: +3%                      │
│                                     │
├─────────────────────────────────────┤
│                                     │
│           [BACK TO MENU]            │
│                                     │
└─────────────────────────────────────┘
```

## Permanent Upgrades

| Upgrade    | Cost | Effect          | Repeatable? |
| ---------- | ---- | --------------- | ----------- |
| Damage     | 100g | +2% base damage | ∞ (forever) |
| Max HP     | 100g | +5 max HP       | ∞           |
| Move Speed | 100g | +1% move speed  | ∞           |

**These are SMALL bonuses that stack over many purchases.**

Example: Buy "Damage +2%" 10 times = +20% damage on ALL runs forever.

## Saving Shop Upgrades

Shop purchases persist in save file:

```json
{
  "gold": 350,
  "shop_damage": 6, // +6% damage bought
  "shop_hp": 15, // +15 HP bought
  "shop_speed": 3, // +3% speed bought
  "endless_unlocked": true,
  "high_score": 12450,
  "best_time": "23:47"
}
```

## Technical Requirements

- Shop UI scene
- Load/save shop data to file
- Apply shop bonuses at run start
- Disable BUY button if not enough gold
- Update display after purchase

---

# Feature 10: Score System

**What It Does:**
Tracks score based on enemies killed. Creates leaderboard competition.

## Scoring

| Action                  | Points |
| ----------------------- | ------ |
| Kill Green Duwende      | 10     |
| Kill Red Duwende        | 25     |
| Kill Santelmo           | 40     |
| Kill Manananggal        | 500    |
| Survive to dawn (bonus) | 1,000  |

## Display

Score shows in top-right corner during gameplay:

```
Score: 12,450
```

## High Score

- Saved to file
- Displayed on main menu
- Displayed on results screen
- Separate high scores for Story vs Endless (Endless added in Week 6)

---

# User Interface Screens

## Screen List

| Screen       | Purpose                          |
| ------------ | -------------------------------- |
| Main Menu    | Start game, access shop/settings |
| Shop         | Buy permanent upgrades           |
| Gameplay HUD | HP, XP, timer, score, weapons    |
| Pause Menu   | Resume, settings, quit           |
| Level Up     | Choose upgrade (from Weeks 1-3)  |
| Victory      | Win stats                        |
| Defeat       | Loss stats                       |

## Main Menu Layout

```
┌─────────────────────────────────────────────┐
│                                             │
│            SARIMANOK SURVIVOR               │
│               🐓                            │
│                                             │
│            [STORY MODE]                     │
│            [SHOP]                           │
│            [SETTINGS]                       │
│            [QUIT]                           │
│                                             │
│   Gold: 350    High Score: 12,450           │
│                                             │
│                              v0.1.0         │
└─────────────────────────────────────────────┘
```

**Loading Screen Text:**

> "The Sarimanok guards the land through the night. Survive until dawn."

Displayed briefly when starting a run (during scene transition).

## Gameplay HUD Layout

```
┌─────────────────────────────────────────────┐
│  ❤️ ████████░░  [12:47]     Score: 12,450  │
│  ⭐ ████░░░░░░                              │
│                                             │
│                                             │
│               (gameplay)                     │
│                                             │
│                                             │
│                                             │
│  🗡️ Peck Lv.3  💨 Wing Slap Lv.2           │
└─────────────────────────────────────────────┘
```

- Top left: HP bar, XP bar
- Top center: Timer
- Top right: Score
- Bottom: Equipped weapons with levels

## Pause Menu

```
┌─────────────────────────────────────────────┐
│                                             │
│               PAUSED                        │
│                                             │
│             [RESUME]                        │
│             [SETTINGS]                      │
│             [QUIT TO MENU]                  │
│                                             │
└─────────────────────────────────────────────┘
```

---

# Week 5: Meta Progression

**End State: "Dying makes me stronger for next run"**

Builds on Week 4, adds:

- Main menu (Story Mode, Shop, Quit)
- Shop screen with 3 upgrades (Damage, HP, Speed)
- Shop upgrades apply at run start
- Shop upgrades persist in save file
- Gold deducts on purchase

## Tasks

- [ ] Main menu screen (Story Mode, Shop, Quit)
- [ ] Add loading screen tagline ("The Sarimanok guards the land through the night...")
- [ ] Shop screen UI (use purchased UI asset pack)
- [ ] Buy Damage upgrade (+2% per purchase)
- [ ] Buy HP upgrade (+5 per purchase)
- [ ] Buy Speed upgrade (+1% per purchase)
- [ ] Upgrades save to file
- [ ] Upgrades apply at run start
- [ ] Gold deducts correctly on purchase
- [ ] BUY button disabled when insufficient gold

**Integration Test:** Die, buy upgrade, start new run - are you stronger?

---

**Related Files:**
- [Win Condition & Enemies](prd-progression-victory.md) - Features 7-8
- [Save System & GameState](prd-progression-state.md) - Week 4 tasks & Definition of Done


