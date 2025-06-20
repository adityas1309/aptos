// Question: Crowdfunding platform
// Generated: 2025-06-25 21:54:46


        module 0x1::Crowdfunding {
            struct Campaign has key {
                creator: address,
                title: vector<u8>,
                goal_amount: u64,
                raised_amount: u64,
                deadline: u64,
                contributors: vector<address>,
                successful: bool,
                funds_withdrawn: bool,
            }
            
            struct Contribution has key {
                campaign_id: u64,
                contributor: address,
                amount: u64,
                refunded: bool,
            }
            
            public fun contribute(contributor: &signer, campaign_addr: address, amount: u64) acquires Campaign {
                let campaign = borrow_global_mut<Campaign>(campaign_addr);
                assert!(aptos_framework::timestamp::now_seconds() < campaign.deadline, 1);
                
                campaign.raised_amount = campaign.raised_amount + amount;
                vector::push_back(&mut campaign.contributors, signer::address_of(contributor));
                
                move_to(contributor, Contribution {
                    campaign_id: 0, // Would be derived from campaign_addr
                    contributor: signer::address_of(contributor),
                    amount,
                    refunded: false,
                });
            }
            
            public fun finalize_campaign(creator: &signer, campaign_addr: address) acquires Campaign {
                let campaign = borrow_global_mut<Campaign>(campaign_addr);
                assert!(signer::address_of(creator) == campaign.creator, 1);
                assert!(aptos_framework::timestamp::now_seconds() >= campaign.deadline, 2);
                
                campaign.successful = campaign.raised_amount >= campaign.goal_amount;
            }
        }
