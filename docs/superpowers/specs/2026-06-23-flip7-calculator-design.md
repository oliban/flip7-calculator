# Flip 7 Score Calculator — Design

**Date:** 2026-06-23
**Status:** Approved

## Purpose

A mobile-first webapp that calculates per-round scores for the card game *Flip 7*
and tracks running totals across rounds for multiple players until someone reaches
the win target (default 200).

## Scope

- Per-round card calculator (full card logic) feeding multiplayer running totals.
- Entry happens **after** a physical round finishes.
- All players visible on one screen; lean UI (no non-scoring action-card buttons).

## Stack

- Single self-contained `index.html`: vanilla HTML/CSS/JS, no build step, no
  dependencies.
- Mobile-first responsive layout.
- Auto-saves full game state to `localStorage` under a single key.

## Features

### 1. Game setup
- First load (or "New Game"): add players by name (minimum 2), set win target
  (default 200).
- Players and target persist across reloads.
- "New Game" clears all state after a confirmation prompt.

### 2. Main screen (the round)
- Vertical stack of compact player rows, one per player.
- Each row shows: name, running total, and this round's in-progress score.
- Tapping a player row expands its card pad and collapses the others (keeps the
  layout tight; one expanded at a time).
- Card pad contents:
  - **Numbers 0–12** — toggle chips (on/off). After-round entry means kept number
    cards are unique, so each number is a simple on/off toggle.
  - **Modifiers** +2, +4, +6, +8, +10, and ×2 — toggle chips.
  - **Busted** toggle — when on, the row scores 0 for the round and the card pad
    greys out / disables.

### 3. Scoring
Per-row round score:

```
scored = sum(numbers) * (2 if x2 else 1) + sum(+modifiers)
bonus  = 15 if exactly 7 numbers selected else 0
round  = 0 if busted else scored + bonus
```

Per official Flip 7 rules the ×2 card doubles the **number cards only**; the `+`
bonus modifiers are added afterward and are not affected by ×2.

- Round score updates live as chips toggle.

### 4. Rounds & winning
- **End Round** button: adds each row's round score to its running total, clears
  round inputs, increments the round counter.
- After ending a round, if any player's total ≥ target, highlight the winner and
  show a banner. The game may continue or be reset via New Game.

### 5. Persistence
- Every state change writes the full game state to `localStorage`:
  players, totals, current round inputs, round number, win target.
- Reload restores the exact prior state.

### 6. Layout (mobile)
- Sticky header: round number + "End Round" button.
- Player rows fill the body; large tap targets; chips wrap on narrow screens.
- No horizontal scrolling.

## Data model (in memory + localStorage)

```js
{
  target: 200,
  round: 1,
  players: [
    {
      id: string,
      name: string,
      total: number,
      hand: {
        numbers: number[],     // selected 0..12
        modifiers: number[],   // selected from [2,4,6,8,10]
        x2: boolean,
        busted: boolean
      }
    }
  ],
  expandedPlayerId: string | null
}
```

## Out of scope (YAGNI)

- Freeze / Flip Three / Second Chance buttons (no effect on after-round score).
- Per-card duplicate/bust detection during tapping (busts entered via toggle).
- Online sync / multi-device; accounts; history of past games.
- PWA/offline install (possible future add-on).
