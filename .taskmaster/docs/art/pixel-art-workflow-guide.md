# Pixel Art Asset Creation Workflow Guide

This guide covers the complete pipeline from Aseprite to Godot 4 for Sarimanok Survivor.

**Version:** 2.3  
**Created:** December 2025  
**For:** Josh (code integration) & Ericka (art creation)

---

## Table of Contents

0. [Learning Resources (Start Here!)](#part-0-learning-resources-start-here)
1. [Color Palette Setup](#part-1-color-palette-setup)
2. [Map/Arena Visual Design](#part-2-maparena-visual-design)
3. [Asset Responsibilities](#part-3-asset-responsibilities-ericka-vs-sourced)
4. [Creating Character Sprites](#part-4-creating-character-sprites)
5. [Detailed Creation Guides (Filipino Assets)](#part-5-detailed-creation-guides-filipino-assets)
6. [Exporting Sprite Sheets](#part-6-exporting-sprite-sheets)
7. [Creating the Tileset](#part-7-creating-the-tileset)
8. [Creating Icons and Small Sprites](#part-8-creating-icons-and-small-sprites)
9. [Importing into Godot 4](#part-9-importing-into-godot-4)
10. [File Organization](#part-10-file-organization)
11. [Pose Lists for Each Creature](#part-11-pose-lists-for-each-creature)
12. [Animation Templates](#part-12-animation-templates-for-ericka)
13. [Sprite Sheet Structure](#part-13-sprite-sheet-structure-for-godot-import)
14. [Complete Asset Checklist](#part-14-complete-asset-checklist)

---

## Part 0: Learning Resources (Start Here!)

**Philosophy: Watch these 3-4 videos, then start making. Don't fall into tutorial hell.**

You don't need to be an expert before starting. Watch these focused tutorials (under 50 minutes total), then jump straight into creating the Sarimanok. You'll learn more by doing than by watching endless videos.

### Recommended Tutorials

| Order | Tutorial                                                                       | Creator       | Length | What You'll Learn                              |
| ----- | ------------------------------------------------------------------------------ | ------------- | ------ | ---------------------------------------------- |
| 1     | [Learn pixel art in 5 MINUTES](https://www.youtube.com/watch?v=lfR7Qj04-UA)    | Game Dev ASAP | 5 min  | Quick interface orientation - watch this FIRST |
| 2     | [Aseprite Tutorial For Beginners](https://www.youtube.com/watch?v=tFsETEP01k8) | Saultoons     | 23 min | Complete tool mastery - all the tools you need |
| 3     | [Aseprite Animation Tutorial](https://www.youtube.com/watch?v=B0enS9BJne4)     | Saultoons     | 11 min | Animation workflow - frames, timing, export    |
| 4     | [Lighting & Shading Basics](https://www.youtube.com/watch?v=u7v4uEDwW9o)       | AdamCYounis   | 9 min  | Shading with limited palettes (optional)       |
| 5     | [Pixel Art 101: Shading Tutorial](https://www.youtube.com/watch?v=jO9ruYaCJmU) | Pixel Pete    | 12 min | More shading techniques (optional)             |

**Total time: ~39 minutes required** + pick one shading tutorial if you want (9 or 12 min)

### Suggested Watch Order

1. **Game Dev ASAP (5 min)** - Get oriented with the interface. Understand where everything is.
2. **Saultoons Beginners (23 min)** - Learn all the tools. This is your main tutorial.
3. **Saultoons Animation (11 min)** - Learn how to add frames and create animations.
4. **AdamCYounis OR Pixel Pete** - _Optional._ Pick one if you want shading practice:
   - AdamCYounis (9 min) - Shorter, covers limited palette shading
   - Pixel Pete (12 min) - More detailed, covers hue shifting

### After the Tutorials

**Start making the Sarimanok Classic immediately.**

- Don't watch more tutorials
- Open Aseprite, create a 32x32 canvas, and start drawing
- Use this guide as your reference
- If you get stuck on something specific, Google it or ask AI
- You'll learn faster by making mistakes than by watching more videos

### Quick Reference: Aseprite Keyboard Shortcuts

These are the shortcuts you'll use constantly. Learn them as you work:

| Shortcut | Action                            |
| -------- | --------------------------------- |
| B        | Pencil/Brush tool                 |
| E        | Eraser                            |
| G        | Paint bucket (fill)               |
| M        | Rectangular selection             |
| V        | Move tool                         |
| Z        | Zoom                              |
| X        | Swap foreground/background colors |
| [ / ]    | Decrease/increase brush size      |
| F6       | Add new frame                     |
| Enter    | Play/pause animation preview      |
| Ctrl+Z   | Undo (your best friend!)          |

---

## Part 1: Color Palette Setup

### Palette Recommendation

For your game with 3 characters, 4 enemies (5 total with Update 1), 6 weapons, pickups, and a tileset:

- **64-color palette** is the sweet spot (Resurrect 64)
- **64-color palette** gives more flexibility if you want richer visuals (Resurrect 64)

**Recommendation:** Use **Resurrect 64**. It's a proven palette with excellent color ramps, and 64 colors gives you the flexibility needed for the vibrant rainbow Sarimanok, multiple color variants, and diverse enemy types.

If you find yourself running out of colors for all the vibrant Sarimanok variants, upgrade to Resurrect 64.

### How to Apply Your Palette in Aseprite

1. **Download your palette from Lospec:**

   - Go to lospec.com, find your palette
   - Click "Download" and select "Aseprite" format (.gpl or .ase)

2. **Load palette into Aseprite:**

   - Open Aseprite
   - Color Mode: **RGBA** (recommended for beginners)
   - In the palette panel (bottom of screen), click the hamburger menu (three lines)
   - Select Load Palette and choose your downloaded file

   **Note on Color Modes:**

   - **RGBA mode** (recommended): Gives you flexibility with layer blending and works seamlessly with Godot 4. Load your palette and work from it, but you're not locked in.
   - **Indexed mode** (optional): Strict palette enforcement, useful for retro purists, but adds complexity with layer blending issues. Only use if you specifically want the constraints.

3. **Lock the palette for consistency:**

   - With palette loaded, save it as your project palette
   - For EVERY new sprite file, load this same palette first
   - Discipline yourself to use only palette colors (RGBA trusts you; Indexed enforces it)

4. **Create a palette reference sheet:**
   - Make a small image showing all 32 (or 64) colors
   - Label groups: "Sarimanok colors", "Duwende greens", "Fire/Santelmo", "Skin tones", "Shadows", etc.
   - This helps both you and Ericka stay consistent

---

## Part 2: Map/Arena Visual Design

The arena is a Filipino provincial farm at night. It has **three visual zones** that create depth and cultural atmosphere.

### Zone Overview

```
┌──────────────────────────────────────────────────────────────────────────────┐
│  ★    ★         ★      NIGHT SKY (gradient)        ★           ★    ★       │
│         ★                     ○ MOON                      ★                  │
│                                                                              │ Zone 3: Sky
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│   🌴  ┌─────────┐  🌴🌴    ┌─────────┐   🌴                                  │
│       │ BAHAY   │          │ BAHAY   │        ← Background buildings         │ Zone 2: Background
│       │ KUBO    │          │ KUBO    │                                       │
│       └────┬────┘          └────┬────┘                                       │
│  ══════════╧════════════════════╧═══════════════════════════════════════════ │ ← Bamboo Fence
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│    [rice] [grass] [dirt] [grass] [crop] [grass] [rice] [grass] [dirt]       │
│                                                                              │
│                    MAIN PLAYING FIELD (60 x 30 tiles)                        │
│                                                                              │ Zone 1: Playing Field
│              Ground Layer: grass/dirt variations (SOURCED)                   │
│              Decoration Layer: rice paddies, crops (ERICKA CREATES)          │
│                                                                              │
│    [grass] [crop] [grass] [dirt] [grass] [rice] [grass] [crop] [grass]      │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

### Zone 1: Main Playing Field (Bottom ~80% of visible area)

This is where all gameplay happens. The player and enemies move here.

**Ground Layer (SOURCED from asset pack):**

- Grass tiles (dark, medium, light variations)
- Dirt tiles (dark, medium, light variations)
- Seamless tiling for natural appearance

**Decoration Layer (ERICKA CREATES - Filipino elements):**

- Rice paddy tiles (2-3 variations) - green stalks in muddy/flooded base
- Vegetable crop tiles (2-3 variations) - generic farm vegetables
- Scattered across the field for visual interest
- NO collision - purely decorative

**Layout Rules:**

- Keep center mostly open for gameplay
- Scatter decorations toward edges
- Avoid cluttering the playing field
- Player should always be clearly visible

### Zone 2: Background Layer (Top ~20% - non-playable)

Creates the Filipino provincial atmosphere. Player cannot reach this area.

**Bahay Kubo Structures (ERICKA CREATES):**

- 1-2 traditional nipa huts on stilts
- Positioned at top of screen
- Warm light glowing from windows (night scene)
- Slightly simplified for background distance

**Vegetation (SOURCED or ERICKA if time):**

- Coconut palm silhouettes
- Banana tree shapes
- Creates depth behind the fence

**Bamboo Fence (ERICKA CREATES):**

- Horizontal fence line separating background from playing field
- 3 tiles: left end, middle (repeating), right end
- Visual boundary that says "you can't go past here"

### Zone 3: Sky Layer (Parallax background)

**Night Sky:**

- Deep blue/purple gradient (created in Godot using `GradientTexture2D`)
- Darker at top, slightly lighter near horizon

**Moon (SOURCED - Not Ericka's Task):**

- Large, prominent moon for atmosphere
- Positioned upper-right or upper-left
- Provides the "night" lighting justification
- Source from itch.io asset pack or free sprites

**Stars (SOURCED - Not Ericka's Task):**

- Scattered small white/yellow dots
- Can be static or use Godot particles for twinkle
- Source from asset pack or create simple dots in Godot

### Technical Implementation in Godot

```
Main Scene Structure:
├── ParallaxBackground
│   ├── ParallaxLayer (Sky + Moon + Stars)
│   │   └── TextureRect or Sprite2D
│   └── ParallaxLayer (Background buildings - slower parallax)
│       └── Sprite2D (bahay_kubo_background.png)
├── TileMap
│   ├── Layer 0: Ground (grass, dirt)
│   └── Layer 1: Decorations (rice paddies, crops)
├── Player
├── Enemies
└── Camera2D
```

### Arena Specifications (from PRD)

| Property  | Value                              |
| --------- | ---------------------------------- |
| Viewport  | 640 x 360 pixels                   |
| Map Size  | 1920 x 1088 pixels (60 x 34 tiles) |
| Tile Size | 32 x 32 pixels                     |
| Camera    | Follows player, stops at edges     |

### Dawn Transition (Victory at 30:00)

When player survives to dawn:

- Sky gradient shifts from night blue to warm orange/pink
- Moon fades out
- Stars disappear
- Bahay kubos become silhouettes against dawn sky
- Game tiles/characters shift from cool night tint to warm dawn colors

**How the Transition Works (Code-Based):**

| Element                    | How It's Handled                             | Ericka's Task? |
| -------------------------- | -------------------------------------------- | -------------- |
| Night filter on everything | `CanvasModulate` node tints the scene blue   | NO - code only |
| Dawn color shift           | Tween the `CanvasModulate` to warm white     | NO - code only |
| Moon sprite                | **SOURCED** from asset pack (fades out)      | NO - buy/find  |
| Stars                      | **SOURCED** or Godot particles (fade out)    | NO - buy/find  |
| Sky gradient               | `GradientTexture2D` in Godot (shifts colors) | NO - code only |
| Sun sprite (optional)      | **SOURCED** from asset pack (fades in)       | NO - buy/find  |

> **Key Principle:** Ericka draws tiles in **normal/natural colors**. The `CanvasModulate` applies the night filter during gameplay. At victory, the filter fades to reveal the "dawn" colors that were there all along. No duplicate art needed!

**See PRD Feature 8 for full implementation details and code examples.**

---

## Part 3: Asset Responsibilities (Ericka vs Sourced)

### What Ericka Creates (Distinctively Filipino Assets)

These are the assets that give the game its Filipino cultural identity. **This is what makes the game unique.**

| Asset                   | Size    | Frames  | Est. Time        | Priority |
| ----------------------- | ------- | ------- | ---------------- | -------- |
| **Sarimanok Classic**   | 32x32   | 2       | 3-4 hrs          | Week 1-2 |
| **Sarimanok Shadow**    | 32x32   | 2       | 1 hr (recolor)   | Week 1-2 |
| **Sarimanok Golden**    | 32x32   | 2       | 1 hr (recolor)   | Week 1-2 |
| **Green Duwende**       | 32x32   | 2       | 2-3 hrs          | Week 3-4 |
| **Red Duwende**         | 32x32   | 2       | 20 min (recolor) | Week 3-4 |
| **Santelmo**            | 32x32   | 2       | 2-3 hrs          | Week 3-4 |
| **Manananggal**         | 48x48   | 4       | 5-7 hrs          | Week 5-6 |
| Weapon Icons (4 unique) | 16x16   | 1 each  | 2 hrs total      | Week 5-6 |
| Weapon Effects          | Various | Various | 2.5-3.5 hrs      | Week 5-6 |
| **Filipino Tiles**      | 32x32   | 1 each  | 1-2 hrs          | Week 5-6 |

**Total Ericka Time: ~18-24 hours**

### Filipino Tiles Breakdown (Ericka Creates)

| Tile                    | Size           | Description                            |
| ----------------------- | -------------- | -------------------------------------- |
| Bahay Kubo (background) | 64x64 or 96x64 | Complete small hut for background      |
| Rice Paddy Tile A       | 32x32          | Green rice stalks in muddy base        |
| Rice Paddy Tile B       | 32x32          | Variation with different stalk pattern |
| Vegetable Crop Tile     | 32x32          | Generic leafy vegetables               |
| Bamboo Fence Left       | 32x32          | Left end piece                         |
| Bamboo Fence Middle     | 32x32          | Repeating middle section               |
| Bamboo Fence Right      | 32x32          | Right end piece                        |

### What Gets Sourced from Asset Packs (~$30-50)

These are generic elements that don't need to be uniquely Filipino. A farm is a farm.

| Asset Type                            | Source               | Cost     |
| ------------------------------------- | -------------------- | -------- |
| Generic grass tiles (dark/med/light)  | Tileset pack         | ~$10-20  |
| Dirt tiles (dark/med/light)           | Tileset pack         | included |
| Rocks and grass tufts                 | Tileset pack         | included |
| Trees (silhouettes for background)    | Tileset pack         | included |
| UI elements (HP bar, XP bar, buttons) | UI pack              | ~$10-15  |
| Pickups (XP gem, Gold coin)           | UI pack or separate  | included |
| Passive icons (Iron Beak, etc.)       | UI pack or icon pack | included |

### Clone Weapons (Minimal Additional Work)

These reuse existing art with color changes:

| Clone Weapon         | Base Asset         | Change         |
| -------------------- | ------------------ | -------------- |
| Ice Shard icon       | Feather Shot icon  | Blue recolor   |
| Ice Shard projectile | Feather projectile | Blue recolor   |
| Flame Wing icon      | Wing Slap icon     | Orange recolor |
| Flame Wing circle    | Wing Slap circle   | Orange recolor |

**Time for clones: ~30 minutes total** (Edit > Replace Color in Aseprite)

---

## Part 4: Creating Character Sprites

### Setup for Each Character

1. **Create new file in Aseprite:**

   - File > New
   - Width: 32, Height: 32 (matches PRD spec)
   - Color Mode: RGBA (see Part 1 for why)
   - Load your palette

2. **Layer organization (recommended):**

   - Body
   - Details (eyes, beak, crest)
   - Outline (if using outlines)

   Keep layers separate so you can adjust parts without redrawing everything.

   **Note on Shadows:** Do NOT draw shadows into your character sprites. Shadows are handled separately in Godot (see below).

3. **Sprite Origin/Centering:**

   Center your character in the canvas. For 32x32 sprites, the center point (16,16) should be approximately at the character's feet or center mass. This ensures:

   - Proper positioning when Godot places sprites
   - Correct rotation pivot if weapons/effects spin around the character
   - Consistent hitbox alignment across all characters

   **Tip:** Draw a small + mark at canvas center before starting, then delete it when done.

4. **Draw your idle frame first:**
   - This is your "base" sprite
   - Get the silhouette right before adding details
   - Test at actual game size (View > Pixel Perfect Mode)
   - **Zoom out frequently** to see how it reads at 100% - silhouette matters more than detail

### Creating Animations

5. **Add frames for animation:**

   - Frame > New Frame (or press F6)
   - For a 2-frame walk animation: Frame 1 = neutral, Frame 2 = wings/legs slightly moved
   - Use Onion Skin (View > Onion Skinning) to see previous frame while drawing

6. **Tag your animations:**

   - Select frames 1-2
   - Frame > Tags > New Tag
   - Name it: "idle" or "walk"
   - **This tag name is used when importing to Godot**

7. **Example animation structure for Sarimanok:**
   ```
   Frames 1-2: idle (tagged "idle")
   That's it for MVP - just 2 frames!
   ```

### Repeat for Each Character Variant

- **Sarimanok Classic:** Full vibrant colors
- **Sarimanok Shadow:** Duplicate file, recolor to dark purple/blue
- **Sarimanok Golden:** Duplicate file, recolor to gold/red

Recoloring tip: Use Edit > Replace Color or manually paint over.

### Character Shadows (Handled in Godot)

**Don't bake shadows into your sprites.** Instead, create ONE separate shadow image that Godot places under all characters.

**Why separate shadows?**

- Ericka draws ONE shadow, reused for all characters and enemies
- Shadow stays still while character bobs up/down (looks natural)
- Easy to adjust size/opacity in code
- Less work than animating shadows in every frame

**Create the shadow sprite:**

```
shadow.png
- Size: 16x8 pixels (or similar ellipse shape)
- Color: Dark gray or black
- Opacity: ~50% transparent
- Shape: Simple oval/ellipse
```

**In Godot, the scene structure looks like:**

```
Player (CharacterBody2D)
├── Shadow (Sprite2D)         ← positioned below character, z-index -1
└── AnimatedSprite2D          ← animated character on top
```

The shadow sprite just sits there - no animation needed. The character bobs above it, creating a natural floating/walking effect.

**Ericka's task:** Create one `shadow.png` (16x8 dark ellipse, 50% opacity). That's it - reused for everything.

---

## Part 5: Detailed Creation Guides (Filipino Assets)

These step-by-step guides focus on the distinctively Filipino assets that Ericka creates.

### Sarimanok Creation Guide

The Sarimanok is the legendary bird of Maranao mythology - it's the HERO of your game and needs to look iconic.

#### Step 1: Research and Reference

Before drawing, gather reference images:

- Search "Sarimanok traditional art" for authentic designs
- Look at Maranao okir patterns (geometric/flowing decorative art)
- Note key features: elaborate tail plumes, distinctive crest, proud posture
- Reference traditional colors: red, orange, yellow, gold, teal

**Key Sarimanok Features:**

- Decorative, fan-like tail feathers (most distinctive feature)
- Head crest or crown-like feature
- Curved beak (often with fish in traditional art, but skip for game)
- Proud, upright posture
- Vibrant, royal colors

#### Step 2: Silhouette First

At 32x32 pixels, details are limited. Focus on a READABLE SILHOUETTE.

```
Start with basic shapes:
         ╱╲
        (  )  ← Head with crest bump
         ││   ← Neck
        ╱██╲  ← Body (rectangular-ish)
       ╱╱  ╲╲ ← Decorative tail feathers
```

**What to include at 32x32:**

- Recognizable head crest (2-3 pixels high)
- Round body shape
- Decorative tail (takes up bottom 1/3 of sprite)
- Simple legs/feet

**What to simplify/omit:**

- Intricate okir patterns (too small)
- Individual feather details
- Fish in beak (not needed for gameplay)

#### Step 3: Color Palette by Variant

**Sarimanok Classic (Default):**

- Body: Bright red/orange primary
- Tail: Rainbow colors - red, orange, yellow, teal/green
- Crest: Gold or bright yellow
- Beak: Orange or gold
- Eye: Black with white highlight

**Sarimanok Shadow (Glass cannon):**

- Body: Deep purple or midnight blue
- Tail: Dark purple, blue, hints of pale violet
- Crest: Pale blue or silver
- Eye: Red or glowing purple (menacing)

**Sarimanok Golden (Tank):**

- Body: Rich gold primary
- Tail: Gold, bronze, copper, red accents
- Crest: Bright gold
- Eye: Black with gold highlight

#### Step 4: Animation (2-Frame Bob)

The animation is simple: a gentle bob up and down.

**Frame 1 (Neutral):**

- Character at normal height
- This is your base drawing

**Frame 2 (Bob):**

- Entire sprite shifted DOWN 1-2 pixels
- OR: body/legs compress slightly
- Creates bouncing effect when walking

```
Frame 1:          Frame 2:
   ╱╲               ╱╲
  (◉ )            (◉ )
   ██               ██
  ╱╱╲╲            ╱╱╲╲
                    ─  (1-2 pixels lower)
```

#### Step 5: Export

- Export as horizontal strip: 64x32 (two 32x32 frames side by side)
- Filename: `sarimanok_classic.png`

---

### Duwende Creation Guide

Duwendes are small goblin-like creatures from Filipino folklore. They come in different colors indicating their nature.

#### Step 1: Cultural Reference

**What are Duwendes?**

- Small, goblin or dwarf-like creatures
- Live in mounds, anthills, or trees
- Colors indicate temperament:
  - **Green:** Common, mischievous
  - **Red:** Aggressive, territorial
  - **Black:** Most powerful, dangerous (Update 1)

#### Step 2: Silhouette Design

```
Basic Duwende shape:
      ╱╲
     (◉◉)  ← Large head with pointy ears
      ╰╯   ← Small, round body
     ╱  ╲  ← Short stubby legs
```

**Key Features at 32x32:**

- Oversized head (1/2 of sprite height)
- Pointy ears sticking out sideways
- Small, squat body
- Short legs
- Mischievous expression (large eyes, small grin)

#### Step 3: Color Application

**Green Duwende (Base sprite):**

- Skin: Forest green, darker green shadows
- Ears: Same green with darker inner
- Eyes: Large, white with black pupils
- Optional: Brown loincloth or simple clothing

**Red Duwende (Recolor):**

- Skin: Deep red, burgundy shadows
- Eyes: Maybe yellow for more aggressive look
- Same sprite, different colors

**Black Duwende (Update 1 - Recolor):**

- Skin: Dark gray/black, purple highlights
- Eyes: Glowing red or yellow
- Most menacing variant

#### Step 4: Animation (2-Frame Waddle)

Simple walking animation toward the player.

**Frame 1:**

- Feet apart in "standing" position
- Arms/hands at sides

**Frame 2:**

- Feet crossed or together (mid-step)
- Slight body lean
- Creates waddling motion when looped

```
Frame 1:          Frame 2:
   ╱╲               ╱╲
  (◉◉)            (◉◉)
   ╰╯               ╰╯
  ╱  ╲            ╲  ╱
 feet apart      feet crossed
```

#### Step 5: Efficient Recoloring Workflow

1. Complete Green Duwende fully
2. Save as `duwende_green.aseprite`
3. File > Save As > `duwende_red.aseprite`
4. Edit > Replace Color (green → red)
5. Adjust shadows and highlights
6. Repeat for Black variant

---

### Santelmo Creation Guide

Santelmo (Saint Elmo's Fire) is a ball of floating fire from Filipino folklore.

#### Step 1: Cultural Reference

**What is Santelmo?**

- Ball of floating fire/light
- Appears in forests, swamps, open fields at night
- Sometimes considered souls of the dead
- Known to lead travelers astray

#### Step 2: Shape Design

Unlike other sprites, Santelmo has no fixed form - it's amorphous fire.

```
Basic flame shape:
      ╲ ╱
     ( ● )  ← Bright core center
      ╱ ╲   ← Flickering edges
```

**Design Approach:**

- Circular/oval core (brightest)
- Irregular edges (flame tendrils)
- No eyes or face (it's fire, not a creature)
- Semi-transparent edges for glow effect

#### Step 3: Color Palette

**Core (center):**

- White or pale yellow (hottest part)

**Middle ring:**

- Bright yellow

**Outer flames:**

- Orange

**Edge tendrils:**

- Deep orange or red
- Can use transparency for glow effect

```
Color layers from center out:
  White → Yellow → Orange → Red/transparent
```

#### Step 4: Animation (2-Frame Flicker)

Faster animation than other creatures (0.15s per frame instead of 0.2s).

**Frame 1:**

- Flame shape A
- Tendrils pointing certain directions

**Frame 2:**

- Flame shape B (different outline)
- Tendrils shifted/changed
- Creates flickering fire effect

```
Frame 1:          Frame 2:
    ╱│            │╲
   ( ● )         ( ● )
    ╲│╱           │╲│
```

**Key:** The outline should change between frames - fire doesn't hold shape.

#### Step 5: Glow Effect (Optional)

For extra polish, you can add a subtle glow:

- Create a larger, more transparent circle behind the main flame
- Use a soft orange/yellow
- This creates the "light source" effect

---

### Manananggal Creation Guide

The Manananggal is the BOSS enemy - it needs to look impressive and terrifying.

#### Step 1: Cultural Reference

**What is a Manananggal?**

- A type of Aswang (Filipino shapeshifting monster)
- Self-segmenting vampire
- Upper torso DETACHES from lower body
- Sprouts bat-like wings to fly
- Most iconic and feared Filipino monster

**Visual Elements:**

- Human female upper torso (long black hair)
- Bat-like wings
- NO lower body (just trailing entrails/viscera)
- Grotesque but recognizable

#### Step 2: Larger Canvas Setup

Manananggal uses **48x48 pixels** for boss presence.

- File > New: 48x48
- This gives 2.25x more pixels than regular sprites
- Room for more detail and intimidating size

#### Step 3: Silhouette Design

```
Basic Manananggal shape:
       ╲      ╱
        ╲    ╱   ← Bat wings spread
         ████    ← Torso/head (hair flows)
          ██     ← Trailing viscera below
          ░░
```

**Key Features:**

- Wide bat wings (span most of the width)
- Human-ish torso/head area
- Long flowing hair
- Trailing "bottom" where body is severed
- Grotesque but readable silhouette

#### Step 4: Color Palette

- **Skin:** Pale, corpse-like (gray-white or pale green)
- **Hair:** Black, flowing
- **Wings:** Dark gray/brown, bat-like membrane
- **Eyes:** Glowing red (menacing)
- **Viscera:** Dark red/maroon at bottom

#### Step 5: Animation (4-Frame Wing Flap)

The Manananggal needs a full wing flap cycle.

```
Frame 1 (Wings Up):     Frame 2 (Wings Mid):    Frame 3 (Wings Down):   Frame 4 (Wings Mid):
    ╲    ╱                  ─  ─                    ╱    ╲                  ─  ─
     ╲  ╱                   ───                    ╱  ╲                    ───
      ██                     ██                     ██                      ██
      ░░                     ░░                     ░░                      ░░

   wings fully up      wings horizontal      wings fully down      back to horizontal
                       (going down)                                (going up)
```

**Animation Timing:** 0.15 seconds per frame (~7 FPS)

**Tips:**

- Body stays mostly static
- Wings do all the movement
- Hair can have slight movement between frames
- Trailing viscera can sway slightly

#### Step 6: Export

- Export as horizontal strip: 192x48 (four 48x48 frames)
- Filename: `manananggal.png`

#### Step 7: Blood Trail (SOURCED - Not Ericka's Task)

Per the PRD, the Manananggal "leaves blood trail visual effect" as it flies. This effect uses a particle sprite from the sourced particle pack (see Part 14).

**Josh's task:** Find a blood drop/splatter sprite in the particle pack for code to spawn behind the Manananggal.

---

### Bahay Kubo Tile Creation Guide

The Bahay Kubo (nipa hut) appears in the background to establish the Filipino farm setting.

#### Step 1: Cultural Reference

**What is a Bahay Kubo?**

- Traditional Filipino house on stilts
- Made of bamboo and nipa palm
- Elevated floor (protection from flooding/pests)
- Steep thatched roof
- Open windows for ventilation

**Key Architectural Features:**

- Stilts/posts raising the house
- Ladder for access
- Steep triangular or gabled roof
- Thatched roof texture (nipa/cogon grass)
- Bamboo or amakan (woven bamboo) walls

#### Step 2: Canvas Size

For background use: **64x64** or **96x64** pixels

This is larger than character sprites because:

- It's a building, should appear bigger
- Background elements can have more detail
- Appears behind the playing field

#### Step 3: Simplified Structure

At pixel scale, simplify to essential shapes:

```
          ╱╲
         ╱  ╲      ← Steep thatched roof (golden/tan)
        ╱────╲
       │ ▓▓▓▓ │    ← House body with window (warm light)
       │ ▓▓▓▓ │
      ═╧══════╧═   ← Stilts/floor elevation
        │    │     ← Support posts
```

#### Step 4: Color Palette

- **Roof:** Golden tan, straw yellow (thatched texture)
- **Walls:** Brown bamboo, or tan amakan pattern
- **Stilts:** Dark brown wood
- **Windows:** Warm orange/yellow glow (night lighting)
- **Shadow:** Dark area underneath the elevated house

#### Step 5: Thatched Roof Technique

The roof is the most recognizable feature. Create thatched texture:

1. Base color: Medium tan/golden
2. Add horizontal lines in slightly darker tan (suggesting layers)
3. Add lighter highlights on top edge
4. Keep it simple - suggestion of texture, not individual strands

```
Roof texture pattern:
─────────────
 ─ ─ ─ ─ ─ ─   ← Subtle horizontal lines
─────────────     suggesting layered thatching
 ─ ─ ─ ─ ─ ─
```

#### Step 6: Night Lighting

Since the game is at night:

- Windows should glow with warm light (oil lamp inside)
- Rest of building is darker/cooler
- Creates cozy "home" feeling in the dangerous night

---

### Rice Paddy Tile Creation Guide

Rice paddies are iconic Filipino agricultural imagery.

#### Step 1: Visual Reference

**Rice Paddy Characteristics:**

- Flooded or muddy field
- Rows of green rice stalks
- Standing water between plants
- Organized but organic appearance

#### Step 2: Canvas Setup

- 32x32 pixels (same as other tiles)
- Create 2-3 variations to avoid repetition

#### Step 3: Design Structure

```
Rice paddy tile structure:
┌────────────────────┐
│  ▌▌  ▌▌  ▌▌  ▌▌   │  ← Green rice stalks (vertical lines)
│ ▌▌  ▌▌  ▌▌  ▌▌    │
│▌▌  ▌▌  ▌▌  ▌▌     │
│░░░░░░░░░░░░░░░░░░░│  ← Muddy/watery base (brown + blue hints)
└────────────────────┘
```

#### Step 4: Color Palette

- **Rice stalks:** Bright green, yellow-green tips
- **Base/water:** Brown-gray mud with subtle blue-cyan hints
- **Variation:** Different stalk arrangements per tile

#### Step 5: Seamless Tiling

Rice paddies need to tile seamlessly with grass:

1. Keep bottom edge similar to grass tile colors
2. Stalks can touch top edge (they grow up)
3. Test by placing multiple tiles adjacent
4. Edit > Canvas Size to preview tiling

#### Step 6: Variations

Create 2-3 variations:

- **Tile A:** Dense stalks, central cluster
- **Tile B:** Sparser stalks, offset pattern
- **Tile C:** Mixed with some harvested/bare patches

---

### Bamboo Fence Tile Creation Guide

The bamboo fence separates the playable area from the background.

#### Step 1: Three-Part Design

Create three tiles that connect:

```
┌──────────┬──────────────────────────────────┬──────────┐
│  LEFT    │           MIDDLE                 │  RIGHT   │
│   ╔══    │  ═══════════════════════════════ │    ══╗   │
│   ║      │  ║   ║   ║   ║   ║   ║   ║   ║   │      ║   │
└──────────┴──────────────────────────────────┴──────────┘
```

#### Step 2: Bamboo Appearance

- **Vertical posts:** Thick bamboo poles, segmented appearance
- **Horizontal rails:** Thinner bamboo connecting posts
- **Color:** Tan/golden brown, with darker segment lines
- **Weathering:** Slight color variation for aged look

#### Step 3: Tile Specifications

| Tile             | Size  | Description                             |
| ---------------- | ----- | --------------------------------------- |
| fence_left.png   | 32x32 | Left end with post, connects to middle  |
| fence_middle.png | 32x32 | Repeating middle section                |
| fence_right.png  | 32x32 | Right end with post, connects to middle |

#### Step 4: Connection Points

Ensure tiles connect seamlessly:

- Horizontal rails must align at same Y position
- Middle tile's left edge matches its right edge
- Left tile's right edge matches middle tile's left edge
- Right tile's left edge matches middle tile's right edge

---

## Part 6: Exporting Sprite Sheets

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
Characters:
sarimanok_classic.png
sarimanok_shadow.png
sarimanok_golden.png

Enemies:
duwende_green.png
duwende_red.png
duwende_black.png (Update 1)
santelmo.png
manananggal.png (48x48 per frame, so 192x48 for 4 frames)

Weapons:
feather_projectile.png
ice_shard_projectile.png (blue recolor)
peck_hit_effect.png
wing_slap_circle.png
flame_wing_circle.png (orange recolor)

Icons:
peck_icon.png
wing_slap_icon.png
feather_shot_icon.png
spiral_feathers_icon.png
ice_shard_icon.png (blue recolor)
flame_wing_icon.png (orange recolor)
```

---

## Part 7: Creating the Tileset

### Two Tileset Approach

**Tileset 1: Generic (SOURCED from asset pack)**

- Grass, dirt, rocks, trees
- Purchase from itch.io or similar (~$10-20)

**Tileset 2: Filipino Elements (ERICKA CREATES)**

- Rice paddies, crops, bahay kubo, bamboo fence
- Smaller scope, focused on cultural identity

### Filipino Tileset Creation

1. **Create new file for tileset:**

   - File > New
   - Width: 128, Height: 64 (4x2 grid of 32x32 tiles)
   - This gives you 8 tile slots
   - Color Mode: RGBA, same palette

2. **Enable Grid:**

   - View > Grid > Grid Settings
   - Width: 32, Height: 32
   - View > Show > Grid (to see tile boundaries)

3. **Filipino Tileset Layout:**

   ```
   ┌────────┬────────┬────────┬────────┐
   │ Rice A │ Rice B │ Crop A │ Crop B │  Row 0: Decorations
   ├────────┼────────┼────────┼────────┤
   │Fence L │Fence M │Fence R │ Extra  │  Row 1: Fence pieces
   └────────┴────────┴────────┴────────┘
   ```

4. **Test Seamless Tiling:**

   Before finalizing any tile, test that it tiles seamlessly:

   - Edit > Canvas Size - expand to 3x3 (96x96 for a single 32x32 tile)
   - Copy your tile to all 9 positions in the grid
   - Check for visible seams where tiles meet
   - Edit the original tile to fix seams, then repeat test
   - Undo (Ctrl+Z) back to original canvas size when done

   **Common seam issues:**

   - Grass blades cut off at edges (extend them to wrap)
   - Dirt patches don't align (use consistent edge colors)
   - Rice stalks create obvious grid patterns (vary placement)

5. **Export:**
   - File > Export As
   - Save as `tileset_filipino.png`

### Tileset Layout Reference

```
Position (0,0) = rice_paddy_a
Position (1,0) = rice_paddy_b
Position (2,0) = vegetable_crop_a
Position (3,0) = vegetable_crop_b
Position (0,1) = bamboo_fence_left
Position (1,1) = bamboo_fence_middle
Position (2,1) = bamboo_fence_right
Position (3,1) = extra/future
```

---

## Part 8: Creating Icons and Small Sprites

### Weapon Icons (16x16)

1. **Create new file for each icon:**

   - 16x16 pixels
   - Same palette
   - One icon per file

2. **Icons Ericka Creates (4 unique):**

   | Icon                     | Description              | Visual                 |
   | ------------------------ | ------------------------ | ---------------------- |
   | peck_icon.png            | Sharp beak/jabbing point | Bird beak shape        |
   | wing_slap_icon.png       | Wing in motion           | Wing with motion lines |
   | feather_shot_icon.png    | Single feather           | Feather pointing right |
   | spiral_feathers_icon.png | Feathers in circle       | 3-4 feathers in spiral |

3. **Clone Icons (recolors):**

   | Clone               | Base              | Change             |
   | ------------------- | ----------------- | ------------------ |
   | ice_shard_icon.png  | feather_shot_icon | Blue/cyan recolor  |
   | flame_wing_icon.png | wing_slap_icon    | Orange/red recolor |

4. **Keep icons simple:**
   - At 16x16, you have very limited space
   - Strong silhouettes, 3-4 colors max per icon
   - Test readability at actual size

### Passive Icons (SOURCED)

Per PRD, passive icons come from asset packs:

- Iron Beak, Thick Plumage, Racing Legs, Magnetic Aura
- Generic upgrade/buff icons work fine
- Or Ericka can create if time permits

### Pickups (SOURCED)

- XP Gem (blue diamond) - from UI/icon pack
- Gold Coin (yellow circle) - from UI/icon pack

---

## Part 9: Importing into Godot 4

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

3. **Enable Integer Scaling (Godot 4.3+):**
   - Project > Project Settings
   - Display > Window > Stretch > Scale Mode: **integer**
   - This ensures pixels remain perfectly square at any window size
   - Prevents pixel distortion at non-integer scale factors (like 1.5x or 2.7x)
   - Your game will scale by whole numbers only (2x, 3x, 4x)

### Importing Character Sprites

1. **Drag PNG files into `res://sprites/characters/`**

2. **Click on imported file, check Import dock:**

   - Filter: Nearest (should be default now)
   - Click "Reimport" if you change settings

   **Troubleshooting blurry pixels:** If your sprites appear blurry or smoothed after import, the texture filter wasn't set correctly. Select the texture in FileSystem, go to the Import tab, verify Filter is set to "Nearest", and click "Reimport". This forces Godot to re-process the image with the correct settings.

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

2. **Add your tileset images:**

   - Open the TileSet, click "Add" at bottom
   - Add `tileset_generic.png` (sourced)
   - Add `tileset_filipino.png` (Ericka's)
   - Set Tile Size: 32x32 for both

3. **Configure tiles:**

   - Godot auto-slices based on grid
   - Click each tile to add collision shapes if needed
   - Most tiles are decoration-only (no collision)

4. **Create TileMap in your main scene:**
   - Add TileMap node
   - Assign your TileSet resource
   - Paint your arena!

### Optional: Aseprite Importer Plugin

For a faster workflow, you can install the **Godot 4 Aseprite Importer** plugin from the Asset Library. This automates much of the import process:

1. **Install the plugin:**

   - In Godot, go to AssetLib tab
   - Search for "Aseprite Importer"
   - Download and enable in Project Settings > Plugins

2. **Configure the plugin:**

   - In Project Settings, find the plugin settings
   - Set the path to your Aseprite executable (e.g., `/Applications/Aseprite.app/Contents/MacOS/aseprite` on Mac)

3. **Benefits:**
   - Import `.ase` or `.aseprite` files directly (no manual PNG export)
   - Auto-generates animations from frame tags
   - Creates SpriteFrames resources automatically
   - Keeps art synced—edit in Aseprite, auto-updates in Godot

**Note:** This is optional. The manual PNG workflow described above works perfectly well and doesn't require plugin setup.

### Code-Handled Effects (DO NOT DRAW THESE)

The following visual effects are handled in Godot via shaders and code. **Ericka does NOT need to create art for these:**

| Effect                                  | How It's Done in Godot                          |
| --------------------------------------- | ----------------------------------------------- |
| Enemy damage flash (white flash on hit) | Shader modulate or `modulate = Color.WHITE`     |
| Player invincibility flash              | Blinking animation or white modulate            |
| Slow debuff visual (Ice Shard)          | Blue tint via `modulate = Color(0.5, 0.5, 1.0)` |
| Pickup magnet glow                      | Shader or existing sparkle particles            |

**Why not draw white frames?** Creating white versions of every enemy sprite is a waste of time. A single line of shader code applies the effect to any sprite dynamically. Same for tint effects.

**Example (Josh implements this):**

```gdscript
# Flash white on hit, then return to normal
func flash_damage():
    modulate = Color.WHITE
    await get_tree().create_timer(0.1).timeout
    modulate = Color(1, 1, 1)  # Back to normal
```

---

## Part 10: File Organization

### Recommended Folder Structure

```
sarimanok-game/
├── game/                              # Godot project
│   ├── sprites/
│   │   ├── characters/
│   │   │   ├── sarimanok_classic.png
│   │   │   ├── sarimanok_shadow.png
│   │   │   └── sarimanok_golden.png
│   │   ├── enemies/
│   │   │   ├── duwende_green.png
│   │   │   ├── duwende_red.png
│   │   │   ├── duwende_black.png      # Update 1
│   │   │   ├── santelmo.png
│   │   │   └── manananggal.png
│   │   ├── weapons/
│   │   │   ├── feather_projectile.png
│   │   │   ├── ice_shard_projectile.png
│   │   │   ├── peck_hit_effect.png
│   │   │   ├── wing_slap_circle.png
│   │   │   └── flame_wing_circle.png
│   │   ├── pickups/                   # SOURCED
│   │   │   ├── pickup_xp.png
│   │   │   └── pickup_gold.png
│   │   ├── icons/
│   │   │   ├── peck_icon.png
│   │   │   ├── wing_slap_icon.png
│   │   │   ├── feather_shot_icon.png
│   │   │   ├── spiral_feathers_icon.png
│   │   │   ├── ice_shard_icon.png
│   │   │   ├── flame_wing_icon.png
│   │   │   └── passives/              # SOURCED
│   │   │       ├── iron_beak_icon.png
│   │   │       ├── thick_plumage_icon.png
│   │   │       ├── racing_legs_icon.png
│   │   │       └── magnetic_aura_icon.png
│   │   └── environment/
│   │       └── bahay_kubo_background.png
│   │       # dawn_overlay NOT NEEDED - handled by GradientTexture2D in Godot
│   ├── tilesets/
│   │   ├── tileset_generic.png        # SOURCED
│   │   ├── tileset_filipino.png       # Ericka creates
│   │   └── tileset_farm.tres
│   └── ...
│
└── art_source/                        # Aseprite source files (NOT in Godot)
    ├── characters/
    │   ├── sarimanok_classic.aseprite
    │   ├── sarimanok_shadow.aseprite
    │   └── sarimanok_golden.aseprite
    ├── enemies/
    │   ├── duwende_green.aseprite
    │   ├── santelmo.aseprite
    │   └── manananggal.aseprite
    ├── tiles/
    │   ├── tileset_filipino.aseprite
    │   └── bahay_kubo.aseprite
    └── palette_resurrect64.aseprite  # Master palette reference
```

**Important:** Keep `.aseprite` source files OUTSIDE the Godot project folder but in your repo. Godot doesn't need them, but you need them for edits.

---

## Part 11: Pose Lists for Each Creature

### Sarimanok (Player Characters) - 32x32

| Pose      | Frames | Description                                                |
| --------- | ------ | ---------------------------------------------------------- |
| idle/walk | 2      | Bob animation - frame 1: neutral, frame 2: slight bob down |

**Animation Notes:**

- Only 2 frames needed (per PRD: "2 frames: idle/walk (bob animation)")
- Code handles sprite flip for direction (no separate left/right sprites needed)
- All 3 variants use same poses, just different colors
- **Timing:** 0.2 seconds per frame (5 FPS)

**Visual Reference for Poses:**

```
Frame 1 (Neutral):        Frame 2 (Bob):
    ╱▔▔╲                     ╱▔▔╲
   ╱ ◉  ╲   crest           ╱ ◉  ╲
   │    │   body             │    │
   ╱╲  ╱╲   tail/feet       ─╱╲──╱╲─  (slightly lower)
```

### Duwendes (Green, Red, Black) - 32x32

| Pose | Frames | Description          |
| ---- | ------ | -------------------- |
| walk | 2      | Waddle toward player |

**Animation Notes:**

- Simple 2-frame walk cycle
- Green, Red, Black are recolors of same base sprite
- Small goblin-like creature with pointy ears
- **Timing:** 0.2 seconds per frame (5 FPS)

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
- **Timing:** 0.15 seconds per frame (~7 FPS - faster for fire)

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
- **Timing:** 0.15 seconds per frame (~7 FPS)

**Visual Reference:**

```
Frame 1:           Frame 2:           Frame 3:           Frame 4:
  ╲    ╱             ─    ─             ╱    ╲             ─    ─
   ╲  ╱   wings up    ──  ──  mid       ╱  ╲   wings down   ──  ──  mid
    ▓▓    torso        ▓▓               ▓▓                  ▓▓
```

### Pickups - 16x16 (SOURCED)

| Asset     | Frames | Description                    |
| --------- | ------ | ------------------------------ |
| XP Gem    | 1-2    | Blue diamond, optional sparkle |
| Gold Coin | 1-2    | Yellow circle, optional spin   |

### Weapon Effects - Various Sizes

| Asset              | Size  | Frames | Description                      |
| ------------------ | ----- | ------ | -------------------------------- |
| Feather Projectile | 16x16 | 1      | Single feather (code rotates it) |
| Ice Shard Proj.    | 16x16 | 1      | Blue recolor of feather          |
| Peck Hit           | 32x32 | 2-3    | Quick slash effect               |
| Wing Slap Circle   | 64x64 | 2-3    | Expanding circle                 |
| Flame Wing Circle  | 64x64 | 2-3    | Orange recolor of Wing Slap      |

**IMPORTANT - Attack Effects Must Convey Motion:**

Because the Sarimanok only has a 2-frame bob animation (no attack poses), the weapon effects must do the heavy lifting to communicate the attack:

- **Peck Hit Effect:** Should look like a directional thrust/jab pointing outward from the Sarimanok, NOT a generic impact spark. Include motion lines or a sharp "stab" shape.
- **Wing Slap Circle:** Should have visible sweep/whoosh lines radiating outward, suggesting a powerful wing sweep. Think "shockwave" not just "circle."
- **Feather Projectile:** The feather sprite should clearly point in its direction of travel. Code handles rotation, but make sure it reads well at all angles.

**Visual Reference:**

```
Peck (directional):       Wing Slap (radial):
      ╱                        ╲ │ ╱
   ──●─→                     ───●───
      ╲                        ╱ │ ╲
   (thrust outward)        (radiating lines)
```

### Icons - 16x16

| Icon            | Frames | Description        | Source  |
| --------------- | ------ | ------------------ | ------- |
| Peck            | 1      | Beak/sharp point   | Ericka  |
| Wing Slap       | 1      | Wing shape         | Ericka  |
| Feather Shot    | 1      | Feather            | Ericka  |
| Spiral Feathers | 1      | Feathers in circle | Ericka  |
| Ice Shard       | 1      | Blue feather       | Recolor |
| Flame Wing      | 1      | Orange wing        | Recolor |
| Iron Beak       | 1      | Metallic beak      | Sourced |
| Thick Plumage   | 1      | Fluffy feathers    | Sourced |
| Racing Legs     | 1      | Running legs       | Sourced |
| Magnetic Aura   | 1      | Magnet or glow     | Sourced |

---

## Part 12: Animation Templates for Ericka

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

### Setting Animation Speed in Godot

When you import animations into Godot, here's where to set the FPS:

1. **Open the SpriteFrames resource:**

   - Select your AnimatedSprite2D node
   - Click on the SpriteFrames property to open the editor

2. **Set animation speed:**

   - In the SpriteFrames panel, find the "Speed (FPS)" field at the top
   - Set it based on your animation type:
     - **5 FPS** for walk/idle animations (0.2 seconds per frame)
     - **7 FPS** for fire/wings animations (0.15 seconds per frame)

3. **Enable looping:**
   - Click the loop icon next to the animation name (should be enabled by default)

**Quick Reference:**
| Animation Type | Seconds/Frame | FPS Setting |
| -------------- | ------------- | ----------- |
| Walk/Idle | 0.2s | 5 FPS |
| Fire/Flicker | 0.15s | 7 FPS |
| Wing Flap | 0.15s | 7 FPS |

---

## Part 13: Sprite Sheet Structure for Godot Import

### Standard Format: Horizontal Strip

All sprites should be exported as **horizontal strips** - frames side by side in a row.

```
┌─────────────────────────────────┐
│ Frame 1 │ Frame 2 │ Frame 3 │...│  = One horizontal row
└─────────────────────────────────┘
```

### Exact Sprite Sheet Specifications

| Asset             | Frame Size | Frames | Total PNG Size | Filename                 |
| ----------------- | ---------- | ------ | -------------- | ------------------------ |
| Sarimanok Classic | 32x32      | 2      | 64x32          | sarimanok_classic.png    |
| Sarimanok Shadow  | 32x32      | 2      | 64x32          | sarimanok_shadow.png     |
| Sarimanok Golden  | 32x32      | 2      | 64x32          | sarimanok_golden.png     |
| Duwende Green     | 32x32      | 2      | 64x32          | duwende_green.png        |
| Duwende Red       | 32x32      | 2      | 64x32          | duwende_red.png          |
| Duwende Black     | 32x32      | 2      | 64x32          | duwende_black.png        |
| Santelmo          | 32x32      | 2      | 64x32          | santelmo.png             |
| Manananggal       | 48x48      | 4      | 192x48         | manananggal.png          |
| Feather Proj.     | 16x16      | 1      | 16x16          | feather_projectile.png   |
| Ice Shard Proj.   | 16x16      | 1      | 16x16          | ice_shard_projectile.png |
| Peck Effect       | 32x32      | 2-3    | 64-96x32       | peck_hit_effect.png      |
| Wing Slap Circle  | 64x64      | 2-3    | 128-192x64     | wing_slap_circle.png     |
| Flame Wing Circle | 64x64      | 2-3    | 128-192x64     | flame_wing_circle.png    |

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

**tileset_filipino.png (128x64 total = 4 columns x 2 rows of 32x32 tiles):**

```
┌────────┬────────┬────────┬────────┐
│ Rice A │ Rice B │ Crop A │ Crop B │ Row 0: Decorations
├────────┼────────┼────────┼────────┤
│Fence L │Fence M │Fence R │ Extra  │ Row 1: Fence pieces
└────────┴────────┴────────┴────────┘
```

### Godot Import Settings

When Josh imports these sprite sheets:

1. **For animated sprites (characters, enemies):**

   - Use AnimatedSprite2D node
   - Create SpriteFrames resource
   - "Add frames from sprite sheet"
   - Set Horizontal = number of frames, Vertical = 1
   - Animation FPS: 5 for walk/idle, 7 for fire/wings

2. **For tileset:**
   - Create TileSet resource
   - Add both tileset PNGs as sources
   - Set Tile Size: 32x32
   - Godot auto-slices into grid

---

## Part 14: Complete Asset Checklist

### Characters (3 total) - ERICKA CREATES

- [ ] sarimanok_classic.png (32x32, 2 frames = 64x32)
- [ ] sarimanok_shadow.png (32x32, 2 frames = 64x32) - recolor
- [ ] sarimanok_golden.png (32x32, 2 frames = 64x32) - recolor

### Enemies (4 for EA, 1 for Update 1) - ERICKA CREATES

- [ ] duwende_green.png (32x32, 2 frames = 64x32)
- [ ] duwende_red.png (32x32, 2 frames = 64x32) - recolor
- [ ] duwende_black.png (32x32, 2 frames = 64x32) - **Update 1** - recolor
- [ ] santelmo.png (32x32, 2 frames = 64x32)
- [ ] manananggal.png (48x48, 4 frames = 192x48)

### Weapon Icons (6 total: 4 unique + 2 recolors) - ERICKA CREATES

- [ ] peck_icon.png (16x16)
- [ ] wing_slap_icon.png (16x16)
- [ ] feather_shot_icon.png (16x16)
- [ ] spiral_feathers_icon.png (16x16)
- [ ] ice_shard_icon.png (16x16) - blue recolor of feather_shot
- [ ] flame_wing_icon.png (16x16) - orange recolor of wing_slap

### Weapon Effects (5 total: 3 unique + 2 recolors) - ERICKA CREATES

- [ ] feather_projectile.png (16x16, 1 frame)
- [ ] ice_shard_projectile.png (16x16, 1 frame) - blue recolor
- [ ] peck_hit_effect.png (32x32, 2-3 frames = 64-96x32)
- [ ] wing_slap_circle.png (64x64, 2-3 frames = 128-192x64)
- [ ] flame_wing_circle.png (64x64, 2-3 frames) - orange recolor

### Shared Assets (1 total) - ERICKA CREATES

- [ ] shadow.png (16x8, dark ellipse, ~50% opacity) - reused under all characters/enemies

### Filipino Environment Tiles - ERICKA CREATES

- [ ] rice_paddy_a.png (32x32) or in tileset
- [ ] rice_paddy_b.png (32x32) or in tileset
- [ ] vegetable_crop_a.png (32x32) or in tileset
- [ ] vegetable_crop_b.png (32x32) or in tileset
- [ ] bamboo_fence_left.png (32x32) or in tileset
- [ ] bamboo_fence_middle.png (32x32) or in tileset
- [ ] bamboo_fence_right.png (32x32) or in tileset
- [ ] bahay_kubo_background.png (64x64 or 96x64)
- ~~dawn_overlay.png~~ — NOT NEEDED, handled by `GradientTexture2D` in Godot

**OR export as single tileset:**

- [ ] tileset_filipino.png (128x64, 8 tiles)

### Passive Icons (4 total) - SOURCED from asset pack

- [ ] iron_beak_icon.png (16x16)
- [ ] thick_plumage_icon.png (16x16)
- [ ] racing_legs_icon.png (16x16)
- [ ] magnetic_aura_icon.png (16x16)

### Pickups (2 total) - SOURCED from asset pack

- [ ] pickup_xp.png (16x16, 1-2 frames)
- [ ] pickup_gold.png (16x16, 1-2 frames)

### Particle Sprites - SOURCED from itch.io

Source a particle/VFX pack from itch.io (~$5-10 or free). Look for packs containing:

- [ ] Blood/hit effect particles - for enemy death puffs
- [ ] Sparkle/shine particles - for XP collection, level-up
- [ ] Fire/flame particles - for Santelmo trail/death
- [ ] Blood drop/trail - for Manananggal boss trail

**Recommended search terms:** "pixel particle pack", "pixel VFX", "pixel effects"

**Why source instead of draw?** Particles are generic effects that don't need Filipino cultural identity. Save Ericka's time for the characters and enemies that make the game unique.

### Generic Environment - SOURCED from asset pack

- [ ] tileset_generic.png (grass, dirt, rocks, trees)

### UI Elements - SOURCED from asset pack

- [ ] HP bar sprites
- [ ] XP bar sprites
- [ ] Button sprites
- [ ] Panel backgrounds

### UI/Branding - FONT-BASED (No Custom Art Needed)

The game title "SARIMANOK SURVIVOR" will use a sourced pixel font, not custom pixel art. This reduces scope while still looking great.

**Font sources:**

- [fonts.google.com](https://fonts.google.com) - filter by "Pixel" or "Display"
- [itch.io](https://itch.io/game-assets/tag-fonts) - pixel font packs
- [dafont.com](https://www.dafont.com/theme.php?cat=303) - free pixel fonts

**Note:** All text in the game (title, damage numbers, victory text, UI labels) uses fonts handled by code - Ericka does not need to draw any text or numbers.

---

## Asset Summary

### Ericka Creates (Filipino Identity)

| Category       | Count                             | Total Time     |
| -------------- | --------------------------------- | -------------- |
| Characters     | 3 sprites                         | 5-6 hrs        |
| Enemies        | 4 sprites (5 with Update 1)       | 9.5-13.5 hrs   |
| Weapon Icons   | 6 icons (4 unique + 2 recolors)   | 2.5 hrs        |
| Weapon Effects | 5 effects (3 unique + 2 recolors) | 3-4 hrs        |
| Filipino Tiles | 8 tiles + background              | 1-2 hrs        |
| Shared         | 1 shadow sprite                   | 15 min         |
| **TOTAL**      | ~28 files                         | **~19-25 hrs** |

### Sourced from Asset Packs (~$35-60)

| Category        | Source                     |
| --------------- | -------------------------- |
| Generic tileset | Tileset pack ($10-20)      |
| UI elements     | UI pack ($10-15)           |
| Pickups         | UI pack (included)         |
| Passive icons   | Icon pack (included)       |
| Particle/VFX    | Particle pack ($5-10/free) |
| Pixel font      | Free (Google Fonts/itch)   |

---

## Quick Start Checklist

### Before Starting Any Sprite:

- [ ] Download and load your palette (Resurrect 64)
- [ ] Set Color Mode to RGBA
- [ ] Set canvas size (32x32 for most, 48x48 for boss, 16x16 for icons)

### For Each Character/Enemy:

- [ ] Research the cultural reference
- [ ] Sketch silhouette first
- [ ] Draw idle frame (Frame 1)
- [ ] Add animation frames
- [ ] Tag animations ("idle", "walk", etc.)
- [ ] Export as horizontal sprite sheet PNG
- [ ] Name file consistently

### For Filipino Tileset:

- [ ] Create 128x64 canvas with 32x32 grid
- [ ] Draw rice paddy variations (Row 0)
- [ ] Draw bamboo fence pieces (Row 1)
- [ ] Test seamless tiling
- [ ] Export as tileset_filipino.png

### For Recolors:

- [ ] File > Save As (new filename)
- [ ] Edit > Replace Color
- [ ] Adjust shadows/highlights as needed
- [ ] Export with new name

---

## Asset Priority Order (Ericka's Roadmap)

Based on the PRD's parallel development timeline:

**Week 1-2:** Sarimanok Classic FIRST (hero character for demo)

- Then Shadow and Golden variants

**Week 3-4:** Duwendes (Green, then Red recolor) + Santelmo

**Week 5-6:** Manananggal (boss) + All Icons + Filipino Tiles

**Week 7-8:** Integration, polish, any remaining assets

If art runs behind, Josh can continue with colored rectangles. The game is shippable with placeholders for Early Access.

---

**Version History:**

- v2.5: Scope reduction - Moved Particle Sprites to SOURCED (itch.io packs), changed title logo to font-based (no custom pixel art). Ericka focuses exclusively on Filipino folklore characters. Updated totals (~28 files, 19-25 hrs). Kept Code-Handled Effects note and attack motion guidance from v2.4.
- v2.4: Gap analysis additions - Added Particle Sprites section, UI/Branding section, Code-Handled Effects note (white flash, tints handled by Godot shaders), attack effect motion guidance for Peck/Wing Slap, Manananggal blood trail step.
- v2.3: Added character shadow guidance (Part 4) - shadows are a separate sprite handled in Godot, not baked into animation frames. Added shadow.png to asset checklist.
- v2.2: Best practices update - Changed color mode recommendation from Indexed to RGBA for beginners (Part 1, 4, 7), added Godot 4.3+ integer scaling setting (Part 9), added seamless tile testing workflow (Part 7), added sprite pivot/origin discussion (Part 4), added dawn overlay creation steps (Part 2), added Aseprite importer plugin option (Part 9), added texture reimport troubleshooting (Part 9), added FPS setting location in Godot (Part 12)
- v2.1: Added Learning Resources section (Part 0) with curated Aseprite tutorials, recommended watch order, and keyboard shortcuts reference
- v2.0: Major update - Added Map/Arena design section, Asset Responsibilities section, detailed Filipino asset creation guides (Sarimanok, Duwende, Santelmo, Manananggal, Bahay Kubo, Rice Paddy), updated asset checklist for 6 weapons with clone recolors, clarified sourced vs created assets per PRD
- v1.0: Initial guide

**Total Ericka Sprites:** ~28 files  
**Estimated Ericka Art Time:** 19-25 hours  
**Asset Pack Budget:** ~$35-60  
**At 10 hrs/week:** 2-2.5 weeks (parallel to coding)
