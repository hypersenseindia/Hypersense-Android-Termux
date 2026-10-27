# Hypersense Android V1

The first build: a `dialog`-driven Termux menu that applies touch, FPS and ping tuning with a single on/off switch.

Non-root, offline, no server.

## Features

- Touch sensitivity adjustment
- FPS and latency stabilisation
- Ping / network priority tuning
- One switch to apply or revert
- Auto-installs `dialog` on first run if it is missing

## Run

```bash
pkg update -y
pkg install -y git dialog
git clone https://github.com/hypersenseindia/Hypersense-Android-Termux
cd Hypersense-Android-Termux
chmod +x HYPERSENSE-5.sh
./HYPERSENSE-5.sh
```

## Files

```
HYPERSENSE-5.sh    the tool
banner.txt         startup banner
```

## Notes

- V1 is kept for reference. **V2 (NeuralCore)** and **MAX v10** supersede it &mdash; use those for new installs.
- Non-root: nothing is written outside `$HOME`.
- Termux only.
---

<p align="center">
  <sub>Built by <b>AG HYDRAXFF</b> &mdash; HYPERSENSEGLOBAL &middot;
  <a href="https://www.instagram.com/hydraxff_yt/">@hydraxff_yt</a></sub>
</p>