# Flip 7 · Score Table

[![Deploy to Fly.io](https://github.com/oliban/flip7-calculator/actions/workflows/deploy.yml/badge.svg)](https://github.com/oliban/flip7-calculator/actions/workflows/deploy.yml)

**Live:** https://flip7-calculator.fly.dev

A mobile-first webapp that calculates per-round scores for the card game
**Flip 7** and tracks running totals across rounds until a player reaches the win
target (default 200).

- Single self-contained `index.html` — vanilla HTML/CSS/JS, no build step.
- Tap the number cards (0–12), `+` modifiers and `×2` that each player kept after
  a round; the app does the math (including the **×2** multiplier on number cards
  and the **+15 Flip 7 bonus** for 7 numbers), or mark a player **busted** (0).
- Auto-saves to `localStorage` — survives refreshes.

## Finishing a game & scoreboard

- As soon as a player reaches the win target after **End round**, the game
  **locks** — no more rounds can be played, and the final standings are shown.
- The finished game (final scores, winner, and the round-by-round history) is
  archived to `localStorage` under a separate key.
- A **📊 Scoreboard** (reachable from the setup screen and the game header)
  shows:
  - **Leaderboard** — every player ranked by wins, with games played, win rate,
    average final score and best game total.
  - **Past games** — each finished game with its winner, final scores, round
    count and date; individual games can be deleted, or the whole history
    cleared.

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
