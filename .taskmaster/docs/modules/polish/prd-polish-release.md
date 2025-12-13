# Sarimanok Survivor - Steam Build & Balance (Weeks 10-11)

## Project Context

- **Genre:** Filipino folklore-themed survivor roguelite
- **Platform:** Windows (Godot 4.x, GDScript)
- **Art Style:** Top-down pixel art (32x32 sprites, 640×360 viewport)
- **Timeline:** 14 weeks → Early Access launch ~March 8, 2026

---

# Week 10: Steam Build & Demo (CODE COMPLETE)

**End State: "Ready for Steam with demo and achievements"**

**🎯 CODE COMPLETE MILESTONE (February 2-8, 2026)**

This is feature freeze. By end of Week 10:

- All features implemented and working
- All art integrated (or refined placeholders)
- Demo submitted for Next Fest review (Feb 9 deadline)
- Weeks 11-14 are ONLY for bugs, balance, and launch logistics

## Demo Configuration (10-Minute Time Limit)

**Type:** Time-limited demo (same build with timer check)

| Setting          | Value                                           |
| ---------------- | ----------------------------------------------- |
| Time Limit       | 10 minutes                                      |
| Cut-off Point    | Before Santelmo (10:00) and before boss (20:00) |
| Shop Access      | DISABLED (removes meta-progression hook)        |
| Character Select | Classic Sarimanok only                          |
| Save Data        | Does not persist                                |

**Demo End Screen:**

```
┌─────────────────────────────────────────────┐
│                                             │
│     The night is far from over...           │
│                                             │
│     Survive to dawn to discover             │
│     the Sarimanok's true power.             │
│                                             │
│         [WISHLIST NOW]  [EXIT]              │
│                                             │
│     Full game: $2.99-4.99 Early Access      │
│                                             │
└─────────────────────────────────────────────┘
```

**Implementation:**

```gdscript
# In GameState.gd or main game scene
var is_demo: bool = true  # Set to false in full game build

func _process(delta):
    if is_demo and time_survived >= 600.0:  # 10 minutes = 600 seconds
        show_demo_end_screen()

func show_demo_end_screen():
    get_tree().paused = true
    # Show demo end UI with wishlist button
    # Wishlist button opens Steam store page in browser
```

## Steam Achievements (5-8 for EA)

| Achievement     | Condition                                            | Type        |
| --------------- | ---------------------------------------------------- | ----------- |
| First Dawn      | Beat Story Mode                                      | Progression |
| Night Owl       | Survive 15:00 in Story Mode                          | Progression |
| Shadow Unlocked | Unlock Shadow Sarimanok                              | Unlock      |
| Century         | Kill 100 enemies in one run                          | Combat      |
| Maxed Out       | Get any weapon to Level 5                            | Build       |
| Shopaholic      | Buy 10 shop upgrades total                           | Meta        |
| Perfectionist   | Beat Story Mode without taking damage in final 5 min | Challenge   |
| Endless Night   | Survive 45:00 in Endless Mode                        | Endurance   |

## GodotSteam Integration (2-4 Hours)

1. Install GodotSteam GDExtension from Godot Asset Library (2-3 min)
2. Create Steam autoload with initialization code (15-30 min)
3. Test Steam overlay (Shift+Tab)
4. **IMPORTANT:** Use Compatibility rendering mode (Forward+ breaks overlay)
5. **IMPORTANT:** Set `SteamAppId` environment variable BEFORE `Steam.steamInit()`

**Achievement Hook Example:**

```gdscript
func _on_story_mode_victory():
    if Steam.isInitialized():
        Steam.setAchievement("ACHIEVEMENT_FIRST_DAWN")
        Steam.storeStats()
```

## Analytics Logging (CRITICAL for Update 1)

Log to local file for balance decisions:

```gdscript
func log_run_data():
    var run_data = {
        "time_survived": time_survived,
        "death_location": player.global_position,
        "enemies_killed": enemies_killed,
        "weapons_chosen": weapons.map(func(w): return w.id),
        "passives_chosen": passives.keys(),
        "final_level": level,
        "cause_of_death": last_damage_source,
        "timestamp": Time.get_unix_time_from_system()
    }

    var file = FileAccess.open("user://analytics.log", FileAccess.READ_WRITE)
    file.seek_end()
    file.store_line(JSON.stringify(run_data))
```

**Use for Update 1:** Analyze which weapons are popular, where players die, average survival time.

---

# Week 11: Balance & Bugs

**End State: "The game is FUN and STABLE"**

## Playtesting Focus

**Run 10+ full runs and track:**

- Average survival time for new players (target: 8-12 minutes)
- Win rate after 5 attempts (target: 20-30%)
- Most popular weapon choices (should be varied)
- Most common death locations/times (adjust difficulty spikes)
- Performance at 200+ enemies (target: 60 FPS)

## Balance Adjustments

**Enemy Stats:**

- If players survive past 30:00 easily: Increase stat scaling rate
- If players die before 10:00 consistently: Reduce early spawn rate
- If boss is trivial: Increase HP or dive attack frequency
- If boss is impossible: Reduce HP or telegraph dive attack longer

**Weapon Balance:**

- If one weapon dominates: Nerf slightly, buff alternatives
- If weapon feels weak: Increase damage or reduce cooldown
- If max level feels underwhelming: Increase final upgrade power

**XP Curve:**

- If leveling too fast: Increase XP requirements
- If leveling too slow: Decrease XP requirements or increase enemy XP drops

## Bug Fixing Priority

1. **Game-breaking:** Crashes, soft-locks, save corruption
2. **Critical:** Can't progress, lose progress, major exploits
3. **High:** Noticeable visual glitches, audio issues, balance problems
4. **Medium:** Minor visual issues, typos, small QoL improvements
5. **Low:** Polish, "nice-to-have" features

## Performance Testing

- 200+ enemies at 60 FPS (target from Week 6)
- 30-minute run with no memory leaks
- Rapid level-ups (spam XP collection) - no lag
- 1000+ projectiles on screen - acceptable FPS (45+)

## External Feedback

Send build to 3-5 friends/family:

- Can they beat Story Mode in 3-5 attempts?
- What feels unfair or frustrating?
- What feels satisfying and fun?
- Any crashes or bugs encountered?

## Error Handling

Wrap critical systems:

```gdscript
func save_game():
    try:
        # Save logic here
        pass
    catch error:
        push_error("Save failed: " + str(error))
        show_error_notification("Failed to save game. Please check disk space.")
```

---

# Definition of Done (Weeks 7-11)

## Week 7 (Settings & Feel)

- [ ] Settings menu works from main menu and pause
- [ ] Volume controls work (music, SFX)
- [ ] Fullscreen/windowed toggle works
- [ ] Screen shake toggle works (accessibility)
- [ ] Reduced motion option works
- [ ] Settings persist in save file
- [ ] Controller UI navigation works (D-pad/stick)
- [ ] Button prompts switch dynamically (keyboard ↔ controller)
- [ ] Screen shake on hits (if enabled)
- [ ] Impact frames on big hits
- [ ] Enemy death particles
- [ ] Pickup magnet visual feedback
- [ ] Level-up particle burst
- [ ] Tutorial teaches through level design (no overlays)
- [ ] In-game bug report button (links to Google Form or Discord)

## Week 8 (Art)

- [ ] Sarimanok Classic sprite imported and working
- [ ] Sarimanok Shadow sprite imported and working
- [ ] Sarimanok Golden sprite imported and working
- [ ] All enemy sprites imported and working
- [ ] Tileset imported, arena painted
- [ ] Weapon/passive icons imported
- [ ] Pickup sprites imported
- [ ] Hitboxes adjusted if needed
- [ ] Animations play correctly
- [ ] No visual glitches

## Week 9 (Audio)

- [ ] Menu music plays
- [ ] Gameplay music plays
- [ ] Boss music triggers at 20:00
- [ ] Victory jingle plays at win
- [ ] All placeholder SFX replaced with final
- [ ] COCKADOODLEDOO sound plays at victory
- [ ] Manananggal roar on spawn
- [ ] Audio respects volume settings
- [ ] Pitch randomization on repetitive sounds
- [ ] Music crossfades smoothly

## Week 10 (Steam Build)

- [ ] Windows build exports correctly
- [ ] Demo build with 10-minute timer works
- [ ] Demo end screen displays with wishlist CTA
- [ ] GodotSteam integration complete
- [ ] Steam overlay works (Shift+Tab)
- [ ] 5-8 achievements implemented and tested
- [ ] Analytics logging to local file
- [ ] Error logging/crash reporting to file for player bug reports
- [ ] Demo submitted for Next Fest review by Feb 9
- [ ] Trailer recorded (gameplay in first 5 seconds)
- [ ] Final screenshots taken

## Week 11 (Balance & Bugs)

- [ ] 10+ full playtests completed
- [ ] All game-breaking bugs fixed
- [ ] All critical bugs fixed
- [ ] Enemy balance feels fair
- [ ] Weapon balance feels varied
- [ ] XP curve feels appropriate
- [ ] Performance: 200+ enemies at 60 FPS
- [ ] No memory leaks in 30-minute run
- [ ] Feedback from 3-5 external testers collected
- [ ] Trailer finalized with music and titles
- [ ] Steam Deck testing complete (if available)

---

**Related Files:**
- [Settings & Game Feel](prd-polish-feel.md) - Week 7
- [Art Integration & Audio Polish](prd-polish-content.md) - Weeks 8-9
- **Next Milestone:** Weeks 12-14 (Launch Prep) - See [../launch/prd-launch-prep.md](../launch/prd-launch-prep.md)
