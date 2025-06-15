// Question: Staking rewards calculation
// Generated: 2025-06-25 21:54:45


        module 0x1::StakingRewards {
            use aptos_framework::timestamp;
            
            struct StakingPool has key {
                total_staked: u64,
                reward_rate: u64,
                last_update_time: u64,
                reward_per_token_stored: u64,
            }
            
            struct UserStake has key {
                amount: u64,
                reward_per_token_paid: u64,
                rewards: u64,
                stake_time: u64,
            }
            
            public fun stake(user: &signer, amount: u64) acquires StakingPool {
                let pool = borrow_global_mut<StakingPool>(@0x1);
                pool.total_staked = pool.total_staked + amount;
                
                move_to(user, UserStake {
                    amount,
                    reward_per_token_paid: pool.reward_per_token_stored,
                    rewards: 0,
                    stake_time: timestamp::now_seconds(),
                });
            }
            
            public fun calculate_rewards(user_addr: address): u64 acquires StakingPool, UserStake {
                let pool = borrow_global<StakingPool>(@0x1);
                let user_stake = borrow_global<UserStake>(user_addr);
                
                let time_elapsed = timestamp::now_seconds() - user_stake.stake_time;
                (user_stake.amount * pool.reward_rate * time_elapsed) / 86400 // daily rewards
            }
        }
