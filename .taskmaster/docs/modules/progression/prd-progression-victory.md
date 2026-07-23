# Sarimanok Survivor - Win Condition & Enhanced Enemies (Week 4)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** phase-based, no fixed dates — see CLAUDE.md
- **Price:** $2.99 EA → $4.99 at 1.0 (see full-release-roadmap.md §Pricing Strategy)

By Week 4, you have a complete gameplay loop: Classic Sarimanok, 2 Duwende enemies (Green/Red), 6 weapons, 4 passives, level-up system, and XP/Gold pickups. This milestone adds the **win condition** (survive to 30:00 dawn) and remaining enemies (Santelmo, Manananggal boss).

## Dependencies

**Must be completed from Weeks 1-3:**

- Classic Sarimanok (movement, combat, stats)
- Green & Red Duwende enemies
- All 6 weapons functional (Peck, Wing Slap, Feather Shot, Spiral Feathers, Ice Shard, Flame Wing)
- All 4 passives functional (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)
- Level-up system with 3 random choices
- XP gems and Gold coins drop from enemies
- Timer counts up from 0:00
- Basic HUD (HP bar, XP bar, timer)
- Game over screen on death

---

# Feature 7: Game Timer & Win Condition

**What It Does:**
30-minute run. The HUD shows a countdown — time remaining until dawn. Reaching 0:00 = VICTORY (dawn, rooster crows). HP reaching 0 = DEFEAT.

## Timer Display

```
┌──────────────┐
│    12:47     │
└──────────────┘
```

Position: Top center of screen
Format: MM:SS (time REMAINING until dawn)
Counts DOWN from 30:00 to 0:00 — decided 2026-07-22, as built in `game/scripts/ui/hud.gd`. Internally `GameTimer.elapsed_time` counts UP; only the display inverts it. Endless Mode will need a count-up display (see prd-characters-endless.md).

## Win Condition (Story Mode)

```
Timer reaches 30:00
    ↓
Freeze gameplay
    ↓
Screen brightens (dawn effect)
    ↓
"COCKADOODLEDOO!" text appears
    ↓
Sarimanok crow sound effect
    ↓
"VICTORY! Balance is restored!"
    ↓
Show results screen
```

## Lose Condition

```
Player HP reaches 0
    ↓
Death animation (Sarimanok falls)
    ↓
"You survived 12:47"
    ↓
Show results screen (same as win, different header)
```

## Results Screen

```
┌─────────────────────────────────────┐
│   VICTORY! / DEFEATED               │
│                                     │
│   Time Survived: 30:00 / 12:47      │
│   Enemies Killed: 847               │
│   Score: 15,420                     │
│   Gold Earned: 312                  │
│                                     │
│   [SHOP]   [RETRY]   [MENU]         │
└─────────────────────────────────────┘
```

## Dawn Transition Implementation

**Technical Approach:** The night-to-day transition uses a **CanvasModulate** node to apply a color filter over all game elements. No duplicate tile art is needed—the same tiles are used for both night and day, with the filter creating the time-of-day effect.

**Key Principle:** Tiles are drawn in **normal/natural colors** (as if daytime). The CanvasModulate applies the night tint during gameplay. At victory, the tint fades to reveal the "dawn" version that was there all along.

> **Scope decision (2026-07-22):** The originally-specced ParallaxBackground sky layer (gradient Sky, Moon, Stars) was a wrong vision and is **CUT — do not re-add**. The dawn effect is CanvasModulate-only, implemented in `game/scripts/core/dawn_controller.gd` (task 50).

**Scene Structure (as built):**

```
Main Scene
├── CanvasModulate (Night Filter - tints everything below)
├── DawnController (Node - owns the dawn tween; exports canvas_modulate_path)
├── TileMap (Ground/decorations - gets tinted)
├── Player (gets tinted)
├── Enemies (gets tinted)
└── Camera2D
```

**Color Values:**
| State | CanvasModulate Color | Effect |
| ---------------- | ----------------------- | -------------------------- |
| Night (gameplay) | `Color(0.6, 0.6, 0.8)` | Slight blue/cool tint |
| Dawn (victory) | `Color(1.0, 0.95, 0.9)` | Warm white, natural colors |

**Transition (as built — `game/scripts/core/dawn_controller.gd`):**

```gdscript
func _on_run_won() -> void:
    if _transition_started:
        return
    _transition_started = true
    var tween := create_tween()
    tween.tween_property(canvas_modulate, "color", dawn_color, 2.0)
    await tween.finished
    dawn_transition_finished.emit()  # results screen / crow SFX hook (task 51)
```

**Visual Timeline:**
| Run time (internal) | CanvasModulate |
| ------------------ | -------------------- |
| 0:00-29:59 | Night tint (cool blue) |
| 30:00 (transition) | 2-second tween to warm white |
| 30:02+ | Natural colors |

---

# Feature 8: Enhanced Enemy Roster

## Santelmo (New Enemy - Week 4)

| Property | Value                              |
| -------- | ---------------------------------- |
| HP       | 15                                 |
| Damage   | 8                                  |
| Speed    | 60                                 |
| Spawns   | 10:00+                             |
| Behavior | Floats, shoots fireballs at player |

**Behavior:**

```
Every frame:
  Float toward player (slower, erratic movement)
  Add slight sine wave to path for "floating" feel

Every 2 seconds:
  Shoot fireball projectile toward player

On contact with player:
  player.take_damage(damage)
```

**Santelmo Fireball Specs:**
| Property | Value |
| -------- | ----------------------------- |
| Speed | 150 pixels/second |
| Damage | 8 |
| Cooldown | 2.0 seconds |
| Size | 16x16 pixels |
| Lifetime | 5 seconds (despawn if no hit) |

**Cultural Note:** Santelmo is "Saint Elmo's Fire" - a ball of floating fire/light that appears in forests, swamps, and open fields. Sometimes believed to be souls of the dead, it leads travelers astray.

## Manananggal Boss (Week 4)

| Property | Value                              |
| -------- | ---------------------------------- |
| HP       | 500                                |
| Damage   | 25                                 |
| Speed    | 90                                 |
| Spawns   | 20:00 (one-time dramatic entrance) |
| Size     | 48x48 sprite (larger than normal)  |

**Behavior:**

```
On spawn:
  Play dramatic entrance (screen shake, screech sound)
  48x48 sprite (larger than normal enemies)

Behavior:
  Fly toward player (medium speed, ignores terrain)
  Every 5 seconds: Dive attack (burst of speed toward player)
  Leaves blood trail visual effect

On death:
  Big XP drop (200) + bonus gold (100g) — several late-game levels; killing it must feel worth it
  Unlocks "Aswang Slayer" achievement (see prd-polish-release)
  Does NOT end game (still must survive to 30:00)
```

**Manananggal Dive Attack Specs:**
| Property | Value |
| ------------- | ------------------------------------------------------ |
| Telegraph | 1.0 second warning (sprite flashes red, screech sound) |
| Dive Speed | 3x normal speed (270 pixels/second) |
| Dive Duration | 0.5 seconds |
| Cooldown | 5.0 seconds between dives |
| Damage | 25 (same as contact damage) |

**Cultural Note:** The Manananggal is a type of Aswang from Filipino folklore. It's a self-segmenting vampire—a woman whose upper torso detaches from her lower body, sprouting bat-like wings to fly through the night hunting prey. More iconic and visually striking than a generic shapeshifter.

## Updated Spawn Timeline (Week 4+)

| Time        | Enemies Spawning               | Spawn Rate          |
| ----------- | ------------------------------ | ------------------- |
| 0:00-8:00   | Green Duwende                  | 1 per 2s → 1 per 1s |
| 8:00-10:00  | Green + Red Duwende            | 1 per 1s            |
| 10:00-20:00 | Green + Red Duwende + Santelmo | 1 per 0.8s → 0.5s   |
| 20:00       | **MANANANGGAL SPAWNS**         | One-time            |
| 20:00-30:00 | All enemies + Manananggal      | 1 per 0.3s (chaos!) |

## Spawn Events (added 2026-07-23 — run-density fix, task 60)

The base timeline leaves 0:00–8:00 green-only and adds nothing new after the boss. Spawn EVENTS fix the pacing by reusing existing enemies — **no new art, no new scenes beyond inherited-scene recolors** (same pattern as green/red duwende variants, task 47).

**Event types:**

- **Swarm ring:** ~20 Green Duwendes spawn simultaneously in a circle around the player and converge. Telegraph with a 1s warning sound/flash.
- **Elite duwende:** inherited-scene recolor variant — ~5× HP, 2× damage, darker tint + slightly larger, 5× XP/gold drops. One spawns among the normal flow.

**Event timeline (all numbers tunable at Week 11 balancing):**

| Time  | Event                                    | Purpose                        |
| ----- | ---------------------------------------- | ------------------------------ |
| 4:00  | Swarm ring (Green)                       | Breaks up the green-only stretch |
| 8:00  | (Red Duwende unlocks — base timeline)    |                                |
| 12:00 | First Elite (Green)                      | Mini-boss moment before Santelmo era peaks |
| 16:00 | Swarm ring (Green + Red mix)             | Pressure spike before boss     |
| 22:00 | Elite (Red) + swarm ring                 | Post-boss novelty              |
| 25:00 | Swarm ring, larger (~30)                 | Escalation                     |
| 28:00 | Elite pair + swarm ring                  | Final-stretch climax before dawn |

**Rules:** events are IN ADDITION to the base spawn rate; events pause while `GameTimer.is_gameplay_active()` is false; elites use the existing pool system (small dedicated pools are fine — they're rare).

## Updated Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |
| Santelmo      | 4       | 3         |
| Elite Duwende | 5×base  | 5×base    |
| Manananggal   | 200     | 100       |

**Manananggal XP raised 50 → 200 (2026-07-23):** the boss is optional (killing it never ends the run), so the reward must make the fight clearly worth taking — ~200 XP is several late-game levels. A boss-kill achievement ("Aswang Slayer") reinforces it (see prd-polish-release achievements).

---

**Related Files:**
- [Shop System & Score](prd-progression-meta.md) - Features 9-10
- [Save System & GameState](prd-progression-state.md) - Week 4-5 tasks & Definition of Done

---

# Art Integration Checkpoint - Santelmo & Boss (Optional)

**Trigger:** Complete this after victory/enemy code tasks are done, IF Ericka has delivered Santelmo and/or Manananggal art.

## Sprite Preview Scene

Use the Sprite Preview Scene created in weapons checkpoint (or create now if not done).

## Verification Checklist - Santelmo

- [ ] **Santelmo Sprite (32x32):** Floating fire ball, glows/flickers
- [ ] **Fireball Projectile (16x16):** Distinct from Santelmo itself
- [ ] **Float Animation:** Sine wave movement feels "ghostly"
- [ ] **Visibility:** Stands out against grass AND against Duwendes
- [ ] **Fire Flicker:** Animation plays at ~0.15s per frame

## Verification Checklist - Manananggal Boss

- [ ] **Boss Sprite (48x48):** Feels "boss-sized" next to 32x32 enemies
- [ ] **Wing Animation:** 4 frames, smooth flap cycle
- [ ] **Dive Telegraph:** Red flash is visible and alarming
- [ ] **Blood Trail:** Effect visible but not obscuring gameplay
- [ ] **Dramatic Entrance:** Sprite reads as "threatening"
- [ ] **Joint Review:** Show to Ericka, get feedback (10 min)

## If Issues Found

1. Document specific issue (screenshot + description)
2. Ericka iterates same week if possible
3. **Manananggal Fallback:** Static 1-frame sprite is acceptable for EA (add animation post-launch)
4. DO NOT block code progress on art issues

## If Art Not Ready

Skip this checkpoint. Continue with placeholder ColorRects (32x32 orange for Santelmo, 48x48 dark red for Manananggal). Art will be integrated in Week 8 polish phase.

