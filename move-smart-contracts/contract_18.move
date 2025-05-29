// Question: Implement a crowdfunding platform
// Generated: 2025-06-25 21:54:41


        module 0x1::Crowdfunding {
            use std::vector;
            use std::signer;
            
            struct Campaign has key {
                creator: address,
                title: vector<u8>,
                description: vector<u8>,
                goal: u64,
                raised: u64,
                deadline: u64,
                backers: vector<address>,
                is_funded: bool,
            }
            
            struct Contribution has key {
                campaign_id: u64,
                amount: u64,
                contributor: address,
            }
            
            public fun create_campaign(
                creator: &signer,
                title: vector<u8>,
                description: vector<u8>,
                goal: u64,
                duration: u64
            ) {
                let campaign = Campaign {
                    creator: signer::address_of(creator),
                    title,
                    description,
                    goal,
                    raised: 0,
                    deadline: aptos_framework::timestamp::now_seconds() + duration,
                    backers: vector::empty<address>(),
                    is_funded: false,
                };
                move_to(creator, campaign);
            }
        }
