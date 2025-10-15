# Git 部署说明（Netlify + GitHub）

本文档说明如何通过 Git 将本项目自动部署到 Netlify，以及常见问题的排查方法。当前生产分支统一为 `main`。

## 概览

- 生产分支：`main`
- 部署平台：Netlify（连接 GitHub 仓库自动部署）
- 发布目录：`.`（由 `netlify.toml` 设置）
- 构建命令：空（纯静态站点），由 `netlify.toml` 设置 `command = ""`
- 路由：SPA 重定向（`_redirects` 与 `netlify.toml` 中的 `[[redirects]]`）

## 前置条件

- Netlify 站点已连接到 GitHub 仓库。
- 仓库包含 `index.html`、`netlify.toml`、`_redirects` 等文件（已在本项目提供）。
- 本地已安装 Git，并配置远程仓库 `origin`。

## 首次配置（一次性）

1. 将 GitHub 仓库默认分支改为 `main`
   - 路径：仓库 `Settings → Branches → Default branch`，选择 `main`。

2. 将 Netlify 的 Production branch 改为 `main`
   - 路径：站点 `Site settings / Project configuration → Build & deploy → Continuous deployment → Branches`。

3. 可选：删除远程 `master` 以避免混淆
   - 命令：`git push origin --delete master`

> 完成以上设置后，后续只需向 `main` 推送即可自动触发部署。

## 日常部署流程（Windows PowerShell 示例）

1. 开发与本地预览（任选其一）
   - `PowerShell`：`.\serve.ps1`，访问 `http://localhost:5600`
   - `Python`：`python -m http.server 8000`
   - `Node`：`npx serve .`

2. 提交并推送到 `main`
   - `git checkout main`
   - `git pull`
   - 修改代码后：`git add -A && git commit -m "feat: ..."`
   - 推送：`git push origin main`

3. 验证部署
   - 打开 Netlify 的 Deploys 页面，查看最新构建是否 `Published`。
   - 若需要立即触发，可点击 `Trigger deploy` 或 `Redeploy`。

## 手动触发部署

- 空提交触发：
  - `git commit --allow-empty -m "chore: trigger Netlify deploy"`
  - `git push origin main`
- Netlify 面板：在 Deploys 页面点击 `Trigger deploy` 或 `Clear cache and deploy site`。

## 分支预览（Branch deploys）

- 若在 Netlify 配置为 “Deploy all branches”，任意非 `main` 分支推送都会生成预览部署，适合 Pull Request 评审。
- 生产环境仍以 `main` 为准。

## 回滚与恢复

- 在 Netlify 的某次 Deploy 详情页选择 `Rollback to this deploy`，即可快速回滚到指定版本。
- 或在 GitHub 以 `git revert` 方式回退提交，再推送到 `main`。

## 分支保护建议（GitHub）

- 在 `Settings → Branches` 为 `main` 添加保护规则：
  - 禁止强制推送和删除（Protect matching branches）。
  - 需要 Pull Request 才能合并（Require a pull request before merging）。
  - 至少 1 个批准（Require approvals）。

## 常见问题排查

- 推送后没触发部署：
  - 确认 Netlify 的 Production branch 是否为 `main`。
  - 检查站点是否已连接到正确的 Git 仓库（必要时 Disconnect 后重新 Connect）。
  - 查看 Netlify Deploys 页面日志是否有 Webhook 或权限错误。

- 部署成功但访问 404：
  - 确认 `_redirects` 与 `netlify.toml` 的 SPA 重定向存在。
  - 发布目录为 `.`，保证 `index.html` 在根目录。

- 样式或脚本未更新：
  - 在 Deploys 页面使用 `Clear cache and deploy site`。

- Node 版本问题：
  - `netlify.toml` 已设置 `NODE_VERSION = "18"`，通常无需更改。

## 命令参考（PowerShell）

```powershell
# 切到 main 并更新
git checkout main
git pull

# 提交并推送
git add -A
git commit -m "feat: ..."
git push origin main

# 触发一次空提交部署
git commit --allow-empty -m "chore: trigger Netlify deploy from main"
git push origin main

# 清理旧 master（可选）
git push origin --delete master
```

---

如需进一步自动化（例如 CI 检查、PR 预览策略、分支保护规则细化），可在 GitHub Actions 与 Netlify 的 Branch deploys 里按需配置。