# cliproxy-image-cli reference

This skill vendors selected CLI files from:

- Source repository: https://github.com/noooob-coder/cliproxy-image-cli
- Vendored commit: `2560cb279fce78edfea9f40221586fe88e665dcf`
- License: see `vendor/cliproxy-image-cli/LICENSE`

Use the vendored executable through Node.js instead of relying on a global command:

```bash
CLI="${CODEX_HOME:-$HOME/.codex}/skills/cliproxy-image-cli/vendor/cliproxy-image-cli/bin/cliproxy-image-cli.js"
node "$CLI" [global options] <command> [command options] <prompt>
```

## Commands

- `generate`: call image generation through local Codex-compatible upstream.
- `edit`: call image editing through local Codex-compatible upstream.

Global options:

- `--timeout <seconds>`: request timeout, default `300`.
- `--metadata-path <file>`: save response/result metadata JSON.
- `--overwrite`: allow overwriting existing output files.
- `-h`, `--help`: show help.

## Generate flags

```bash
node "$CLI" generate [options] [--output <file|dir>] <prompt>
```

- `--model <name>`: default `gpt-image-2`.
- `--prompt-file <file>`: read prompt from UTF-8 file.
- `--output <file|dir>`: output file or directory.
- `--size <WxH>`: `1024x1024`, `1536x1024`, `1024x1536`, or `auto`.
- `--quality <value>`: image quality, commonly `auto`, `high`, etc. depending on upstream support.
- `--background <value>`: background mode, for example transparent when supported.
- `--moderation <value>`: moderation mode if supported.
- `--partial-images <count>`: request partial image events if supported.
- `--output-format png|jpeg|webp`.
- `--response-format b64_json|url`.

## Edit flags

```bash
node "$CLI" edit [options] --image <path|url> [--output <file|dir>] <prompt>
```

- `--image <path|url|data-url>`: repeatable; at least one image is required.
- `--mask <path|url|data-url>`: optional mask.
- `--input-fidelity <value>`: pass through fidelity preference when supported.
- Shared generation flags: model, prompt-file, output, size, quality, background, moderation, output-format, response-format.

## Autodiscovery

The CLI reads:

1. `CODEX_HOME`, otherwise `~/.codex`.
2. `config.toml` for the active model provider and `base_url`.
3. `auth.json` for `OPENAI_API_KEY`.

It maps to `/v1/images/generations` or `/v1/images/edits`, and can fall back to `/v1/responses` when implemented by the CLI/upstream.

## Preference cache

Successful transport preference is cached at:

```text
~/.codex/cliproxy-image-cli-preferences.json
```

The cache is keyed by `base_url + action` so generation and editing can use different successful paths.

## Troubleshooting

- Missing vendored command: reinstall this skill from its repository.
- Missing Node.js: install Node.js 18+.
- Missing credentials: verify `~/.codex/auth.json`.
- Unsupported upstream: point Codex at an OpenAI-compatible provider implementing `/v1/images/*` or image-capable `/v1/responses`.
- Existing output conflict: choose a new path, or use `--overwrite` only when the user approved replacement.
- Long prompt or special shell characters: write a prompt file and use `--prompt-file`.
