================================================================================
                    SARIMANOK SURVIVOR - ART COLLABORATION
================================================================================

This shared Dropbox folder is where we collaborate on game art.
Ericka creates art here, Josh integrates it into the game.

--------------------------------------------------------------------------------
FOLDER STRUCTURE
--------------------------------------------------------------------------------

sarimanok-art/
|
|-- source/                    <-- Aseprite source files (.aseprite)
|   |-- characters/            Sarimanok variants
|   |-- enemies/               Duwendes, Santelmo, Manananggal
|   |-- weapons/               Weapon effects and projectiles
|   |-- icons/                 Weapon and passive icons
|   |-- tiles/                 Filipino-themed tiles
|   '-- palette.aseprite       MASTER COLOR PALETTE (load this first!)
|
'-- exports/                   <-- Finished PNGs ready for the game
    |-- characters/
    |-- enemies/
    |-- weapons/
    |-- icons/
    '-- tiles/


--------------------------------------------------------------------------------
FOR ERICKA - YOUR WORKFLOW
--------------------------------------------------------------------------------

1. BEFORE STARTING ANY NEW SPRITE:
   - Open Aseprite
   - Go to: Sprite > Color Mode > make sure it's "RGBA Color"
   - Load the palette: Click palette menu (bottom) > Load Palette
   - Select: source/palette.aseprite
   - Now you're ready to draw!

2. WHILE WORKING:
   - Save your .aseprite file in the correct source/ subfolder
   - Example: source/characters/sarimanok_classic.aseprite
   - Save often! (Ctrl+S / Cmd+S)

3. WHEN A SPRITE IS FINISHED:
   - File > Export Sprite Sheet (or Ctrl+E / Cmd+E)
   - Export settings:
     * Sheet Type: "Horizontal Strip" (for animations)
     * OR "Packed" if it's a single image
     * Constraints: None (keep original size)
     * Output File: Choose the matching exports/ subfolder
   - Name it exactly the same as your source file, but .png
   - Example: exports/characters/sarimanok_classic.png

4. LET JOSH KNOW:
   - Send a quick message: "sarimanok_classic is done!"
   - Josh will grab it from exports/ and put it in the game


--------------------------------------------------------------------------------
FILE NAMING RULES (IMPORTANT!)
--------------------------------------------------------------------------------

Use these exact names - Godot needs them to match the code:

CHARACTERS (32x32, 2 frames horizontal = 64x32 total):
  sarimanok_classic.png
  sarimanok_shadow.png
  sarimanok_golden.png

ENEMIES (32x32, 2 frames = 64x32 total, except boss):
  duwende_green.png
  duwende_red.png
  santelmo.png
  manananggal.png          (48x48, 4 frames = 192x48 total)

WEAPONS:
  feather_projectile.png   (16x16)
  ice_shard_projectile.png (16x16, blue tint)
  peck_hit_effect.png      (32x32, 2-3 frames)
  wing_slap_circle.png     (64x64, 2-3 frames)
  flame_wing_circle.png    (64x64, orange tint)

ICONS (all 16x16, single frame):
  peck_icon.png
  wing_slap_icon.png
  feather_shot_icon.png
  spiral_feathers_icon.png
  ice_shard_icon.png
  flame_wing_icon.png

TILES:
  tileset_filipino.png     (see tile guide for layout)
  bahay_kubo_background.png

NAMING RULES:
  - All lowercase
  - Use underscores instead of spaces: "sarimanok_classic" not "Sarimanok Classic"
  - No special characters
  - Keep names SHORT but clear


--------------------------------------------------------------------------------
FOR JOSH - INTEGRATION WORKFLOW
--------------------------------------------------------------------------------

1. CHECK EXPORTS FOLDER:
   - When Ericka finishes something, it appears in exports/

2. COPY TO GAME PROJECT:
   - Copy the PNG from: Dropbox/sarimanok-art/exports/[subfolder]/
   - Paste to: sarimanok-game/game/sprites/[matching subfolder]/

3. COMMIT TO GIT:
   - Stage the new sprite
   - Commit with message like: "Add sarimanok_classic sprite"

4. IF YOU NEED TO EDIT A SPRITE:
   - Open the .aseprite file from source/
   - Make your changes
   - Re-export to exports/ with same name
   - Copy to game project and commit

5. KEEP SOURCE FILES:
   - The source/ folder is our backup
   - Never delete .aseprite files - we need them for edits


--------------------------------------------------------------------------------
ABOUT THE PALETTE FILE
--------------------------------------------------------------------------------

source/palette.aseprite contains the Dawnbringer 32 color palette.

WHY USE IT:
- Keeps all our sprites visually consistent
- 32 colors is plenty for pixel art
- Professional games use limited palettes

HOW TO SET IT UP (one-time):
1. Go to: lospec.com/palette-list/dawnbringer-32
2. Click "Download" and choose "GIMP GPL" format
3. You'll get a file called dawnbringer-32.gpl
4. In Aseprite: Palette menu (bottom of screen) > Load Palette
5. Select the dawnbringer-32.gpl file
6. File > Save As > save to source/palette.aseprite

LOADING IT FOR EACH NEW SPRITE:
- Palette menu (bottom of screen) > Load Palette
- Select source/palette.aseprite
- Now all 32 colors are in your palette panel


--------------------------------------------------------------------------------
QUICK CHECKLIST FOR ERICKA
--------------------------------------------------------------------------------

[ ] Loaded the palette? (source/palette.aseprite)
[ ] Working in correct source/ subfolder?
[ ] File named correctly? (lowercase, underscores)
[ ] Correct canvas size? (32x32 for most, 48x48 for boss, 16x16 for icons)
[ ] Exported to exports/ folder as PNG?
[ ] Let Josh know it's ready?


--------------------------------------------------------------------------------
QUESTIONS?
--------------------------------------------------------------------------------

Check the full pixel-art-workflow-guide.md in the game repo for:
- Detailed creation guides for each creature
- Animation frame counts
- Export settings
- Godot import instructions

Or just ask Josh!


================================================================================
                         Happy creating! - Josh & Ericka
================================================================================

