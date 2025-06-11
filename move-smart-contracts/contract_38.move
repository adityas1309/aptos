// Question: Voting system with delegation
// Generated: 2025-06-25 21:54:44


        module 0x1::Voting {
            struct Proposal has key {
                id: u64,
                description: vector<u8>,
                votes_for: u64,
                votes_against: u64,
                end_time: u64,
            }
            
            struct Voter has key {
                voting_power: u64,
                has_voted: bool,
                delegated_to: address,
            }
            
            public fun vote(voter: &signer, proposal_addr: address, vote_for: bool) acquires Proposal, Voter {
                let voter_data = borrow_global_mut<Voter>(signer::address_of(voter));
                assert!(!voter_data.has_voted, 1);
                
                let proposal = borrow_global_mut<Proposal>(proposal_addr);
                if (vote_for) {
                    proposal.votes_for = proposal.votes_for + voter_data.voting_power;
                } else {
                    proposal.votes_against = proposal.votes_against + voter_data.voting_power;
                };
                voter_data.has_voted = true;
            }
        }
