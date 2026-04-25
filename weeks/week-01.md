# Week 01 — Environment Setup & First Impressions

**Phase**: M1 Foundations
**Dates**: 2026-04-XX → 2026-04-XX
**Target hours**: 10h · **Logged**: __h
**Status**: ✅ Complete

## 🎯 Goal
建立 Rust 工具鏈、看完 The Book Ch. 1-3、寫出第一支 Rust 程式。

## 🏆 Milestone Achieved
✨ 能 `cargo run` 並讀懂編譯錯誤訊息。已寫出 FizzBuzz 和 Fibonacci。

## 📝 Reflections

### What clicked
- Cargo workspace 共享 target/ 的概念
- Expression vs statement（分號改變意義）
- Tuple destructuring：`let (a, b) = (0, 1)`
- match + tuple 的 pattern matching 比 if/else 優雅

### What was hard
- [填你卡到的地方，例如：第一次看 ownership 相關章節有點抽象]
- [或：搞清楚 cargo new 在 workspace 下的行為]

### Java ↔ Rust insight
- Java 預設 mutable，Rust 預設 immutable —— 心智反過來
- Rust 的 integer overflow 在 debug 會 panic，Java 永遠 silent wrap
- Rust 沒有 `null`，要用 Option<T>（雖然 Ch. 1-3 還沒深入）
- match 比 switch 強：能 destructure tuple、強制 exhaustive

### Aha moments
- 寫 Fibonacci 時，`(a, b) = (b, a + b)` 一行 swap 兩個變數
- match 編譯器強制你 cover 所有 case —— 這是 Rust 防 bug 的核心

## 🔗 Artifacts
- exercises/week-01/fizzbuzz/
- exercises/week-01/fibonacci/

## 📚 Resources used
- The Rust Book Ch. 1-3
- Rustlings: intro, variables, functions, if（如果做了）