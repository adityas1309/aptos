// Question: Create a time-locked vault
// Generated: 2025-06-25 21:54:40


        module 0x1::TimeLockedVault {
            use std::signer;
            use aptos_framework::timestamp;
            
            struct Vault has key {
                amount: u64,
                unlock_time: u64,
                owner: address,
            }
            
            public fun create_vault(
                owner: &signer,
                amount: u64,
                lock_duration: u64
            ) {
                let vault = Vault {
                    amount,
                    unlock_time: timestamp::now_seconds() + lock_duration,
                    owner: signer::address_of(owner),
                };
                move_to(owner, vault);
            }
            
            public fun withdraw(owner: &signer) acquires Vault {
                let owner_addr = signer::address_of(owner);
                let vault = borrow_global<Vault>(owner_addr);
                
                assert!(timestamp::now_seconds() >= vault.unlock_time, 1);
                assert!(vault.owner == owner_addr, 2);
                
                // Withdraw logic here
                move_from<Vault>(owner_addr);
            }
        }
