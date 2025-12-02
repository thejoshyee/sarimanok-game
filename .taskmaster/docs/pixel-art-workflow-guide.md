# Pixel Art Asset Creation Workflow Guide

This guide covers the complete pipeline from Aseprite to Godot 4 for Sarimanok Survivor.

**Version:** 1.0  
**Created:** December 2025  
**For:** Josh (code integration) & Ericka (art creation)

---

## Part 1: Color Palette Setup (Do This First)

### Palette Recommendation

For your game with 3 characters, 5 enemies, 4 weapons, pickups, and a tileset:

- **32-color palette** is the sweet spot (Dawnbringer 32)
- **64-color palette** gives more flexibility if you want richer visuals (Resurrect 64)

**Recommendation:** Start with **Dawnbringer 32**. It's a proven palette used in many indie games, has excellent color ramps for shading, and 32 colors is enough for your scope. You can always expand later.

If you find yourself running out of colors for all the vibrant Sarimanok variants, upgrade to Resurrect 64.

### How to Apply Your Palette in Aseprite

1. **Download your palette from Lospec:**

   - Go to lospec.com, find your palette
   - Click "Download" and select "Aseprite" format (.gpl or .ase)

2. **Load palette into Aseprite:**

   - Open Aseprite
   - Go to Sprite > Color Mode > Indexed
   - In the palette panel (bottom of screen), click the hamburger menu (three lines)
   - Select Load Palette and choose your downloaded file

3. **Lock the palette for consistency:**

   - With palette loaded, save it as your project palette
   - For EVERY new sprite file, load this same palette first
   - Working in Indexed Color Mode prevents accidental off-palette colors

4. **Create a palette reference sheet:**
   - Make a small image showing all 32 (or 64) colors
   - Label groups: "Sarimanok colors", "Duwende greens", "Skin tones", "Shadows", etc.
   - This helps both you and Ericka stay consistent

---

## Part 2: Creating Character Sprites

### Setup for Each Character

1. **Create new file in Aseprite:**

   - File > New
   - Width: 32, Height: 32 (matches PRD spec)
   - Color Mode: Indexed
   - Load your palette

2. **Layer organization (recommended):**

   - Shadow (optional, for drop shadow)
   - Body
   - Details (eyes, beak, crest)
   - Outline (if using outlines)

   Keep layers separate so you can adjust parts without redrawing everything.

3. **Draw your idle frame first:**
   - This is your "base" sprite
   - Get the silhouette right before adding details
   - Test at actual game size (View > Pixel Perfect Mode)

### Creating Animations

4. **Add frames for animation:**

   - Frame > New Frame (or press F6)
   - For a 2-frame walk animation: Frame 1 = neutral, Frame 2 = wings/legs slightly moved
   - Use Onion Skin (View > Onion Skinning) to see previous frame while drawing

5. **Tag your animations:**

   - Select frames 1-2
   - Frame > Tags > New Tag
   - Name it: "idle" or "walk"
   - **This tag name is used when importing to Godot**

6. **Example animation structure for Sarimanok:**
   ```
   Frames 1-2: idle (tagged "idle")
   That's it for MVP - just 2 frames!
   ```

### Repeat for Each Character Variant

- **Sarimanok Classic:** Full vibrant colors
- **Sarimanok Shadow:** Duplicate file, recolor to dark purple/blue
- **Sarimanok Golden:** Duplicate file, recolor to gold/red

Recoloring tip: Use Edit > Replace Color or manually paint over. Working in Indexed mode makes this easier.

---

## Part 3: Exporting Sprite Sheets

### Single Character Export (Recommended for Your Project)

1. **File > Export Sprite Sheet**

2. **Configure Layout tab:**

   - Sheet Type: "Horizontal Strip" (for simple 2-frame animations)
   - OR "By Rows" if you have multiple animation tags

3. **Configure Sprite tab:**

   - Layers: Visible layers (or select specific layers)
   - Frames: All frames, OR select specific Tags

4. **Configure Borders tab:**

   - Border Padding: 0
   - Spacing: 0 (Godot handles this fine)
   - Inner Padding: 0

5. **Configure Output tab:**

   - Output File: `sarimanok_classic.png`
   - Check "JSON Data" if you want animation metadata (optional but helpful)

6. **Click Export**

### Your Export Should Look Like:

```
For 2-frame idle animation:
┌─────────┬─────────┐
│ Frame 1 │ Frame 2 │  = 64x32 PNG
└─────────┴─────────┘
```

### Naming Convention

Use this pattern for all exports:

```
sarimanok_classic.png
sarimanok_shadow.png
sarimanok_golden.png
duwende_green.png
duwende_red.png
duwende_black.png
santelmo.png
manananggal.png (48x48 per frame, so 192x48 for 4 frames)
```

---

## Part 4: Creating the Tileset

### Tileset Approach (All Tiles in One File)

1. **Create new file for tileset:**

   - File > New
   - Width: 256, Height: 128 (8x4 grid of 32x32 tiles)
   - This gives you 32 tile slots
   - Color Mode: Indexed, same palette

2. **Enable Grid:**

   - View > Grid > Grid Settings
   - Width: 32, Height: 32
   - View > Show > Grid (to see tile boundaries)

3. **Draw each tile in its grid cell:**

   ```
   Row 0: Ground variations (grass dark, grass med, grass light, dirt dark, dirt med, dirt light)
   Row 1: Decorations (rice crop, vegetables, rocks small, rocks large, grass tufts)
   Row 2: Edge pieces (fence left, fence mid, fence right, fence post, tree variants)
   Row 3: Extra (bahay kubo pieces, more trees, future expansion)
   ```

4. **Make tiles seamless:**

   - For grass/dirt: edges should match when placed next to each other
   - Test by copying a tile and placing it adjacent
   - Edit > Canvas Size can help test tiling

5. **Export tileset:**
   - File > Export As
   - Save as `tileset_farm.png`
   - This is a simple PNG export (not sprite sheet export)

### Tileset Layout Reference (Keep This for Godot Import)

```
Position (0,0) = grass_dark
Position (1,0) = grass_med
Position (2,0) = grass_light
... document each tile position
```

---

## Part 5: Creating Icons and Small Sprites

### Weapon/Passive Icons (16x16)

1. **Create new file for each icon:**

   - 16x16 pixels
   - Same palette
   - One icon per file (e.g., `peck_icon.png`, `wing_slap_icon.png`)

2. **Why individual files (not a sprite sheet):**

   - Icons are used in UI (level-up screen, HUD)
   - Godot UI nodes work best with individual textures (just drag & drop)
   - Easier to update one icon without re-exporting everything
   - 8 small icons don't benefit from atlasing

3. **Keep icons simple:**
   - At 16x16, you have very limited space
   - Strong silhouettes, 3-4 colors max per icon
   - Test readability at actual size

### Pickups (16x16)

Same process:

- `pickup_xp.png` (blue gem)
- `pickup_gold.png` (yellow coin)

---

## Part 6: Importing into Godot 4

### Project Settings (Do This Once)

1. **Set pixel-perfect rendering:**

   - Project > Project Settings
   - Rendering > Textures > Default Texture Filter: **Nearest**
   - This keeps pixels crisp, no blurring

2. **Set viewport (already in your project.godot):**
   - Display > Window > Viewport Width: 640
   - Display > Window > Viewport Height: 360
   - Stretch Mode: canvas_items
   - Stretch Aspect: keep

### Importing Character Sprites

1. **Drag PNG files into `res://sprites/characters/`**

2. **Click on imported file, check Import dock:**

   - Filter: Nearest (should be default now)
   - Click "Reimport" if you change settings

3. **Create AnimatedSprite2D in your scene:**

   - Add AnimatedSprite2D node to player
   - In Sprite Frames property, click "New SpriteFrames"
   - Click the SpriteFrames to open the editor

4. **Add animation from sprite sheet:**
   - In SpriteFrames panel, click "Add frames from sprite sheet"
   - Select your PNG
   - Set Horizontal: 2, Vertical: 1 (for 2-frame horizontal strip)
   - Select the frames, click "Add Frames"
   - Rename animation to "idle" or "walk"

### Importing Tileset

1. **Create TileSet resource:**

   - In FileSystem, right-click > New Resource > TileSet
   - Save as `tileset_farm.tres`

2. **Add your tileset image:**

   - Open the TileSet, click "Add" at bottom
   - Select your `tileset_farm.png`
   - Set Tile Size: 32x32

3. **Configure tiles:**

   - Godot auto-slices based on grid
   - Click each tile to add collision shapes if needed
   - Most tiles are decoration-only (no collision)

4. **Create TileMap in your main scene:**
   - Add TileMap node
   - Assign your TileSet resource
   - Paint your arena!

---

## Part 7: File Organization

### Recommended Folder Structure

```
sarimanok-game/
├── game/                          # Godot project
│   ├── sprites/
│   │   ├── characters/
│   │   │   ├── sarimanok_classic.png
│   │   │   ├── sarimanok_shadow.png
│   │   │   └── sarimanok_golden.png
│   │   ├── enemies/
│   │   │   ├── duwende_green.png
│   │   │   ├── duwende_red.png
│   │   │   ├── duwende_black.png
│   │   │   ├── santelmo.png
│   │   │   └── manananggal.png
│   │   ├── weapons/
│   │   │   └── feather_projectile.png
│   │   ├── pickups/
│   │   │   ├── pickup_xp.png
│   │   │   └── pickup_gold.png
│   │   └── icons/
│   │       ├── peck_icon.png
│   │       ├── wing_slap_icon.png
│   │       └── ...
│   ├── tilesets/
│   │   ├── tileset_farm.png
│   │   └── tileset_farm.tres
│   └── ...
│
└── art_source/                    # Aseprite source files (NOT in Godot)
    ├── characters/
    │   ├── sarimanok_classic.aseprite
    │   ├── sarimanok_shadow.aseprite
    │   └── sarimanok_golden.aseprite
    ├── enemies/
    │   └── ...
    ├── tileset_farm.aseprite
    └── palette_dawnbringer32.aseprite  # Your master palette reference
```

**Important:** Keep `.aseprite` source files OUTSIDE the Godot project folder but in your repo. Godot doesn't need them, but you need them for edits.

---

## Part 8: Pose Lists for Each Creature

### Sarimanok (Player Characters) - 32x32

| Pose      | Frames | Description                                                |
| --------- | ------ | ---------------------------------------------------------- |
| idle/walk | 2      | Bob animation - frame 1: neutral, frame 2: slight bob down |

**Animation Notes:**

- Only 2 frames needed (per PRD: "2 frames: idle/walk (bob animation)")
- Code handles sprite flip for direction (no separate left/right sprites needed)
- All 3 variants use same poses, just different colors

**Visual Reference for Poses:**

```
Frame 1 (Neutral):        Frame 2 (Bob):
    ╱▔▔╲                     ╱▔▔╲
   ╱ ◉  ╲   crest           ╱ ◉  ╲
   │    │   body             │    │
   ╱╲  ╱╲   tail/feet       ─╱╲──╱╲─  (slightly lower)
```

### Duwendes (All 3 Colors) - 32x32

| Pose | Frames | Description          |
| ---- | ------ | -------------------- |
| walk | 2      | Waddle toward player |

**Animation Notes:**

- Simple 2-frame walk cycle
- Green, Red, Black are recolors of same base sprite
- Small goblin-like creature with pointy ears

**Visual Reference:**

```
Frame 1:                  Frame 2:
   ╱╲                        ╱╲
  (◉◉)  pointy ears        (◉◉)
   ╰╯   round body          ╰╯
  ╱  ╲  feet apart         ╲  ╱  feet crossed
```

### Santelmo - 32x32

| Pose  | Frames | Description          |
| ----- | ------ | -------------------- |
| float | 2      | Flickering fire ball |

**Animation Notes:**

- Ball of floating fire
- 2 frames = flame flicker effect
- No walking animation (floats)

**Visual Reference:**

```
Frame 1:                  Frame 2:
   ╱╲                        ╲╱
  (  )  flame shape        (  )  alternate flame
   ╲╱   orange/yellow       ╱╲   shape
```

### Manananggal (Boss) - 48x48

| Pose | Frames | Description     |
| ---- | ------ | --------------- |
| fly  | 4      | Wing flap cycle |

**Animation Notes:**

- Larger sprite (48x48) for boss presence
- 4 frames for smooth wing flap
- Flying torso with bat wings, no lower body
- Grotesque but readable silhouette

**Visual Reference:**

```
Frame 1:           Frame 2:           Frame 3:           Frame 4:
  ╲    ╱             ─    ─             ╱    ╲             ─    ─
   ╲  ╱   wings up    ──  ──  mid       ╱  ╲   wings down   ──  ──  mid
    ▓▓    torso        ▓▓               ▓▓                  ▓▓
```

### Pickups - 16x16

| Asset     | Frames | Description                    |
| --------- | ------ | ------------------------------ |
| XP Gem    | 1-2    | Blue diamond, optional sparkle |
| Gold Coin | 1-2    | Yellow circle, optional spin   |

### Weapon Effects - Various Sizes

| Asset              | Size  | Frames | Description                      |
| ------------------ | ----- | ------ | -------------------------------- |
| Feather Projectile | 16x16 | 1      | Single feather (code rotates it) |
| Peck Hit           | 32x32 | 2-3    | Quick slash effect               |
| Wing Slap Circle   | 64x64 | 2-3    | Expanding circle                 |

### Icons - 16x16

| Icon            | Frames | Description        |
| --------------- | ------ | ------------------ |
| Peck            | 1      | Beak/sharp point   |
| Wing Slap       | 1      | Wing shape         |
| Feather Shot    | 1      | Feather            |
| Spiral Feathers | 1      | Feathers in circle |
| Iron Beak       | 1      | Metallic beak      |
| Thick Plumage   | 1      | Fluffy feathers    |
| Racing Legs     | 1      | Running legs       |
| Magnetic Aura   | 1      | Magnet or glow     |

---

## Part 9: Animation Templates for Ericka

### Template: 2-Frame Walk/Idle Cycle

Use this for: Sarimanok, Duwendes

```
┌─────────────────────────────────────────────────────┐
│ FRAME 1 (Neutral)                                   │
├─────────────────────────────────────────────────────┤
│ - Character in standing pose                        │
│ - Feet/legs in neutral position                     │
│ - Wings/arms at rest                                │
│ - This is the "base" frame                          │
└─────────────────────────────────────────────────────┘
           ↓ (0.2 seconds)
┌─────────────────────────────────────────────────────┐
│ FRAME 2 (Bob/Step)                                  │
├─────────────────────────────────────────────────────┤
│ - Body shifted down 1-2 pixels                      │
│ - Feet/legs alternate position                      │
│ - Small variation from Frame 1                      │
│ - Creates "bounce" when looped                      │
└─────────────────────────────────────────────────────┘
           ↓ (loops back to Frame 1)
```

**Timing:** 0.2 seconds per frame = 5 FPS

### Template: 2-Frame Flicker (Santelmo)

```
┌─────────────────────────────────────────────────────┐
│ FRAME 1 (Flame Shape A)                             │
├─────────────────────────────────────────────────────┤
│ - Main flame shape                                  │
│ - Bright center (yellow/white)                      │
│ - Orange edges                                      │
└─────────────────────────────────────────────────────┘
           ↓ (0.15 seconds - fast!)
┌─────────────────────────────────────────────────────┐
│ FRAME 2 (Flame Shape B)                             │
├─────────────────────────────────────────────────────┤
│ - Slightly different flame outline                  │
│ - Move some pixels at edges                         │
│ - Creates "flickering fire" effect                  │
└─────────────────────────────────────────────────────┘
```

**Timing:** 0.15 seconds per frame = ~7 FPS (faster for fire)

### Template: 4-Frame Wing Flap (Manananggal)

```
┌─────────────────────────────────────────────────────┐
│ FRAME 1 (Wings Up)                                  │
├─────────────────────────────────────────────────────┤
│ - Wings fully extended upward                       │
│ - Torso at highest position                         │
└─────────────────────────────────────────────────────┘
           ↓ (0.15 seconds)
┌─────────────────────────────────────────────────────┐
│ FRAME 2 (Wings Mid - Going Down)                    │
├─────────────────────────────────────────────────────┤
│ - Wings at horizontal/slight down                   │
│ - Torso moving down                                 │
└─────────────────────────────────────────────────────┘
           ↓ (0.15 seconds)
┌─────────────────────────────────────────────────────┐
│ FRAME 3 (Wings Down)                                │
├─────────────────────────────────────────────────────┤
│ - Wings fully extended downward                     │
│ - Torso at lowest position                          │
└─────────────────────────────────────────────────────┘
           ↓ (0.15 seconds)
┌─────────────────────────────────────────────────────┐
│ FRAME 4 (Wings Mid - Going Up)                      │
├─────────────────────────────────────────────────────┤
│ - Wings at horizontal/slight up                     │
│ - Torso moving up                                   │
│ - Loops back to Frame 1                             │
└─────────────────────────────────────────────────────┘
```

**Timing:** 0.15 seconds per frame = ~7 FPS

---

## Part 10: Sprite Sheet Structure for Godot Import

### Standard Format: Horizontal Strip

All sprites should be exported as **horizontal strips** - frames side by side in a row.

```
┌─────────────────────────────────┐
│ Frame 1 │ Frame 2 │ Frame 3 │...│  = One horizontal row
└─────────────────────────────────┘
```

### Exact Sprite Sheet Specifications

| Asset             | Frame Size  | Frames    | Total PNG Size | Filename               |
| ----------------- | ----------- | --------- | -------------- | ---------------------- |
| Sarimanok Classic | 32x32       | 2         | 64x32          | sarimanok_classic.png  |
| Sarimanok Shadow  | 32x32       | 2         | 64x32          | sarimanok_shadow.png   |
| Sarimanok Golden  | 32x32       | 2         | 64x32          | sarimanok_golden.png   |
| Duwende Green     | 32x32       | 2         | 64x32          | duwende_green.png      |
| Duwende Red       | 32x32       | 2         | 64x32          | duwende_red.png        |
| Duwende Black     | 32x32       | 2         | 64x32          | duwende_black.png      |
| Santelmo          | 32x32       | 2         | 64x32          | santelmo.png           |
| Manananggal       | 48x48       | 4         | 192x48         | manananggal.png        |
| XP Gem            | 16x16       | 1-2       | 16x16 or 32x16 | pickup_xp.png          |
| Gold Coin         | 16x16       | 1-2       | 16x16 or 32x16 | pickup_gold.png        |
| Feather           | 16x16       | 1         | 16x16          | feather_projectile.png |
| Tileset           | 32x32 tiles | ~32 tiles | 256x128        | tileset_farm.png       |

### Visual: What Each Sprite Sheet Looks Like

**sarimanok_classic.png (64x32 total):**

```
┌──────────┬──────────┐
│  32x32   │  32x32   │
│ Frame 1  │ Frame 2  │
│ (neutral)│  (bob)   │
└──────────┴──────────┘
```

**manananggal.png (192x48 total):**

```
┌──────────┬──────────┬──────────┬──────────┐
│  48x48   │  48x48   │  48x48   │  48x48   │
│ Frame 1  │ Frame 2  │ Frame 3  │ Frame 4  │
│(wings up)│  (mid)   │(wings dn)│  (mid)   │
└──────────┴──────────┴──────────┴──────────┘
```

**tileset_farm.png (256x128 total = 8 columns x 4 rows of 32x32 tiles):**

```
┌────┬────┬────┬────┬────┬────┬────┬────┐
│0,0 │1,0 │2,0 │3,0 │4,0 │5,0 │6,0 │7,0 │ Row 0: Ground
├────┼────┼────┼────┼────┼────┼────┼────┤
│0,1 │1,1 │2,1 │3,1 │4,1 │5,1 │6,1 │7,1 │ Row 1: Decorations
├────┼────┼────┼────┼────┼────┼────┼────┤
│0,2 │1,2 │2,2 │3,2 │4,2 │5,2 │6,2 │7,2 │ Row 2: Edge pieces
├────┼────┼────┼────┼────┼────┼────┼────┤
│0,3 │1,3 │2,3 │3,3 │4,3 │5,3 │6,3 │7,3 │ Row 3: Extra/Future
└────┴────┴────┴────┴────┴────┴────┴────┘
```

### Godot Import Settings (Week 7-8)

When Josh imports these sprite sheets:

1. **For animated sprites (characters, enemies):**

   - Use AnimatedSprite2D node
   - Create SpriteFrames resource
   - "Add frames from sprite sheet"
   - Set Horizontal = number of frames, Vertical = 1
   - Animation FPS: 5-8 for most, 10 for fast flicker

2. **For tileset:**
   - Create TileSet resource
   - Add tileset_farm.png as source
   - Set Tile Size: 32x32
   - Godot auto-slices into grid

---

## Quick Reference Checklist

### Before Starting Any Sprite:

- [ ] Load your palette (Dawnbringer 32 or Resurrect 64)
- [ ] Set Color Mode to Indexed
- [ ] Set canvas size (32x32 for most, 48x48 for boss, 16x16 for icons)

### For Each Character/Enemy:

- [ ] Draw idle frame
- [ ] Add animation frames
- [ ] Tag animations ("idle", "walk", etc.)
- [ ] Export as horizontal sprite sheet PNG
- [ ] Name file consistently (character_name.png)

### For Tileset:

- [ ] Create 256x128 canvas (or larger if needed)
- [ ] Enable 32x32 grid
- [ ] Draw each tile in grid cell
- [ ] Test that edge tiles connect seamlessly
- [ ] Export as single PNG
- [ ] Document which tile is where

### For Godot Import:

- [ ] Set project texture filter to Nearest
- [ ] Import PNGs to correct folders
- [ ] Create SpriteFrames for animated sprites
- [ ] Create TileSet resource for tilemap

---

## Asset Priority Order (Ericka's Roadmap)

Based on the PRD's parallel development timeline:

**Week 1-2:** Sarimanok (all 3 variants) - The hero should look good first

**Week 3-4:** Duwendes (all 3 colors) + Santelmo - Core enemies

**Week 5-6:** Manananggal (boss) + Icons (weapons/passives)

**Week 7:** Tileset + UI elements

**Week 8:** Integration and polish

If art runs behind, Josh can continue with colored rectangles. The game is shippable with placeholders for Early Access.

---

## Complete Asset Checklist

### Characters (3 total)

- [ ] sarimanok_classic.png (32x32, 2 frames)
- [ ] sarimanok_shadow.png (32x32, 2 frames)
- [ ] sarimanok_golden.png (32x32, 2 frames)

### Enemies (5 total)

- [ ] duwende_green.png (32x32, 2 frames)
- [ ] duwende_red.png (32x32, 2 frames)
- [ ] duwende_black.png (32x32, 2 frames)
- [ ] santelmo.png (32x32, 2 frames)
- [ ] manananggal.png (48x48, 4 frames)

### Weapon Icons (4 total)

- [ ] peck_icon.png (16x16, 1 frame)
- [ ] wing_slap_icon.png (16x16, 1 frame)
- [ ] feather_shot_icon.png (16x16, 1 frame)
- [ ] spiral_feathers_icon.png (16x16, 1 frame)

### Passive Icons (4 total)

- [ ] iron_beak_icon.png (16x16, 1 frame)
- [ ] thick_plumage_icon.png (16x16, 1 frame)
- [ ] racing_legs_icon.png (16x16, 1 frame)
- [ ] magnetic_aura_icon.png (16x16, 1 frame)

### Pickups (2 total)

- [ ] pickup_xp.png (16x16, 1-2 frames)
- [ ] pickup_gold.png (16x16, 1-2 frames)

### Weapon Effects (3 total)

- [ ] feather_projectile.png (16x16, 1 frame)
- [ ] peck_hit_effect.png (32x32, 2-3 frames)
- [ ] wing_slap_circle.png (64x64, 2-3 frames)

### Environment (1 tileset)

- [ ] tileset_farm.png (256x128, ~32 tiles)

---

**Total Sprites:** ~22 sprite files
**Estimated Art Time:** 36-46 hours (per PRD)
**At 10 hrs/week:** 4-5 weeks (parallel to coding)
