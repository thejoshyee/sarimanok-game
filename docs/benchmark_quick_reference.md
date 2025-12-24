# Performance Benchmark Quick Reference

**📋 Full procedure:** See `performance_benchmark_procedure.md`

---

## Fast Run (2 minutes)

1. **Open test scene**
   ```bash
   godot game/project.godot
   # Open: scenes/tests/performance_test.tscn
   ```

2. **Set enemy count**
   - Select `EnemySpawner` node
   - Inspector → `Enemy Count`: 100 or 200

3. **Run test**
   - Press **F6** (Run Current Scene)
   - Wait 60 seconds
   - Don't touch the window

4. **Check results**
   - Console shows: `=== PERFORMANCE TEST RESULTS ===`
   - CSV auto-saved to `user://benchmark_results_[timestamp].csv`

---

## Pass Criteria ✅

| Metric | Target |
|--------|--------|
| Avg FPS | ≥ 60 |
| Max Frame Time | ≤ 20ms |
| No Crashes | ✅ |

**First frame spike** (Min FPS: 1.00) = normal startup, ignore it.

---

## CSV Location by OS

- **macOS:** `~/Library/Application Support/Godot/app_userdata/Sarimanok Survivor/`
- **Windows:** `%APPDATA%\Godot\app_userdata\Sarimanok Survivor\`
- **Linux:** `~/.local/share/godot/app_userdata/Sarimanok Survivor/`

---

## Test Schedule

- [ ] Week 3 - Foundation baseline ✅ (DONE)
- [ ] Week 4 - After weapons/projectiles
- [ ] Week 6 - After pickups/particles
- [ ] Week 9 - After real sprites
- [ ] Week 10 - After audio
- [ ] Week 12 - Pre-launch

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Low FPS | Close background apps, restart |
| No console output | Open Output panel, enable All Messages |
| Can't find CSV | Check OS-specific path above |
| Scene won't load | Verify in `game/` directory |

---

**📖 Need details?** Read the full procedure in `performance_benchmark_procedure.md`
