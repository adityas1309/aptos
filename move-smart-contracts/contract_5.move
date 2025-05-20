// Question: Create a voting contract
// Generated: 2025-06-25 21:54:39


        module 0x1::Voting {
            use std::signer;
            use std::vector;
            
            struct Proposal has key {
                title: vector<u8>,
                description: vector<u8>,
                yes_votes: u64,
                no_votes: u64,
                voters: vector<address>,
            }
            
            public fun create_proposal(
                account: &signer,
                title: vector<u8>,
                description: vector<u8>
            ) {
                let proposal = Proposal {
                    title,
                    description,
                    yes_votes: 0,
                    no_votes: 0,
                    voters: vector::empty<address>(),
                };
                move_to(account, proposal);
            }
        }
