# decks

Talks, built with [mslide](https://github.com/284km/mslide) — a slide tool
written in [Mere](https://merelang.org/).

Each talk is a directory holding one markdown file. `build.mere` turns every one
of them into a page and a PDF, and writes an index. Published at
**<https://284km.github.io/decks/>**.

```sh
mere install
mere -c build.mere > b.c && clang -O2 b.c -o build
./build                     # decks/ -> pages, PDFs and index.html
sh scripts/check.sh
```

## The revision is pinned, and that is the point

`mere.toml` names an exact revision of mslide, and `mere.lock` records it with a
hash. A talk given in 2026 renders in 2030 the way it was given, however far the
tool has moved since — a deck is not software and should not drift with its
build. Changing the pin is a decision, and it shows up in a diff as one.

## Why the outputs are committed

The page and the PDF sit next to the markdown they came from. GitHub Pages serves
this branch directly, so a talk is published by pushing it: there is no workflow
between writing a deck and showing it, and nothing in between to break the week
of a conference.

That is affordable here because a deck is **one self-contained HTML file** — the
CSS is inline, there is no JavaScript, and nothing is fetched. It opens from a
memory stick with the network off.

## Layout

    decks/<YYYY-MM-DD-slug>/deck.md    the talk. this is the source
    decks/<YYYY-MM-DD-slug>/index.html the page, built
    decks/<YYYY-MM-DD-slug>/deck.pdf   what a conference asks for, built
    index.html                         the list, built
    test/decks/wiring/deck.md          not a talk — see below

`decks/` holds talks that have been given. The fixture lives outside it because a
gate that wrote into `decks/` would publish its own input, and a gate pointed at
an empty directory would check nothing.

## What is checked

`scripts/check.sh`, and deliberately thin: mslide has its own gates and this is
not the place to re-run them. What belongs here is the wiring —

- the pinned tool resolves and `build.mere` compiles,
- a deck in this layout becomes a page **with its slides in it** (a page with no
  slides is still a page, and would pass a test that only asked whether a file
  appeared),
- the PDF starts with `%PDF-`,
- the index names the deck,
- and `mere.toml` pins a revision that `mere.lock` records, because a pin that is
  not written down is not a pin.

The build is compiled rather than interpreted. Encoding one PNG takes the
interpreter forty-five minutes.
