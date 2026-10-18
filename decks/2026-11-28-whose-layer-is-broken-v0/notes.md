# notes — whose layer is broken, v0 (everything, no time limit)

Not part of the deck: `build.mere` reads `deck.md` only.

## What v0 is

Every episode from the tower that is worth telling, with no regard for length:
108 slides. The talk given on the day is made from this by subtraction. `v2/` is
one such subtraction (36 slides, 20 minutes), the first draft (`../2026-11-28-
whose-layer-is-broken/`) is the talk as it could be written at the proposal.

Chapters:

| | chapter | what it collects |
|---|---|---|
| 0 | 塔 | what was built, and the vote |
| 1 | puts 1 + 1 | the main case, in full |
| 2 | 症状は、原因と別の層に出る | 15 cases where the symptom and the cause were in different layers or libraries |
| 3 | 2 つの誤りが重なると、正しい出力になる | 14 cases where a check stayed green or silent for a reason of its own |
| 4 | 答え合わせの相手にも、層がある | the reference ruby and the host's libm |
| 5 | 遅さも、別の層にいる | 13 cases of CPU and memory, most with a first guess that was wrong |
| 6 | この発表自身 | the talk's own evidence, and its own correction |
| 7 | 持ち帰ってほしいこと | the three lines |

## Where each case can be checked

Public repositories unless marked "author's notes". The main case is in the
first draft's `notes.md`.

| case | where |
|---|---|
| 文字の d に、横棒が出る / 正解を持たない検査 | merelang/mere c82a8975 (v0.1.365); mslide README; mbrowse `scripts/winding_check.sh`. 297 / 297: author's notes |
| 3D の描画が、2 フレーム目で落ちる / 規則ごと、取り下げた | merelang/mere 44edc20f (v0.1.456), 8e59c160 (v0.1.457). 2,715 tests, 29 type-checks: author's notes |
| x86-64 でだけ、9 回目から NaN | merelang/mere d802ba8c |
| CI が、生まれてからずっと赤 | merelang/mere 807987cc |
| 足し算の順番は、C コンパイラのもの | merelang/mere a3f2d507 |
| ループにしていたのは、clang だった / 同じ日に、もう 1 つ | merelang/mere ccd7a7c0 (v0.1.402) |
| CRC は、64 ビットでは偶然正しかった | mgz 74fa3a3 |
| 1 枚の画像が、2 つの違うファイルになる | mpng 6439e56 |
| Ruby の定数表が、壊れていた | merelang/mere 543536ca (v0.1.390) |
| CPU 0% で、止まる / 決め手は、アドレスではなかった | merelang/mere bd60dfec (v0.1.589); the ASan build: author's notes |
| 同じ処理が 4 つ、それぞれずれていた | merelang/mere fc738816 (v0.1.409) |
| popen 1 回で、メモリが 33 MB → 537 MB | author's notes (the mere-ruby round of 2026-10-11) |
| 整数の幅が、3 つある | mere-ruby PAIN.md, M8 |
| 印字は、ずっと正しかった / コードにはコメントまであった | merelang/mere cd3e81ee (v0.1.634); `lib/codegen_riscv.ml` at v0.1.633 |
| 本家 ruby との一致が 2,589 件 / 何もしていなかったもの / 直したあとの比較でも | mere-ruby bb4d35a |
| ソケットのテストが、パスの長さを測っていた | mere-ruby c312000 → 9f4a6af |
| 殺されたファイルが、98 / 98 の緑 / 直した版の方が、悪く見えた | mere-ruby 6f09c1f and the round after it; author's notes |
| 道具が無ければ、成功 / それを塞ぐ検査も | merelang/mere a7c5d671 (v0.1.531), `scripts/tool_preflight_check.sh` |
| どの CI にも居ない検査 | merelang/mere be154d59 (v0.1.532) |
| 全部走らせたら、3 本赤 | merelang/mere v0.1.533, 3578edc5 |
| 毒見が、黙って力を失う / 毒見は、壊して測る | merelang/mere v0.1.627, 513a07de (v0.1.636) |
| ランダムでは、壊れない | mgz 957f6b6 |
| 答え合わせの相手が、何も確かめていなかった | author's notes (mere-ruby, the fourth survey) |
| 落ちるはずのない検査 | merelang/mere v0.1.523; author's notes |
| データベースの検査が、黙って飛ぶ | author's notes; fixed 2026-09-28 |
| 本家 ruby は、掛け算と足し算を 1 命令にしていた | mere-ruby 7ea5534 |
| macOS の数学関数は、正しく丸めていない | author's notes (RV floats and libm) |
| 本家 ruby の版と機械も、答えを変える | mere-ruby README at ef4941b |
| 圧縮しない圧縮器 / 同じ圧縮器の、ほかの 2 つ | mgz eb5b1bc |
| このスライドが、1 枚 25 秒 | mpng 275c32a, mslide dd037d4 |
| Hash 1 つに、索引 1 つ | mere-ruby 4774582 (Mere v0.1.643) |
| 安全の検査が、1 時間終わらない / 問いを狭める | merelang/mere 514f8562 (v0.1.548) |
| 計画に書いた原因は、2 つとも外れた / 本当の原因 | mere-ruby ce029af → 86ee8e1 (Mere v0.1.605) |
| 1 行で、169 MiB → 3.5 MiB / LLVM では回収していなかった | merelang/mere c1524169, 8a38b18c (v0.1.443) |
| 自作の CPU で、命令を数える | merelang/mere 99f89488, 2ddbec18, 75d2c1fe (v0.1.616–618) |
| gsub 10 万回で 1 GB | mere-ruby 11f1048 → 5839d5b |
| 測って、作ったものを捨てた | mere-ruby f64c566 ("MEASURED AND NOT KEPT") |
| 時間切れではなく、メモリの番人だった / その後 | mere-ruby fdbf1d1, ddb7b21; author's notes |
| 1 GB のファイルを開く | author's notes (medit2) |
| 測ったのは、古いファイルだった | author's notes (Wasm size) |
| 1,000 個の関数が、1 つの塊 | merelang/mere 555906d6 (v0.1.581) |
| この発表自身 | mere-ruby CI run for c2ea241; author's notes of 2026-09-24 |

## Not confirmed, so not on a slide

- the exact size of the block `map_recycle` overran (a figure of 2928 bytes came
  up in research; the commit says only "claimed 4 KB on it")
- how many instructions later the constant-table corruption crashed

## Before using a case on the day

- [ ] every "author's notes" row: find the public commit or run that shows it, or
      say it without the number
- [ ] rehearse each case that goes into the day's talk with a clock; v0 does not
      know how long any of them takes
