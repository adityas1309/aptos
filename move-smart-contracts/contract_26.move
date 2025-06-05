// Question: Event emission system
// Generated: 2025-06-25 21:54:42


        module 0x1::EventSystem {
            use std::event;
            
            struct TransferEvent has drop, store {
                from: address,
                to: address,
                amount: u64,
            }
            
            public fun emit_transfer(from: address, to: address, amount: u64) {
                event::emit(TransferEvent { from, to, amount });
            }
        }
