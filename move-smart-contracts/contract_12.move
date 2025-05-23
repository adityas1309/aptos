// Question: Implement a governance token
// Generated: 2025-06-25 21:54:40


        module 0x1::GovernanceToken {
            use std::signer;
            use std::vector;
            
            struct GovernanceToken has key {
                balance: u64,
                voting_power: u64,
                delegated_to: address,
            }
            
            struct Proposal has key {
                id: u64,
                title: vector<u8>,
                description: vector<u8>,
                votes_for: u64,
                votes_against: u64,
                end_time: u64,
                executed: bool,
            }
            
            public fun delegate_votes(
                delegator: &signer,
                delegate: address
            ) acquires GovernanceToken {
                let delegator_addr = signer::address_of(delegator);
                let token = borrow_global_mut<GovernanceToken>(delegator_addr);
                token.delegated_to = delegate;
            }
            
            public fun vote_on_proposal(
                voter: &signer,
                proposal_id: u64,
                vote_for: bool
            ) acquires GovernanceToken, Proposal {
                let voter_addr = signer::address_of(voter);
                let token = borrow_global<GovernanceToken>(voter_addr);
                let proposal = borrow_global_mut<Proposal>(@0x1);
                
                if (vote_for) {
                    proposal.votes_for = proposal.votes_for + token.voting_power;
                } else {
                    proposal.votes_against = proposal.votes_against + token.voting_power;
                };
            }
        }
