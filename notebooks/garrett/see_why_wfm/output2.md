input tokens:  611,274
output tokens: 3,890

Given the massive dataset (319 contexts), I'll focus my analysis on identifying the strongest, most recurring reason-patterns and produce actionable copy. I'll sample broadly rather than read every field of every context exhaustively.

---

# Step 1 — Pattern Analysis

### 1. Referral Partnership Fit
The sender explicitly wants referral partners, and the target's role/category matches what the sender listed as an ideal partner type.

Example contexts: CTX-0001, CTX-0003, CTX-0013, CTX-0036, CTX-0047

---

### 2. Target Could Be a Direct Customer
The target's business role or category matches the sender's ideal customer description (e.g., sender sells to contractors, target is a contractor).

Example contexts: CTX-0002, CTX-0006, CTX-0016, CTX-0019, CTX-0048

---

### 3. Same Local Area
Both businesses are nearby (typically < 20 miles) and at least one cares about locality.

Example contexts: CTX-0005, CTX-0014, CTX-0022, CTX-0027, CTX-0064

---

### 4. Mutual Connections
The pair share a notable number of mutual connections on the platform.

Example contexts: CTX-0001, CTX-0003, CTX-0008, CTX-0086, CTX-0099

---

### 5. Met at a Networking Event (Online or In-Person)
They recently attended the same event, or were paired 1:1 during one and rated each other highly.

Example contexts: CTX-0005, CTX-0010, CTX-0011, CTX-0018, CTX-0037

---

### 6. Introduced by a Mutual Contact
A specific person recently introduced sender and target.

Example contexts: CTX-0001, CTX-0073, CTX-0095, CTX-0143, CTX-0210

---

### 7. Both Could Send Each Other Business (Two-Way Match)
Target matches sender's partner/customer criteria AND sender matches target's partner/customer criteria — a potential two-way referral or vendor relationship.

Example contexts: CTX-0002, CTX-0024, CTX-0036, CTX-0040, CTX-0058

---

### 8. Same or Related Industry / Role Overlap
Both businesses operate in the same or closely adjacent industry, creating natural collaboration or knowledge-sharing opportunities.

Example contexts: CTX-0006, CTX-0012, CTX-0034, CTX-0065, CTX-0049

---

### 9. Target Serves the Sender's Customers
The target's ideal customers overlap with the sender's existing clients — meaning the sender could refer business to the target.

Example contexts: CTX-0003, CTX-0056, CTX-0085, CTX-0105, CTX-0120

---

### 10. Shared Community or Group Membership
Both are in the same Alignable community, discussion group, or local chamber/alliance.

Example contexts: CTX-0028, CTX-0064, CTX-0078, CTX-0161, CTX-0190

---

### 11. Known Outside the Platform (Contact List / ACF)
The target was found in the sender's address book or auto-connected through an external source — suggesting a pre-existing offline relationship.

Example contexts: CTX-0007, CTX-0020, CTX-0035, CTX-0063, CTX-0079

---

### 12. Meeting Already in Progress / Momentum
The pair have already exchanged messages and expressed mutual interest in connecting further (proposed or scheduled meeting).

Example contexts: CTX-0004, CTX-0008, CTX-0010, CTX-0011, CTX-0024

---

---

# Step 2 — Copy Generation

### 1. Referral Partnership Fit
They list your type of business as an ideal referral partner.

**Variant A (no business name)**
> *They're actively looking for partners like you.*
- Their profile specifically lists your industry
- They want referrals flowing both ways
- Could mean steady introductions over time
- Required fields: target's partner tags, sender's business category
- Missing in dataset: ~5% (partner tags occasionally empty)

**Variant B (uses target business name)**
> *{target_business_name} is looking for partners like you.*
- They named your industry in their partner wishlist
- They're open to sending and receiving referrals
- This could become a consistent source of introductions
- Required fields: target business name, target's partner tags, sender's business category
- Missing in dataset: ~3% (target business name almost always present; partner tags rarely missing when match flagged)

---

### 2. Target Could Be a Direct Customer
Their business fits the profile of your ideal customer.

**Variant A (no business name)**
> *This business looks like a great fit for what you offer.*
- Their industry matches your ideal customer list
- They may already need your services
- A conversation could uncover a direct opportunity
- Required fields: sender's customer tags/description, target's business category
- Missing in dataset: ~5% (target category is almost always present)

**Variant B (uses target business name)**
> *{target_business_name} could be a great customer for you.*
- Their category matches your ideal customer profile
- They serve clients who likely need what you provide
- One conversation could open a new account
- Required fields: target business name, sender's customer tags, target's business category
- Missing in dataset: ~3%

---

### 3. Same Local Area
You're both nearby — local connections often turn into business.

**Variant A (no business name)**
> *They're in your area and could become a local ally.*
- Less than 20 miles from your business
- Local businesses often refer neighbors first
- Easier to meet in person or collaborate
- Required fields: distance_miles, sender/recipient location, locality caring flag
- Missing in dataset: ~10% (some pairs lack the "cares about locality" flag but distance is always present)

**Variant B (uses target business name)**
> *{target_business_name} is right in your neighborhood.*
- They're just a short drive away
- Local owners often prefer doing business nearby
- In-person connection is easy to arrange
- Required fields: target business name, distance_miles, locations
- Missing in dataset: ~3%

---

### 4. Mutual Connections
You share people in common — that often means trust is already building.

**Variant A (no business name)**
> *You already share mutual connections on the platform.*
- People you both trust are already in each other's network
- Shared contacts make warm introductions easy
- Common ground can fast-track a referral relationship
- Required fields: mutual_count (> 0)
- Missing in dataset: ~15% (mutual_count is 0 or absent in some pairs)

**Variant B (uses target business name)**
> *You and {target_business_name} share connections here.*
- Mutual contacts suggest overlapping circles
- Reaching out may feel familiar, not cold
- A shared connection could vouch for either of you
- Required fields: target business name, mutual_count
- Missing in dataset: ~15%

---

### 5. Met at a Networking Event
You recently connected at the same event — this keeps momentum going.

**Variant A (no business name)**
> *You both showed up to the same event recently.*
- You were at the same networking session
- Following up quickly can turn a handshake into business
- They already know your face or name
- Required fields: event attendance data (online or in-person events they attended)
- Missing in dataset: ~75% (only a minority of contexts include event data)

**Variant B (uses target business name)**
> *You and {target_business_name} were at the same event.*
- You crossed paths at a recent networking session
- A quick follow-up keeps the connection warm
- They're more likely to respond to someone they've seen
- Required fields: target business name, event attendance data
- Missing in dataset: ~75%

---

### 6. Introduced by a Mutual Contact
Someone you both know made this introduction — that carries weight.

**Variant A (no business name)**
> *A mutual contact just introduced you two.*
- Someone in your network thought you should connect
- Introductions from trusted people lead to real conversations
- There's likely a reason they thought of you both
- Required fields: introducer_name, has_recent_introduction flag
- Missing in dataset: ~92% (only a few contexts have this signal)

**Variant B (uses target business name)**
> *You were just introduced to {target_business_name}.*
- A shared contact saw a reason to connect you
- That vote of confidence raises your odds of a reply
- The groundwork for trust is already laid
- Required fields: target business name, introducer_name
- Missing in dataset: ~92%

---

### 7. Both Could Send Each Other Business (Two-Way Match)
You could be customers or partners for each other — a rare two-way fit.

**Variant A (no business name)**
> *This could go both ways — you each fit the other's needs.*
- They match your customer or partner profile
- You match theirs too
- Two-way referral relationships tend to stick
- Required fields: bidirectional match flags (sender_matches_recipient AND recipient_matches_sender)
- Missing in dataset: ~70% (bidirectional match is relatively uncommon)

**Variant B (uses target business name)**
> *You and {target_business_name} could help each other grow.*
- You fit their ideal customer or partner description
- They fit yours as well
- Mutual value means a stronger, lasting partnership
- Required fields: target business name, bidirectional match flags
- Missing in dataset: ~70%

---

### 8. Same or Related Industry / Role Overlap
You're in the same industry — that can mean collaboration, not just competition.

**Variant A (no business name)**
> *You're in the same space — that opens doors.*
- Industry peers often swap referrals and overflow work
- They understand your world without explanation
- Collaboration can be more profitable than competition
- Required fields: role_overlap flag or matching categories
- Missing in dataset: ~40% (role_overlap flag present in a meaningful minority)

**Variant B (uses target business name)**
> *{target_business_name} is in your industry — worth a conversation.*
- Peers in the same field share leads they can't serve
- They already speak your language
- Could become a go-to for overflow or joint projects
- Required fields: target business name, role_overlap flag
- Missing in dataset: ~40%

---

### 9. Target Serves the Sender's Customers
Their clients could become your clients — they may refer you naturally.

**Variant A (no business name)**
> *Their customers already need what you offer.*
- They serve people who are likely looking for you next
- A single referral conversation could open a pipeline
- Their trust with clients transfers to you
- Required fields: sender matches recipient's customer targets flag
- Missing in dataset: ~75% (this specific flag is less common)

**Variant B (uses target business name)**
> *{target_business_name}'s clients could become yours.*
- They work with people who need your services
- A referral from them carries built-in credibility
- One relationship could mean many introductions
- Required fields: target business name, sender_matches_recipient_customer_targets
- Missing in dataset: ~75%

---

### 10. Shared Community or Group Membership
You're in the same local community or group — that's built-in common ground.

**Variant A (no business name)**
> *You're part of the same community here.*
- Shared group membership means shared goals
- Community members tend to support each other
- You're already neighbors in the same digital space
- Required fields: same_community flag
- Missing in dataset: ~85% (same_community is present in a small fraction)

**Variant B (uses target business name)**
> *You and {target_business_name} share a community.*
- You're both members of the same group
- That common ground makes outreach feel natural
- Community members look out for each other
- Required fields: target business name, same_community flag
- Missing in dataset: ~85%

---

### 11. Known Outside the Platform
This person may already be in your contacts — you have a head start.

**Variant A (no business name)**
> *You may already know each other outside this platform.*
- They showed up in your address book or contacts
- A familiar name gets a faster response
- This isn't a cold connection — it's a warm one
- Required fields: known_outside_source flag (reverse_address_book, ACF, or sponsor)
- Missing in dataset: ~80% (only ~20% of contexts have this signal)

**Variant B (uses target business name)**
> *{target_business_name} may already be in your world.*
- They appeared in your contacts or external network
- You likely have more in common than you think
- Re-connecting here could unlock a real opportunity
- Required fields: target business name, known_outside_source flag
- Missing in dataset: ~80%

---

### 12. Meeting Already in Progress
You've already started talking — sending a message keeps things moving.

**Variant A (no business name)**
> *You've already been in touch — keep the momentum going.*
- A conversation is underway between you two
- Following up shows reliability and interest
- The next message could turn talk into action
- Required fields: conversation_history (non-empty with mutual engagement), meeting_lifecycle
- Missing in dataset: ~40% (many contexts have no prior conversation)

**Variant B (uses target business name)**
> *You and {target_business_name} are already talking — keep going.*
- You've exchanged messages and shown mutual interest
- This message builds on a foundation you've both started
- Timely follow-up is what closes opportunities
- Required fields: target business name, conversation_history, meeting_lifecycle
- Missing in dataset: ~40%

---

# Step 3 — Data-Dependency Audit

| # | Pattern | Required Fields | Est. % Missing | Notes |
|---|---------|----------------|----------------|-------|
| 1 | Referral Partnership Fit | target partner tags, sender category | ~5% | Partner tags empty in a few sparse profiles |
| 2 | Target Could Be a Customer | sender customer tags, target category | ~5% | Target category nearly always present |
| 3 | Same Local Area | distance_miles, locations | ~10% | Distance always computed; "cares about locality" sometimes absent |
| 4 | Mutual Connections | mutual_count > 0 | ~15% | Some pairs have 0 or no mutual_count |
| 5 | Met at Event | event attendance arrays | ~75% | Most contexts lack event data |
| 6 | Introduced by Mutual | introducer_name | ~92% | Rare signal |
| 7 | Two-Way Match | bidirectional match flags | ~70% | Uncommon to have both directions flagged |
| 8 | Same Industry | role_overlap flag | ~40% | Present in a meaningful minority |
| 9 | Target Serves Sender's Customers | sender_matches_recipient_customer_targets | ~75% | Specific flag uncommon |
| 10 | Shared Community | same_community flag | ~85% | Very small fraction |
| 11 | Known Outside Platform | known_outside_source flags | ~80% | Only ~20% of sample |
| 12 | Meeting in Progress | conversation_history + meeting_lifecycle | ~40% | Many contexts are first-touch |

**Variant B additional dependency:** `{target_business_name}` — present in ~97% of contexts (missing in ~3% where the field is the person's own name used as a placeholder or left as a generic string). This adds negligible incremental missing-rate to any variant.

---

**Summary for prioritization:** Patterns 1–4 have the lowest missing-data rates and cover the largest share of send contexts. Patterns 5, 12, and 8 cover a mid-tier share. Patterns 6, 7, 9, 10, and 11 are high-signal but low-availability — best used when the signal *is* present, with fallback to a more available pattern otherwise.