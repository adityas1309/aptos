// Question: Create a staking contract
// Generated: 2025-06-25 21:54:39


        module 0x1::Staking {
            use std::signer;
            use aptos_framework::timestamp;
            
            struct StakeInfo has key {
                amount: u64,
                stake_time: u64,
                reward_rate: u64,
            }
            
            public fun stake(account: &signer, amount: u64) {
                let stake_info = StakeInfo {
                    amount,
                    stake_time: timestamp::now_seconds(),
                    reward_rate: 5, // 5% annual rate
                };
                move_to(account, stake_info);
            }
            
            public fun calculate_rewards(staker: address): u64 acquires StakeInfo {
                let stake_info = borrow_global<StakeInfo>(staker);
                let time_elapsed = timestamp::now_seconds() - stake_info.stake_time;
                (stake_info.amount * stake_info.reward_rate * time_elapsed) / (100 * 365 * 24 * 3600)
            }
        }
