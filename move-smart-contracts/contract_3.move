// Question: Create a simple counter contract
// Generated: 2025-06-25 21:54:39


        module 0x1::Counter {
            use std::signer;
            
            struct Counter has key {
                value: u64,
            }
            
            public fun initialize(account: &signer) {
                let counter = Counter { value: 0 };
                move_to(account, counter);
            }
            
            public fun increment(account: &signer) acquires Counter {
                let counter_ref = borrow_global_mut<Counter>(signer::address_of(account));
                counter_ref.value = counter_ref.value + 1;
            }
        }
