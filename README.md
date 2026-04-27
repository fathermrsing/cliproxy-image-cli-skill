# cliproxy-image-cli Codex Skill

一个可直接安装到 Codex 的图片生成 / 图片编辑 skill。它封装本机已安装的 [`cliproxy-image-cli`](https://github.com/noooob-coder/cliproxy-image-cli)，自动复用 Codex 的 OpenAI 兼容配置，通过 `gpt-image-2` 等图片模型生成或编辑本地图片文件。

## 能力

- 文生图：例如「画一张 SaaS 架构图，中文标签，保存到当前目录」
- 图像编辑：例如「把这张图片背景换成雪山」
- 默认使用 `gpt-image-2`
- 自动读取 `~/.codex/config.toml` 与 `~/.codex/auth.json`
- 支持输出路径、尺寸、质量、metadata 等 CLI 参数

## 前置要求

1. 已安装 Codex。
2. Codex 已配置可用的 OpenAI 兼容上游。
3. 已安装 Node.js 18+。
4. 已安装 CLI：

```bash
npm install -g cliproxy-image-cli
```

## 安装 skill

### macOS / Linux

```bash
git clone https://github.com/YOUR_NAME/cliproxy-image-cli-skill.git
cd cliproxy-image-cli-skill
./scripts/install.sh
```

也可以手动复制：

```bash
mkdir -p ~/.codex/skills
cp -R ./skill_src/cliproxy-image-cli ~/.codex/skills/cliproxy-image-cli
```

### Windows PowerShell

```powershell
git clone https://github.com/YOUR_NAME/cliproxy-image-cli-skill.git
cd cliproxy-image-cli-skill
.\scripts\install.ps1
```

## 使用示例

在 Codex 里输入：

```text
$cliproxy-image-cli 画一张 SaaS 架构图，中文标签，保存到当前目录
```

或：

```text
$cliproxy-image-cli 生成一张电影感橘猫宇航员海报，竖版，保存到当前目录
```

编辑图片：

```text
$cliproxy-image-cli 把 ./input.png 的背景换成雪山，保持主体不变，输出 ./edited.png
```

## 项目结构

```text
skill_src/
  cliproxy-image-cli/
    SKILL.md
    agents/openai.yaml
    references/cliproxy-image-cli.md
scripts/
  install.sh
  install.ps1
```

## 说明

本仓库只包含 Codex skill 包装与安装脚本。实际图片生成能力来自 `cliproxy-image-cli` 及你的本地 Codex/OpenAI 兼容配置。
