// Question: Time-locked operations
// Generated: 2025-06-25 21:54:43


        module 0x1::TimeLock {
            use aptos_framework::timestamp;
            
            struct LockedOperation has key {
                unlock_time: u64,
                operation_data: vector<u8>,
            }
            
            public fun create_lock(account: &signer, unlock_after: u64, data: vector<u8>) {
                let unlock_time = timestamp::now_seconds() + unlock_after;
                move_to(account, LockedOperation { unlock_time, operation_data: data });
            }
            
            public fun execute_if_unlocked(account: address) acquires LockedOperation {
                let lock = borrow_global<LockedOperation>(account);
                assert!(timestamp::now_seconds() >= lock.unlock_time, 1);
                // Execute operation logic here
            }
        }
