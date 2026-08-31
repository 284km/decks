#!/bin/sh
# scripts/check.sh — the build works, on a fixture rather than on the talks.
#
# `decks/` holds talks that have been given. A gate that wrote into it would
# publish its own input, and a gate pointed at an empty directory would check
# nothing, so there is a fixture and the build takes a directory.
#
# What is asserted is thin on purpose: mslide has its own gates and this
# repository is not the place to re-run them. What is this repository's own is
# the wiring — that the pinned tool resolves, that a deck in this layout becomes
# a page and a PDF, and that the index names what is there.
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MERE="${MERE:-mere}"
command -v "$MERE" >/dev/null 2>&1 || { echo "check: no mere — set MERE=/path/to/mere.exe" >&2; exit 1; }
cd "$ROOT"
[ -d .mere_modules ] || { echo "check: no .mere_modules — run: $MERE install" >&2; exit 1; }
CC="${CC:-clang}"; command -v "$CC" >/dev/null 2>&1 || CC=cc
command -v "$CC" >/dev/null 2>&1 || { echo "check: no C compiler — the build cannot run interpreted" >&2; exit 1; }

T="$(mktemp -d)"
trap 'rm -rf "$T"; rm -f test/decks/wiring/index.html test/decks/wiring/deck.pdf test/decks/index.html' EXIT
fail=0

# Encoding a PNG under the interpreter takes 45 minutes, so this is compiled and
# the build is the first assertion.
"$MERE" -c build.mere > "$T/b.c" || { echo "check: build.mere did not compile to C" >&2; exit 1; }
$CC -O2 -o "$T/build" "$T/b.c" 2>/dev/null || { echo "check: the generated C did not build" >&2; exit 1; }

out=$("$T/build" test/decks 2>&1) || { echo "$out" >&2; echo "check: the build did not run" >&2; exit 1; }
echo "$out"

for f in test/decks/wiring/index.html test/decks/wiring/deck.pdf test/decks/index.html; do
  [ -s "$f" ] || { echo "FAIL  $f was not written" >&2; fail=1; }
done

# A page with no slides in it is still a page, and would pass a test that only
# asked whether a file appeared.
grep -q '<section id="s1"' test/decks/wiring/index.html || { echo "FAIL  the page has no slides" >&2; fail=1; }
grep -q '<section id="s2"' test/decks/wiring/index.html || { echo "FAIL  the page is missing its second slide" >&2; fail=1; }
if grep -qi '<script' test/decks/wiring/index.html; then echo "FAIL  the page carries a script" >&2; fail=1; fi
head -c 5 test/decks/wiring/deck.pdf | grep -q '%PDF-' || { echo "FAIL  the pdf is not a pdf" >&2; fail=1; }
grep -q 'wiring/' test/decks/index.html || { echo "FAIL  the index does not name the deck" >&2; fail=1; }

# The tool is pinned, and a pin that is not recorded is not a pin.
grep -q 'rev = ' mere.toml || { echo "FAIL  mere.toml pins no revision" >&2; fail=1; }
[ -f mere.lock ] || { echo "FAIL  mere.lock is missing" >&2; fail=1; }

[ "$fail" -eq 0 ] || { echo "check: FAILED" >&2; exit 1; }
echo "check: ok"
