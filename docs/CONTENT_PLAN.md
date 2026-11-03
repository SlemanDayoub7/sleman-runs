# Content plan — build in public

The app is the proof. The posts are the distribution. This file is the calendar, the templates and the conversion plan, so posting never depends on inspiration at 11 pm.

---

## 1. Positioning

> **"I'm building a production-grade Flutter running app in public — clean architecture, offline-first, Arabic RTL, real GPS. 8 weeks, everything documented."**

Why this positioning works:

- **Specific stack** → recruiters can match it to a job description.
- **Constraint (8 weeks)** → shows delivery, not endless perfectionism.
- **Unusual detail (Arabic RTL + GPS)** → stands out from the 10 000 to-do-list clones.
- **Public process** → you are evaluated on judgment, which is what hiring actually is.

Supporting bio line: *Flutter developer — building [Sleman Runs] in public. Clean architecture, Bloc, offline-first.*

---

## 2. Two audiences, two jobs

| | LinkedIn | Instagram |
| --- | --- | --- |
| Audience | Hiring managers, tech leads, agency owners, recruiters | Developers, runners, design-curious, local network |
| Job | Prove judgment and communication | Prove the product is real and you can ship |
| Format | Text + diagram/carousel, 900–1 400 chars | Reels 15–30 s, carousels, stories |
| Frequency | 2×/week (Mon, Thu, 8:30–9:30 local) | 3×/week (Tue, Fri, Sun) + story most days |
| CTA | "Happy to talk about Flutter roles — DMs open" | "Follow the build" / "Watch the demo (link in bio)" |

Never post the same caption twice. Same idea, different shape: LinkedIn gets the *why*, Instagram gets the *what it looks like*.

---

## 3. Content pillars

1. **Engineering decisions** (LinkedIn) — architecture, trade-offs, rejected options. Highest hiring value.
2. **Visible progress** (Instagram) — screen recordings, before/after, theme toggle, RTL switch.
3. **Honest process** (both) — bugs, dead ends, what I'd do differently, weekly metrics.

Ratio per month: 50% pillar 1, 30% pillar 2, 20% pillar 3.

---

## 4. Calendar — 8 weeks

Week 0 content is written **before** the first line of code, so the series starts with momentum.

| # | Week | Post | Hook (first line) |
| --- | --- | --- | --- |
| 01 | 0 | Architecture before UI | "I wrote 9 architecture decision records before writing a single widget. Here's the folder structure I'll live with for 8 weeks." |
| 02 | 0 | The plan | "8 weeks. 1 Flutter app. Everything public. Here's the roadmap — and the 3 things I'm cutting." |
| 03 | 1 | Theme + RTL system | "Dark mode is not a color swap. It's 14 tokens, 4 test modes, and zero `if (isDark)` in your widgets." |
| 04 | 1 | Repo as portfolio | "Your GitHub repo is your interview. Branches, PR templates, CI gates, ADRs — the boring parts that get you hired." |
| 05 | 2 | Design tokens | Carousel: "Why I moved every color out of my widgets." |
| 06 | 2 | First screen | Reel: theme toggle → Arabic toggle → mirrored layout, 20 s, no voice, captions. |
| 07 | 3 | Offline-first | "Offline-first isn't a feature. It's a constraint you accept on day one — or pay for in week 9." |
| 08 | 3 | Schema tour | Carousel: 6 tables, one diagram, the `sync_queue` trick that makes v2 possible. |
| 09 | 4 | GPS filtering | "Your phone lies to you 30% of the time. Here's the filter that fixes it." |
| 10 | 4 | Permission UX | "The permission screen nobody designs — and why denial is a first-class state." |
| 11 | 5 | Live tracking | Reel: start run → map draws → pause → notification. 25 s. |
| 12 | 5 | Crash recovery | "I force-killed my app mid-run on purpose. It recovered. Here's the 5-second flush." |
| 13 | 6 | History + splits | Carousel: pace zones explained with real splits from a 10K. |
| 14 | 6 | Bug post-mortem | "This bug only appeared after 4 km. Here's how I found it." |
| 15 | 7 | Stats | "Weekly volume, streaks, PRs — all in SQL, no backend." |
| 16 | 7 | Scope discipline | "Everyone told me to add a web demo and ship iOS. I did neither. Here's the math." |
| 17 | 7 | SOLID in real files | Carousel: 5 principles, 5 real file paths, 5 screenshots. |
| 18 | 8 | Launch | "v1.0 is out. 8 weeks, 61 PRs, X tests, 2 languages, 1 GPS pipeline." |
| 19 | 8 | Retro + numbers | "What I got wrong: 3 architectural mistakes and what they cost." |
| 20 | 8 | Hiring CTA | "I'm looking for a Flutter role. Here's what I can do — and the repo that proves it." |

Batch production: record all visual assets for a week on Sunday in one 90-minute session. Write the two LinkedIn posts on Monday morning while the demo is fresh.

---

## 5. Templates

### LinkedIn post (engineering pillar)

```
[Hook: one sentence, no hashtags, no "I'm excited to announce"]

[2–3 sentences of context: the problem and why it's non-obvious]

[The decision, numbered if possible]
1. ...
2. ...
3. ...

[The trade-off you accepted — this is the part that proves seniority]

[One line on what changed in the code/product]

[CTA: a question, or "repo in comments", or "open to Flutter roles"]

#Flutter #CleanArchitecture #MobileDevelopment #BuildInPublic
```

Rules: one idea per post, short paragraphs (1–3 lines), no link in the body (put it in the first comment), emoji only as bullets or not at all, hashtags 2–4 not 12.

### Carousel (8–10 slides)

1. Hook — the claim, big type.
2. The problem — what most codebases do.
3. Why it hurts — concrete consequence.
4. Option A / Option B — two columns.
5. The decision — one sentence.
6. The code — 8 readable lines maximum, real file.
7. The result — screenshot or metric.
8. The trade-off — what you gave up.
9. Takeaway — one sentence someone can repeat.
10. CTA + handle.

Design: app palette, one font, slide numbers, 1080×1350, exported from Figma templates reused every week.

### Reel (15–30 s, no talking)

```
0–2 s   Hook text on screen: the surprising claim
2–6 s   Problem state (wrong/broken/plain)
6–18 s  Demo: the real app, real taps, real GPS
18–25 s The detail that makes it credible (test passing, code, diagram)
25–30 s CTA: "Follow the build" / "v1.0 in 3 weeks"
```

Captions burned in (most people watch muted), trending-but-relevant audio only, screen recording at 60 fps, no shaky handheld footage.

### Story sequence (daily, 3 frames)

1. Today's commit or screen.
2. One sentence of context.
3. Poll or question ("Dark or light?" / "Should I add intervals next?").

---

## 6. Profile setup (do this in week 0)

**LinkedIn**
- Headline: `Flutter Developer · Building an offline-first running app in public · Clean Architecture, Bloc, RTL`
- Banner: app screenshot + "8 weeks. 1 app. All public."
- Featured: repo link, demo link, launch post, case study PDF.
- About: 4 short paragraphs — what you build, how you build it, proof links, what you're looking for.
- Open to work: Flutter/Android roles, on-site + remote, with a note referencing the build.

**Instagram**
- Handle close to the brand; bio: `Building a running app in public 🏃 · Flutter · EN/AR · v1.0 in 8 weeks`
- Link in bio → GitHub repo (or a simple link page).
- Highlights: `Architecture`, `UI`, `Bugs`, `Numbers`, `Demo`.
- Reuse the app's palette for all graphics so the feed looks like the product.

**GitHub**
- Profile README linking the repo, the series and the demo.
- Pin the repo once v0.3 lands.

---

## 7. Numbers to track weekly

| Metric | Why |
| --- | --- |
| Commits / PRs merged | Proves cadence on the repo graph |
| Test count + coverage % | Concrete quality signal |
| LinkedIn impressions → profile views → DMs | Does it reach hiring managers? |
| Instagram saves + shares | Better than likes for reach |
| Repo stars / unique visitors | Weak but public proof |
| Inbound conversations | The only metric that pays |

Review in 10 minutes every Sunday. If profile views rise but DMs don't, the CTA or the featured section is the problem, not the content.

---

## 8. Converting attention into work

Posting alone rarely lands a job. Pair it with deliberate outreach.

- **Weekly:** 5 targeted messages — CTOs/leads at companies using Flutter, agency owners, recruiters who post Flutter roles.
- **Message template:**

  > Hi [name] — I'm building an offline-first running app in Flutter in public (clean architecture, Bloc, Arabic RTL, real GPS tracking). Week 5 demo: [link]. I'm looking for a Flutter role where this kind of work matters. Worth a 15-minute chat?

- **Attach the case study, not the CV.** 2 pages: problem, architecture diagram, 3 hard problems and how they were solved, demo link, what you'd do next.
- **Apply with the project:** every application links the repo and the 3-minute demo video.
- **Ask for the retro:** after a rejection, ask what was missing. Two out of ten answer, and those answers are worth more than the posts.

---

## 9. Launch checklist (week 8)

- [ ] Demo video plays inline on LinkedIn and Instagram (captions burn-in, sound off)
- [ ] README has GIF, demo video, architecture diagram, series index
- [ ] Case study PDF exported and attached to LinkedIn featured
- [ ] 3-minute demo video (screen recording + captions, no talking head required)
- [ ] CV updated with the project as the first entry, with metrics
- [ ] Launch post scheduled for Tuesday 9:00 and cross-posted to Instagram
- [ ] 10 target companies listed, 5 messages sent on launch day
- [ ] Retro drafted while the details are still painful
