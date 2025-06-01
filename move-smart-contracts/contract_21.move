// Question: Create a prediction market
// Generated: 2025-06-25 21:54:41


        module 0x1::PredictionMarket {
            use std::vector;
            use std::signer;
            
            struct Market has key {
                question: vector<u8>,
                creator: address,
                end_time: u64,
                total_yes_shares: u64,
                total_no_shares: u64,
                is_resolved: bool,
                outcome: bool,
            }
            
            struct Position has key {
                market_id: u64,
                yes_shares: u64,
                no_shares: u64,
                total_invested: u64,
            }
            
            public fun create_market(
                creator: &signer,
                question: vector<u8>,
                duration: u64
            ) {
                let market = Market {
                    question,
                    creator: signer::address_of(creator),
                    end_time: aptos_framework::timestamp::now_seconds() + duration,
                    total_yes_shares: 0,
                    total_no_shares: 0,
                    is_resolved: false,
                    outcome: false,
                };
                move_to(creator, market);
            }
        }
