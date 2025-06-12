// Question: Liquidity pool AMM basics
// Generated: 2025-06-25 21:54:44


        module 0x1::LiquidityPool {
            struct Pool<phantom X, phantom Y> has key {
                reserve_x: u64,
                reserve_y: u64,
                total_shares: u64,
            }
            
            struct LPToken<phantom X, phantom Y> has key {
                shares: u64,
            }
            
            public fun create_pool<X, Y>(creator: &signer, initial_x: u64, initial_y: u64) {
                let initial_shares = (initial_x * initial_y);
                move_to(creator, Pool<X, Y> { 
                    reserve_x: initial_x, 
                    reserve_y: initial_y, 
                    total_shares: initial_shares 
                });
                move_to(creator, LPToken<X, Y> { shares: initial_shares });
            }
            
            public fun swap_x_to_y<X, Y>(pool_addr: address, amount_x: u64): u64 acquires Pool {
                let pool = borrow_global_mut<Pool<X, Y>>(pool_addr);
                let amount_y = (pool.reserve_y * amount_x) / (pool.reserve_x + amount_x);
                pool.reserve_x = pool.reserve_x + amount_x;
                pool.reserve_y = pool.reserve_y - amount_y;
                amount_y
            }
        }
