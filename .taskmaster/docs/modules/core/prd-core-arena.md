# Sarimanok Survivor - Arena Design (Farm Stage)

## Overview

The farm arena is a bounded outdoor environment where all gameplay takes place. The player (Sarimanok) defends the farm through the night against waves of Filipino mythological creatures.

**Design Goals:**
- Feel spacious and explorable (2.5x larger than original spec)
- Visual variety through distinct zones
- Filipino cultural landmarks (bahay kubo, rice paddies)
- Mostly open for gameplay - decorations don't block movement

---

## Arena Specifications

| Property | Value |
|----------|-------|
| **Size** | 3072 x 2048 pixels |
| **Tiles** | 96 x 64 tiles (32x32 each) |
| **Viewport** | 640 x 360 pixels |
| **Visible Area** | ~1/6 of arena at once |
| **Camera** | Follows player, bounded to arena edges |

### Why These Numbers
- 3072 / 32 = 96 tiles (clean math)
- 2048 / 32 = 64 tiles (clean math)
- 640x360 viewport scales cleanly: 3x = 1920x1080, 4x = 2560x1440
- Player sees enough to react but arena feels large

---

## Zone Layout

The arena is divided into distinct visual zones. All zones are passable - decorations are visual only (no collision except arena boundaries).

```
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│ [Trees]  [BAHAY KUBO 2x2]  [Trees]          [RICE PADDIES - flooded fields]          [Trees] │
│  Col 0-6      Col 10-15      Col 20-30            Col 40-80                         Col 90-95│  Rows 0-12
│                                          (alternating water/plant tiles)                     │  NORTH
│                                          ════════════════════════════════                    │
│                                          ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░                    │
│                                          ════════════════════════════════                    │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                              │
│ [Fence]                    OPEN GRASS AREA                                           [Fence] │  Rows 13-24
│ [Fence]            (grass variations, occasional dirt path)                          [Fence] │
│                                                                                              │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                              │
│                          CENTER PLAY AREA - MOSTLY OPEN                                      │  Rows 25-42
│                          (light grass base, scattered dirt paths)                            │  MAIN GAMEPLAY
│                          (sparse rocks and grass tufts for variety)                          │
│                                                                                              │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                              │
│ [Fence]      VEGETABLE PLOTS              LOWER OPEN AREA                            [Fence] │  Rows 43-54
│ [Fence]      Col 10-35                    Col 40-85                                  [Fence] │
│ [Fence]      (rows of crop tiles)                                                    [Fence] │
├──────────────────────────────────────────────────────────────────────────────────────────────┤
│ [Trees]  [Fence posts]    [WELL/CART area Col 45-50]    [Fence posts]                [Trees] │  Rows 55-63
│  Col 0-6                                                                            Col 90-95│  SOUTH
└──────────────────────────────────────────────────────────────────────────────────────────────┘
```

### Zone Descriptions

| Zone | Location | Tiles Used | Purpose |
|------|----------|------------|---------|
| **North/Rice Paddies** | Rows 0-12 | Trees, bahay kubo, rice paddies | Cultural landmarks, main Filipino identity |
| **Open Grass** | Rows 13-24 | Grass variations, fence edges | Transition area |
| **Center Play** | Rows 25-42 | Light grass, sparse decorations | Main gameplay space (most open) |
| **Lower Farm** | Rows 43-54 | Vegetable crops, grass | Visual variety |
| **South Edge** | Rows 55-63 | Trees, fence, well/cart | Southern boundary |
| **West/East Edges** | Cols 0-6, 90-95 | Trees, fence posts | Side boundaries |

---

## Points of Interest

### 1. Bahay Kubo (Northwest)
- **Location:** Rows 2-5, Cols 10-13 (2x2 tiles = 64x64 pixels)
- **Purpose:** Primary Filipino cultural landmark
- **Notes:** Traditional nipa hut, iconic silhouette. Placeholder = tan/brown 2x2 block.

### 2. Rice Paddies (North)
- **Location:** Rows 2-7, Cols 40-80
- **Purpose:** Filipino farming identity
- **Pattern:** Alternating rows of water tiles and plant tiles
- **Notes:** Creates horizontal stripe pattern. Placeholder = blue-green alternating.

### 3. Vegetable Plots (Southwest)
- **Location:** Rows 45-52, Cols 10-35
- **Purpose:** Break up open space, add visual variety
- **Pattern:** Rows of crop tiles with dirt paths between
- **Notes:** Placeholder = alternating green shades.

### 4. Well or Cart (South Center)
- **Location:** Rows 57-60, Cols 45-50
- **Purpose:** Secondary landmark, helps with orientation
- **Notes:** Could be a traditional well or carabao cart. Single tile or 2x2.

---

## Tileset Requirements

### Ground Layer (Layer 0) - Covers entire 96x64 grid

| Tile ID | Name | Placeholder Color | Usage |
|---------|------|-------------------|-------|
| 0 | grass_dark | #2d5a1e | Edges, under decorations |
| 1 | grass_medium | #3d7a2e | Most common ground tile |
| 2 | grass_light | #4d9a3e | Center areas, variation |
| 3 | dirt_dark | #5c4033 | Paths, under structures |
| 4 | dirt_light | #7a5a43 | Path edges, variation |
| 5 | rice_water | #4a6a7a | Rice paddy water |
| 6 | rice_plants | #5a8a5a | Rice paddy crops |

### Decoration Layer (Layer 1) - Sparse placement, no collision

| Tile ID | Name | Placeholder Color | Usage |
|---------|------|-------------------|-------|
| 7 | crop_row_1 | #6a9a4a | Vegetable plots |
| 8 | crop_row_2 | #7aaa5a | Vegetable plots (alternating) |
| 9 | rock_small | #6a6a6a | Scattered in center |
| 10 | grass_tuft | #3d8a2e (darker spot) | Scattered decoration |

### Edge Layer (Layer 1 or separate) - Arena boundaries

| Tile ID | Name | Placeholder Color | Usage |
|---------|------|-------------------|-------|
| 11 | fence_h | #8a6a4a | Horizontal fence |
| 12 | fence_v | #8a6a4a | Vertical fence |
| 13 | fence_post | #6a4a2a | Fence corners/posts |
| 14 | tree | #1a3a1a | Corner trees, edge trees |
| 15 | bahay_kubo_tl | #9a7a5a | Bahay kubo top-left |
| 16 | bahay_kubo_tr | #8a6a4a | Bahay kubo top-right |
| 17 | bahay_kubo_bl | #7a5a3a | Bahay kubo bottom-left |
| 18 | bahay_kubo_br | #6a4a2a | Bahay kubo bottom-right |
| 19 | well_cart | #7a5a3a | Well or cart structure |

**Total: 20 tile types**

### Placeholder Tileset Layout (256x128 PNG)

Each cell = 32x32 pixels. Total tileset = 256x128 pixels (8 cols x 4 rows).

```
Row 0 (y=0-31):
  #2d5a1e   #3d7a2e   #4d9a3e   #5c4033   #7a5a43   #4a6a7a   #5a8a5a   #6a9a4a
  grass     grass     grass     dirt      dirt      rice      rice      crop
  dark      med       light     dark      light     water     plants    row1

Row 1 (y=32-63):
  #7aaa5a   #6a6a6a   #3d8a2e   #8a6a4a   #8a6a4a   #6a4a2a   #1a3a1a   #9a7a5a
  crop      rock      grass     fence     fence     fence     tree      kubo
  row2      small     tuft      horiz     vert      post                TL

Row 2 (y=64-95):
  #8a6a4a   #7a5a3a   #6a4a2a   #7a5a3a   (empty)   (empty)   (empty)   (empty)
  kubo      kubo      kubo      well
  TR        BL        BR        cart

Row 3 (y=96-127):
  (leave empty for future tiles)
```

**Tile Index Reference:**
| Index | Tile | Hex Color |
|-------|------|-----------|
| 0 | grass_dark | #2d5a1e |
| 1 | grass_medium | #3d7a2e |
| 2 | grass_light | #4d9a3e |
| 3 | dirt_dark | #5c4033 |
| 4 | dirt_light | #7a5a43 |
| 5 | rice_water | #4a6a7a |
| 6 | rice_plants | #5a8a5a |
| 7 | crop_row_1 | #6a9a4a |
| 8 | crop_row_2 | #7aaa5a |
| 9 | rock_small | #6a6a6a |
| 10 | grass_tuft | #3d8a2e |
| 11 | fence_h | #8a6a4a |
| 12 | fence_v | #8a6a4a |
| 13 | fence_post | #6a4a2a |
| 14 | tree | #1a3a1a |
| 15 | bahay_kubo_tl | #9a7a5a |
| 16 | bahay_kubo_tr | #8a6a4a |
| 17 | bahay_kubo_bl | #7a5a3a |
| 18 | bahay_kubo_br | #6a4a2a |
| 19 | well_cart | #7a5a3a |

---

## Spawn Zones

Enemies spawn just outside the visible arena, then walk in.

| Zone | Spawn Area | Notes |
|------|------------|-------|
| **North** | Y = -32, X = 0 to 3072 | Random X along top edge |
| **South** | Y = 2080, X = 0 to 3072 | Random X along bottom edge |
| **East** | X = 3104, Y = 0 to 2048 | Random Y along right edge |
| **West** | X = -32, Y = 0 to 2048 | Random Y along left edge |

**Spawn logic:** Pick random edge, pick random position along that edge, spawn enemy 32-64 pixels outside boundary.

---

## Camera Configuration

```gdscript
# Camera2D settings
camera.limit_left = 0
camera.limit_top = 0
camera.limit_right = 3072
camera.limit_bottom = 2048
camera.position_smoothing_enabled = true
camera.position_smoothing_speed = 5.0
```

---

## Boundary Collision

Invisible StaticBody2D walls prevent player from leaving arena:

| Wall | Position | Size |
|------|----------|------|
| Top | (1536, -16) | (3072, 32) |
| Bottom | (1536, 2064) | (3072, 32) |
| Left | (-16, 1024) | (32, 2048) |
| Right | (3088, 1024) | (32, 2048) |

**Note:** Enemies spawn OUTSIDE these walls and walk through them (no collision with enemies, only player).

---

## Night/Day Effect

Uses CanvasModulate to tint the entire arena:

| State | CanvasModulate Color | Effect |
|-------|---------------------|--------|
| Night (0:00-29:59) | Color(0.6, 0.6, 0.8) | Cool blue tint |
| Dawn (30:00 victory) | Color(1.0, 0.95, 0.9) | Warm natural colors |

**Transition:** 2-second tween from night to dawn colors on victory.

---

## Implementation Checklist

### Code Updates
- [ ] Update ARENA_WIDTH to 3072 in main.gd
- [ ] Update ARENA_HEIGHT to 2048 in main.gd
- [ ] Update camera limits in main.tscn
- [ ] Update spawn edge positions in spawn_manager.gd
- [ ] Update boundary collision walls

### Tileset Setup
- [ ] Create placeholder_farm.png (256x128, colored squares)
- [ ] Import as TileSet resource in Godot
- [ ] Configure tile size 32x32
- [ ] Set up tile regions

### Tilemap Painting
- [ ] Paint Layer 0 (Ground) - full 96x64 coverage
- [ ] Paint Layer 1 (Decorations) - sparse placement
- [ ] Place bahay kubo tiles (NW)
- [ ] Place rice paddy pattern (N)
- [ ] Place vegetable plots (SW)
- [ ] Place edge trees and fences
- [ ] Place well/cart (S center)

### Testing
- [ ] Player can move across full arena
- [ ] Camera follows and stops at edges
- [ ] Enemies spawn from correct positions
- [ ] No gaps or visual glitches in tilemap

---

## Art Replacement (Week 7-8)

When Ericka creates the final tileset:
1. Replace placeholder_farm.png with final art
2. Re-import in Godot (same tile regions)
3. Tilemap layout stays the same
4. Test for any size/alignment issues

**Optional Filipino elements Ericka could add:**
- Detailed bahay kubo with nipa roof
- Rice paddy with water reflections
- Carabao cart or traditional well
- Banana trees instead of generic trees
