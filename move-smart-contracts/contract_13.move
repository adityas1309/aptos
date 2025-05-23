// Question: Create an escrow contract
// Generated: 2025-06-25 21:54:40


        module 0x1::Escrow {
            use std::signer;
            
            struct EscrowAccount has key {
                buyer: address,
                seller: address,
                arbiter: address,
                amount: u64,
                is_completed: bool,
                buyer_approved: bool,
                seller_approved: bool,
            }
            
            public fun create_escrow(
                creator: &signer,
                buyer: address,
                seller: address,
                arbiter: address,
                amount: u64
            ) {
                let escrow = EscrowAccount {
                    buyer,
                    seller,
                    arbiter,
                    amount,
                    is_completed: false,
                    buyer_approved: false,
                    seller_approved: false,
                };
                move_to(creator, escrow);
            }
            
            public fun approve_transaction(approver: &signer) acquires EscrowAccount {
                let approver_addr = signer::address_of(approver);
                let escrow = borrow_global_mut<EscrowAccount>(@0x1);
                
                if (approver_addr == escrow.buyer) {
                    escrow.buyer_approved = true;
                } else if (approver_addr == escrow.seller) {
                    escrow.seller_approved = true;
                };
                
                if (escrow.buyer_approved && escrow.seller_approved) {
                    escrow.is_completed = true;
                };
            }
        }
