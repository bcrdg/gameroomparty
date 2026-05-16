# Game Room Party

A retro-styled vertical platformer arcade game with online leaderboards. Play as a robot jumping through neon platforms, collecting quarters, and reaching for the sky!

## 🎮 Play Online
**Live Version:** https://bcrdg.github.io/gameroomparty/

## 🏗️ Architecture Overview

### Single-File Dual-Mode System
The game uses **one HTML file** (`GameRoomParty.html`) with conditional features controlled by the `gameMode` variable:

```javascript
let gameMode = 'arcade'; // 'arcade' or 'online'
```

### Game Modes

#### Arcade Mode (`gameMode = 'arcade'`)
- **Target:** Physical arcade cabinet at Sonora Game Room
- **Controls:** Joystick/buttons, keyboard (Arrow keys/WASD)
- **Start Flow:** INSERT COIN → PRESS START
- **Credits:** Coins accumulate as credits (`credits` counter, visible on screen when > 0). Each game start decrements the counter, so multiple coins → multiple games queued.
- **Name Entry:** On-screen keyboard (arrow keys to navigate, S to select). Keyboard includes dedicated DEL, SPACE, and DONE keys on the bottom row.
- **Leaderboard:** Saves to "Arcade Players" in JSONBin

#### Online Mode (`gameMode = 'online'`)
- **Target:** Web browsers (desktop/mobile)
- **Controls:** Keyboard, touch, **tilt (mobile gyroscope)**
- **Start Flow:** TAP TO START (no coin required)
- **Name Entry:** Direct keyboard typing (type name + Enter)
- **Leaderboard:** Saves to "Online Players" in JSONBin

## 📁 File Structure

```
GameRoomParty/
├── GameRoomParty.html     # Main game file (arcade mode by default)
├── bonus_stage.html       # Bridge bonus level (iframe, arcade only)
├── bonus_stage_space.html # Space shooter bonus level (iframe, arcade only)
├── launch.bat             # Kiosk-mode Edge launcher for the arcade cabinet
├── Music/                 # Audio files
│   ├── menu.mp3
│   └── gameplay/
│       ├── track1.mp3 - track31.mp3  # track30/31 are former bonus/gameover tracks
│       └── tracks.json
├── images/               # Character drop event images
│   ├── nate_french_fries.png
│   ├── peter_dollar.png
│   └── Cody_chicken_wings.png
├── blocked_words.js      # Profanity filter for high scores
└── README.md            # This file
```

## 🌐 Deployment

### GitHub Branches
- **`master`** - Main development branch, arcade mode default
- **`gh-pages`** - Deployed online version
  - Contains `index.html` (copy of GameRoomParty.html with `gameMode='online'`)
  - Hosted at https://bcrdg.github.io/gameroomparty/

### Deployment Process
When updating the game:
1. Edit `GameRoomParty.html` on `master` branch
2. Test locally
3. Commit and push to `master`
4. Merge `master` into `gh-pages`
5. Copy `GameRoomParty.html` to `index.html`
6. Change `gameMode` to `'online'` in `index.html`
7. Push `gh-pages` branch

This process is typically automated in our workflow.

## 🎯 Key Features

### Dual Leaderboards (JSONBin)
- **All-Time** and **This Week** scores
- Separate tracking for **Online Players** and **Arcade Players**
- Tracks both **Points** and **Height** scores
- Weekly scores auto-reset every Sunday

### JSONBin Configuration
```javascript
const JSONBIN_BIN_ID = '6a04d1d2c0954111d81c163c';
const JSONBIN_KEY = '$2a$10$...'; // Master key for writes
```

**Easter Egg:** If you find this key and add 8675309000000 with your name as the high score, you get a free sandwich at the game room! 🥪

### Scoring System
- **Points Score:** Earned by climbing height + killing enemies + collecting items
- **Height Score:** Maximum vertical distance traveled (separate leaderboard)
- High score entry triggered if you qualify for either leaderboard

### Promotional Features
Rotating banner at bottom of start screen (8-second intervals). The two arrays
`arcadeMessages` and `onlineMessages` are completely separate and chosen by
`gameMode`.

**Arcade banners:**
1. "Take a selfie at the high score name entry screen with a score of 500,000 height points or better for a free sandwich!" (no QR)
2. "Scan to play on your phone! Compete with players around the world" — QR code points to https://bcrdg.github.io/gameroomparty

**Online banners (8 total)** rotate through address/hours, food specials, pool hall, bingo, Sunday funday, menu link, and events calendar link. None show the QR (`showQR: false` on all).

## 🎨 Game Features

### Core Gameplay
- **Physics:** Doodle Jump-style vertical platformer
- **Lives:** 3 lives with respawn on death
- **Autofire:** Bullets automatically fire every 0.33 seconds
- **Screen Wrap:** Player wraps around screen edges

### Platform Types
- **Normal** (cyan) - Standard jump
- **Moving** (purple) - Slides left/right
- **Breaking** (orange) - Breaks after landing
- **Springs** (yellow) - Super jump boost

### Powerups
- **Jetpack** - Sustained upward flight
- **Helicopter** - Controlled hover

### Special Events
- **Bonus Stages** — *arcade mode only.* Collect 3 quarters to trigger one of two bonus levels:
  - **Bridge Stage** (`bonus_stage.html`) - Navigate 3D perspective bridge, collect quarters while avoiding bombs
  - **Space Shooter** (`bonus_stage_space.html`) - Swordfish II-style rail shooter with 3 enemy types (fighter / tank / weaver), boss battle at 15 seconds remaining, and weapon powerups (spread / rapid / health)
  - First bonus is randomly selected, then alternates between the two
  - Both use iframe with identical launch sequence and score return mechanism (`postMessage` on completion)
- **Online Mode Coin Behavior** — Bonus stages are skipped in online mode. Each collected coin instead awards **50,000 points** directly to the player's score.
- **Character Drops** - Nate (fries +1500pts), Peter (quarters +1500pts), Cody (spicy wings -500pts)

### Death Phrases
50+ silly phrases displayed when you lose a life:
- "SKILL ISSUE"
- "ERROR 404: SKILL NOT FOUND"
- "CERTIFIED BRUH MOMENT"
- "L + RATIO"
- And many more!

## 🕹️ Arcade Hardware (XIN-MO Dual Arcade USB Encoder)

The cabinet uses a **XIN-MO Dual Arcade USB encoder** which Windows enumerates as a standard HID gamepad ("XIN-MO Dual Arcade"). The game polls `navigator.getGamepads()` every frame and synthesizes synthetic `keydown` / `keyup` events so the rest of the input code (which is keyboard-driven) continues to work unchanged.

Both `GameRoomParty.html` and `bonus_stage_space.html` implement the same polling loop. `bonus_stage.html` does not yet have gamepad support added (the bridge stage relied on existing keyboard handling).

### Physical Button → Index → Synthesized Key
| Physical input | Gamepad button | Synthesized key | Notes |
|---|---|---|---|
| Joystick LEFT  | B0 | `ArrowLeft`  | held → key held |
| Joystick DOWN  | B1 | `ArrowDown`  | held → key held |
| Joystick UP    | B2 | `ArrowUp`    | held → key held |
| Joystick RIGHT | B3 | `ArrowRight` | held → key held |
| START button   | B4 | `s`          | one-shot keydown on press |
| COIN switch    | B7 | `c`          | **active-low** (see below) |

### Coin Switch Quirk
The coin microswitch on the cabinet is **normally closed** — B7 reads as *pressed* in the resting state and *releases* the moment a coin passes through. The poll loop watches for that falling edge (`pressed → released`) and dispatches a `keydown` for `c`. There's also a `padCoinArmed` flag that requires the button to be observed in its pressed state at least once before any release will fire a coin event, which prevents spurious "coin inserted" events on browser/gamepad connection glitches.

### Kiosk Launcher
`launch.bat` opens the game in Edge's kiosk mode. This is what the arcade cabinet uses to boot directly into the game with no browser chrome visible.

## 🛠️ Development Guidelines

### Adding New Features
1. Check if feature should be mode-specific using `if (gameMode === 'online')`
2. Update both gameplay and UI rendering code
3. Test in both arcade and online modes
4. Update this README if architecture changes

### Modifying High Scores
- All score data is in `onlineScores` and `arcadeScores` objects
- Weekly scores auto-clean on load (removes scores older than Sunday)
- Use `insertHighScore(name, points, height)` to add entries

### Audio System
- Menu music loops on start screen
- Gameplay tracks shuffle randomly
- Bonus stage has separate music
- Auto-discovery system probes for `track1.mp3` through `track50.mp3`

### Common Tasks

#### Change Game Mode
In `GameRoomParty.html`, line ~164:
```javascript
let gameMode = 'arcade'; // Change to 'online' for web version
```

#### Update JSONBin Credentials
Lines ~155-157:
```javascript
const JSONBIN_BIN_ID = 'YOUR_BIN_ID';
const JSONBIN_KEY = 'YOUR_MASTER_KEY';
```

#### Add Death Phrases
Around line ~297, add to `DEATH_PHRASES` array:
```javascript
const DEATH_PHRASES = [
  'YOUR NEW PHRASE HERE',
  // ... existing phrases
];
```

## 📝 Technical Notes

### Case Sensitivity
- Music folder is `Music/` (capital M)
- On Linux servers (GitHub Pages), case matters!
- Windows is case-insensitive, so test on actual deployment

### Browser Compatibility
- Tilt controls require `DeviceOrientationEvent` API (iOS/Android)
- Canvas 2D rendering (all modern browsers)
- localStorage for local scores
- Fetch API for JSONBin

### Performance
- Background cached as off-screen canvas
- Particles cleaned up when off-screen
- Platforms/enemies culled outside viewport
- Target: 60 FPS on modern devices

## 🐛 Known Issues / TODO
- Mobile touch controls could use better visual feedback
- No pause functionality currently
- Space shooter bonus level uses procedural canvas drawing for all graphics (no sprite sheets)
- Bridge bonus stage (`bonus_stage.html`) does not yet have XIN-MO gamepad polling

## 📐 Display & Layout Notes
- On desktop browsers in **online mode**, the game canvas is constrained to arcade-cabinet proportions (tall, narrow) and centered rather than filling the whole window — keeps gameplay consistent across deployments.
- Coordinate scaling factor `S = W / BASE_W` (where `BASE_W = 420`) is used throughout for resolution-independent rendering. When adding new gameplay objects, scale positions, sizes, and velocities by `S`. Off-screen cull thresholds also need to scale with `S` — a fixed `y < -100` cutoff will incorrectly delete newly-spawned enemies on any wide window.
- Death phrases auto-shrink via `ctx.measureText()` until they fit within 90% of the canvas width, so any phrase length works on any screen.

## 🎯 Future Enhancements
- Add pause menu
- Boss battles at certain heights
- More powerup types
- Difficulty scaling options
- Sound effect volume controls

## 📞 Contact
**Sonora Game Room**
- Website: www.sonoragameroom.com/party
- Physical Location: Arcade cabinet at Sonora Game Room

## 🤝 Contributing
This is a private project for Sonora Game Room. For bug reports or feature requests, contact the owner.

## 📜 License
All rights reserved © Sonora Game Room

---

**For Claude Code:** This README provides context for future development sessions. The single-file dual-mode architecture allows us to maintain one codebase with conditional features based on `gameMode`. Always test both modes when making changes!
