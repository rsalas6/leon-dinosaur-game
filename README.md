# Leon's Dinosaur Game

A 3D dinosaur racing game for the browser, built for iPhone and iPad.
Switch dinosaurs to match the terrain and beat three rivals to the finish line.

- 15 levels across 5 worlds: Jungle, Desert, Swamp, Snow and Volcano
- 8 dinosaurs, each one fastest on its own terrain
- Installable as an app (Add to Home Screen) and works 100% offline after the first visit:
  Three.js and the fonts are bundled in `vendor/`, and a service worker caches every file

## Project layout

| Path | What it is |
| --- | --- |
| `dino-race.html` | Game source (Three.js, single file) |
| `build.sh` | Builds `site/` from the source: full HTML page, app manifest, offline service worker |
| `sw.template.js` | Service worker template used by `build.sh` |
| `vendor/` | Three.js r128 and the game fonts, bundled so nothing loads from the internet |
| `site/` | Deployable output served by Cloudflare Pages |

## Workflow

1. Edit `dino-race.html`.
2. Run `./build.sh`.
3. Commit and push to `main`. The GitHub Action in `.github/workflows/deploy.yml` builds and deploys to Cloudflare Pages (project `leon-dinosaur-game`).

The action needs a repository secret named `CLOUDFLARE_API_TOKEN` with the **Cloudflare Pages: Edit** permission.

Live at https://leon-juego-dinosarios.beto.page (also https://leon-dinosaur-game.pages.dev).

## Local preview

```sh
python3 -m http.server 8000 --directory site
```

Then open http://localhost:8000.
