# Sarimanok Survivor - Character Variants (Week 6)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** phase-based, no fixed dates — see CLAUDE.md
- **Price:** $2.99 EA → $4.99 at 1.0 (see full-release-roadmap.md §Pricing Strategy)

By Week 6, you have a complete, winnable game: Classic Sarimanok, 4 enemies (Green/Red Duwende, Santelmo, Manananggal boss), 6 weapons, 4 passives, level-up system, shop progression, win condition (30:00 dawn), and save system. This milestone adds **character variety** (Shadow & Golden Sarimanok variants).

## Dependencies

**Must be completed from Weeks 1-5:**

- Complete Story Mode (survive to 30:00 = victory)
- All 4 enemies functional (Green/Red Duwende, Santelmo, Manananggal)
- Shop system with 3 permanent upgrades (Damage, HP, Speed)
- Save system persisting gold and shop upgrades
- High score tracking for Story Mode
- Results screen showing stats (time, kills, score, gold)
- Main menu with Story Mode and Shop buttons

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

Unlock tracking persists via `SaveManager`. **Canonical schema:** [prd-progression-state.md §Save Data Format](../progression/prd-progression-state.md) — do not duplicate the JSON here. This module's keys: `shadow_unlocked`, `golden_unlocked`.

## Unlock Logic

```gdscript
# In save_manager.gd (see prd-progression-state.md — GameState is only a reset orchestrator)

func check_shadow_unlock():
    """Call when run ends. Check if player survived 15:00 in Story Mode."""
    if GameTimer.elapsed_time >= 900.0 and not shadow_unlocked:  # 15:00 = 900 seconds
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

**Related Files:**

- [Endless Mode](prd-characters-endless.md) - Feature 12, Week 6 tasks & MVP Checkpoint

---

# Art Integration Checkpoint - Character Variants (Optional)

**Trigger:** Complete this after character select code is done, IF Ericka has delivered Shadow and/or Golden Sarimanok art.

## Verification Checklist - Shadow Sarimanok

- [ ] **Sprite (32x32):** Dark purple/blue color palette
- [ ] **Visual Distinction:** Immediately recognizable as different from Classic
- [ ] **Silhouette:** Still reads as "bird" despite darker colors
- [ ] **Animation:** 2-frame bob animation works correctly
- [ ] **Sprite Flip:** Flips correctly when moving left/right

## Verification Checklist - Golden Sarimanok

- [ ] **Sprite (32x32):** Gold/red/bronze color palette
- [ ] **Visual Distinction:** Immediately recognizable as different from Classic and Shadow
- [ ] **Silhouette:** Still reads as "bird" with metallic colors
- [ ] **Animation:** 2-frame bob animation works correctly
- [ ] **Sprite Flip:** Flips correctly when moving left/right

## Character Select Screen

- [ ] **All 3 Variants Visible:** Distinct at character select preview size
- [ ] **Color Contrast:** No variant blends into UI background
- [ ] **Locked State:** Grayed-out versions still distinguishable
- [ ] **Joint Review:** Show all variants side-by-side to Ericka (10 min)

## If Issues Found

1. Document specific issue (screenshot + description)
2. Ericka iterates same week if possible
3. Colors too similar: Adjust saturation or hue
4. DO NOT block code progress on art issues

## If Art Not Ready

Skip this checkpoint. Continue with placeholder ColorRects (purple for Shadow, gold for Golden). Art will be integrated in Week 8 polish phase.

