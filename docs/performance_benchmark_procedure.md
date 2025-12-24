# Performance Benchmark Procedure

**Version:** 1.0
**Created:** 2024-12-24
**Purpose:** Repeatable performance testing for Sarimanok Survivor Week 3 validation

---

## Prerequisites Checklist

### Hardware Requirements
Before running the benchmark, document your test hardware:

- [ ] **CPU:** _________________ (e.g., Intel i5-8400 @ 2.8GHz)
- [ ] **GPU:** _________________ (e.g., NVIDIA GTX 1060 6GB)
- [ ] **RAM:** _________________ (e.g., 16GB DDR4)
- [ ] **OS:** __________________ (e.g., Windows 10, macOS 14, Ubuntu 22.04)
- [ ] **Godot Version:** 4.5 (confirm with `godot --version`)

**Baseline Hardware (Mid-Range PC):**
- CPU: Intel i5 or AMD Ryzen 5 (6th gen or newer)
- GPU: NVIDIA GTX 1060 / AMD RX 580 or equivalent
- RAM: 8GB minimum

### Software Setup
- [ ] Godot 4.5 installed and accessible from command line
- [ ] No other heavy applications running (close browsers, IDEs, etc.)
- [ ] System monitoring tools ready (optional but recommended)

---

## Test Configurations

### Standard Benchmark Runs

| Test Name | Enemy Count | Duration | Pass Criteria |
|-----------|-------------|----------|---------------|
| **Baseline 100** | 100 enemies | 60 seconds | Avg FPS ≥ 60, Max frame time ≤ 20ms |
| **Target 200** | 200 enemies | 60 seconds | Avg FPS ≥ 60, Max frame time ≤ 20ms |

---

## Running the Benchmark

### Method 1: Godot Editor (Recommended)

**Step 1:** Open the project
```bash
cd /path/to/sarimanok-game
godot game/project.godot
```

**Step 2:** Configure enemy count
1. Open `game/scenes/tests/performance_test.tscn`
2. Select the `EnemySpawner` node
3. In Inspector, set `Enemy Count` to desired value (100 or 200)
4. Save the scene (Ctrl/Cmd + S)

**Step 3:** Run the test
1. With `performance_test.tscn` open, press **F6** (Run Current Scene)
2. Test runs automatically for 60 seconds
3. **Do not touch the window** - let it run uninterrupted
4. Results print to console when complete

**Step 4:** Record results
Copy the console output from the "=== PERFORMANCE TEST RESULTS ===" section.

Example output:
```
=== PERFORMANCE TEST RESULTS (60s) ===
Average FPS: 59.01
Min FPS: 1.00
Average Frame Time: 18.27 ms
Max Frame Time: 22.77 ms
Total Samples: 3594
TEST STATUS: PASS ✓
Target: 60 FPS avg, <20ms frame time
=======================================
```

---

### Method 2: Command Line (Headless)

**For automated testing:**

```bash
cd /path/to/sarimanok-game
godot --headless --path game/ scenes/tests/performance_test.tscn
```

**Note:** FPS metrics may differ in headless mode. Use editor runs for official benchmarks.

---

## Data Collection

### Manual Recording (Current Method)

Create a results file for each test run:

**File:** `docs/benchmark_results/YYYY-MM-DD_[test-name].txt`

**Template:**
```
Date: YYYY-MM-DD
Time: HH:MM
Hardware: [CPU/GPU/RAM from checklist above]
Godot Version: 4.5
Test: [Baseline 100 / Target 200]
Enemy Count: [100/200]

=== RESULTS ===
[Paste console output here]

Pass/Fail: [PASS/FAIL]
Notes: [Any observations, anomalies, or environmental factors]
```

### CSV Export (Enhanced Method)

The performance test script can export CSV data for analysis.

**Enable CSV export:**
1. Open `game/scripts/tests/performance_test.gd`
2. Uncomment the CSV export section in `_log_results()` (if implemented)
3. CSV saved to: `user://benchmark_results_[timestamp].csv`

**CSV Location by Platform:**
- **Windows:** `%APPDATA%\Godot\app_userdata\Sarimanok Survivor\`
- **macOS:** `~/Library/Application Support/Godot/app_userdata/Sarimanok Survivor/`
- **Linux:** `~/.local/share/godot/app_userdata/Sarimanok Survivor/`

---

## Pass/Fail Criteria

### Primary Thresholds
✅ **PASS** if ALL conditions met:
- Average FPS ≥ 60
- Average frame time ≤ 16.67ms
- Max frame time ≤ 20ms (allows occasional spikes)
- No crashes or errors during 60s run

❌ **FAIL** if ANY condition met:
- Average FPS < 60
- Average frame time > 16.67ms
- Max frame time > 20ms sustained (>5 seconds)
- Crashes, freezes, or errors

### Startup Spike Exception
**First frame FPS drop** (Min FPS: 1.00) is expected during pool initialization and does NOT count as a fail.

---

## Running Multiple Tests (Validation)

For consistency validation, run the same test **twice in a row**:

1. Run Test 1 → record results
2. **Wait 30 seconds** (let system cool down)
3. Run Test 2 → record results
4. Compare: Results should vary **<5% FPS**

**Example:**
- Test 1: 59.01 FPS avg
- Test 2: 58.50 FPS avg
- Variance: 0.86% ✅ PASS

If variance >5%, investigate:
- Background processes interfering?
- Thermal throttling?
- Inconsistent enemy spawn patterns?

---

## Troubleshooting

### "Test scene won't load"
- Verify you're in the `game/` directory
- Check `performance_test.tscn` exists in `scenes/tests/`
- Ensure enemy pool config resource exists

### "FPS way too low"
- Close background applications
- Check GPU drivers up to date
- Verify no other Godot instances running
- Try restarting computer

### "Results not printing to console"
- Open **Output** panel in Godot (bottom dock)
- Enable **All Messages** filter
- Ensure test ran for full 60 seconds

### "CSV file not found"
- Check correct `user://` path for your OS (see Data Collection section)
- Verify CSV export code is uncommented in `performance_test.gd`
- Check console for file write errors

---

## Benchmark Schedule

Run benchmarks at these project milestones:

- [x] **Week 3 Foundation** - Baseline established (100/200 enemies)
- [ ] **Week 4** - After adding weapons and projectiles
- [ ] **Week 6** - After adding pickups and particles
- [ ] **Week 9** - After adding real sprites (vs placeholders)
- [ ] **Week 10** - After adding audio
- [ ] **Week 12** - Final pre-launch validation

---

## Expected Setup Time

**First-time setup:** ~5 minutes (reading procedure, hardware checklist)
**Per test run:** ~2 minutes (configure enemy count, run 60s test, record results)

❌ **FAIL** if setup takes >2 minutes per run after first time - indicates missing automation.

---

## Quick Reference

### Fast Benchmark Run (After First Time)
1. Open Godot → Open `performance_test.tscn` (30 sec)
2. Set enemy count in Inspector (10 sec)
3. Press F6, wait 60 sec
4. Copy console output (20 sec)
5. **Total: ~2 minutes**

### Pass Criteria TL;DR
- 60 FPS average? ✅
- <20ms max frame time? ✅
- No crashes? ✅
- **= PASS**

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024-12-24 | Initial benchmark procedure for Task 10.5 |

