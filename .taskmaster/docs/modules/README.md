# PRD Modules - Split Structure

This directory contains the project's PRD split into 14 smaller, focused files (~150-280 lines each) for optimal task-master-ai parsing.

## Directory Structure

```
modules/
├── core/           (4 files) - Weeks 1-3 Foundation
├── progression/    (3 files) - Weeks 4-5 Win Condition & Shop
├── characters/     (2 files) - Week 6 Character Variants & Endless Mode
├── polish/         (3 files) - Weeks 7-11 Settings, Art, Audio, Balance
└── launch/         (2 files) - Weeks 12-14 Steam Launch
```

## File Organization by Week

### Weeks 1-3: Core Foundation
- [core/prd-core-foundation.md](core/prd-core-foundation.md) - Player character, tech specs, performance (221 lines)
- [core/prd-core-enemies.md](core/prd-core-enemies.md) - Enemy system, Duwendes, spawning (133 lines)
- [core/prd-core-weapons.md](core/prd-core-weapons.md) - Weapon system, 6 weapons, data-driven architecture (187 lines)
- [core/prd-core-progression.md](core/prd-core-progression.md) - Passives, level-up, pickups, Week 1-3 tasks (346 lines)

### Weeks 4-5: Win Condition & Meta Progression
- [progression/prd-progression-victory.md](progression/prd-progression-victory.md) - Win condition, dawn transition, Santelmo, Manananggal (255 lines)
- [progression/prd-progression-meta.md](progression/prd-progression-meta.md) - Shop system, score system, UI screens (224 lines)
- [progression/prd-progression-state.md](progression/prd-progression-state.md) - Save system, GameState singleton, Week 4-5 tasks (271 lines)

### Week 6: Character Variety & Endless Mode
- [characters/prd-characters-variants.md](characters/prd-characters-variants.md) - Shadow & Golden Sarimanok, character select (166 lines)
- [characters/prd-characters-endless.md](characters/prd-characters-endless.md) - Endless Mode, Week 6 tasks, MVP checkpoint (230 lines)

### Weeks 7-11: Polish & Balance
- [polish/prd-polish-feel.md](polish/prd-polish-feel.md) - Week 7: Settings, game feel, controller UX (276 lines)
- [polish/prd-polish-content.md](polish/prd-polish-content.md) - Weeks 8-9: Art integration & audio polish (252 lines)
- [polish/prd-polish-release.md](polish/prd-polish-release.md) - Weeks 10-11: Steam build, demo, balance, bugs (280 lines)

### Weeks 12-14: Launch
- [launch/prd-launch-prep.md](launch/prd-launch-prep.md) - Week 12: Steam store page, final prep (169 lines)
- [launch/prd-launch-execute.md](launch/prd-launch-execute.md) - Weeks 13-14: Next Fest & launch (253 lines)

## Integration Testing Philosophy

**Critical principle:** Test as you build, not after weeks of building.

Each PRD file includes:
- ✅ **Integration Test sections** - Verify multiple systems work together
- ✅ **Definition of Done checklists** - Ensure features integrate with existing systems
- ✅ **Cross-system testing** - Test full loops, not isolated components
- ✅ **Regression checks** - Verify old features still work after new additions

### Example Integration Tests

- **Week 1:** "Can you survive for 60 seconds dodging and pecking?"
- **Week 2:** "Can you reach level 10 with 2 weapons + 1 passive?"
- **Week 3:** "Can you max out 6 weapons and 4 passives in one run?"
- **Week 4:** "Can you beat the game (survive to 30:00)?"
- **Week 5:** "Die, buy upgrade, start new run - are you stronger?"
- **Week 6:** "Survive 15:00, unlock Shadow, beat Story Mode, unlock Golden and Endless Mode"
- **Week 7:** "Complete 30:00 victory run with controller"
- **Week 8:** "Complete 30:00 victory run with all new art, no visual glitches"
- **Week 9:** "Eyes closed test - recognize all gameplay events by audio alone"

## Usage with task-master-ai

Parse individual modules based on what you're working on:

```bash
# Parse Week 1-3 foundation tasks
task-master parse-prd .taskmaster/docs/modules/core/prd-core-foundation.md --tag=week-1-3

# Parse Win condition tasks
task-master parse-prd .taskmaster/docs/modules/progression/prd-progression-victory.md --tag=week-4

# Parse all modules sequentially
task-master parse-prd .taskmaster/docs/modules/core/prd-core-progression.md --append
task-master parse-prd .taskmaster/docs/modules/progression/prd-progression-victory.md --append
# ... continue for each module
```

## Line Count Distribution

| File | Lines | Status |
|------|-------|--------|
| core/prd-core-foundation.md | 221 | ✅ Target |
| core/prd-core-enemies.md | 133 | ✅ Compact |
| core/prd-core-weapons.md | 187 | ✅ Target |
| core/prd-core-progression.md | 346 | ⚠️ Slightly over (3 features + tasks) |
| progression/prd-progression-victory.md | 255 | ✅ Target |
| progression/prd-progression-meta.md | 224 | ✅ Target |
| progression/prd-progression-state.md | 271 | ✅ Target |
| characters/prd-characters-variants.md | 166 | ✅ Target |
| characters/prd-characters-endless.md | 230 | ✅ Target |
| polish/prd-polish-feel.md | 276 | ✅ Target |
| polish/prd-polish-content.md | 252 | ✅ Target |
| polish/prd-polish-release.md | 280 | ✅ Target |
| launch/prd-launch-prep.md | 169 | ✅ Target |
| launch/prd-launch-execute.md | 253 | ✅ Target |

**Total:** 14 files, average 233 lines per file (target: ~200-250 lines)

## Benefits of Split Structure

1. **Better AI parsing:** Each file is digestible by task-master-ai
2. **Focused context:** Work on specific features without loading entire PRD
3. **Parallel development:** Different team members can work on different modules
4. **Clearer milestones:** Each file maps to specific weeks/features
5. **Integration emphasis:** Tests verify systems work together, not in isolation

---

**Original files removed:**
- ~~prd-core.md~~ (835 lines) → 4 files
- ~~prd-progression.md~~ (723 lines) → 3 files
- ~~prd-characters.md~~ (388 lines) → 2 files
- ~~prd-polish.md~~ (784 lines) → 3 files
- ~~prd-launch.md~~ (405 lines) → 2 files

