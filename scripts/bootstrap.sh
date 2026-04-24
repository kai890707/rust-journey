#!/usr/bin/env bash
# =============================================================================
# rust-journey bootstrap script
# =============================================================================
# What this does:
#   1. Creates labels (types, phases, statuses)
#   2. Creates milestones (M1-M2 Foundations through M11-M12 Job Hunt)
#   3. Creates 48 issues for Weeks 1-8 (Phase 1: Rust Foundations)
#   4. Prints a summary with useful links
#
# Usage:
#   chmod +x scripts/bootstrap.sh
#   ./scripts/bootstrap.sh
#
# Requirements:
#   - GitHub CLI (`gh`) authenticated:   gh auth login
#   - Run from inside the rust-journey repo root
# =============================================================================

set -e

# --- colors -----------------------------------------------------------------
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_ORANGE='\033[0;33m'
C_DIM='\033[2m'
C_RESET='\033[0m'

log()   { echo -e "${C_BLUE}▶${C_RESET} $1"; }
ok()    { echo -e "${C_GREEN}✓${C_RESET} $1"; }
head()  { echo -e "\n${C_ORANGE}━━━ $1 ━━━${C_RESET}"; }

# --- preflight --------------------------------------------------------------
if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI not found. Install with: brew install gh"
  exit 1
fi

if ! gh auth status &> /dev/null; then
  echo "❌ Not logged in to gh. Run: gh auth login"
  exit 1
fi

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")
if [ -z "$REPO" ]; then
  echo "❌ Not inside a GitHub repo. cd into the rust-journey directory first."
  exit 1
fi

ok "Authenticated as: $(gh api user -q .login)"
ok "Repo: $REPO"

# ============================================================================
# 1. LABELS
# ============================================================================
head "Creating labels"

create_label() {
  local name=$1 color=$2 desc=$3
  gh label create "$name" --color "$color" --description "$desc" --force > /dev/null 2>&1 || true
  ok "label: $name"
}

# Task types
create_label "type:read"      "60a5fa" "Reading books / docs / articles"
create_label "type:drill"     "a78bfa" "Rustlings / small exercises"
create_label "type:code"      "f59e0b" "Hands-on coding"
create_label "type:write"     "34d399" "Writing notes / docs / blog"
create_label "type:challenge" "f87171" "Stretch problem"
create_label "type:ship"      "ef4444" "Release / publish"
create_label "type:share"     "06b6d4" "Publish to community"
create_label "type:plan"      "94a3b8" "Planning / decisions"
create_label "type:setup"     "64748b" "Environment / tooling"
create_label "type:community" "ec4899" "Networking / social"

# Phase labels
create_label "phase:M1-M2-foundations"    "ce422b" "Rust basics"
create_label "phase:M3-async"              "d97706" "Async & concurrency"
create_label "phase:M4-M5-solana"          "dc2626" "Blockchain + Solana"
create_label "phase:M6-M7-flagship"        "b91c1c" "Flagship DApp"
create_label "phase:M8-M9-evm"             "991b1b" "EVM ecosystem"
create_label "phase:M10-opensource"        "7f1d1d" "Open source contributions"
create_label "phase:M11-M12-jobhunt"       "450a0a" "Job search sprint"

# Status labels
create_label "status:blocked"  "eab308" "Waiting on something"
create_label "status:stretch"  "8b5cf6" "Optional / bonus"
create_label "task"            "1c1917" "Learning task"
create_label "reflection"      "059669" "Weekly retro"
create_label "milestone"       "facc15" "Week milestone marker"

# ============================================================================
# 2. MILESTONES
# ============================================================================
head "Creating milestones"

create_milestone() {
  local title=$1 desc=$2
  # gh doesn't have a milestone command, use the API
  gh api "repos/$REPO/milestones" --method POST \
    -f title="$title" \
    -f description="$desc" \
    -f state="open" > /dev/null 2>&1 || true
  ok "milestone: $title"
}

create_milestone "M1-M2: Rust Foundations"       "Weeks 1-8. Master ownership, traits, iterators. Ship a CLI + published crate."
create_milestone "M3: Async & Concurrency"        "Weeks 9-12. Tokio, async/await, mini-redis."
create_milestone "M4-M5: Blockchain + Solana"     "Weeks 13-20. First deployed Solana program."
create_milestone "M6-M7: Flagship DApp"           "Weeks 21-28. Portfolio centerpiece."
create_milestone "M8-M9: EVM Ecosystem"           "Weeks 29-36. Foundry, Alloy, Reth."
create_milestone "M10: Open Source"               "Weeks 37-40. Merged PRs & a deep technical post."
create_milestone "M11-M12: Job Hunt"              "Weeks 41-52. Resume, interviews, offer."

# ============================================================================
# 3. ISSUES FOR WEEKS 1-8
# ============================================================================
head "Creating 48 tasks for Weeks 1-8"

MS_P1="M1-M2: Rust Foundations"

mk_issue() {
  local week=$1 title=$2 type=$3 body=$4
  gh issue create \
    --title "[W$(printf '%02d' $week)] $title" \
    --body "$body" \
    --label "task,type:$type,phase:M1-M2-foundations" \
    --milestone "$MS_P1" > /dev/null
  ok "W$(printf '%02d' $week) · $title"
}

# ---- Week 1 ----
log "Week 1: Environment Setup & First Impressions"
mk_issue 1 "Install rustup, cargo, VS Code + rust-analyzer" "setup" "Set up the Rust toolchain. Verify with \`rustc --version\` and \`cargo --version\`. Install rust-analyzer extension in VS Code."
mk_issue 1 "Create rust-journey repo on GitHub, first README commit" "setup" "Already done if you're reading this. Push this bootstrap."
mk_issue 1 "Read The Book Ch. 1-3 (installation, hello world, common concepts)" "read" "Link: https://doc.rust-lang.org/book/ch01-00-getting-started.html"
mk_issue 1 "Rustlings: intro → variables → functions → if" "drill" "Install: \`cargo install rustlings\`. Run: \`rustlings\`."
mk_issue 1 "Rewrite FizzBuzz + Fibonacci from Java into Rust" "code" "Same logic, but feel how Rust's syntax differs. Push to repo."
mk_issue 1 "Create crypto Twitter, follow @rustlang @solana @anchorprotocol" "community" "Start building your presence on day 1."

# ---- Week 2 ----
log "Week 2: Ownership — Rust's Heart"
mk_issue 2 "Read The Book Ch. 4 (Ownership) — twice" "read" "The most important chapter. Read once for the shape, second time for the details."
mk_issue 2 "Rustlings: move_semantics (all 6 exercises)" "drill" "This is where the compiler starts pushing back. Good."
mk_issue 2 "Write a note: Ownership explained from a Java dev's view" "write" "Save to notes/ownership-from-java-view.md — comparing GC vs ownership/drop."
mk_issue 2 "Read The Book Ch. 5 (Structs) + Ch. 6 (Enums & match)" "read" "The two building blocks of Rust data modeling."
mk_issue 2 "Rustlings: structs, enums, strings" "drill" ""
mk_issue 2 "Code: Order state machine (struct + enum) — e-commerce themed" "code" "Use your SAP background. Model order lifecycle (Pending → Paid → Shipped → etc.) with enum + match."

# ---- Week 3 ----
log "Week 3: Collections, Error Handling, Modules"
mk_issue 3 "Read The Book Ch. 7 (Packages, Crates, Modules)" "read" ""
mk_issue 3 "Read The Book Ch. 8 (Vec, String, HashMap)" "read" ""
mk_issue 3 "Read The Book Ch. 9 (Error Handling) — panic! vs Result" "read" "Learn the \`?\` operator."
mk_issue 3 "Rustlings: vecs, hashmaps, options, error_handling" "drill" ""
mk_issue 3 "Code: CLI password generator with character stats (HashMap)" "code" "Practice collections + error handling in a small useful tool."
mk_issue 3 "Read lib.rs of anyhow OR thiserror crate" "read" "Understanding how real crates are structured. ~30 min."

# ---- Week 4 ----
log "Week 4: Generics, Traits, Lifetimes"
mk_issue 4 "Read The Book Ch. 10 (Generics, Traits, Lifetimes) — slowly" "read" "Most abstract chapter. Don't rush."
mk_issue 4 "Rustlings: generics, traits, lifetimes" "drill" ""
mk_issue 4 "Write a note: Java interfaces vs Rust traits — comparison table" "write" "Save to notes/traits-vs-interfaces.md"
mk_issue 4 "Read The Book Ch. 11 (Testing)" "read" ""
mk_issue 4 "Code: Add traits + unit tests to the W2 order state machine" "code" "Practice writing tests, extracting behavior into traits."
mk_issue 4 "Challenge: Generic Stack<T> implementing Iterator" "challenge" "Stretch task — tests your trait + generics intuition."

# ---- Week 5 ----
log "Week 5: Mini Project — minigrep"
mk_issue 5 "Complete The Book Ch. 12 (minigrep) verbatim first" "code" "Type it out. Resist copy-paste."
mk_issue 5 "Enhance minigrep: add regex support (regex crate)" "code" "Real-world pattern matching."
mk_issue 5 "Enhance minigrep: colored output (colored or owo-colors)" "code" "Discover the ecosystem."
mk_issue 5 "Enhance minigrep: replace hand-rolled parsing with clap crate" "code" "Learn what every serious CLI uses."
mk_issue 5 "Write README + usage examples + animated gif for minigrep" "write" "Use asciinema or vhs to record."
mk_issue 5 "Push minigrep to its own repo + write a dev.to / Medium post" "share" "First public Rust artifact. 🏆"

# ---- Week 6 ----
log "Week 6: Iterators, Closures, Functional Style"
mk_issue 6 "Read The Book Ch. 13 (Iterators + Closures)" "read" "The most elegant part of Rust."
mk_issue 6 "Rustlings: iterators" "drill" ""
mk_issue 6 "Rewrite minigrep using iterator chains" "code" "Replace loops with .filter().map().collect()."
mk_issue 6 "Read std::iter docs — all trait methods" "read" "Skim to know what's available; deep-read 5 you haven't seen before."
mk_issue 6 "Challenge: solve one Advent of Code problem using only iterators" "challenge" "Any year, any day. Pure iterator chain."
mk_issue 6 "Write a note: Java Stream API vs Rust Iterator" "write" "Save to notes/iterators-vs-streams.md"

# ---- Week 7 ----
log "Week 7: Smart Pointers & Interior Mutability"
mk_issue 7 "Read The Book Ch. 15 (Smart Pointers)" "read" ""
mk_issue 7 "Write a note: When to use Box vs Rc vs Arc" "write" "Save to notes/smart-pointers-decision-tree.md"
mk_issue 7 "Understand RefCell and the interior mutability pattern" "read" "Why it exists, when to reach for it."
mk_issue 7 "Code: simple graph using Rc<RefCell<T>>" "code" "Feel the pain, then appreciate why most graphs use arena allocation."
mk_issue 7 "Preview The Book Ch. 16 (Concurrency)" "read" "Just a skim — deeper dive coming in M3."
mk_issue 7 "Decide the topic for your first published crate" "plan" "What small, reusable library will you extract from your work so far?"

# ---- Week 8 ----
log "Week 8: Publish First Crate"
mk_issue 8 "Extract reusable part of CLI tool into lib.rs" "plan" "Design the public API. What should be pub, what should be crate-private?"
mk_issue 8 "Implement the crate's library API (lib.rs)" "code" ""
mk_issue 8 "Write doc comments (/// and //!), run cargo doc --open" "write" "Rust's doc story is world-class. Use it."
mk_issue 8 "Write full test suite (unit + integration)" "code" "Integration tests go in tests/ directory."
mk_issue 8 "Register crates.io account + cargo publish" "ship" "🏆 MILESTONE: your name on crates.io."
mk_issue 8 "Announce on Twitter + dev.to: I published my first Rust crate" "share" "Build an audience. This is a real accomplishment."

# ============================================================================
# DONE
# ============================================================================
head "All done!"

ISSUE_COUNT=$(gh issue list --limit 100 --json number -q '. | length')

echo ""
echo -e "${C_GREEN}✓${C_RESET} Created 48 tasks for Weeks 1-8"
echo -e "${C_GREEN}✓${C_RESET} Total open issues: ${ISSUE_COUNT}"
echo ""
echo -e "${C_ORANGE}Next steps:${C_RESET}"
echo "  1. Open the Issues tab:          gh issue list --web"
echo "  2. Create a project board:        https://github.com/$REPO/projects/new"
echo "     → Choose 'Board' template, add columns: Todo / In Progress / Done"
echo "     → Bulk-add all 'task' issues to the project"
echo "  3. Start Week 1:                  gh issue list --label 'type:setup' --state open"
echo "  4. Close your first issue:        gh issue close 1 -c 'Installed! rustc 1.xx.x'"
echo ""
echo -e "${C_DIM}Tip: Ask Claude 'unpack M3' when you're ready for the next phase.${C_RESET}"
echo ""
