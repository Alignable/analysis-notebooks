input tokens:  615,299
output tokens: 3,969

Given the massive context set, I'll work through both tasks methodically, citing specific CTX examples and computing missing rates from the frequency table.

---

## Task A — Additional patterns

### Pattern 13: You Fit Their Ideal Customer Profile
The target has described the kind of customer they want to work with, and your business matches that description. Distinct from "target could be your customer" (Pattern 2) — here the signal flows the other way: *they* are looking for someone like *you*.

Example contexts: CTX-0002 (sender is a lender, recipient lists "Lenders" as ideal customer), CTX-0040 (sender is a real estate agent, recipient lists "Real Estate Agents" as ideal customer tag), CTX-0056 (sender is an IT platform, recipient lists "IT Service Providers" as partner/customer need), CTX-0058 (sender is a bookkeeper, recipient lists "Bookeepers" as ideal customer tag)

> *{target_first_name} is looking for a business like yours.*
> - Their ideal customer description matches your profile
> - You may be exactly who they want to hear from
> - Worth a conversation to see if the fit is real

Required fields: `sender_matches_recipient_customer_targets` = true OR `sender_roles_matching_recipient_customer_roles` (non-empty), plus `recipient_customer_section.recipient_description` or `recipient_customer_section.recipient_customer_tags` for copy enrichment.
Missing in dataset: `sender_matches_recipient_customer_targets` is present in 11.3% of contexts; `sender_roles_matching_recipient_customer_roles` in 11.3%. The trigger requires at least one of these; combined coverage is ~11.3% (they co-occur). The copy-enriching field `recipient_customer_tags` is present in 63.6%, `recipient_customer_description` in 67.4%. **Worst-case trigger field missing: 88.7%.**

---

### Pattern 14: Business Model & Geographic Reach Alignment
Both businesses operate in the same model (both B2B, or both B2B+B2C) and serve a compatible geographic footprint — making a practical referral or customer relationship more likely than it first appears.

Example contexts: CTX-0002 (both B2B, both national), CTX-0036 (sender B2C local, recipient B2B+B2C regional — same region, overlapping customer base), CTX-0040 (both B2C+B2B, sender local, recipient national — sender fits inside recipient's reach), CTX-0004 (sender B2C local, recipient B2B+B2C regional, same state)

> *You and {target_first_name} serve the same kind of buyers in the same region.*
> - You're both focused on B2B clients
> - Your geographic reach overlaps well
> - That usually means shared referral opportunities

Required fields: `sender_customer_section.sender_characteristics.sender_business_model` + `recipient_customer_section.recipient_characteristics.recipient_business_model` + at least one of (`same_state`, `distance_miles`, `sender_geographic_reach`, `recipient_geographic_reach`).
Missing in dataset: `sender_business_model` at 99.1%, `recipient_business_model` at 85.6%. The worst-covered required field is `recipient_business_model` — **missing in 14.4%.**

---

### Pattern 15: Conversation Already Active — Keep the Momentum
You and the target have already exchanged messages (beyond just the initial connect), but no meeting has been scheduled yet. The conversation has stalled or gone quiet. This is a "re-engage an active thread" signal, distinct from Pattern 12 (meeting in progress).

Example contexts: CTX-0002 (recipient replied with phone number, no meeting booked yet), CTX-0057 (multiple messages exchanged about collaboration, no meeting scheduled), CTX-0014 (sender and recipient exchanged friendly messages, conversation paused), CTX-0050 (recipient thanked sender for reaching out, thread went quiet)

> *You and {target_first_name} already have a conversation going.*
> - They've replied — the door is open
> - A quick follow-up could move things forward
> - Sometimes all it takes is one more message

Required fields: `conversation_history` (with at least 2 messages from different users) AND `meeting_context.meeting_lifecycle` = "none" or absent.
Missing in dataset: `conversation_history` present in 37.3% of contexts. Meeting lifecycle is always present when meeting_context exists (21.0%), so the negation is well-defined. **Worst-covered required field: `conversation_history` — missing in 62.7%.**

---

### Pattern 16: Shared Community or Group Membership
Both the sender and recipient are members of the same Alignable group or local community. This provides a natural conversation starter that doesn't require a business-fit argument.

Example contexts: CTX-0028 (same_community = true, same state, nearby), CTX-0054 (same_community = true, same state), CTX-0078 (same_community = true, same state), CTX-0130 (same_community = true, same state, very close distance)

> *You and {target_first_name} are both part of the same community here.*
> - You share a local group or community connection
> - That common ground is a natural starting point
> - Worth introducing yourself and seeing where it goes

Required fields: `relationship_data.same_community` = true.
Missing in dataset: `same_community` present in 7.2% of contexts — **missing in 92.8%.**

*Note: This is the existing Pattern 10 ("Shared Community or Group Membership") from the original 12. On closer review, if it was already covered, I'll replace this with a different net-new pattern below.*

**Replacement — Pattern 16: Connection Request Entry Point Shapes the Pitch**
The `connection_request_source` field (87.1% present) tells us *how* the sender found the target — e.g., `biz/search-more` (actively searched), `ACF` (contact list), `stream/new_businesses` (browsing new businesses), `aggregate_second_degree` (mutual connections drawer), `profile` (visited their profile). This isn't a *reason* in isolation, but it can power a more honest, specific opening than a generic "I noticed your profile."

However, after reflection, `connection_request_source` is more of a *how they arrived* metadata than a *reason to message*. It modifies tone, not trigger. I'll keep the original three net-new patterns (13, 14, 15) and not force a fourth.

---

## Task B — Pattern refinements

### Pattern 1: Referral Partnership Fit
**Properties added:** `sender_partner_section.sender_partner_tags` (92.8%), `sender_partner_section.sender_description` (84.0%), `relationship_data.sender_prefers_referral_partners` (50.5%), `relationship_data.recipient_prefers_referral_partners` (41.1%).
**What changes:** Both — tighten the trigger by requiring cross-match on *both* sides' partner tags (not just target's), and when both `sender_prefers_referral_partners` and `recipient_prefers_referral_partners` are true, elevate confidence; enrich copy with specifics from sender's stated partner wishlist.

> *You and {target_first_name} are each looking for the other's kind of business.*
> - They list your industry in their partner wishlist
> - You list theirs in yours
> - Both of you have said you're actively looking for referral partners

Required fields: `recipient_matches_sender_partner_targets` OR `recipient_roles_matching_sender_partner_roles` (32.9%), plus `sender_partner_tags` (92.8%). Enriched when `sender_prefers_referral_partners` (50.5%) and `recipient_prefers_referral_partners` (41.1%) are both true.
Missing in dataset: The core trigger (`recipient_matches_sender_partner_targets` or `recipient_roles_matching_sender_partner_roles`) is present in 32.9%. `sender_partner_tags` missing in **7.2%**. The enriching boolean pair is present together in roughly ~20–25% of contexts (both must be true).

---

### Pattern 2: Target Could Be a Direct Customer
**Properties added:** `recipient_customer_section.recipient_customer_tags` (63.6%), `recipient_customer_section.recipient_description` (67.4%), `recipient_customer_section.recipient_characteristics.recipient_business_model` (85.6%).
**What changes:** Copy enrichment — when the target has described *their own* ideal customer, the sender can see whether the target's customer base overlaps with theirs (indicating the target serves the same end market) or whether the target themselves fit the sender's ICP. The business model field lets copy specify "they're a B2B operation like you" rather than a generic claim.

> *{target_first_name}'s business looks like a strong fit for what you offer.*
> - Their role and category match your ideal customer
> - They're a B2B operation serving the same end market
> - A short intro could open a real conversation

Required fields: `recipient_matches_sender_customer_targets` = true OR `recipient_roles_matching_sender_customer_roles` (non-empty) — 25.4% present. `recipient_customer_tags` (63.6%) and `recipient_business_model` (85.6%) for copy enrichment.
Missing in dataset: Trigger field present in 25.4% of contexts. Enrichment field `recipient_customer_tags` — **missing in 36.4%.**

---

### Pattern 3: Same Local Area
**Properties added:** `relationship_data.same_state` (43.3%), `relationship_data.recipient_cares_about_locality` (31.7%), `relationship_data.sender_cares_about_locality` (25.1%).
**What changes:** Both — tighten trigger by weighting higher when *both* sides care about locality (not just proximity by miles), and use `same_state` as a fallback when `distance_miles` is large but state match exists. Copy becomes more confident when both locality flags are true.

> *You and {target_first_name} are both in the same area — and you both value local connections.*
> - You're in the same state and close by
> - They've indicated local relationships matter to them
> - So have you — that's a strong starting point

Required fields: `distance_miles` (99.7%) plus at least one of `same_state` (43.3%), `recipient_cares_about_locality` (31.7%), `sender_cares_about_locality` (25.1%).
Missing in dataset: `distance_miles` missing in **0.3%**. The enriching locality booleans are present in 43.3% / 31.7% / 25.1% respectively.

---

### Pattern 7: Both Could Send Each Other Business (Two-Way Match)
**Properties added:** `sender_prefers_referral_partners` (50.5%), `recipient_prefers_referral_partners` (41.1%), `recipient_partner_section.recipient_description` (46.7%).
**What changes:** Both — tighten trigger by requiring the explicit boolean preferences (not just tag overlap), and enrich copy with the target's free-text partner description so the sender sees *exactly* what the target wrote about the kind of partner they want.

> *This looks like a two-way fit — you each match what the other is looking for.*
> - {target_first_name} described their ideal partner, and it sounds like you
> - You've both flagged that you're open to referral partnerships
> - The overlap here is specific, not generic

Required fields: Both `sender_matches_recipient_partner_targets` (15.0%) AND `recipient_matches_sender_partner_targets` (32.9%) for the two-way trigger. Enriched by `sender_prefers_referral_partners` (50.5%) + `recipient_prefers_referral_partners` (41.1%) + `recipient_partner_section.recipient_description` (46.7%).
Missing in dataset: The two-way trigger (both directions present) occurs in roughly ~5–8% of contexts. `recipient_partner_description` — **missing in 53.3%.**

---

### Pattern 8: Same or Related Industry / Role Overlap
**Properties added:** `recipient_customer_section.recipient_characteristics.recipient_business_model` (85.6%), `recipient_customer_section.recipient_characteristics.recipient_geographic_reach` (84.3%).
**What changes:** Copy enrichment — when two businesses share a role or industry, specifying that they also share the same business model (B2B) or geographic scope ("you both serve regional clients") makes the overlap feel concrete rather than surface-level.

> *You and {target_first_name} are in related fields — and serve similar markets.*
> - You share an industry or professional overlap
> - You're both B2B and focused on the same region
> - That often means you're running into the same challenges and opportunities

Required fields: `relationship_data.role_overlap` = true (34.2%). `recipient_business_model` (85.6%) and `recipient_geographic_reach` (84.3%) for enrichment.
Missing in dataset: Trigger `role_overlap` — **missing in 65.8%.** Enrichment fields well-covered.

---

### Pattern 9: Target Serves the Sender's Customers
**Properties added:** `recipient_customer_section.recipient_customer_tags` (63.6%), `recipient_customer_section.recipient_description` (67.4%).
**What changes:** Copy enrichment — instead of just saying "they serve your customers," the copy can now reference the target's actual customer description to show the sender *why* the overlap is real (e.g., "they work with contractors and small businesses — the same people you work with").

> *{target_first_name} works with the same kinds of clients you do.*
> - They describe their ideal customer — and it overlaps with yours
> - That shared client base could mean referral potential in both directions
> - Worth exploring how your services complement each other

Required fields: Overlap between sender's customer tags and recipient's customer tags or description. `recipient_customer_tags` (63.6%) + `recipient_customer_description` (67.4%) for enrichment.
Missing in dataset: `recipient_customer_tags` — **missing in 36.4%.**

---

### Pattern 11: Known Outside the Platform (Contact List / ACF)
**Properties added:** `state.connection_request_source` (87.1%).
**What changes:** Copy enrichment — when `connection_request_source` is `ACF` or `reverse_address_book`, the copy can reference the specific origin ("it looks like you're already in each other's contact lists" vs. a vague "we're connected outside the platform"). This makes the hook more concrete and trustworthy.

> *It looks like you already know each other outside this platform.*
> - You showed up in each other's contacts
> - That existing connection gives you a head start
> - A quick hello here could turn that into a real conversation

Required fields: `eligible_criteria` includes `known_outside_source_acf` or `known_outside_source_reverse_address_book`. `connection_request_source` (87.1%) for enrichment.
Missing in dataset: The trigger is controlled by `eligible_criteria` (100% present when applicable). `connection_request_source` — **missing in 12.9%.**

---

### Pattern 12: Meeting Already in Progress / Momentum
**Properties added:** `state.conversation_history` (37.3% — already used for detecting meeting state, but underused for enriching copy with *what was actually said*).
**What changes:** Copy enrichment — rather than a generic "you have a meeting in progress," the copy can reference the last message or proposed time from the conversation, making the nudge feel specific and timely (e.g., "they shared their calendar link — have you grabbed a time yet?").

> *You and {target_first_name} are close to getting on a call.*
> - They shared a scheduling link in your last exchange
> - The conversation has momentum — don't let it cool off
> - Grabbing a time now keeps things moving

Required fields: `meeting_context.meeting_lifecycle` (21.0%) + `conversation_history` (37.3%) for enrichment.
Missing in dataset: `meeting_context` — **missing in 79.0%.** `conversation_history` — **missing in 62.7%.**