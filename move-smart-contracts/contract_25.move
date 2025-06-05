// Question: Resource management with capabilities
// Generated: 2025-06-25 21:54:42


        module 0x1::ResourceManager {
            struct AdminCap has key, store {}
            struct Vault has key {
                balance: u64,
            }
            
            public fun initialize(account: &signer) {
                move_to(account, AdminCap {});
                move_to(account, Vault { balance: 0 });
            }
            
            public fun deposit(account: &signer, amount: u64) acquires Vault {
                let vault = borrow_global_mut<Vault>(signer::address_of(account));
                vault.balance = vault.balance + amount;
            }
        }
