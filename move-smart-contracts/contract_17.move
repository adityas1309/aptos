// Question: Create a lending protocol
// Generated: 2025-06-25 21:54:41


        module 0x1::LendingProtocol {
            use std::signer;
            
            struct LendingPool has key {
                total_supplied: u64,
                total_borrowed: u64,
                interest_rate: u64,
                reserve_factor: u64,
            }
            
            struct UserPosition has key {
                supplied: u64,
                borrowed: u64,
                last_update: u64,
            }
            
            public fun supply(user: &signer, amount: u64) acquires LendingPool, UserPosition {
                let user_addr = signer::address_of(user);
                let pool = borrow_global_mut<LendingPool>(@0x1);
                
                if (!exists<UserPosition>(user_addr)) {
                    let position = UserPosition {
                        supplied: amount,
                        borrowed: 0,
                        last_update: aptos_framework::timestamp::now_seconds(),
                    };
                    move_to(user, position);
                } else {
                    let position = borrow_global_mut<UserPosition>(user_addr);
                    position.supplied = position.supplied + amount;
                };
                
                pool.total_supplied = pool.total_supplied + amount;
            }
        }
