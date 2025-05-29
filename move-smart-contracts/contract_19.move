// Question: Create a yield farming contract
// Generated: 2025-06-25 21:54:41


        module 0x1::YieldFarming {
            use std::signer;
            
            struct Farm has key {
                staking_token: vector<u8>,
                reward_token: vector<u8>,
                reward_rate: u64,
                total_staked: u64,
                last_update_time: u64,
                reward_per_token_stored: u64,
            }
            
            struct UserStake has key {
                amount: u64,
                reward_debt: u64,
                last_claim_time: u64,
            }
            
            public fun stake(user: &signer, amount: u64) acquires Farm, UserStake {
                let user_addr = signer::address_of(user);
                let farm = borrow_global_mut<Farm>(@0x1);
                
                if (!exists<UserStake>(user_addr)) {
                    let stake = UserStake {
                        amount,
                        reward_debt: 0,
                        last_claim_time: aptos_framework::timestamp::now_seconds(),
                    };
                    move_to(user, stake);
                } else {
                    let stake = borrow_global_mut<UserStake>(user_addr);
                    stake.amount = stake.amount + amount;
                };
                
                farm.total_staked = farm.total_staked + amount;
            }
        }
