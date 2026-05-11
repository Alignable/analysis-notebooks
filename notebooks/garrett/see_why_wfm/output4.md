## Patterns Ranked by "What's in it for me?"

### 1. Two-Way Match — You Each Fit What the Other Is Looking For
*When it applies:* The sender matches the recipient's ideal partner/customer profile AND the recipient matches the sender's — a bidirectional fit.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.sender_matches_recipient_partner_targets` (15.0%)
  - `state.prompt_context.input.relationship_data.recipient_matches_sender_partner_targets` (32.9%)
- Supplementary:
  - `state.prompt_context.input.relationship_data.sender_prefers_referral_partners` (50.5%)
  - `state.prompt_context.input.relationship_data.recipient_prefers_referral_partners` (41.1%)
  - `state.prompt_context.input.recipient.profile_data.recipient_partner_section.recipient_description` (46.7%)
  - `state.prompt_context.input.sender.profile_data.sender_partner_section.sender_description` (84.0%)
- Overall availability: ~15.0% (bottlenecked by `sender_matches_recipient_partner_targets`; the two flags must co-occur, so real overlap is likely ~5–8%)

**What's in it for me?**
Most introductions are one-sided — you hope the other person sees value in you. Here, both profiles already say the fit goes both ways. That means the person on the other end has just as much reason to reply as you have to reach out. Two-way relationships tend to stick because nobody's doing all the giving. This is as close to a sure bet as networking gets.

**Example**
> *This could go both ways, {target_first_name} — you each match what the other wants.*
- Their ideal partner description sounds like your business
- Your ideal partner description sounds like theirs
- Both of you have said you want referral partners

**Rank rationale:** A confirmed bidirectional fit is the single most compelling reason to message someone — it removes the biggest fear ("will they even care?"). ⚠️ low-coverage (~5–8% effective availability)

---

### 2. Referral Partnership Fit
*When it applies:* The recipient's business role or category matches what the sender listed as an ideal referral partner type (or vice versa), and at least one side has flagged interest in referral partnerships.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.recipient_matches_sender_partner_targets` (32.9%) **OR** `state.prompt_context.input.relationship_data.recipient_roles_matching_sender_partner_roles` (32.9%)
- Supplementary:
  - `state.prompt_context.input.sender.profile_data.sender_partner_section.sender_partner_tags` (92.8%)
  - `state.prompt_context.input.sender.profile_data.sender_partner_section.sender_description` (84.0%)
  - `state.prompt_context.input.relationship_data.sender_prefers_referral_partners` (50.5%)
  - `state.prompt_context.input.relationship_data.recipient_prefers_referral_partners` (41.1%)
  - `state.prompt_context.input.recipient.profile_data.recipient_partner_section.recipient_partner_tags` (66.1%)
- Overall availability: ~32.9%

**What's in it for me?**
This person's profile specifically names your kind of business as the type of partner they want to trade referrals with. That's not a guess — they wrote it down. A single referral partner who actually sends you leads on a regular basis can be worth more than dozens of loose connections. This message is your chance to start that relationship before someone else does.

**Example**
> *{target_first_name} is looking for a partner exactly like you.*
- They listed your industry in their partner wishlist
- You listed theirs in yours
- Referral partners like this are hard to find

**Rank rationale:** A named, one-directional partner match is nearly as motivating as the two-way version — the sender knows the other side is already looking for them.

---

### 3. Target Could Be a Direct Customer
*When it applies:* The recipient's business role or category matches the sender's ideal customer description.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.recipient_matches_sender_customer_targets` (25.4%) **OR** `state.prompt_context.input.relationship_data.recipient_roles_matching_sender_customer_roles` (25.4%)
- Supplementary:
  - `state.prompt_context.input.sender.profile_data.sender_customer_section.sender_customer_tags` (91.8%)
  - `state.prompt_context.input.sender.profile_data.sender_customer_section.sender_description` (95.3%)
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_characteristics.recipient_business_model` (85.6%)
  - `state.prompt_context.input.recipient.profile_data.recipient_general_profile_information.recipient_category` (96.6%)
- Overall availability: ~25.4%

**What's in it for me?**
You described your ideal customer on your profile. This person's business matches that description. That doesn't guarantee a sale, but it means the conversation starts in the right place — you're not pitching to someone who'd never buy. One real customer relationship can pay for months of networking time.

**Example**
> *{target_first_name}'s business looks like a strong fit for what you offer.*
- Their role matches your ideal customer profile
- They're in a category you specifically serve
- A short intro could open a real opportunity

**Rank rationale:** Direct revenue potential is the most concrete "what's in it for me" — only ranked below partnership patterns because partnerships promise ongoing lead flow, not a single transaction.

---

### 4. You Fit Their Ideal Customer Profile
*When it applies:* The sender's business matches what the recipient described as their ideal customer — the recipient is looking for someone like the sender.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.sender_matches_recipient_customer_targets` (11.3%) **OR** `state.prompt_context.input.relationship_data.sender_roles_matching_recipient_customer_roles` (11.3%)
- Supplementary:
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_customer_tags` (63.6%)
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_description` (67.4%)
- Overall availability: ~11.3%

**What's in it for me?**
This person described their ideal customer — and your business fits that description. That means they want to hear from you. When someone is already looking for what you are, your message doesn't feel like a cold pitch; it feels like a welcome answer. You're much more likely to get a reply, and the conversation starts from a position of mutual interest.

**Example**
> *{target_first_name} is looking for a business like yours.*
- Their ideal customer description matches your profile
- You may be exactly who they want to hear from
- Worth a conversation to see if the fit is real

**Rank rationale:** Knowing the other person is actively seeking your type of business is highly motivating — it flips the dynamic from "I'm asking for attention" to "they want what I am."

---

### 5. Meeting Already in Progress — Keep the Momentum
*When it applies:* A meeting has been proposed or scheduled between the pair, and the next step is confirmation or follow-through.

**Properties**
- Necessary:
  - `state.prompt_context.input.meeting_context.meeting_lifecycle` (21.0%)
- Supplementary:
  - `state.conversation_history` (37.3%)
  - `state.prompt_context.input.meeting_context.meeting_type` (21.0%)
  - `state.prompt_context.input.meeting_context.meeting_initiator` (20.1%)
  - `state.prompt_context.input.meeting_context.user_logistics` (14.7%)
  - `state.sender_scheduling_link` (23.2%)
  - `state.prompt_context.input.meeting_context.has_scheduled_meeting` (0.6%)
  - `state.prompt_context.input.meeting_context.scheduled_datetime` (0.3%)
  - `state.sender_proposed_meeting_time` (1.3%)
- Overall availability: ~21.0%

**What's in it for me?**
You've already done the hard part — you started a conversation and someone said yes to meeting. The only thing standing between you and a real relationship is one more message. People get busy and threads go cold; a timely nudge is what separates the connections that turn into business from the ones that fade away. Don't lose the momentum you've already built.

**Example**
> *You and {target_first_name} are close to getting on a call.*
- A meeting has been proposed — lock it in
- The conversation already has momentum
- One more message keeps things moving

**Rank rationale:** Sunk-cost psychology is real — the sender has already invested time, and the ask is simply "finish what you started," making this extremely actionable.

---

### 6. Conversation Already Active — Re-engage the Thread
*When it applies:* The pair have exchanged messages (beyond an initial connect), but no meeting has been proposed or scheduled — the thread has stalled.

**Properties**
- Necessary:
  - `state.conversation_history` (37.3%) — must contain at least 2 messages from different users
- Supplementary:
  - `state.prompt_context.input.meeting_context` (21.0%) — absence or `meeting_lifecycle` = "none" confirms no meeting in flight
  - `state.prompt_context.input.recipient.profile_data.recipient_about_section.recipient_description` (76.8%)
- Overall availability: ~37.3% (further filtered to threads with mutual engagement and no meeting, likely ~15–20% effective)

**What's in it for me?**
This person already replied to you — that puts you ahead of every other connection request in their inbox. Conversations stall all the time, not because of disinterest but because life gets in the way. A short follow-up message can restart something that was already going somewhere. You've already cleared the hardest hurdle (getting a reply); this is about finishing the job.

**Example**
> *You and {target_first_name} already have a conversation going.*
- They've replied — the door is open
- A quick follow-up could move things forward
- Sometimes all it takes is one more message

**Rank rationale:** An existing thread with a real reply is warmer than any cold outreach; the sender's effort-to-reward ratio is excellent.

---

### 7. Introduced by a Mutual Contact
*When it applies:* A specific person recently introduced the sender and recipient on the platform.

**Properties**
- Necessary:
  - `state.prompt_context.input.connection_origin.recent_introduction.has_recent_introduction` (1.3%)
  - `state.prompt_context.input.connection_origin.recent_introduction.introducer_name` (1.3%)
- Supplementary:
  - `state.prompt_context.input.relationship_data.mutual_count` (71.8%)
  - `state.prompt_context.input.recipient.profile_data.recipient_about_section.recipient_description` (76.8%)
- Overall availability: ~1.3%

**What's in it for me?**
Someone you both trust thought you should meet — that's the strongest signal in business networking. An introduction from a mutual contact carries built-in credibility that no cold message can replicate. The other person is expecting to hear from you, and ignoring a warm intro feels rude. Your odds of a meaningful reply are significantly higher here than with any other type of outreach.

**Example**
> *{target_first_name}, you were just introduced — don't leave them hanging.*
- A mutual contact connected you for a reason
- That vote of confidence raises your reply odds
- The groundwork for trust is already laid

**Rank rationale:** Warm introductions have the highest response rates of any outreach type — the social obligation to reply is powerful. ⚠️ low-coverage (~1.3% effective availability)

---

### 8. Target Serves Your Customers — They Could Refer You
*When it applies:* The recipient's ideal customers overlap with the sender's existing customer base, meaning the recipient is naturally positioned to refer business to the sender.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.sender_matches_recipient_partner_targets` (15.0%) **OR** overlap detected between `state.prompt_context.input.sender.profile_data.sender_customer_section.sender_customer_tags` (91.8%) and `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_customer_tags` (63.6%)
- Supplementary:
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_description` (67.4%)
  - `state.prompt_context.input.sender.profile_data.sender_customer_section.sender_description` (95.3%)
- Overall availability: ~15.0% (when using the explicit flag); tag-overlap approach availability is higher (~63.6%) but requires runtime matching logic

**What's in it for me?**
This person works with the same kinds of clients you do — but offers different services. That means their customers probably need what you sell, and yours probably need what they sell. One relationship like this can become a steady, low-effort source of warm introductions. You're not competing; you're complementing.

**Example**
> *{target_first_name} works with the same kinds of clients you do.*
- Their customer base overlaps with yours
- Different services, same audience — that's referral gold
- Worth exploring how you complement each other

**Rank rationale:** Shared customer base without competition is the foundation of the most durable referral relationships — highly motivating for anyone who's experienced one before.

---

### 9. Same Local Area
*When it applies:* Both businesses are nearby (typically < 25 miles) and at least one party has indicated local relationships matter to them.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.distance_miles` (99.7%)
  - `state.prompt_context.input.sender.profile_data.sender_general_profile_information.sender_location` (100%)
  - `state.prompt_context.input.recipient.profile_data.recipient_general_profile_information.recipient_location` (100%)
- Supplementary:
  - `state.prompt_context.input.relationship_data.same_state` (43.3%)
  - `state.prompt_context.input.relationship_data.recipient_cares_about_locality` (31.7%)
  - `state.prompt_context.input.relationship_data.sender_cares_about_locality` (25.1%)
- Overall availability: ~99.7% (distance is nearly universal; pattern fires when distance is below a threshold, so effective rate depends on the cutoff, but the data is present)

**What's in it for me?**
Local businesses refer local businesses — it's the most natural networking instinct there is. When someone asks a neighbor for a recommendation, they want someone nearby. Being connected to the businesses around you means you're top of mind when those referrals happen. It's also easier to grab coffee, attend the same events, and build real trust with someone down the road.

**Example**
> *{target_first_name} is right in your area.*
- They're just a short drive from your business
- Local owners tend to refer people they know nearby
- Easy to meet in person if the fit is right

**Rank rationale:** Proximity is a universally understood and trusted networking signal — less targeted than match-based patterns but broadly motivating and extremely high coverage.

---

### 10. Business Model & Geographic Reach Alignment
*When it applies:* Both businesses share the same business model (e.g., both B2B) and serve a compatible geographic footprint, making practical collaboration more likely.

**Properties**
- Necessary:
  - `state.prompt_context.input.sender.profile_data.sender_customer_section.sender_characteristics.sender_business_model` (99.1%)
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_characteristics.recipient_business_model` (85.6%)
- Supplementary:
  - `state.prompt_context.input.sender.profile_data.sender_customer_section.sender_characteristics.sender_geographic_reach` (97.8%)
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_characteristics.recipient_geographic_reach` (84.3%)
  - `state.prompt_context.input.relationship_data.same_state` (43.3%)
  - `state.prompt_context.input.relationship_data.distance_miles` (99.7%)
- Overall availability: ~85.6% (bottlenecked by `recipient_business_model`)

**What's in it for me?**
You and this person sell to the same type of buyer in the same geography. That's not a coincidence — it means you're likely running into the same prospects, attending the same events, and hearing the same pain points. When two businesses share a market but don't compete, the referral math works naturally. This is the kind of connection that pays off without either of you having to force it.

**Example**
> *You and {target_first_name} serve the same kind of buyers in the same region.*
- You're both focused on B2B clients
- Your geographic reach overlaps well
- That usually means shared referral opportunities

**Rank rationale:** Structural alignment (model + geography) is a strong practical signal, but less emotionally motivating than a named match — it's "we probably should connect" vs. "they're looking for you."

---

### 11. Mutual Connections
*When it applies:* The pair share a notable number of mutual connections on the platform (mutual_count > 0).

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.mutual_count` (71.8%) — must be > 0
- Supplementary:
  - `state.prompt_context.input.recipient.profile_data.recipient_about_section.recipient_description` (76.8%)
  - `state.prompt_context.input.recipient.profile_data.recipient_general_profile_information.recipient_category` (96.6%)
- Overall availability: ~71.8% (field presence; effective rate where count > 0 is lower)

**What's in it for me?**
You and this person already move in the same circles — you just haven't met yet. Shared connections mean someone in your network already trusts them, and someone in their network already trusts you. That makes your message feel less like a cold outreach and more like a natural next step. People respond faster when they can see a familiar name in common.

**Example**
> *You and {target_first_name} already share connections here.*
- People you both trust are in each other's networks
- Shared contacts make a warm intro easy
- Common ground can fast-track a real conversation

**Rank rationale:** Mutual connections are a trust accelerator but not a business-fit signal on their own — best used to reinforce a stronger pattern.

---

### 12. Same or Related Industry / Role Overlap
*When it applies:* Both businesses operate in the same or closely adjacent industry, creating natural collaboration or knowledge-sharing potential.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.role_overlap` (34.2%)
- Supplementary:
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_characteristics.recipient_business_model` (85.6%)
  - `state.prompt_context.input.recipient.profile_data.recipient_customer_section.recipient_characteristics.recipient_geographic_reach` (84.3%)
  - `state.prompt_context.input.recipient.profile_data.recipient_general_profile_information.recipient_category` (96.6%)
  - `state.prompt_context.input.sender.profile_data.sender_general_profile_information.sender_category` (98.7%)
- Overall availability: ~34.2%

**What's in it for me?**
Industry peers aren't just competitors — they're the people who send you overflow work, share vendor recommendations, and understand your problems without a 10-minute preamble. Knowing someone in your space who you're not directly competing with is one of the most underrated assets in small business. At minimum, you'll learn something. At best, you'll get referrals they can't serve themselves.

**Example**
> *{target_first_name} is in your industry — worth a conversation.*
- Peers in the same field share leads they can't serve
- They already speak your language
- Could become your go-to for overflow or joint projects

**Rank rationale:** Role overlap creates relevance but the business case is indirect — the sender has to imagine the value rather than see it spelled out.

---

### 13. Known Outside the Platform
*When it applies:* The recipient appeared in the sender's contact list, address book, or was auto-connected through an external source — suggesting a pre-existing offline relationship.

**Properties**
- Necessary:
  - `state.eligible_criteria` (100%) — must contain `known_outside_source_acf` or `known_outside_source_reverse_address_book`
- Supplementary:
  - `state.connection_request_source` (87.1%)
  - `state.prompt_context.input.recipient.profile_data.recipient_about_section.recipient_description` (76.8%)
- Overall availability: ~20% estimated (based on Pass 1 analysis of eligible_criteria content; the trigger fields are always present but the specific values occur in a minority)

**What's in it for me?**
This isn't a stranger — they showed up in your contacts, which means you've crossed paths before, even if you don't remember exactly when. That existing connection, however faint, gives you a head start. People are far more likely to respond to a name they recognize than a cold outreach. Re-connecting here could turn a dormant contact into an active business relationship.

**Example**
> *It looks like you and {target_first_name} already know each other.*
- They appeared in your contacts or address book
- A familiar name gets a faster response
- This isn't cold outreach — it's re-connecting

**Rank rationale:** Pre-existing familiarity is a genuine advantage but the business case is speculative — you don't know *why* they're in your contacts.

---

### 14. Met at a Networking Event
*When it applies:* Both the sender and recipient recently attended the same online or in-person networking event.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.online_events_they_attended_recently` (4.4%) **OR** `state.prompt_context.input.relationship_data.in_person_events_they_attended_recently` (0.9%)
- Supplementary:
  - `state.prompt_context.input.relationship_data.online_events_they_are_both_registered_for` (0.9%)
  - `state.prompt_context.input.recipient.profile_data.recipient_about_section.recipient_description` (76.8%)
- Overall availability: ~4.4% (taking the higher of the two event fields)

**What's in it for me?**
You were both in the same room (or the same virtual room) recently. That shared experience is a natural conversation starter — you don't have to manufacture common ground because you already have it. Following up quickly after an event is what separates the people who build real networks from the people who collect business cards. They're more likely to remember you and respond while the event is still fresh.

**Example**
> *You and {target_first_name} were at the same event recently.*
- You crossed paths at a networking session
- A quick follow-up keeps the connection warm
- They're more likely to respond while it's fresh

**Rank rationale:** Shared event attendance is a strong social proof signal but availability is very low. ⚠️ low-coverage (~4.4% effective availability)

---

### 15. Shared Community or Group Membership
*When it applies:* Both the sender and recipient are members of the same community or group on the platform.

**Properties**
- Necessary:
  - `state.prompt_context.input.relationship_data.same_community` (7.2%)
- Supplementary:
  - `state.prompt_context.input.relationship_data.same_state` (43.3%)
  - `state.prompt_context.input.relationship_data.distance_miles` (99.7%)
  - `state.prompt_context.input.recipient.profile_data.recipient_about_section.recipient_description` (76.8%)
- Overall availability: ~7.2%

**What's in it for me?**
You're both members of the same group — that's built-in common ground you didn't have to create. Community members tend to look out for each other and respond more warmly to fellow members than to strangers. It's a natural, low-pressure way to start a conversation without needing a pitch. Think of it as being neighbors in the same digital neighborhood.

**Example**
> *You and {target_first_name} are part of the same community here.*
- Shared group membership means shared context
- Community members tend to support each other
- A natural starting point for a conversation

**Rank rationale:** Common group is a trust signal but doesn't imply business fit — a useful secondary hook, not a primary motivator. ⚠️ low-coverage (~7.2% effective availability)

---

### 16. Discussion Post Connection Origin
*When it applies:* The sender and recipient connected through a specific discussion post in a group.

**Properties**
- Necessary:
  - `state.prompt_context.input.connection_origin.discussion_post_they_connected_from` (0.3%)
  - `state.prompt_context.input.connection_origin.discussion_post_they_connected_from.group_name` (0.3%)
  - `state.prompt_context.input.connection_origin.discussion_post_they_connected_from.post_contents` (0.3%)
- Supplementary:
  - `state.prompt_context.input.connection_origin.discussion_post_they_connected_from.posted_by` (0.3%)
- Overall availability: ~0.3%

**What's in it for me?**
You connected over a specific post — meaning there was something concrete that brought you together, not just an algorithm. That shared interest makes your message feel relevant and personal. People are more likely to engage when they remember *why* they connected in the first place. Referencing the original discussion shows you're paying attention, not just blasting messages.

**Example**
> *{target_first_name}, you connected over a discussion — keep it going.*
- You both engaged with the same group post
- That shared interest is a natural conversation starter
- Reference the original topic and pick up where you left off

**Rank rationale:** Highly specific and personal, but occurrence is vanishingly rare — nearly impossible to use at scale. ⚠️ low-coverage (~0.3% effective availability)