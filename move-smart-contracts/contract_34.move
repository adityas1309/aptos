// Question: Pausable contract functionality
// Generated: 2025-06-25 21:54:43


        module 0x1::Pausable {
            struct PausableState has key {
                paused: bool,
                pauser: address,
            }
            
            public fun initialize_pausable(account: &signer) {
                move_to(account, PausableState { 
                    paused: false, 
                    pauser: signer::address_of(account) 
                });
            }
            
            public fun pause(account: &signer) acquires PausableState {
                let state = borrow_global_mut<PausableState>(signer::address_of(account));
                assert!(signer::address_of(account) == state.pauser, 1);
                state.paused = true;
            }
            
            public fun when_not_paused(account: address) acquires PausableState {
                let state = borrow_global<PausableState>(account);
                assert!(!state.paused, 2);
            }
        }
