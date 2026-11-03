# Post 01 — Architecture before UI

- **Series:** Week 0 · Episode 01
- **Pillars:** Engineering decisions (primary), honest process
- **Goal:** establish technical credibility, make the repo the CTA, not the post
- **Assets needed:** folder-tree screenshot, the layer diagram, 10-slide carousel
- **Publish:** LinkedIn Tuesday 09:00 · Instagram Wednesday 18:00 (carousel) + 3 stories

---

## LinkedIn — main post

> Copy from the line below. Do not add a link in the body; it goes in the first comment.

---

I wrote 9 architecture decision records before writing a single widget.

Not for documentation. For leverage.

Every Flutter project starts the same way: `flutter create`, one screen, another screen, then a `utils.dart` with 400 lines and a `Manager` that manages everything.

Six weeks later nobody remembers why the database is Hive, why state is handled three different ways, or why the app dies when it loses signal.

So this time I wrote the decisions down first. One page each: the context, the choice, what I rejected, and what it costs me.

01 Record every decision — future me is a stranger
02 Feature-first clean architecture — domain never imports Flutter
03 Bloc/Cubit — a live run is a 6-state machine, not a boolean
04 Offline-first with Drift — local is the source of truth, not a cache
05 go_router — the web showcase needs real URLs
06 geolocator + foreground task — a run must survive a locked screen
07 flutter_map over Google Maps — no API key, no billing, one code path
08 ARB + full RTL — Arabic is a test, not a checkbox
09 get_it, manual wiring — the dependency graph should be readable

Nine pages before the first widget.

The trade-off is real: my first session produced zero pixels. But weeks 2–8 don't get to renegotiate structure, and every "why is it like this?" has a file to point at.

Architecture isn't the diagram. It's the list of decisions you can defend.

I'm building Sleman Runs in public for 8 weeks — real GPS tracking, offline-first, English + Arabic. Repo in the comments.

What would you add to the list — or cut?

#Flutter #CleanArchitecture #BuildInPublic #MobileDevelopment

---

## First comment (post within 2 minutes)

Repo: https://github.com/SlemanDayoub7/sleman-runs

The architecture doc and all 9 ADRs are in `docs/`. Happy to talk about Flutter roles — DMs open.

## Hook variants (A/B if the first underperforms)

1. `9 documents. 0 widgets.`
2. `I spent day one of a Flutter project writing no Flutter.`
3. `The most useful file in my Flutter repo has no code in it.`

## Expected pushback, and the replies

| Comment | Reply |
| --- | --- |
| "This is over-engineering for a small app." | "For a to-do app, yes. A GPS run has a 6-state machine, a database, a foreground service and two languages. The ADRs took 3 hours and they're why the folder tree hasn't changed." |
| "ADRs are corporate theatre." | "They're 1 page each and they're the only reason I remember why flutter_map beat Google Maps. Also: they're free interview prep." |
| "Why not Riverpod?" | "Better tool, wrong market. Bloc is what the job listings ask for, and I'm optimizing for hiring. ADR-0003 says exactly that." |
| "Show the code." | "Week 1. Right now the repo is docs + CI + a roadmap." |

---

## Instagram — carousel (1080 × 1350, 10 slides)

| # | Text on slide | Visual |
| --- | --- | --- |
| 1 | **9 decisions before the first widget** | Big type on Ember `#E8452A`, small "Sleman Runs · Ep 01" |
| 2 | "Every Flutter project starts the same way." | Three stacked code-ish blocks: `main.dart`, `utils.dart`, `manager.dart` |
| 3 | "Six weeks later, nobody remembers why." | Faded folder tree with 3 question marks |
| 4 | **The format is 1 page.** Context · Decision · Alternatives · Consequences | 4 boxes, one per line |
| 5 | The folder tree | Real screenshot of `lib/` at 2× zoom, monospace |
| 6 | **The 3 that matter** — Bloc for a 6-state run · Drift as source of truth · ARB + RTL | 3 cards, one accent color each |
| 7 | **What I rejected.** Google Maps · Riverpod · Hive | Strikethrough text, muted |
| 8 | "Hour 1 produced zero pixels." | Empty phone mockup, subtle grid |
| 9 | **Architecture isn't the diagram. It's the decisions you can defend.** | Full-bleed statement slide |
| 10 | "Building in public · 8 weeks · repo in bio" | Handle + app icon |

Caption:

```
9 architecture decision records. 0 widgets.

Every Flutter project I've rushed started with screens and ended with a utils.dart nobody wants to open.

So I wrote the decisions down first: one page each, with what I rejected and what it costs.

The first hour produced zero pixels. Weeks 2–8 have a structure they can't argue with.

Building Sleman Runs in public for 8 weeks: real GPS, offline-first, English + Arabic.

Repo in bio. What would you add to the list?

#flutter #flutterdev #buildinpublic #cleancode #appdevelopment
```

## Stories (post 3 frames the same day)

1. Folder-tree screenshot → "Day 1. No code yet."
2. Carousel slide 4 (the ADR format) → "Should I make these public as I go?"
3. Poll: "ADRs before code — worth it or overthinking?" · Worth it / Overthinking

---

## Arabic version (optional — for the local network)

Use it as a separate post, not a translation buried in the comments.

> كتبت ٩ قرارات معمارية قبل أن أكتب أول ويدجت.
>
> ليس للتوثيق، بل لتوفير الوقت.
>
> كل مشروع Flutter يبدأ بنفس الطريقة: شاشة، ثم شاشة أخرى، ثم ملف utils بـ ٤٠٠ سطر و"Manager" يدير كل شيء.
>
> بعد ستة أسابيع لا أحد يتذكر لماذا اخترنا Hive، ولا لماذا تُدار الحالة بثلاث طرق، ولا لماذا يتوقف التطبيق عند فقدان الشبكة.
>
> هذه المرة كتبت القرارات أولًا: صفحة واحدة لكل قرار — السياق، الاختيار، البدائل المرفوضة، والتكلفة.
>
> التسعة قرارات: بنية نظيفة، Bloc، Drift للعمل دون اتصال، go_router، geolocator، flutter_map، تعريب كامل مع RTL، وget_it.
>
> المقايضة واضحة: الساعة الأولى لم تُنتج أي واجهة. لكن الأسابيع ٢–٨ لن تعيد النقاش حول البنية.
>
> المعمارية ليست الرسم، بل قائمة القرارات التي تستطيع الدفاع عنها.
>
> أبني Sleman Runs علنًا لمدة ٨ أسابيع: تتبع GPS حقيقي، عمل دون اتصال، عربي وإنجليزي. الرابط في التعليق الأول.

---

## Visual specs

- Palette: background `#0B0F14` (dark set) or `#F7F8FA` (light set); do **not** mix sets in one carousel.
- Type: Manrope 700 for statements (96 px top, 72 px mid), Manrope 500 at 40 px for body, JetBrains Mono for code at 32 px.
- Margins 96 px; one idea per slide; max 14 words per slide.
- Export: 1080 × 1350 PNG, sRGB, under 1 MB each. Same template every episode — the series should be recognizable in the feed.

## Tone rules

- No "I'm thrilled/excited to announce".
- No "game-changer", "revolutionize", "10x".
- Numbers over adjectives.
- Name the cost of every decision — that's what makes it credible.
- End with a question that a senior dev would actually answer.

## Publishing checklist

- [ ] Carousel exported and proofread on a phone, not the desktop editor
- [ ] First line is readable without clicking "…see more" (under ~140 characters)
- [ ] Link in the first comment, not the body
- [ ] Repo is public and the README renders (check on mobile)
- [ ] Reply to every comment within the first hour
- [ ] Log impressions + profile views in the weekly numbers doc on Sunday
