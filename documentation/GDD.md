# Kue Untuk Siapa - Game Design Document

## Overview
- **Judul**: Kue Untuk Siapa
- **Genre**: RPG 2D Top-Down (Grid-based)
- **Engine**: Godot 4.7, GL Compatibility Renderer
- **Resolusi**: Flexible (canvas_items stretch mode)

## Grid System
- **Ukuran Cell**: 32x32 pixels
- **Movement**: 4 arah (atas/bawah/kiri/kanan)
- **Smooth Tween**: Player bergerak smooth antar cell (0.15 detik per langkah)
- **Collision**: Physics-based, cek target cell sebelum bergerak

## Movement
- Input: WASD atau Arrow Keys
- Interaksi: Enter / Space
- Player bergerak per-grid dengan tween animation
- Facing direction di-track untuk menentukan arah interaksi
- Movement di-lock saat event/dialog/battle aktif

## Battle System (Nanti)
- Turn-based ala Dragon Quest klasik
- Hanya sprite musuh yang ditampilkan di layar
- Status tim: HP (Health Points) dan EP (Energy Points)
- Referensi: Dragon Quest I-IV, Final Fantasy I-III

## Event System
- **Area2D + Signal**: Tiap event menggunakan Area2D sebagai trigger zone
- **Event Types**: dialog, npc, door, chest, battle
- **Interaction**: Player menghadap event + tekan tombol aksi
- **Dialog**: Menggunakan Dialogic plugin

## Directory Structure
```
kue-untuk-siapa/
├── addons/                    # Plugins (Dialogic)
├── assets/
│   ├── sprites/               # Sprite sheets
│   ├── tilesets/              # Tilesets (32x32)
│   └── ui/                    # UI assets
├── data/
│   ├── events/                # Event data
│   └── maps/                  # Map data
├── documentation/
│   └── GDD.md                 # Dokumentasi ini
├── scenes/
│   ├── main/                  # Entry point
│   ├── player/                # Player scene
│   ├── maps/                  # Map scenes
│   ├── events/                # Event trigger scenes
│   ├── ui/                    # UI scenes
│   └── battle/                # Battle scenes (nanti)
├── scripts/
│   ├── autoload/              # Singletons (EventManager, GameManager)
│   ├── player/                # Player movement
│   ├── events/                # Event trigger scripts
│   └── ui/                    # UI scripts
└── project.godot
```

## Autoloads
- **EventManager**: Mengelola event queue, dialog state, interaction check
- **GameManager**: Game state, party data, save/load

## Input Map
| Action       | Keys                          |
|------------- |-------------------------------|
| move_up      | W, Up Arrow                   |
| move_down    | S, Down Arrow                 |
| move_left    | A, Left Arrow                 |
| move_right   | D, Right Arrow                |
| interact     | Enter, Space                  |
