# cliproxy-image-cli Codex Skill

一个可直接安装到 Codex 的图片生成 / 图片编辑 skill。它内置（vendor）了 [`cliproxy-image-cli`](https://github.com/noooob-coder/cliproxy-image-cli) 的核心 CLI 代码，自动复用 Codex 的 OpenAI 兼容配置，通过 `gpt-image-2` 等图片模型生成或编辑本地图片文件。

> 本仓库内置上游 CLI 代码是为了避免上游项目不可用时导致 skill 失效。引用与授权信息见下方「引用与授权」。

## 能力

- 文生图：例如「画一张 SaaS 架构图，中文标签，保存到当前目录」
- 图像编辑：例如「把这张图片背景换成雪山」
- 默认使用 `gpt-image-2`
- 自动读取 `~/.codex/config.toml` 与 `~/.codex/auth.json`
- 支持输出路径、尺寸、质量、metadata 等 CLI 参数
- 不需要额外执行 `npm install -g cliproxy-image-cli`

## 前置要求

1. 已安装 Codex。
2. Codex 已配置可用的 OpenAI 兼容上游。
3. 已安装 Node.js 18+。

## 安装 skill

### macOS / Linux

```bash
git clone https://github.com/fathermrsing/cliproxy-image-cli-skill.git
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
git clone https://github.com/fathermrsing/cliproxy-image-cli-skill.git
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

## 直接调用内置 CLI

安装后可以直接调用 vendored CLI：

```bash
CLI="${CODEX_HOME:-$HOME/.codex}/skills/cliproxy-image-cli/vendor/cliproxy-image-cli/bin/cliproxy-image-cli.js"
node "$CLI" --help
node "$CLI" generate --output ./image.png --size 1024x1024 "一张蓝紫色科技风图标"
```

## 项目结构

```text
skill_src/
  cliproxy-image-cli/
    SKILL.md
    agents/openai.yaml
    references/cliproxy-image-cli.md
    vendor/cliproxy-image-cli/
      bin/cliproxy-image-cli.js
      lib/image-cli.js
      LICENSE
      package.json
      UPSTREAM.md
scripts/
  install.sh
  install.ps1
```

## 引用与授权

本项目 vendored CLI 代码来自：

- 上游项目：[`noooob-coder/cliproxy-image-cli`](https://github.com/noooob-coder/cliproxy-image-cli)
- Vendored commit：`2560cb279fce78edfea9f40221586fe88e665dcf`
- Vendored 路径：`skill_src/cliproxy-image-cli/vendor/cliproxy-image-cli/`

上游代码继续遵循其原始许可证：`skill_src/cliproxy-image-cli/vendor/cliproxy-image-cli/LICENSE`。

该许可证允许个人学习、研究、评估、内部非商用测试；禁止未授权商用、转售、付费分发、SaaS/托管/API 商业服务集成等商业用途。商业使用请联系原作者获取授权。

## 说明

本仓库提供 Codex skill 包装、安装脚本，以及为了稳定可用而内置的 CLI 代码。实际图片生成仍依赖你的本地 Codex/OpenAI 兼容配置。
