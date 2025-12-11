# Sarimanok Survivor - Win Condition & Enhanced Enemies (Week 4)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026
- **Price:** $2.99-4.99

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
30-minute timer counts up. Surviving to 30:00 = VICTORY (dawn, rooster crows). HP reaching 0 = DEFEAT.

## Timer Display

```
┌──────────────┐
│    12:47     │
└──────────────┘
```

Position: Top center of screen
Format: MM:SS
Counts UP from 0:00

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

**Scene Structure:**

```
Main Scene
├── ParallaxBackground (Sky Layer)
│   ├── Sky (ColorRect or Sprite2D - gradient)
│   ├── Moon (Sprite2D - SOURCED, not custom)
│   └── Stars (Sprite2D or particles - SOURCED)
│
├── CanvasModulate (Night Filter - tints everything below)
│
├── Background (Bahay kubo, trees - gets tinted)
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

**Sky Elements (SOURCED - Not Custom):**

- **Moon:** Source from asset pack or free sprites (32x32 or 48x48)
- **Stars:** Source from asset pack, or use simple white dots/particles
- **Sky gradient:** Can be created in Godot using `GradientTexture2D` (no art file needed)

**Transition Code Example:**

```gdscript
func trigger_dawn_transition():
    var tween = create_tween()

    # 1. Fade out moon and stars (2 seconds)
    tween.tween_property($Moon, "modulate:a", 0.0, 2.0)
    tween.parallel().tween_property($Stars, "modulate:a", 0.0, 2.0)

    # 2. Shift sky gradient from night blue to warm dawn
    tween.parallel().tween_property($Sky, "modulate", Color(1.0, 0.8, 0.6), 2.0)

    # 3. Shift CanvasModulate from night tint to warm dawn
    tween.parallel().tween_property($CanvasModulate, "color", Color(1.0, 0.95, 0.9), 2.0)

    await tween.finished
    # Continue to victory screen, play COCKADOODLEDOO, etc.
```

**Visual Timeline:**
| Time | Sky | Moon/Stars | CanvasModulate |
| ------------------ | --------------------- | ---------- | -------------------- |
| 0:00-29:59 | Dark blue/purple | Visible | Night tint (blue) |
| 30:00 (transition) | Shifts to orange/pink | Fading out | Shifts to warm white |
| 30:02+ | Warm dawn colors | Gone | Natural colors |

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
  Bonus gold drop (100g)
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

## Updated Enemy Drops

| Enemy         | XP Drop | Gold Drop |
| ------------- | ------- | --------- |
| Green Duwende | 1       | 1         |
| Red Duwende   | 3       | 2         |
| Santelmo      | 4       | 3         |
| Manananggal   | 50      | 100       |

---

**Related Files:**
- [Shop System & Score](prd-progression-meta.md) - Features 9-10
- [Save System & GameState](prd-progression-state.md) - Week 4-5 tasks & Definition of Done










