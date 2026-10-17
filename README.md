# Leon Dinosaur Game

A 3D dinosaur racing game for the browser, built for iPhone and iPad.
Switch dinosaurs to match the terrain and beat three rivals to the finish line.

- 15 levels across 5 worlds: Jungle, Desert, Swamp, Snow and Volcano
- 8 dinosaurs, each one fastest on its own terrain
- Installable as an app (Add to Home Screen) and playable offline

## Project layout

| Path | What it is |
| --- | --- |
| `dino-race.html` | Game source (Three.js, single file) |
| `build.sh` | Builds `site/` from the source: full HTML page, app manifest, offline service worker |
| `sw.template.js` | Service worker template used by `build.sh` |
| `site/` | Deployable output served by Cloudflare Pages |

## Workflow

1. Edit `dino-race.html`.
2. Run `./build.sh`.
3. Commit and push. Cloudflare Pages deploys `site/` automatically.

Cloudflare Pages settings: framework preset **None**, build command **empty**, output directory **`site`**.

## Local preview

```sh
python3 -m http.server 8000 --directory site
```

Then open http://localhost:8000.
