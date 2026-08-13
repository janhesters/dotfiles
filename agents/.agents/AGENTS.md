# System-Wide Instructions

## Asking Questions

When unsure about the user's intent, constraints, or the best approach, ask clarifying questions rather than guessing. This applies both before starting work (e.g., before researching, fetching, or writing code) and after gathering information (e.g., when findings are ambiguous or multiple paths are viable). Prefer a short question over a wrong assumption.

## Prose Writing

Read and follow the prose-writing skill at `~/dev/aidd-jan/.agents/skills/aidd-prose-writing/SKILL.md` only when the task requires writing or editing a prose deliverable for the user. Examples include Slack messages / DMs, emails, posts, articles, video descriptions or scripts, notes, and documentation.

Do not read the prose-writing skill for ordinary conversational replies, progress updates, explanations, clarifying questions, or short answers where prose is only the medium rather than the requested deliverable.

## Skill Creation

Whenever creating or updating a skill, first read and follow the skill-creating skill at `~/dev/aidd-jan/.agents/skills/aidd-skill-creating/SKILL.md`.

## Omarchy

Omarchy wraps system tools with its own commands. Always use `omarchy` wrappers — never call underlying tools (systemctl, systemd-run, notify-send, pacman, yay, etc.) directly. Discover available commands with `omarchy commands`.

OmarchyConstraints {
  Never use underlying tools directly when an `omarchy` command exists.
  Never edit files in `~/.local/share/omarchy/` — always override in `~/.config/`.
}

OmarchyPackageManagement {
  Constraints {
    Never use `pacman -S` or `yay -S` directly — Omarchy's package wrappers ensure consistency across updates.
  }

  install(package) => match (package) {
    case (official Arch repo) => `omarchy-pkg-add <package>`
    case (AUR) => `omarchy-pkg-aur-add <package>`
    case (interactive browsing) => `omarchy-pkg-install`
  }

  remove(package) => `omarchy-pkg-drop <package>`

  check(package) => match (intent) {
    case (is it missing?) => `omarchy-pkg-missing <package>`
    case (is it present?) => `omarchy-pkg-present <package>`
  }
}

## Mise

Bun (and potentially other dev tools) are managed via [mise](https://mise.jdx.dev/). To upgrade:
- `mise upgrade bun` — upgrade bun to latest
- `mise install bun@latest && mise use -g bun@latest` — install and set a specific version globally

Do not use `bun upgrade` or system package managers for bun.

## Calendar

constraint CalendarEvents {
  create_event silently drops `location` — after creating, get_event to verify it stuck; if missing, set via update_event.
  Use a full geocodable address (street, postal code, city, country).
}

## Gmail

constraint ThreadReads {
  search_threads returns only a partial subset of a thread's messages — never treat it as the full thread.
  To read or summarize a thread => get_thread(threadId) for the complete message list.
}

## SDR email signatures

Every external email originating from Scale360 or another SDR or lead-generation partner must include the sender's complete personal sign-off, legal footer, and confidentiality notice. This includes prospect information emails, follow-ups, replies, forwards, and partner correspondence.

The structure follows [André Reutlinger's Slack guidance](https://reactsquad-earlynode.slack.com/archives/C0BP0TLUKC1/p1786343344115939). The ReactSquad blocks below are canonical; do not copy Scale360's company details.

When referring to the person who made the outreach call, write "my colleague" or the equivalent in the email's language. Do not name the SDR caller unless the user explicitly asks you to name them.

For emails sent by Jan, copy exactly one of the complete blocks below. Match the signature language to the language of the email. Never combine the German and English versions in one email.

### Jan: German email

```text
Viele Grüße

Jan Hesters
CTO | ReactSquad
LinkedIn: https://www.linkedin.com/in/jan-hesters/
Mobil: +49 157 89577653 | E-Mail: jan@reactsquad.io
https://www.reactsquad.io

EarlyNode GmbH
Engelbertstraße 33
52078 Aachen
Deutschland

Geschäftsführer: Nikolas Chapoupis-Mertens
Handelsregister: Amtsgericht Aachen | HRB 21731
USt.-ID: DE317573558
Impressum: https://www.reactsquad.io/imprint

Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtümlich erhalten haben, informieren Sie bitte den Absender und löschen Sie diese E-Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser E-Mail und der darin enthaltenen Informationen sind nicht gestattet.
```

### Jan: English email

```text
Best regards,

Jan Hesters
CTO | ReactSquad
LinkedIn: https://www.linkedin.com/in/jan-hesters/
Mobile: +49 157 89577653 | Email: jan@reactsquad.io
https://www.reactsquad.io

EarlyNode GmbH
Engelbertstraße 33
52078 Aachen
Germany

Managing Director: Nikolas Chapoupis-Mertens
Commercial Register: Local Court Aachen | HRB 21731
VAT ID: DE317573558
Imprint: https://www.reactsquad.io/imprint

This email contains confidential and/or legally protected information. If you are not the intended recipient or have received this email in error, please notify the sender and delete this email. Unauthorised copying, as well as the unauthorised disclosure of this email and the information contained therein, is not permitted.
```

For emails sent by Nikolas, use the following personal details with the legal footer and confidentiality notice from the matching language block above. Do not copy Jan's personal details. If a required personal contact detail is missing, ask the user instead of guessing.

```text
Nikolas Chapoupis-Mertens
CEO & Managing Director | ReactSquad
nikolas@reactsquad.io | https://www.reactsquad.io
```

In HTML or rich-text email, render the confidentiality notice in a smaller font and italics. Use `font-size: 10px; font-style: italic; color: #666666;` when HTML styling is available.

Do not send or draft an SDR-sourced external email without the complete language-matched signature. Do not include a confidentiality notice in a language different from the email.

## Printing

constraint Printing {
  Plain `lp` prints tiny on the Canon MG4200 (driverless IPP) — always force the paper size: `lp -o media=A4 -o fit-to-page <file>`.
  The Canon also silently drops text in some embedded fonts (e.g. bank form fill-ins) — if content is missing from a printout, rasterize first: `pdftoppm -png -r 300` → `img2pdf`/`magick` → print the image PDF.
}

## Todos

Personal todos live in **Taskwarrior** (`task` CLI; `taskwarrior-tui` for an interactive board). Drive everything through the `task` command — never hand-edit `~/.task/`.

Tasks {
  add(desc, priority?, due?, project?, tags?) => `task add "$desc" [priority:H|M|L] [due:$date] [project:$project] [+$tag]`
  list   => `task next`        // urgency-ranked view
  done(id)   => `task $id done`
  drop(id)   => `task $id delete`
  edit(id, …)=> `task $id modify …`

  Priority ∈ { H, M, L, none }.
  due accepts natural forms: due:today, due:tomorrow, due:friday, due:eod, due:2026-06-25.
  Ranking in `task next` = computed urgency (priority + due + age + tags), not a manual sort.
}

constraint TodoIntake {
  Never guess priority or deadline — ask.
  If an item's meaning is ambiguous or underspecified (e.g. a terse label like "Post checken"), ask what it refers to before adding, so the stored task is self-explanatory later.
  On a pasted batch: ask once (batched, not item-by-item spam) for each item's priority (H/M/L/none) and whether it has a deadline/delivery time + when, vs. a plain "need to do this". Only fall back to no-priority/no-due after the user declines.
  On a single later add: ask where it sits in the priority order — capture as priority level, and when finer ranking is needed set a `due` date to position it relative to neighbours.
  Disambiguate "schedule" / "scheduled today" — it carries several meanings; identify which before acting (ask if unclear):
    1. defer in the tracker — set the task's `due`/`scheduled` to a later day (pure todo tracking).
    2. do it today, send later — produce the artifact today (message/email/code), schedule it to go out (send/PR) on a future day => `due:today` + annotate "schedule the send for <day>".
    3. like 2 but it goes out later *today* => `due:today` + annotate the send time.
    4. book a calendar event/meeting (e.g. "schedule a call") => create via Calendar (MCP), not a todo.
  Fold rich context into the task as annotations, including tool hints (about email => Gmail via MCP; about Slack => Slack via MCP; relevant links, names, the next concrete step) so the task stays actionable later without re-deriving context.
  After any change, show the resulting `task next` so the user sees the new ranking.
}

## Personal Repos

- **`~/dev/dotfiles`** — GNU Stow packages for config file overrides (`~/.config/hypr/`, `~/.config/espanso/`, etc.). Use for files that can be fully owned by the user and symlinked into `~/.config/`. Not suitable for shared files like `mimeapps.list` that other tools also write to.
- **`~/dev/omarchy-supplement`** — Idempotent install scripts for post-Omarchy setup (packages, key remapping, default apps, web apps, themes, etc.). Use for imperative actions like `xdg-mime default`, package installs, or anything that modifies shared system state.
