+++
title = "why i use nixos"
date = 2026-06-20
description = "a quick rundown of what makes nix(os) my daily driver: reproducible packaging, isolated dev environments, and how it differs from docker."
+++

## reproducible packaging

write one config / package an app once, and it runs on any machine that has nix. no "works on my machine" — the same definition builds the same thing everywhere.

how is this different from docker? docker is a container platform, mostly used to bundle and isolate a single app. nix(os) is broader: it's tooling that can encompass a whole range of other tooling — including docker itself.

## development & deployment environments

write a `flake.nix` with every tool you need pinned to an exact version, plus your environment variables and hooks (pre/post commands). then run:

```sh
nix develop
```

now you're in an isolated shell with all your tooling and variables ready to go — and nothing installed globally. two projects that need different versions of the same tool, or different variables, never collide.

the same flake works for deployment too, so the environment you develop in is the environment you ship.

## and that's just the start

the sky's the limit here — there's so much more you can do.
