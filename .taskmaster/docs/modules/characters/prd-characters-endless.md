# Sarimanok Survivor - Endless Mode & MVP Checkpoint (Week 6)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Feature 12: Endless Mode

**What It Does:**
Unlocks after beating Story Mode. No time limit—survive as long as possible. Uses same difficulty scaling as Story Mode (spawn rate + stat scaling already implemented from Weeks 1-3).

**Why It's Important:**
Replayability after beating Story Mode. Leaderboard appeal. Adds value without significant development time (reuses all existing systems).

## Unlock Condition

```
Beat Story Mode (survive to 30:00)
    ↓
"ENDLESS MODE UNLOCKED!" notification
    ↓
Endless Mode button appears on main menu
```

## Endless Mode Rules (Simplified EA Version)

- Timer counts UP forever (no 30:00 win condition)
- Same spawn rate scaling as Story Mode (continues past 30:00)
- Same HP/damage scaling as Story Mode (continues past 30:00)
- You WILL eventually die (no win condition)
- Goal: Survive as long as possible

**No additional scaling needed:** The exponential spawn rate formula and stat scaling from Weeks 1-3 already provide infinite difficulty progression.

## Main Menu with Endless Mode

```
┌─────────────────────────────────────────────┐
│                                             │
│            SARIMANOK SURVIVOR               │
│               🐓                            │
│                                             │
│            [STORY MODE]                     │
│            [ENDLESS MODE] 🔒 / ✓            │
│            [SHOP]                           │
│            [SETTINGS]                       │
│            [QUIT]                           │
│                                             │
│   Gold: 350    High Score: 12,450           │
│   Best Time (Endless): 47:23                │
│                                             │
└─────────────────────────────────────────────┘
```

**Before unlock:** Show 🔒 and "Beat Story Mode to unlock"
**After unlock:** Show ✓ and allow selection

## Leaderboards

| Mode         | Leaderboard   |
| ------------ | ------------- |
| Story Mode   | High Score    |
| Endless Mode | Time Survived |

## Technical Requirements

- Check if Story Mode has been beaten (endless_unlocked flag)
- Add Endless Mode button to main menu (locked initially)
- Disable 30:00 victory condition for Endless Mode
- Track best time for Endless Mode separately
- Display best time on main menu
- Reuse ALL existing systems (enemies, weapons, scaling)

## Endless Mode Flow

```
Player selects Endless Mode
    ↓
Character select screen (same as Story Mode)
    ↓
Run starts (identical to Story Mode)
    ↓
Timer counts up forever
    ↓
No victory at 30:00 (just keep going)
    ↓
Player eventually dies
    ↓
Results screen shows time survived
    ↓
Update best time if new record
```

## Save File Updates

```json
{
  "gold": 350,
  "shop_damage": 6,
  "shop_hp": 15,
  "shop_speed": 3,
  "endless_unlocked": false,
  "shadow_unlocked": false,
  "golden_unlocked": false,
  "high_score_story": 12450,
  "high_score_endless": 0,
  "best_time_story": "30:00",
  "best_time_endless": "47:23"
}
```

## Implementation Notes

**What's different from Story Mode:**

- No victory condition at 30:00 (just keep spawning enemies)
- Track separate high score and best time
- Display "Endless Mode" label in HUD

**What's the same:**

- All enemies, weapons, passives
- Level-up system
- Shop bonuses apply
- Spawn rate formula (continues scaling past 30:00)
- Enemy stat scaling (continues past 30:00)
- Gold earned persists

---

# Week 6: Character Select & Endless Mode

**End State: "I can pick characters and play Endless Mode"**

Builds on Week 5, adds:

- Character select screen (3 Sarimanoks with different stats)
- Shadow Sarimanok unlocks at 15:00 survived (Story Mode)
- Golden Sarimanok unlocks after beating Story Mode
- Simplified Endless Mode (unlocks after beating Story Mode)

## Tasks

- [ ] Character select screen before run
- [ ] Classic Sarimanok (default, balanced stats)
- [ ] Shadow Sarimanok (80 HP, 125% damage - glass cannon)
- [ ] Golden Sarimanok (130 HP, 85% speed, 100% damage - tank build)
- [ ] Lock/unlock display with requirements shown
- [ ] Shadow unlocks: survive 15:00 in Story Mode (single run)
- [ ] Golden unlocks: beat Story Mode (survive to 30:00)
- [ ] Unlock notifications when achieved
- [ ] Character stat modifiers apply correctly
- [ ] Simplified Endless Mode (disable 30:00 win condition, keep everything else)
- [ ] Endless Mode unlocks after beating Story Mode
- [ ] Endless Mode best time tracking
- [ ] Main menu shows Endless Mode lock status

**Integration Test:** Survive 15:00, unlock Shadow, beat Story Mode, unlock Golden and Endless Mode

---

# Definition of Done (Week 6)

## Character System

- [ ] All 3 Sarimanok variants implemented with correct stats
- [ ] Character select screen works
- [ ] Shadow shows unlock requirement (locked until 15:00 survived)
- [ ] Shadow unlocks correctly after surviving 15:00 in Story Mode
- [ ] Golden shows unlock requirement (locked until Story Mode beaten)
- [ ] Golden unlocks correctly after beating Story Mode
- [ ] Unlock notifications display
- [ ] Character selection persists for the run
- [ ] Character stat modifiers apply correctly (HP, speed, damage)
- [ ] Each variant visually distinct (placeholder colors)

## Endless Mode

- [ ] Endless Mode locked initially
- [ ] Unlocks after Story Mode victory
- [ ] Endless Mode button appears on main menu
- [ ] No win condition (play until death)
- [ ] Same scaling as Story Mode (continues past 30:00)
- [ ] Best time saved separately
- [ ] Best time displayed on main menu
- [ ] Results screen works for Endless Mode

## Save System

- [ ] Character unlocks persist in save file
- [ ] Endless Mode unlock persists in save file
- [ ] Best times tracked separately for Story/Endless
- [ ] High scores tracked separately for Story/Endless

## Technical

- [ ] No console errors
- [ ] Save/load works correctly with new fields
- [ ] Unlock logic triggers correctly

---

# MINIMUM VIABLE PRODUCT CHECKPOINT

**At the end of Week 6, you have a SHIPPABLE game:**

- Complete survivor game with core loop
- 3 characters (Classic, Shadow, Golden), 4 enemies, 6 weapons, 4 passives
- Story Mode (30-minute survival with win condition)
- Endless Mode (survive as long as possible)
- Shop progression (permanent upgrades)
- Save system (gold, unlocks, high scores)
- Placeholder SFX for game feel (from Weeks 2-3)
- Damage numbers and enemy flash (from Week 3)

**This is SHIPPABLE as Early Access!**

Weeks 7-14 are polish, art, audio, balance, and launch prep. The game is functionally complete after Week 6.

---

**Related Files:**

- [Character Variants](prd-characters-variants.md) - Feature 11
- **Next Milestone:** Weeks 7-11 (Polish: Settings, Art, Audio, Balance) - See [../polish/prd-polish-feel.md](../polish/prd-polish-feel.md)
