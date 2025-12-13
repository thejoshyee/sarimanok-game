# Sarimanok Survivor - Progression & Pickup Systems (Weeks 1-3)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Feature 4: Passive System

**What It Does:**
Passives are stat boosts that stack. Collect them through level-up choices. No animation or visual effect—just numbers.

## Passive Roster (4 Total)

| Passive           | Per Level         | Max Level | At Max             |
| ----------------- | ----------------- | --------- | ------------------ |
| **Iron Beak**     | +10% Damage       | 5         | +50% total damage  |
| **Thick Plumage** | +15 Max HP        | 5         | +75 HP             |
| **Racing Legs**   | +10% Move Speed   | 5         | +50% move speed    |
| **Magnetic Aura** | +20% Pickup Range | 5         | +100% pickup range |

## How Passives Stack

**Example: Iron Beak**

- Level 1: All weapons deal 110% damage
- Level 2: All weapons deal 120% damage
- Level 3: All weapons deal 130% damage
- Level 4: All weapons deal 140% damage
- Level 5: All weapons deal 150% damage

**These multiply with weapon upgrades!**

Peck Level 5 (35 damage) + Iron Beak Level 5 (150%):

```
35 × 1.50 = 52.5 damage per hit
```

## Technical Requirements

- Simple stat modifiers in player script
- Passive manager tracks levels
- Apply modifiers to relevant calculations
- Only needs icon art (16x16)

---

# Feature 5: Level-Up System

**What It Does:**
Collecting XP fills a bar. When full, game pauses and presents 3 random upgrade choices. Player picks one, game resumes.

## XP Curve

| Level | XP Required  | Cumulative |
| ----- | ------------ | ---------- |
| 1→2   | 5            | 5          |
| 2→3   | 10           | 15         |
| 3→4   | 15           | 30         |
| 4→5   | 20           | 50         |
| 5→6   | 25           | 75         |
| ...   | +5 per level | ...        |

Formula: `xp_needed = 5 + (level - 1) * 5`

## Level-Up Screen

```
┌─────────────────────────────────────────────┐
│              LEVEL UP!                      │
├─────────────────────────────────────────────┤
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐     │
│  │  PECK   │  │  WING   │  │  IRON   │     │
│  │   +1    │  │  SLAP   │  │  BEAK   │     │
│  │ Lv.1→2  │  │  NEW!   │  │  NEW!   │     │
│  └─────────┘  └─────────┘  └─────────┘     │
│                                             │
│         Click to choose one                 │
└─────────────────────────────────────────────┘
```

## Choice Pool Logic

The pool contains:

- All weapons not yet at max level (or not owned + slot available)
- All passives not yet at max level (or not owned)

**Example scenarios:**

_Early game (Level 2, only have Peck):_

- Pool: Peck+1, Wing Slap (NEW), Feather Shot (NEW), Iron Beak, Thick Plumage, Racing Legs
- Show 3 random from pool

_Mid game (Have all 6 weapons):_

- Pool: Peck+1, Wing Slap+1, Feather Shot+1, Iron Beak+1, Thick Plumage+1, Racing Legs+1
- No "NEW" weapons (slots full)

_Late game (Peck maxed):_

- Pool excludes Peck entirely
- Only shows upgradeable items

## Technical Requirements

```gdscript
func _on_xp_collected(amount):
    current_xp += amount
    if current_xp >= xp_to_next_level:
        current_xp -= xp_to_next_level
        level += 1
        xp_to_next_level = calculate_xp_needed(level)
        show_level_up_screen()

func show_level_up_screen():
    get_tree().paused = true
    var choices = get_random_choices(3)
    level_up_ui.display(choices)

func _on_choice_selected(choice):
    apply_upgrade(choice)
    get_tree().paused = false
```

---

# Feature 6: Pickup System

**What It Does:**
Enemies drop XP gems and Gold coins. Player walks over them to collect.

## Pickup Types

| Pickup        | Visual                | Effect                 |
| ------------- | --------------------- | ---------------------- |
| **XP Gem**    | Blue diamond (16x16)  | Adds to XP bar         |
| **Gold Coin** | Yellow circle (16x16) | Adds to permanent gold |

## Pickup Behavior

- Spawns at enemy death location
- Sits still for 0.5s (brief pause)
- Then slowly drifts toward player (magnetic effect)
- Collected when touching player hitbox
- Collection range increased by Magnetic Aura passive

## Magnet Effect

```gdscript
func _process(delta):
    var distance = global_position.distance_to(player.global_position)
    if distance < player.pickup_range:
        var direction = (player.global_position - global_position).normalized()
        global_position += direction * magnet_speed * delta
```

## Technical Requirements

- Pickup scene (Area2D with sprite)
- Spawned by enemy on death
- Magnetic drift toward player when close
- Collected on overlap with player
- Play collect sound
- Show "+1" floating text (nice-to-have)

## Placeholder Art (Week 1-3)

- XP Gem: ColorRect, blue, 16x16
- Gold Coin: ColorRect, yellow, 16x16

---

# Week 1: The Core Loop

**End State: "I can play a survivor game"**

What's playable at end of week:

- Sarimanok moves with WASD in a bounded arena
- Peck attack fires automatically
- Green Duwendes spawn and walk toward player
- Duwendes die when hit, drop XP gem (placeholder)
- Player dies when HP = 0
- Game over screen shows "You died"

## Tasks

- [ ] Create project structure
- [ ] Set up project settings (640×360 viewport, canvas_items stretch)
- [ ] **Set up Audio buses in Project Settings (Master, Music, SFX) - do this Day 1, takes 5 minutes, prevents hours of headache later**
- [ ] **Configure Input Map in Project Settings**: Map 'Spacebar' and 'Gamepad A' to 'ui_accept' (makes controller support free/automatic).
- [ ] Create TileMap with placeholder tileset (simple colored squares)
- [ ] Paint basic 60×34 arena with placeholder tiles
- [ ] Set up Camera2D with limits (0,0 to 1920,1088)
- [ ] Add invisible boundary collision (StaticBody2D)
- [ ] Implement player movement (WASD) using `Input.get_action_strength()` for analog support
- [ ] Create placeholder Sarimanok sprite (colored rectangle 32x32)
- [ ] Implement Peck attack (auto-fire, cooldown)
- [ ] Create placeholder Duwende (green rectangle 32x32)
- [ ] Duwende walks toward player
- [ ] Duwende takes damage from Peck
- [ ] Duwende dies and drops placeholder XP gem
- [ ] Player takes damage from enemy contact
- [ ] Player dies at 0 HP, shows game over
- [ ] **Use `tr()` function for all UI text strings (localization prep - costs nothing now)**
- [ ] **Create `localization/translations.csv` with initial UI strings (30 min - enables community translations later)**

**Integration Test:** Can you survive for 60 seconds dodging and pecking?

---

# Week 2: Progression Loop

**End State: "I can level up and get stronger"**

Builds on Week 1, adds:

- XP gems are collected and fill XP bar
- Level up pauses game, shows 3 choices
- Choices: Peck +1, Wing Slap (new), Iron Beak (new)
- Wing Slap weapon works (AOE circle)
- Iron Beak passive increases damage
- Red Duwende spawns (recolor, higher stats)
- Timer shows on screen (counts up)

## Tasks

- [ ] XP gem pickup works
- [ ] XP bar UI displays
- [ ] Level up triggers at threshold
- [ ] Level up screen pauses game
- [ ] Display 3 random choices (placeholder buttons)
- [ ] Clicking choice applies upgrade and resumes game
- [ ] Wing Slap weapon (AOE circle around player)
- [ ] Iron Beak passive (damage boost)
- [ ] Add Red Duwende (recolor, different stats)
- [ ] Timer displays on screen
- [ ] Enemy stat scaling (HP/damage increase over time)
- [ ] **Placeholder SFX: Peck attack sound (use BFXR or free sound pack)**
- [ ] **Placeholder SFX: Enemy hit sound**
- [ ] **Placeholder SFX: XP pickup sound**

**Integration Test:** Can you reach level 10 with 2 weapons + 1 passive?

---

# Week 3: Full Arsenal + Data-Driven Architecture

**End State: "I can build different weapon combos with scalable architecture"**

Builds on Week 2, adds:

- Feather Shot weapon (projectile toward nearest enemy)
- All 4 passives working (Thick Plumage, Racing Legs, Magnetic Aura)
- All weapons/passives upgrade to level 5
- **Data-driven WeaponData Resource system**
- **2 Clone weapons (Ice Shard, Flame Wing) for build variety**
- **Damage numbers on enemy hit (debugging tool)**
- **Enemy damage flash (white flash on hit)**

## Tasks

- [ ] Feather Shot weapon (projectile)
- [ ] Thick Plumage passive (+HP)
- [ ] Racing Legs passive (+speed)
- [ ] **Spiral Feathers weapon (4 feathers orbit player, damage on contact)**
- [ ] **Magnetic Aura passive (+20% pickup range per level, max 5 = +100%)**
- [ ] **WeaponData Resource class (data-driven weapon definitions)**
- [ ] **Debuff system (slow effect for Ice Shard)**
- [ ] **Ice Shard clone weapon (blue Feather Shot + 0.5s slow debuff)**
- [ ] **Flame Wing clone weapon (orange Wing Slap, +20% damage, smaller radius)**
- [ ] Weapon upgrades to level 5 work
- [ ] Passive upgrades to level 5 work
- [ ] Max 6 weapons enforced in level-up pool
- [ ] Level-up pool includes all weapons/passives correctly
- [ ] **Damage numbers (floating text on enemy hit - CRITICAL for balance testing)**
- [ ] **Enemy damage flash (white flash on hit - game feel)**
- [ ] **Placeholder SFX: Wing Slap sound**
- [ ] **Placeholder SFX: Feather Shot sound**
- [ ] **Placeholder SFX: Spiral Feathers sound**
- [ ] **Placeholder SFX: Enemy death sound**
- [ ] **Placeholder SFX: Gold pickup sound**

**Integration Test:** Can you max out 6 weapons and 4 passives in one run? Do damage numbers appear on hits?

---

# Definition of Done (Weeks 1-3)

## Core Gameplay

- [ ] Player moves in all 8 directions
- [ ] Player takes damage from enemies
- [ ] Player dies at 0 HP
- [ ] Peck attack damages enemies
- [ ] Wing Slap damages nearby enemies
- [ ] Feather Shot fires projectiles
- [ ] Spiral Feathers orbit and damage enemies
- [ ] Ice Shard slows enemies
- [ ] Flame Wing is smaller AOE with higher damage
- [ ] All weapons auto-fire correctly
- [ ] Weapons upgrade through level-ups
- [ ] Passives boost stats correctly (Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura)

## Enemies

- [ ] Green Duwende spawns and walks toward player
- [ ] Red Duwende is stronger than Green
- [ ] All enemies drop XP and Gold
- [ ] Spawn rate increases over time
- [ ] Enemy stat scaling works (HP/damage increase over time)

## Progression

- [ ] XP collected fills bar
- [ ] Level up pauses game
- [ ] 3 choices displayed
- [ ] Choice applies correctly
- [ ] Game resumes after choice
- [ ] Gold persists after run ends

## Technical

- [ ] 60 FPS with 100+ enemies
- [ ] No memory leaks (long runs)
- [ ] No console errors
- [ ] Damage numbers appear on hits
- [ ] Enemy flash when hit
- [ ] Placeholder SFX for game feel

---

**Related Files:**
- [Core Foundation](prd-core-foundation.md) - Player Character (Feature 1)
- [Enemy System](prd-core-enemies.md) - Feature 2
- [Weapon System](prd-core-weapons.md) - Feature 3
- **Next Milestone:** Week 4-5 (Win Condition & Shop System) - See [../progression/prd-progression-victory.md](../progression/prd-progression-victory.md)
