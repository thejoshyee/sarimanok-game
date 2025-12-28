# Ericka's Art Checklist

> **Total Estimated Time:** 20-27 hours
> **Target Completion:** Week 6 (before baby buffer)
> **Priority:** Characters FIRST, then Farm Tileset (needed for playable demo)

---

## 🎮 How Weapons Work (READ THIS FIRST!)

**Important:** In survivor games like Vampire Survivors, the player character **NEVER animates attacking**. The Sarimanok just bobs/walks - that's it. Weapons are **separate visual effects** that spawn around or shoot from the player automatically.

**Think of it like this:**

- The Sarimanok sprite only has 2 frames (bob up/down)
- Weapons are independent sprites that appear/disappear on cooldowns
- The code spawns these weapon effects - Ericka just draws what they look like

**Example from Vampire Survivors:**

- Garlic = expanding circle appears around player (AOE)
- Knife = small knife sprite shoots forward (projectile)
- Bible = book sprites orbit around the player (orbital)
- Whip = slash effect appears in direction player faces (melee)

---

## 🐓 Player Characters (5-6 hrs total)

### Sarimanok Classic ⭐ PRIORITY

- [ ] Sprite (32x32, 2 frames) — 3-4 hrs

**What it looks like:**

- Legendary Maranao bird with rainbow/vibrant colors
- Key features: decorative fan-like tail plumes, distinctive head crest, proud upright posture
- Reference traditional Maranao okir patterns for color inspiration
- Colors: Red, orange, yellow, gold, teal accents

**Animation (2 frames):**

- Frame 1: Standing neutral
- Frame 2: Slight bob down (1-2 pixels lower) — creates bounce when walking

**Design tips:**

- At 32x32, focus on SILHOUETTE over detail
- The decorative tail is the most recognizable feature
- Strong black outline for readability
- Code handles flipping sprite for left/right movement

---

### Sarimanok Shadow

- [ ] Sprite (32x32, 2 frames) — 1 hr (recolor of Classic)

**What it looks like:**

- Same shape as Classic, different colors
- Dark purple/midnight blue body
- Pale violet/silver highlights
- Glowing red or purple eyes (menacing look)
- This is the "glass cannon" - fast & deadly but fragile

---

### Sarimanok Golden

- [ ] Sprite (32x32, 2 frames) — 1 hr (recolor of Classic)

**What it looks like:**

- Same shape as Classic, different colors
- Rich gold primary color
- Bronze and copper tail accents
- Red highlights
- This is the "tank" - slow but tough

---

## 👹 Enemies (9.5-13.5 hrs total)

### Green Duwende

- [ ] Sprite (32x32, 2 frames) — 2-3 hrs

**What it looks like:**

- Small goblin/dwarf creature from Filipino folklore
- Oversized head (takes up ~half the sprite height)
- Pointy ears sticking out sideways
- Small squat body, short stubby legs
- Mischievous expression: large eyes, small grin
- Colors: Forest green skin, darker green shadows, maybe brown loincloth

**Animation (2 frames - waddle walk):**

- Frame 1: Feet apart in standing position
- Frame 2: Feet together/crossed (mid-step)
- Creates waddling motion when looped

---

### Red Duwende

- [ ] Sprite (32x32, 2 frames) — 20 min (recolor of Green)

**What it looks like:**

- Same sprite as Green Duwende, just recolored
- Deep red/burgundy skin
- Maybe yellow eyes for more aggressive look
- This variant is more territorial/angry

---

### Santelmo

- [ ] Sprite (32x32, 2 frames) — 2-3 hrs

**What it looks like:**

- Ball of floating fire/light (Saint Elmo's Fire)
- NO face or creature features - it's pure fire
- Bright white/yellow core (hottest part)
- Orange middle ring
- Red/transparent flame edges
- Irregular flickering outline

**Animation (2 frames - flicker):**

- Frame 1: Flame shape A
- Frame 2: Different flame outline (shifted tendrils)
- Plays FAST (0.15s per frame) for fire effect
- The outline should change between frames - fire doesn't hold shape

---

### Manananggal (Boss) ⚠️ HIGH EFFORT

- [ ] Sprite (48x48, 4 frames) — 5-7 hrs

**What it looks like:**

- Flying female torso with bat wings - NO lower body
- Long flowing black hair
- Pale/corpse-like skin (gray-white or pale green)
- Large bat-like wings spanning most of the width
- Trailing viscera/entrails where body is severed (dark red)
- Glowing red eyes
- Grotesque but readable silhouette

**Animation (4 frames - wing flap):**

- Frame 1: Wings fully up
- Frame 2: Wings horizontal (going down)
- Frame 3: Wings fully down
- Frame 4: Wings horizontal (going up)
- Body mostly static, wings do all the movement
- Hair can sway slightly between frames

**Fallback:** If this is blocking progress, create a static 1-frame sprite (saves 4-5 hrs). Can add animation post-launch.

---

### Black Duwende (Update 1 - NOT for EA)

- [ ] Sprite (32x32, 2 frames) — 20 min (recolor)

**What it looks like:**

- Recolor of Green Duwende
- Dark gray/black skin with purple highlights
- Glowing red or yellow eyes
- Most menacing variant

---

## ⚔️ Weapon Icons (2 hrs total)

These are **16x16 icons** shown in the HUD and level-up screen. They represent the weapon, not the attack itself.

| Icon                | Size  | Time   | Description                                                                                                                |
| ------------------- | ----- | ------ | -------------------------------------------------------------------------------------------------------------------------- |
| [ ] Peck            | 16x16 | 30 min | **A sharp bird beak pointing right.** Show just the beak shape, maybe with small motion lines. Think "quick jab."          |
| [ ] Wing Slap       | 16x16 | 30 min | **A wing with motion swoosh lines.** The wing should look like it's mid-swing. Curved motion lines suggest circular sweep. |
| [ ] Feather Shot    | 16x16 | 30 min | **A single feather pointing right.** Elegant, flowing feather shape. This is also reused for the projectile sprite.        |
| [ ] Spiral Feathers | 16x16 | 30 min | **3-4 small feathers arranged in a circle/spiral pattern.** Suggests orbiting motion.                                      |
| [ ] Ice Shard       | 16x16 | 15 min | **Blue recolor of Feather Shot icon.** Add blue/cyan tint, maybe some ice crystal sparkle.                                 |
| [ ] Flame Wing      | 16x16 | 15 min | **Orange/red recolor of Wing Slap icon.** Add warm fire colors, maybe some flame wisps at edges.                           |

---

## 💥 Weapon Effects (2.5-3.5 hrs total)

**These are the actual attack visuals that spawn during gameplay.** The Sarimanok never animates attacking - these effects just appear/fire automatically.

---

### Feather Projectile

- [ ] 16x16, 1 frame — 30 min

**What it is:** A feather that shoots toward enemies (like knife in Vampire Survivors)

**What it looks like:**

- Single elegant feather, pointing RIGHT
- Colorful (matches Sarimanok colors: red/orange/gold)
- Clear directional shape - must read well when rotated
- Code handles rotation to aim at enemies

**How it works in-game:**

- Spawns at Sarimanok's position
- Flies toward nearest enemy
- Can reuse this exact sprite for Spiral Feathers (code rotates it)

---

### Ice Shard Projectile

- [ ] 16x16, 1 frame — 15 min (blue recolor)

**What it is:** A cold feather that slows enemies

**What it looks like:**

- Same shape as Feather Projectile
- Blue/cyan color palette
- Maybe add a few ice crystal sparkles
- Slightly transparent/glowing look

---

### Peck Hit Effect

- [ ] 32x32, 2-3 frames — 1 hr

**What it is:** A quick jab that appears in front of the Sarimanok (like whip in Vampire Survivors)

**What it looks like:**

- **Directional thrust pointing OUTWARD** from center
- NOT a generic impact spark
- Think: sharp beak strike with motion lines
- Should clearly show direction of attack
- Frame 1: Thrust appears
- Frame 2-3: Thrust extends/fades

**Visual reference:**

```
Frame 1:        Frame 2:        Frame 3:
   →              →→             →→→
  ──●            ───●           ────●
   →              →→             →→→
(appears)     (extends)        (fades)
```

**How it works in-game:**

- Spawns in front of Sarimanok (direction they're facing)
- Quick flash - damages enemies in small cone
- Very fast animation (appears and disappears quickly)

---

### Wing Slap Circle

- [ ] 64x64, 2-3 frames — 1-2 hrs

**What it is:** A circular sweep that damages ALL enemies around the Sarimanok (like garlic in Vampire Survivors)

**What it looks like:**

- **Expanding circular swoosh/wave**
- NOT just a simple circle - needs motion!
- Radiating lines suggesting outward sweep
- Feathery/wind-like edges
- Frame 1: Small circle appears
- Frame 2: Circle expands with motion lines
- Frame 3: Circle at full size, fading

**Visual reference:**

```
Frame 1:        Frame 2:        Frame 3:
    ·              ╲│╱            ╲ │ ╱
   (●)            ─(●)─          ──(●)──
    ·              ╱│╲            ╱ │ ╲
 (small)       (expanding)     (full size)
```

**How it works in-game:**

- Spawns centered on Sarimanok
- Expands outward, damaging all nearby enemies
- Code positions it - Ericka just draws the effect

---

### Flame Wing Circle

- [ ] 64x64, 2-3 frames — 15 min (orange recolor)

**What it is:** A fiery version of Wing Slap (smaller radius, more damage)

**What it looks like:**

- Same animation as Wing Slap Circle
- Orange/red/yellow fire colors
- Add flame wisps at the edges
- Slightly smaller feeling (75% of Wing Slap conceptually)

---

### Spiral Feathers (NO NEW ART NEEDED)

- Uses Feather Projectile sprite
- Code places 4-8 feathers orbiting the Sarimanok
- Code handles rotation as they circle
- **Ericka doesn't need to draw anything new for this!**

---

## 🏠 Farm Tileset - Filipino Elements (2-3 hrs)

These tiles give the farm arena its Filipino identity. Generic tiles (grass, dirt, rocks, trees) will come from purchased asset packs.

### Arena Layout Reference (Top-Down View)

This is a bird's eye view looking straight DOWN at the ground (like Google Maps satellite view). There is NO horizon - "north" just means top of the map.

```
┌──────────────────────────────────────────────────────────────────────────────┐
│ [Trees]  [BAHAY KUBO]  [Trees]        [RICE PADDIES]               [Trees]   │  Rows 0-12
│           (2x2 tiles)            (alternating water/plant rows)              │  NORTH
│                                   ════════════════════════                   │
│                                   ░░░░░░░░░░░░░░░░░░░░░░░░                   │
│                                   ════════════════════════                   │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ [Fence]              OPEN GRASS AREA                                [Fence]  │  Rows 13-24
│                      (grass variations, dirt paths)                          │
│                                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│                    CENTER PLAY AREA - MOSTLY OPEN                            │  Rows 25-42
│                    (light grass, scattered rocks/tufts)                      │  MAIN GAMEPLAY
│                    (where player spends most time)                           │
│                                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ [Fence]      VEGETABLE PLOTS              OPEN AREA                 [Fence]  │  Rows 43-54
│              (rows of crops)                                                 │
│                                                                              │
├──────────────────────────────────────────────────────────────────────────────┤
│ [Trees]   [Fence posts]    [CART/WELL]    [Fence posts]             [Trees]  │  Rows 55-63
│                            (landmark)                                        │  SOUTH
└──────────────────────────────────────────────────────────────────────────────┘
  Cols 0-6                                                           Cols 89-95
  WEST                                                               EAST
```

**What Ericka draws:** Bahay kubo, rice paddies, cart/well, (optional) bamboo fence
**From asset packs:** Grass, dirt, trees, rocks, generic fence

### Bahay Kubo ⭐ REQUIRED

- [ ] Sprite (64x64, as 2x2 tiles) — 1-2 hrs

**What it looks like:**

- Traditional nipa hut on stilts
- Steep thatched roof made of nipa palm leaves
- Warm wood tones (browns, tans)
- Warm light glowing from windows (night scene)
- Recognizable silhouette even at small size

**Design tips:**

- The 2x2 layout: TL (roof left), TR (roof right), BL (stilts left), BR (stilts right)
- Focus on the iconic triangular roof shape
- Stilts visible at bottom

---

### Rice Paddy Tiles ⭐ REQUIRED

- [ ] Water tile (32x32) — 30 min
- [ ] Plant tile (32x32) — 30 min

**What they look like:**

**Water tile:**
- Blue-green flooded field base
- Slight ripple or reflection hints
- This is the "between rows" tile

**Plant tile:**
- Green rice stalks growing upward
- Muddy/watery base visible
- Arranged in neat row pattern

**How they're used in the tilemap:**
```
Row 2: [water][water][water][water][water]
Row 3: [plant][plant][plant][plant][plant]
Row 4: [water][water][water][water][water]
Row 5: [plant][plant][plant][plant][plant]
```
Creates the signature look of Filipino rice farming - horizontal stripes of green crops in shallow flooded fields (not a pond, just a few inches of water covering the soil).

---

### Carabao Cart OR Traditional Well ⭐ REQUIRED (pick one)

- [ ] Sprite (32x32 or 64x64) — 30 min

**Option A - Carabao Cart:**
- Wooden cart with large wheels
- No carabao needed (just the cart)
- Rustic farm equipment look

**Option B - Traditional Well:**
- Stone or wooden well structure
- Bucket and rope visible
- Simple but recognizable

---

### Bamboo Fence (Optional - can use generic fence from asset pack)

- [ ] Left end (32x32) — 10 min
- [ ] Middle/repeating (32x32) — 10 min
- [ ] Right end (32x32) — 10 min

**What it looks like:**
- Horizontal bamboo poles lashed together
- Natural bamboo green-tan color
- Visible bamboo nodes/joints

**Note:** Skip if time is tight - generic wood fence from asset pack works fine.

---

## 🔲 Shared Asset

### Shadow Sprite

- [ ] 16x8, 1 frame — 15 min

**What it is:** A simple shadow that goes under ALL characters and enemies

**What it looks like:**

- Dark gray or black oval/ellipse
- ~50% transparent
- Simple, no detail needed

**How it works:**

- Code places this UNDER every character/enemy
- Character bobs up/down, shadow stays still
- Creates natural "floating/walking" look
- **Draw once, reused for everything!**

---

## 📊 Progress Tracker

| Category          | Items  | Done  | % Complete |
| ----------------- | ------ | ----- | ---------- |
| Player Characters | 3      | 0     | 0%         |
| Enemies           | 4 (EA) | 0     | 0%         |
| Weapon Icons      | 6      | 0     | 0%         |
| Weapon Effects    | 5      | 0     | 0%         |
| Farm Tileset      | 4      | 0     | 0%         |
| Shared (Shadow)   | 1      | 0     | 0%         |
| **TOTAL**         | **23** | **0** | **0%**     |

---

## ⏰ Weekly Art Targets

| Week     | Target                                         |
| -------- | ---------------------------------------------- |
| Week 1-2 | Sarimanok Classic (PRIORITY) + Shadow + Golden |
| Week 3-4 | Green Duwende + Red Duwende + Santelmo         |
| Week 5   | Manananggal Boss + Farm Tileset (Filipino elements) |
| Week 6   | All Icons + Weapon Effects ← ART COMPLETE      |
| Week 7+  | Rest / Polish if able / Baby buffer            |

---

## 📁 File Organization & Handoff

### How Ericka Delivers Art

**Each asset = separate files:**
- `sarimanok_classic.aseprite` → exports to `sarimanok_classic.png`
- `green_duwende.aseprite` → exports to `green_duwende.png`
- `bahay_kubo.aseprite` → exports to `bahay_kubo.png`
- etc.

**Ericka does NOT need to arrange tiles into a tileset.** Just draw each thing separately.

### How Josh Integrates Art

**For sprites (characters, enemies, weapons):**
- Drop PNG directly into `game/sprites/` folder
- Update scene to use new sprite instead of placeholder ColorRect

**For tileset tiles (bahay kubo, rice paddies, etc.):**
- Josh copies Ericka's tiles into the master tileset PNG
- Replaces placeholder colored squares with real art
- Tilemap stays the same - just looks better

**Example workflow:**
1. Ericka draws `rice_paddy_water.png` (32x32)
2. Ericka draws `rice_paddy_plants.png` (32x32)
3. Josh opens `placeholder_farm.png` in Aseprite
4. Josh pastes Ericka's tiles over the placeholder squares
5. Save → Godot auto-updates → done

**Folder structure:**
```
game/assets/
├── original/           # Ericka's source files
│   ├── characters/
│   ├── enemies/
│   ├── tiles/          # Individual tile PNGs
│   └── weapons/
├── tilesets/
│   └── placeholder_farm.png  # Master tileset (Josh assembles)
└── purchased/          # Asset pack files
```

---

## 🎨 Art Style Guidelines

- **Sprite sizes:** 32x32 (characters/enemies), 48x48 (boss), 16x16 (icons), 64x64 (AOE effects)
- **Animation:** 2 frames for most things, 4 frames for boss
- **Colors:** 2-3 main colors per sprite, use the Resurrect 64 palette
- **Outlines:** Black outlines help readability at small sizes
- **Test:** Always zoom out to see how sprites read at actual game size
- **Silhouette:** If the shape isn't clear in solid black, redesign it

---

## 💡 Quick Reference: What Each Weapon Does

| Weapon              | Type       | Visual             | In-Game Behavior                     |
| ------------------- | ---------- | ------------------ | ------------------------------------ |
| **Peck**            | Melee      | Beak thrust effect | Quick jab in front of player         |
| **Wing Slap**       | AOE        | Expanding circle   | Damages all enemies around player    |
| **Feather Shot**    | Projectile | Flying feather     | Shoots toward nearest enemy          |
| **Spiral Feathers** | Orbital    | Feathers circling  | 4-8 feathers orbit player constantly |
| **Ice Shard**       | Projectile | Blue feather       | Slower shot, slows enemies on hit    |
| **Flame Wing**      | AOE        | Fire circle        | Smaller but stronger Wing Slap       |

---

## 🎮 Vampire Survivors Visual Reference

If you want to see how this style works, watch any Vampire Survivors gameplay video. Notice:

- Player character ONLY walks/idles (no attack animations)
- Weapons just "appear" around the player on cooldowns
- Projectiles fire automatically toward enemies
- Orbital weapons spin around the player
- AOE effects expand from the player's center

The Sarimanok will work exactly the same way!
