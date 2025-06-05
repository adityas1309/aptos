// Question: Implement a liquidity mining program
// Generated: 2025-06-25 21:54:42


        module 0x1::LiquidityMining {
            use std::signer;
            
            struct MiningPool has key {
                pool_token: vector<u8>,
                reward_token: vector<u8>,
                total_liquidity: u64,
                reward_rate_per_second: u64,
                last_reward_time: u64,
                accumulated_reward_per_share: u64,
            }
            
            struct UserInfo has key {
                liquidity_amount: u64,
                reward_debt: u64,
                pending_rewards: u64,
                last_deposit_time: u64,
            }
            
            public fun deposit_liquidity(
                user: &signer,
                amount: u64
            ) acquires MiningPool, UserInfo {
                let user_addr = signer::address_of(user);
                let pool = borrow_global_mut<MiningPool>(@0x1);
                
                // Update pool rewards
                update_pool_rewards(pool);
                
                if (!exists<UserInfo>(user_addr)) {
                    let user_info = UserInfo {
                        liquidity_amount: amount,
                        reward_debt: (amount * pool.accumulated_reward_per_share) / 1000000,
                        pending_rewards: 0,
                        last_deposit_time: aptos_framework::timestamp::now_seconds(),
                    };
                    move_to(user, user_info);
                } else {
                    let user_info = borrow_global_mut<UserInfo>(user_addr);
                    user_info.pending_rewards = user_info.pending_rewards + 
                        ((user_info.liquidity_amount * pool.accumulated_reward_per_share) / 1000000) - user_info.reward_debt;
                    user_info.liquidity_amount = user_info.liquidity_amount + amount;
                    user_info.reward_debt = (user_info.liquidity_amount * pool.accumulated_reward_per_share) / 1000000;
                };
                
                pool.total_liquidity = pool.total_liquidity + amount;
            }
            
            fun update_pool_rewards(pool: &mut MiningPool) {
                let current_time = aptos_framework::timestamp::now_seconds();
                if (current_time <= pool.last_reward_time) {
                    return
                };
                
                if (pool.total_liquidity == 0) {
                    pool.last_reward_time = current_time;
                    return
                };
                
                let time_elapsed = current_time - pool.last_reward_time;
                let reward = time_elapsed * pool.reward_rate_per_second;
                pool.accumulated_reward_per_share = pool.accumulated_reward_per_share + 
                    (reward * 1000000) / pool.total_liquidity;
                pool.last_reward_time = current_time;
            }
        }
