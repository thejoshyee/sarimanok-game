# Sarimanok Survivor - Character Variety & Endless Mode (Week 6)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026
- **Price:** $2.99-4.99

By Week 6, you have a complete, winnable game: Classic Sarimanok, 4 enemies (Green/Red Duwende, Santelmo, Manananggal boss), 6 weapons, 4 passives, level-up system, shop progression, win condition (30:00 dawn), and save system. This milestone adds **character variety** (Shadow & Golden Sarimanok variants) and **Endless Mode** for replayability. After this week, you have a **SHIPPABLE MVP**.

## Dependencies

**Must be completed from Weeks 1-5:**

- Complete Story Mode (survive to 30:00 = victory)
- All 4 enemies functional (Green/Red Duwende, Santelmo, Manananggal)
- Shop system with 3 permanent upgrades (Damage, HP, Speed)
- Save system persisting gold and shop upgrades
- High score tracking for Story Mode
- Results screen showing stats (time, kills, score, gold)
- Main menu with Story Mode and Shop buttons

## Deferred to Later Milestones

- **Polish (settings, controller UX, juice)** → Week 7
- **Art integration** → Week 8
- **Audio polish** → Week 9
- **Balance & bugs** → Week 11
- **Steam build & demo** → Week 10

---

# Feature 11: Character Variants

**What It Does:**
Three Sarimanok variants with different stats encourage different playstyles. Shadow (glass cannon) and Golden (tank) must be unlocked through gameplay achievements.

## Character Roster (3 Variants)

| Character               | Colors           | HP  | Speed | Damage | Playstyle                      | Unlock                      |
| ----------------------- | ---------------- | --- | ----- | ------ | ------------------------------ | --------------------------- |
| **Sarimanok (Classic)** | Rainbow/vibrant  | 100 | 100%  | 100%   | Balanced, good for learning    | Default                     |
| **Sarimanok (Shadow)**  | Dark purple/blue | 80  | 100%  | 125%   | Glass cannon, high risk/reward | Survive 15:00 in Story Mode |
| **Sarimanok (Golden)**  | Gold/red/bronze  | 130 | 85%   | 100%   | Tank, sustained survival       | Beat Story Mode (30:00)     |

## Character Differences

**Classic Sarimanok:**

- 100 HP, 100% speed, 100% damage
- Balanced stats good for learning
- Available from start
- Use ColorRect placeholder: multicolor/rainbow, 32x32

**Shadow Sarimanok:**

- 80 HP (fragile), 100% speed, 125% damage (powerful)
- Glass cannon playstyle: kill fast or die fast
- High risk, high reward
- Unlocks: survive to 15:00 in a single Story Mode run
- Use ColorRect placeholder: dark purple/blue, 32x32

**Golden Sarimanok:**

- 130 HP (tank), 85% speed (slower), 100% damage
- Tank playstyle: sustained survival, absorb hits
- Great for learning boss patterns
- Unlocks: beat Story Mode (survive to 30:00)
- Use ColorRect placeholder: gold/bronze, 32x32

## Unlock Progression

**Shadow at 15:00:**

- Achievable in 3-5 attempts
- Proves you can handle mid-game difficulty
- Must be in Story Mode specifically (not Endless)
- Unlocks permanently once achieved

**Golden at 30:00:**

- Requires beating Story Mode completely
- Reward for first victory
- Unlocks permanently once achieved

## Character Select Screen

```
┌─────────────────────────────────────────────┐
│         SELECT YOUR SARIMANOK               │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐     │
│  │ CLASSIC │  │ SHADOW  │  │ GOLDEN  │     │
│  │  🐓 🌈  │  │  🐓 🌙  │  │  🐓 ⭐  │     │
│  │         │  │         │  │         │     │
│  │ HP: 100 │  │ HP: 80  │  │ HP: 130 │     │
│  │ SPD:100%│  │ SPD:100%│  │ SPD:85% │     │
│  │ DMG:100%│  │ DMG:125%│  │ DMG:100%│     │
│  │         │  │         │  │         │     │
│  │[SELECT] │  │ 🔒15:00 │  │ 🔒BEAT  │     │
│  └─────────┘  └─────────┘  └─────────┘     │
│                                             │
│         [BACK TO MENU]                      │
└─────────────────────────────────────────────┘
```

**Locked character display:**

- Show stats but grayed out
- Display lock icon 🔒
- Show unlock requirement text
- Cannot be selected until unlocked

**Unlocked character display:**

- Full color
- [SELECT] button enabled
- Highlight selected character

## Technical Requirements

- Character select scene before starting a run
- Load character stats based on selection
- Check unlock conditions from save file
- Display lock/unlock status correctly
- Persist character unlocks in save file
- Apply character stat modifiers at run start

## Save File Updates

Add unlock tracking to save data:

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
  "best_time_story": "30:00"
}
```

## Unlock Logic

```gdscript
# In GameState.gd

func check_shadow_unlock():
    """Call when run ends. Check if player survived 15:00 in Story Mode."""
    if time_survived >= 900.0 and not shadow_unlocked:  # 15:00 = 900 seconds
        shadow_unlocked = true
        show_unlock_notification("Shadow Sarimanok")
        save_game()

func check_golden_unlock():
    """Call when Story Mode victory at 30:00."""
    if not golden_unlocked:
        golden_unlocked = true
        show_unlock_notification("Golden Sarimanok")
        save_game()
```

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

**Next Milestone:** Weeks 7-11 (Polish: Settings, Art, Audio, Balance) - See `prd-polish.md`
