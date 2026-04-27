---
name: cliproxy-image-cli
description: Use when Codex needs to generate or edit raster images as local files through the installed `cliproxy-image-cli` command, especially requests such as “画一张图”, “生成海报/封面/插画”, “用 gpt-image-2 生图”, “把这张图片改成…”, or when the user wants to save image outputs in the current project. This skill reuses local Codex OpenAI-compatible configuration and supports text-to-image, image editing, masks, metadata, and explicit output paths.
---

# CLIProxy Image CLI

Use the installed `cliproxy-image-cli` command to generate or edit local image files from Codex. The CLI automatically reads the local Codex config and auth, so do not ask for base URL, port, or API key unless autodiscovery fails.

## Preconditions

- Command: `cliproxy-image-cli`
- Runtime: Node.js 18+
- Default model: `gpt-image-2`
- Config sources: `CODEX_HOME` or `~/.codex/config.toml`, plus `~/.codex/auth.json`
- Supported upstream paths: `/v1/images/generations`, `/v1/images/edits`, or CLI-managed `/v1/responses` fallback

If the command is missing, install it with `npm install -g cliproxy-image-cli` or the user’s package manager before continuing.

## Core workflow

1. Determine whether the user wants generation or editing.
2. Choose an output path:
   - If the user gave a path, use it exactly.
   - Otherwise save into the current Codex working directory with a descriptive filename.
   - Do not overwrite existing files unless the user asked for replacement; choose a new filename instead.
3. Choose size:
   - Explicit user size wins.
   - Use `1536x1024` for horizontal/banner/landscape/wide images.
   - Use `1024x1536` for vertical/poster/phone-wallpaper/book-cover images.
   - Use `1024x1024` when orientation is unclear.
   - Use `auto` only when explicitly requested.
4. Improve underspecified prompts before invoking the CLI. Preserve user intent, language, and constraints.
5. Run the CLI, then verify exit code and that output file(s) exist.
6. Report the saved path(s) concisely.

For detailed flags and troubleshooting, read `references/cliproxy-image-cli.md` only when needed.

## Generate

```bash
cliproxy-image-cli generate \
  --output ./image.png \
  --size 1024x1024 \
  --quality high \
  "一只戴宇航员头盔的橘猫，电影感，超清"
```

Useful flags:

- `--model <name>` default `gpt-image-2`
- `--prompt-file <file>` for long or multiline prompts
- `--output <file|dir>`
- `--size 1024x1024|1536x1024|1024x1536|auto`
- `--quality <value>`
- `--background <value>`
- `--output-format png|jpeg|webp`
- `--metadata-path <json-file>`
- global `--overwrite` only with user approval

## Edit

```bash
cliproxy-image-cli edit \
  --image ./input.png \
  --mask ./mask.png \
  --output ./edited.png \
  --size 1024x1024 \
  "保留主体不变，把背景替换成雪山"
```

Rules:

- `--image <path|url|data-url>` is required and can be repeated.
- `--mask <path|url|data-url>` is optional.
- Prefer local paths when attached or referenced images already exist on disk.
- Use edit rather than generate when the user asks to modify, restyle, preserve, replace background, inpaint, extend, or combine existing images.

## Prompt handling

- For architecture diagrams, UI mockups, posters, covers, and other structured outputs, rewrite the prompt to specify composition, labels/text language, layout, style, and clarity.
- If text inside the image matters, include exact labels in the prompt and ask for clean readable typography.
- For long prompts, write a temporary UTF-8 prompt file and pass `--prompt-file` to avoid shell quoting issues.

## Verification

After running:

```bash
test -s ./image.png && file ./image.png
```

If metadata was requested, verify the JSON exists and includes saved file information.
