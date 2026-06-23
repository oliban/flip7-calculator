# Flip 7 · Score Table

A mobile-first webapp that calculates per-round scores for the card game
**Flip 7** and tracks running totals across rounds until a player reaches the win
target (default 200).

- Single self-contained `index.html` — vanilla HTML/CSS/JS, no build step.
- Tap the number cards (0–12), `+` modifiers and `×2` that each player kept after
  a round; the app does the math (including the **×2** multiplier on number cards
  and the **+15 Flip 7 bonus** for 7 numbers), or mark a player **busted** (0).
- Auto-saves to `localStorage` — survives refreshes.

## Run locally

Just open `index.html` in a browser, or serve the folder:

```sh
python3 -m http.server 8000   # then visit http://localhost:8000
```

## Scoring

```
score = sum(numbers) × (2 if ×2 else 1) + sum(+modifiers) + (15 if 7 numbers)
        # 0 if busted
```

Per official rules, the ×2 doubles **number cards only**; `+` modifiers are added
afterward.

## Deploy (Fly.io)

Served by nginx (see `Dockerfile` / `fly.toml`):

```sh
fly deploy
```

See `docs/superpowers/specs/` for the design spec.
