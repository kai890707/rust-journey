# 🚀 Setup Guide

逐步操作指引。大約 **15-20 分鐘**可以全部完成。

---

## 步驟 0：前置需求（一次性）

### 0.1 安裝 GitHub CLI

```bash
brew install gh
```

### 0.2 登入 GitHub

```bash
gh auth login
```

選擇：
- `GitHub.com`
- `HTTPS`
- `Yes` (authenticate Git)
- `Login with a web browser` → 複製顯示的代碼，貼到瀏覽器

完成後驗證：
```bash
gh auth status
```
應該看到 `✓ Logged in to github.com as <你的帳號>`。

---

## 步驟 1：在 GitHub 建立空 Repo

1. 到 https://github.com/new
2. 設定：
   - **Repository name**: `rust-journey`
   - **Description**: `52 weeks from Java to Rust & Web3`
   - **Public** ✅
   - **不要勾** "Add a README file"（我們已經有了）
   - 其他都不勾
3. 點 `Create repository`

---

## 步驟 2：把我給你的檔案推上去

### 2.1 解壓我給你的 zip

假設你把它解壓到 `~/code/rust-journey`。

```bash
cd ~/code/rust-journey
```

### 2.2 初始化 git 並推上去

**把 `<YOUR-USERNAME>` 換成你的 GitHub 帳號**：

```bash
git init
git add .
git commit -m "chore: bootstrap rust-journey"
git branch -M main
git remote add origin https://github.com/<YOUR-USERNAME>/rust-journey.git
git push -u origin main
```

去你的 repo 頁面刷新一下，應該看到所有檔案已上傳。🎉

---

## 步驟 3：執行 bootstrap script（核心）

這步會自動建立：
- 25 個 labels
- 7 個 milestones
- 48 個 issues（Week 1-8 所有任務）

```bash
./scripts/bootstrap.sh
```

應該會看到綠色的 `✓` 打勾跑過所有項目。大約 1-2 分鐘。

如果失敗，最常見原因是 `gh` 沒登入 → 回到步驟 0.2。

---

## 步驟 4：建立 Project Board（看板）

這步必須手動做，因為 Projects V2 的 API 還不好用。約 3 分鐘。

### 4.1 建立 Project

1. 到你的 repo 頁面 → 點上方的 **Projects** tab
2. 點綠色的 **Link a project** 或 **New project**
3. 選 **Board** template（不是 Table）
4. Project name: `Rust Journey Board`
5. 點 **Create project**

### 4.2 設定欄位（Columns）

預設會有 Todo / In Progress / Done，夠用。如果你想加的話可以再加：
- `📚 This Week` — 當前週要做的
- `🚀 Shipped` — 完成並且有 artifact 的

### 4.3 把所有 issues 加進 board

**最快的做法**：

1. 在 Project 的 `+ Add item` 點下去
2. 輸入 `is:issue is:open` 按 Enter
3. 會顯示所有 48 個 issues
4. 全選 → 加進 Todo 欄位

### 4.4（推薦）新增「Week」欄位方便篩選

在 Project 頁面右上角：
1. 點 `⋯` → `Settings`
2. 左側 `+ New field` → 選 `Single select`
3. Field name: `Week`
4. Options 加：`W01`, `W02`, ... `W08`（先加到 W08 夠用）
5. 儲存

然後在 board view：
1. 點右上角 `Group by: Status` → 改成 `Group by: Week`
2. 現在你每週任務一目了然

---

## 步驟 5：開始使用

### 每日流程

**早上 / 開始學習前**：
```bash
gh issue list --label "type:setup" --state open        # 看當週還沒做的
# 或直接去 Project board：https://github.com/<你>/rust-journey/projects
```

**做完一個 issue**：
```bash
gh issue close 3 -c "完成 ch1-3，筆記在 notes/day1.md"
```

**寫學習日誌**：
直接編輯 `LOG.md`，`git commit` 推上去。每次 commit 都是你公開的學習軌跡。

**寫週反思**：
編輯 `weeks/week-XX.md`，記錄收穫。

### 推薦設 alias（可選）

```bash
# 加到你的 ~/.zshrc 或 ~/.bashrc
alias rj='cd ~/code/rust-journey'
alias rjt='gh issue list --state open --label "task"'     # 看任務
alias rjs='gh issue list --state closed --label "task" | wc -l'  # 看完成數
```

---

## 步驟 6：更新 README 的個人資訊

編輯 `README.md`：

1. 把 `[your-handle-here]` 換成你的 Twitter / crates.io / LinkedIn handle
2. 把 `*Started: [DATE]*` 改成今天日期
3. commit：

```bash
git add README.md
git commit -m "docs: personalize README"
git push
```

---

## 🎯 完成！你現在擁有：

✅ 一個公開的學習 repo（未來履歷）
✅ 48 個待辦的具體任務
✅ 7 個階段的 milestones
✅ 一個 kanban board 追蹤進度
✅ 筆記、日誌、作品集的結構
✅ 每 commit / close issue 都在建立 GitHub contribution graph

---

## 常見問題

**Q: 我完成 W1-W8 之後呢？**
A: 回來跟 Claude 說「展開 M3 階段」，我會給你下一個 bootstrap script。

**Q: 可以改任務嗎？**
A: 當然。直接在 GitHub 上 edit issue，或建新 issue。這是你的學習，不是死板計畫。

**Q: 我超前進度 / 落後了怎麼辦？**
A: 超前：拉下一週的 issue 提前做。落後：調整 milestone due date，不要自責，重要的是持續前進。

**Q: README 上的 badges 怎麼更新？**
A: 目前是靜態的 shield.io。之後 Claude 可以幫你做 GitHub Action 自動更新。或你自己改字串然後 commit 就會改。

**Q: 看起來好像工作？**
A: 好的學習本來就像工作。但你看 commit 綠圖滿起來的時候會上癮的。

---

## 🆘 卡住了？

- Script 失敗：檢查 `gh auth status`
- 權限問題：重新 `gh auth login`
- 其他：回來問 Claude，把錯誤訊息貼給我

Good luck, future Rustacean. 🦀
