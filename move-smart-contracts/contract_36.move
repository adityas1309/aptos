// Question: Escrow service implementation
// Generated: 2025-06-25 21:54:44


        module 0x1::Escrow {
            struct EscrowAccount has key {
                buyer: address,
                seller: address,
                amount: u64,
                released: bool,
                arbiter: address,
            }
            
            public fun create_escrow(account: &signer, buyer: address, seller: address, amount: u64, arbiter: address) {
                move_to(account, EscrowAccount { 
                    buyer, 
                    seller, 
                    amount, 
                    released: false, 
                    arbiter 
                });
            }
            
            public fun release_funds(releaser: &signer, escrow_addr: address) acquires EscrowAccount {
                let escrow = borrow_global_mut<EscrowAccount>(escrow_addr);
                let releaser_addr = signer::address_of(releaser);
                assert!(releaser_addr == escrow.buyer || releaser_addr == escrow.arbiter, 1);
                escrow.released = true;
            }
        }
