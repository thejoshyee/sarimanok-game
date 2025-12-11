# Object Pooling Audit - Sarimanok Survivor

**Date:** 2025-12-09
**Status:** Clean slate - no existing pooling infrastructure

## Current State

### Pooling Utilities

- **None found** - No Pool, Factory, or Manager classes exist yet

### Spawn/Despawn Patterns

- **No instantiate() calls** - No objects are currently spawned dynamically
- **No queue_free() calls** - No objects are currently destroyed dynamically

### Systems to Pool (Future)

Based on PRD requirements, we'll need pools for:

- **Enemies**: Target 300 pre-allocated (Week 3: 100+, Final: 200+)
- **Projectiles**: Target 200 pre-allocated
- **Pickups**: Target 500 pre-allocated
- **Particles**: Target 100 per type pre-allocated

### Implementation Notes

Since the project has no existing spawn/despawn code:

- We can design the pooling API from scratch without migration concerns
- All enemy spawners, weapons, and pickup systems will use pooling from day one
- No legacy queue_free() or instantiate() patterns to refactor

## Call Site Mapping

Currently empty - no spawn/despawn call sites exist yet.

When systems are implemented, document them here:

- Enemy spawners: (none yet)
- Weapon projectiles: (none yet)
- Pickup drops: (none yet)
- Particle effects: (none yet)





