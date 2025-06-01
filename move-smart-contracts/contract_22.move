// Question: Implement a DAO treasury
// Generated: 2025-06-25 21:54:42


        module 0x1::DAOTreasury {
            use std::vector;
            use std::signer;
            
            struct Treasury has key {
                balance: u64,
                proposals: vector<ProposalInfo>,
                members: vector<address>,
                voting_threshold: u64,
            }
            
            struct ProposalInfo has store {
                id: u64,
                proposer: address,
                description: vector<u8>,
                amount: u64,
                recipient: address,
                votes_for: u64,
                votes_against: u64,
                executed: bool,
                deadline: u64,
            }
            
            struct MemberVote has key {
                proposal_id: u64,
                vote: bool,
                voting_power: u64,
            }
            
            public fun propose_spending(
                proposer: &signer,
                description: vector<u8>,
                amount: u64,
                recipient: address
            ) acquires Treasury {
                let treasury = borrow_global_mut<Treasury>(@0x1);
                
                let proposal = ProposalInfo {
                    id: vector::length(&treasury.proposals),
                    proposer: signer::address_of(proposer),
                    description,
                    amount,
                    recipient,
                    votes_for: 0,
                    votes_against: 0,
                    executed: false,
                    deadline: aptos_framework::timestamp::now_seconds() + 604800, // 1 week
                };
                
                vector::push_back(&mut treasury.proposals, proposal);
            }
        }
