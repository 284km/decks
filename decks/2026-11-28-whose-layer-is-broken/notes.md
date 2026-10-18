# notes — whose layer is broken (YAPC::Tokyo 2026, 20 min)

Not part of the deck: `build.mere` reads `deck.md` only. This is what the slides
stand on, so that a number on a slide can be traced before it is said out loud.

## Time budget

| act | from the slide titled | minutes |
|---|---|---|
| opening | 自作言語で作った… / 今日の話 / 言えること・言えないこと | 1 |
| 0. no material comes from outside | 3 つの層、全部自分のコード … それでも、3 つとも残る | 3 |
| 1. two guesses, both with evidence | 見当 1 … どちらも、証拠つき | 2 |
| 2. a guess turned into a check | 推測を、検査に変える … 検査は、外れも確定させる | 4 |
| 3. stop inferring, read the output | 観察が、食い違い始めた … mv a0, s10 | 3 |
| 4. the cause | 例外の仕組み … 最初の見当は、方向としては合っていた | 2 |
| 5. why nothing saw it | なぜ、誰も見なかったのか … 正直な 1 点 | 3 |
| 6. what to take home | 持ち帰ってほしいこと … ありがとうございました | 2 |

## Facts on the slides, and where they come from

All as of the bug (2026-09-02 / 03) unless a slide says otherwise.

| slide | fact | source |
|---|---|---|
| 3 つの層 | Ruby interpreter over 40,000 lines | mere-ruby, `git ls-files '*.mere'` minus vendored modules, early September |
| ある日、動かなくなった | 149 places rewritten for 64-bit, not one commit | the RV64 work in merelang/mere, v0.1.394 onward (LW/SW to LD/SD through one helper) |
| 境界のテストは、全部通っていた | Ruby: byte for byte against ruby 3.2.2, 162 programs | mere-ruby CI `corpus` job, green on 2026-09-02 (c2ea241) and 09-03 (ef4941b); 162 `.rb` files in `corpus/` |
| 境界のテストは、全部通っていた | machine code: no mismatch at 64 or 32 bits | merelang/mere `scripts/rv_exec_check.sh`; after the fix on 09-03 it read 83 / 0 / 2 at 64 and 77 / 0 / 3 at 32 (match / mismatch / known-different) |
| 境界のテストは、全部通っていた | QEMU 7 / 7 | merelang/mere `scripts/qemu_virt.sh`, 09-03 |
| 機械が言った | `gc_collect: reserved 2, used 17` | the frame-slot check added in Mere v0.1.398 |
| 見当 2 も、検査に | the call-contract check never fired | memu's shadow-stack `abi` instrument |
| mv a0, s10 | `3fb164:  000d0513   mv a0, s10` | `mere -rvd` on the RV64 mere-ruby binary |
| 書いていた先は、区画の外 | record of 15 words; saves at 20..29 instead of 5..14 | the try_or catch record in `lib/codegen_riscv.ml` before the fix |
| 壊れていたのは 1 行 | `enc_s (20 + i * 4)` became `(20 + i) * wsz ()` | introduced v0.1.388, rewritten v0.1.394; `git log -L` names both |
| 2. テストはあった | passes with 0 allocations, breaks with 1 | measured on the broken version (v0.1.400, 32-bit) |
| 正直な 1 点 | 32-bit broken since the same change | the same line; 4-byte words put the saves at 80..116 bytes, still past 60 |

## To re-measure before the day

- [ ] QEMU differential (`scripts/qemu_virt.sh`) — 7 / 7 is from 09-03
- [ ] decide whether 境界のテスト also says what the comparison against ruby reads
      today (ruby/spec, test/unit); if so, give the date and the denominator,
      never "all green"
- [ ] the measurement on 2. テストはあった, once more, on the broken version
- [ ] the date of the talk: the directory says 11-28 until the timetable says otherwise

## Not said

- Mere's language design
- the RISC-V instruction set, beyond the one line `mv a0, s10`
- any particular AI tool
- "making things to learn has become easy" (a different talk)

## What this deck found in mslide

- **Fixed in mslide 99ff6bb**: an ordered list was drawn as bullets — `1.` to
  `5.` all came out as `・`, and the order is the point of that slide. The parser
  had kept the markers; the PNG layout ignored them.
- **Fixed through mpng 275c32a (mslide dd037d4)**: a slide took about 25 seconds
  to render, because mpng still pinned mgz's first match finder, which scanned
  all 32768 distances at every position. This deck went from 14 minutes to 3
  seconds; the pixels inside the PDF are the same.
- **Worked around here**: a fenced block is drawn at 7/10 of body size, so the
  one line the talk turns on (`mv a0, s10`) was the smallest text on its slide.
  It is a `#` heading instead. That size is mslide's choice for long code lines
  and stays.
- **Not decided**: body text is a twenty-fourth of the height (30 px at 720).
  Probably small for a hall; to be judged on the projector, not here.
