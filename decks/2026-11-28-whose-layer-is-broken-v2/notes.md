# notes — whose layer is broken, v2 (YAPC::Tokyo 2026, 20 min)

Not part of the deck: `build.mere` reads `deck.md` only.

## What v2 is

The other directory, `2026-11-28-whose-layer-is-broken/`, is the talk as it
could be written when the proposal went in (2026-09-06). This one is the best
version that can be written now. Both stay on this branch until one is given;
only that one goes to `main`.

What does not move, because the published abstract promises it: `puts 1 + 1`
after widening to 64 bits, three layers each with green boundary tests, two
wrong guesses, a guess turned into a check, reading the machine code instead of
inferring, the one line, and "something other than me can judge".

What v2 does with it:

- **The audience picks a suspect** at the start; the answer comes after the one
  line.
- **The main case is told in about nine minutes**, one message a slide.
- **The three take-home lines become the frame for the second half.** Each is
  followed by two to four short case files from the same tower — bugs whose
  symptom showed in one layer or library and whose cause was in another, checks
  that stayed silent, and the cost that turned out to be two libraries down.
- **It ends on this talk itself**: the September correction to its own evidence
  was the error, and a log said so.

## Time budget (36 slides)

| part | from the slide titled | minutes |
|---|---|---|
| opening, the vote | 自作言語で… / 最初に、ひとつ選んでください | 0.5 |
| the main case | 3 つの層 … では、なぜ緑だったのか | 9 |
| the three lines | 持ち帰ってほしいこと | 0.5 |
| 1. turn suspicion into a check | 1. 疑いは、検査にする … そのとき足した 8 行のテスト | 2.5 |
| 2. a silent check is not proof | 2. 黙っている検査を … 2 つの誤りが重なると | 3.5 |
| 3. read the artifact | 3. 観察が食い違ったら … そして、この発表の準備中にも | 2.5 |
| close | 当てるためではなく … ありがとうございました | 1.5 |

Twenty minutes is tight for seven case files. If rehearsal runs long, cut in
this order: ランダムでは、壊れない → 道具が無ければ、成功 → 正解を持たない検査
(fold its numbers into the d slide). Never cut 印字は、ずっと正しかった or
このスライドが、1 枚 25 秒: they are the two that are the same shape as the main
case in the same tower.

## Facts on the slides, and where they can be checked

The main case (2026-09-02/03) is in the first draft's `notes.md` and is the same.
Everything below is from public repositories.

| slide | fact | where |
|---|---|---|
| 文字の d に、横棒が出る | a 30 px `d` drew a bar it does not have; the inside test was half-open in the curve parameter, not in y | merelang/mere v0.1.365 (c82a8975); mslide README, "The fix that came out of drawing something" |
| 同 | the existing gate compared against a browser and passed 297 / 297; it had no 30 px case | the author's design notes for mslide M3 |
| 正解を持たない検査 | mirror the glyph: 87 points disagreed on the old rule, 0 on the new; first found on `g` at 12 px | mslide README; mbrowse `winding_check.sh` |
| 3D の描画が、2 フレーム目で落ちる | a region rule shipped in Mere v0.1.453–455, all gates green; m3d crashed from its second frame; reverted in v0.1.456 (44edc20f); the "822 MB → 10 MB" measurement was withdrawn | merelang/mere 44edc20f and the v0.1.456 changelog |
| そのとき足した 8 行のテスト | on its first run it found Wasm printing -424242 where 700 was right | merelang/mere 8e59c160 (v0.1.457) |
| 印字は、ずっと正しかった | print, print_no_nl, print_int and the failure path wrote with whatever a0 held; memu printed every write it had not opened | merelang/mere v0.1.634 (cd3e81ee) |
| 同 | the comment "The emulator's write syscall ignores the descriptor, but QEMU's ..." | `lib/codegen_riscv.ml` at v0.1.633 |
| 本家 ruby との一致が 2,589 件 | the mspec shim made `it_behaves_like` a no-op (1781 lines), compared only the class in `should.raise`, had no `should_not.raise`; MATCH 2589 → 2221 when it followed mspec | mere-ruby bb4d35a (2026-09-29) |
| 道具が無ければ、成功 | `qemu_virt.sh` exited 0 when QEMU was absent, and CI installed QEMU with `continue-on-error: true`; 65 gates had the "absent tool is success" shape, 46 were in CI | merelang/mere v0.1.531 (a7c5d671), `scripts/tool_preflight_check.sh` |
| ランダムでは、壊れない | a 32×32 random-pixel PNG crashed mgz's encoder (the code-length tree's 7-bit limit was never checked); random byte strings of 1–4096 bytes over three seeds all passed; the 3,104 bytes are a fixture | mgz 957f6b6 (2026-09-07) |
| 圧縮しない圧縮器 | every check asked whether the output was correct, which stored blocks pass; an 8.9 MB layer took 369 s (gzip 0.1 s); a hash chain made it 1.3 s | mgz eb5b1bc (2026-09-16) |
| このスライドが、1 枚 25 秒 | this talk's first draft, 33 slides, took 14 min 34 s to build; `sample` put the time in mgz's old `find_match`; mpng still pinned mgz 57efe4c; after mpng 275c32a and mslide dd037d4 it builds in 3 s, and the images inside the PDF are the same pixels | mpng 275c32a, mslide dd037d4 (2026-10-18) |
| そして、この発表の準備中にも | the September correction said "162 matching against ruby" was really RV64 against the C backend; mere-ruby's CI `corpus` job (162 programs against ruby 3.2.2, byte for byte) was green on 2026-09-02 (c2ea241); the other 162 is the RV64 corpus, 142 of 162 against C | mere-ruby CI, run for c2ea241 |

## To check before the day

- [ ] rehearse with a clock; the cut order is above
- [ ] the vote: three options with hands up in 20 seconds
- [ ] 印字が壊れた: what exactly broke when memu passed descriptors through
- [ ] the 297 / 297 and 2,715 figures are from the author's notes; find the
      commit or CI run that shows each, or say them without the number
- [ ] body text at 30 px on the venue's projector
