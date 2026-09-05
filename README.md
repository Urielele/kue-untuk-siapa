# Kue Untuk Siapa

RPG 2D top-down grid-based yang dibuat dengan Godot 4.7. Sebuah game hadiah ulang tahun untuk someone special <3.

> **Mainkan di:** [bimonoo.itch.io/kue-untuk-siapa](https://bimonoo.itch.io/kue-untuk-siapa)

## Tentang Game

Kue Untuk Siapa adalah game RPG 2D dengan perspektif top-down dan sistem gerak berbasis grid. Jelajahi desa, selesaikan teka-teki, dan temukan siapa pemilik kue yang sebenarnya.

### Fitur

- **Grid-based Movement** - Gerak 4 arah dengan animasi tween yang smooth
- **Sistem Dialog** - Percakapan dengan NPC menggunakan Dialogic plugin
- **Event System** - Trigger interaktif berbasis Area2D untuk dialog, pintu, peti, dan battle
- **Scene Transition** - Transisi antar peta yang mulus
- **Multiple Maps** - Prologue, desa, dan area misterius

## Kontrol

| Aksi | Tombol |
|------|--------|
| Gerak | WASD / Arrow Keys |
| Interaksi | Enter / Z |
| Dialog | Enter / Space / Z / X |

## Spesifikasi Teknis

- **Engine**: Godot 4.7 (GL Compatibility Renderer)
- **Resolusi**: 960x720 (flexible stretch mode)
- **Grid Size**: 32x32 pixels
- **Bahasa**: GDScript
- **Plugin**: Dialogic (dialog system)

## Struktur Proyek

```
kue-untuk-siapa/
├── addons/              # Plugin (Dialogic)
├── assets/
│   ├── sprites/         # Sprite sheets
│   ├── tilesets/        # Tilesets 32x32
│   └── ui/              # Aset UI
├── data/
│   ├── events/          # Data event
│   └── maps/            # Data peta
├── dialog/
│   ├── characters/      # Karakter dialog
│   ├── style/           # Style dialog
│   └── timelines/       # Timeline dialog
├── documentation/
│   └── GDD.md           # Game Design Document
├── scenes/
│   ├── main/            # Entry point
│   ├── player/          # Scene pemain
│   ├── maps/            # Scene peta
│   ├── events/          # Scene trigger event
│   ├── party/           # Scene anggota party
│   ├── battle/          # Scene battle
│   └── ui/              # Scene UI
├── scripts/
│   ├── autoload/        # Singleton (EventManager, GameManager)
│   ├── audio/           # Script audio
│   ├── events/          # Script trigger event
│   ├── maps/            # Script peta
│   ├── party/           # Script party
│   ├── player/          # Script gerak pemain
│   └── ui/              # Script UI
└── project.godot
```

## Autoloads

| Nama | Fungsi |
|------|--------|
| `EventManager` | Mengelola event queue, state dialog, dan interaksi |
| `GameManager` | State game, data party, save/load |
| `SceneTransition` | Transisi antar scene |
| `MusicManager` | Pengelolaan musik dan audio |
| `Dialogic` | Plugin dialog system |

## Cara Menjalankan

1. Clone repository ini
2. Buka project di Godot 4.7
3. Jalankan project

## Status Pengembangan

- [x] Grid-based movement dengan tween
- [x] Event system (dialog, NPC, pintu)
- [x] Dialog system dengan Dialogic
- [x] Party system dengan follower
- [x] Scene transition
- [x] Multiple maps
- [ ] Sistem battle
- [ ] Save/Load system
- [ ] Sistem inventory


## Credits

- [Death's Gambit - Alex Kubodera](https://www.alexkubodera.com/pixel-art#/deaths-gambit/)
- [001. Once Upon a Time (UNDERTALE Soundtrack) - Toby Fox](https://youtu.be/0AQMAth2gio?si=oL9YXhD0mH4XUkOR)
- [033. Quiet Water (UNDERTALE Soundtrack) - Toby Fox](https://youtu.be/4LfRKEovz2Y?si=rNOa3Y5FQ5I1qsAd)
- [012. Home (UNDERTALE Soundtrack) - Toby Fox](https://youtu.be/0UkRqMFMZic?si=KJOzU5wddUbMXAKq)
- [022. Snowdin Town (UNDERTALE Soundtrack) - Toby Fox](https://youtu.be/LETChg7kPJo?si=cxJA8REYsx__diIz)

## License

MIT

---

Dibuat dengan Godot Engine