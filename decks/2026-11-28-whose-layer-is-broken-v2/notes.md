# notes — whose layer is broken, v2 (YAPC::Tokyo 2026, 20 min)

Not part of the deck: `build.mere` reads `deck.md` only.

## What v2 is

The other directory, `2026-11-28-whose-layer-is-broken/`, is the talk as it
could be written when the proposal went in (2026-09-06). This one is the best
version that can be written now, with what happened since. Both stay on this
branch until one of them is given; only that one goes to `main`.

What does not move, because the published abstract promises it: `puts 1 + 1`
after widening to 64 bits, three layers each with green boundary tests, two
guesses that were wrong, a guess turned into a check, reading the machine code
instead of inferring, the one line, and "something other than me can judge".

What v2 changes:

- **The audience picks a suspect** at the start, and the answer comes after the
  one line (答え合わせ: 2, the machine code the compiler emitted).
- **One message a slide.** 40 slides in 20 minutes, most of them one sentence.
- **Act 5 turns on one sentence**: writing back from the wrong place and writing
  back from a place nobody has written yet give the same output.
- **The same shape, twice more.** October's print without a descriptor on an
  emulator that ignored descriptors; and this talk's own September correction,
  which was the thing that was wrong. Both are "two errors, one right output" or
  "the log judged, not memory".

## Time budget

| part | from the slide titled | minutes |
|---|---|---|
| opening, the vote | 自作言語で… / 最初に、ひとつ選んでください | 1 |
| the tower and the symptom | 3 つの層 … 他人の層なら、材料が外から来る | 3 |
| two guesses | 見当 1 … どちらも、証拠つき | 2 |
| a guess turned into a check | 推測を、検査に変える … 検査は、外れも確定させる | 3 |
| read the output | 観察が、食い違い始めた … s10 に書く命令は | 2 |
| the cause, and the answer | 例外の仕組み … 答え合わせ | 3 |
| why it was green | では、なぜ緑だったのか … 32 ビットも | 2 |
| the same shape again | 同じ形に、その後も出会った … そして、この発表の準備中にも | 2 |
| take home | 持ち帰ってほしいこと … ありがとうございました | 2 |

## Facts on the slides that are not in v1

v1's `notes.md` has the rest (the bug of 2026-09-02/03), and they are the same.

| slide | fact | source |
|---|---|---|
| 10 月: 印字は、ずっと正しかった | print, print_no_nl, print_int and the failure path issued write(2) with whatever a0 held; memu printed every write to a descriptor it had not opened | merelang/mere v0.1.634 (2026-10-07), its commit message |
| コードにはコメントまであった | "The emulator's write syscall ignores the descriptor, but QEMU's ..." | `lib/codegen_riscv.ml` at v0.1.633, next to the stderr path |
| 同 | 5 other sites wrote with no descriptor: `li a0 1` added to four print paths and `li a0 2` to the failure path | the v0.1.634 diff of `lib/codegen_riscv.ml` |
| そして、この発表の準備中にも | the September correction said "162 matching against ruby" was really RV64 against the C backend; the CI log shows mere-ruby's `corpus` job (162 programs against ruby 3.2.2, byte for byte) green on 2026-09-02 | mere-ruby CI run for c2ea241; the other 162 is the RV64 corpus, 142 of 162 against C |

## To check before the day

- [ ] 「5 箇所」 is the v0.1.634 diff. A note elsewhere says "4 of 10"; the slide
      says what the diff shows, and the denominator is not on the slide until it is
      counted from the code
- [ ] 印字が壊れた: what exactly broke when memu passed descriptors through (the
      memory of it is `print_int 5` writing to fd 5 and getting EBADF)
- [ ] the vote: rehearse that 3 options with hands up fits in 20 seconds
