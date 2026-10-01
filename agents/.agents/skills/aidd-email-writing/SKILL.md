---
name: aidd-email-writing
description: Write, reply to, revise, or review emails for Jan. Read the full correspondence, decide whether a reply is needed, and present a concise, ready-to-copy draft with unresolved points and assumptions. Apply when asked to write or answer an email, including follow-ups and declines.
---

# Email writing

EmailWorkflow {
  read full correspondence -> decide whether an email is needed -> draft -> present for review

  constraint Precedence {
    These email-specific rules take precedence over conflicting general prose rules.
    Follow Jan's explicit instructions and later corrections.
  }
}

BeforeWriting {
  Read every relevant message in both directions, not only the latest message or search excerpts.
  Read relevant attachments before drafting or asking Jan for information.
  If the full correspondence is inaccessible, ask Jan to paste it before drafting a reply or follow-up.
  For a new outbound email, use Jan's brief and any relevant prior correspondence; do not invent a history.
  When using Gmail, first read [references/gmail.sudo.md](references/gmail.sudo.md).

  constraint Context {
    Ask no question already asked or answered. Do not repeat information the recipient already has.
    For an unanswered question, briefly refer to the earlier email by its verified date instead of listing everything again.
    Example: "As in my email of 21 September, ..." only if that email exists.
    Distinguish proposals, requests, confirmed agreements, and unresolved points.
    Do not turn interest or a request into an offer, acceptance, availability, or commitment.
  }

  replyNeeded => match (correspondence) {
    case (other party is already due to act, a follow-up would duplicate an earlier email,
          or known leave or holidays make a follow-up premature) =>
      tell Jan briefly why no email is needed; do not produce an unnecessary draft
    default => draft only what advances the current step
  }

  Consider the recipient's leave, holidays, and time zone. Verify any timing claim used to decide whether to write.
  Ask Jan only for material missing information the correspondence cannot resolve.
}

EmailDraft {
  structure = [
    greeting using the recipient's name,
    one concrete sentence responding to what the recipient last wrote or did,
    clearly stated request or purpose,
    details needed to act, such as an address, date, version, or attachment,
    sign-off
  ]

  constraint Relevance {
    Keep the email as short as possible. Include only what the recipient needs to act.
    For a new outbound email without prior contact, open with the concrete reason for writing.
    Do not invent a previous contribution to satisfy the opening sentence.
    Include personal information only when needed.
    Do not invent names, dates, amounts, versions, attachments, or commitments.
    Use exact numbers with units and currency, dates, version numbers, and attachment filenames when relevant.
  }

  constraint Questions {
    Present multiple necessary questions as a numbered list, with one question per item.
    Make each easy to answer with yes/no or a number when that fits the question.
    Refer to previously unanswered questions briefly; do not restate their whole checklist.
    Use courteous, clear requests. Explain real deadlines or boundaries briefly.
  }

  constraint Tone {
    Use the language Jan requests; otherwise match the correspondence's language, formality, Du/Sie, and length.
    If the recipient writes briefly, reply briefly. Use simple, short sentences without idioms for non-native speakers.
    Be warm, respectful, and considerate. Use natural, complete sentences and short paragraphs.
    Acknowledge the specific recent contribution; omit generic thanks, filler, exaggeration, and stock openings.
    Do not use "I hope you are well" or "Ich hoffe, es geht Ihnen gut".
    Add a friendly closing sentence only when sincerely meant and useful.
    If we caused a misunderstanding or inconvenience, acknowledge the specific mistake briefly and continue constructively.
    Declines: be brief and friendly, give one sentence of explanation, and thank the recipient.
  }

  signOff(language) => match (language) {
    case (German) => "Beste Grüße\nJan"
    case (English) => "Best regards\nJan"
    default => use the corresponding natural closing in the email's language, followed by Jan
  }

  Use only this short sign-off by default. Add a company footer only if Jan explicitly requests it.
}

Presentation {
  Before each draft, explain in 1-3 sentences its purpose, what is already settled, and what remains open.
  Then show the complete draft, ready to copy. Keep the explanation outside the email.
  After the draft, separately list any assumptions or missing details for Jan to check.
  Do not guess a date or number. Ask for essential facts first; label any remaining placeholder clearly.
  If there are no assumptions, say so briefly.
  For several emails, number the drafts. End with "No reply needed" or "Keine Antwort nötig",
  matching Jan's language, and list each thread needing no reply with a short reason.
}

Corrections {
  Apply Jan's corrections to the current draft and all later emails.
  Persist reusable preferences in this skill's canonical file, resolving symlinks before editing.
  Keep thread-specific factual corrections with their context; do not reuse that thread's facts in unrelated emails.
}

constraint Sending {
  Writing, answering, reviewing, or saving a draft is not permission to send.
  Never send until Jan explicitly says "send" or "senden", or gives an equivalent explicit send instruction.
  When using Gmail, also follow the final confirmation workflow in [references/gmail.sudo.md](references/gmail.sudo.md).
  Once the exact message is authorized under the applicable workflow, send and verify the result without asking again,
  unless its details change.
}
