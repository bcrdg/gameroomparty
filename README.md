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
- **Name Entry:** On-screen keyboard (arrow keys to navigate, S to select)
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
├── bonus_stage.html       # Bonus stage mini-game (iframe)
├── Music/                 # Audio files
│   ├── menu.mp3
│   ├── gameover.mp3
│   ├── bonus.mp3
│   └── gameplay/
│       ├── track1.mp3 - track29.mp3
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
Rotating banner at bottom of start screen (8-second intervals):
1. "Play online at www.sonoragameroom.com/party" (with QR code)
2. "Take a selfie at the enter name screen with an arcade height score of 1 million or higher for a free sandwich!"

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
- **Bonus Stage** - Collect 3 quarters to trigger quarter-collecting bridge mini-game
- **Character Drops** - Nate (fries), Peter (quarters), Cody (hot wings)

### Death Phrases
50+ silly phrases displayed when you lose a life:
- "SKILL ISSUE"
- "ERROR 404: SKILL NOT FOUND"
- "CERTIFIED BRUH MOMENT"
- "L + RATIO"
- And many more!

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
- Bonus stage joystick can stick (input reset added but may need refinement)
- Mobile touch controls could use better visual feedback
- No pause functionality currently

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
