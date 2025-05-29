// Question: Implement a flash loan contract
// Generated: 2025-06-25 21:54:41


        module 0x1::FlashLoan {
            use std::signer;
            
            struct FlashLoanPool has key {
                available_liquidity: u64,
                fee_rate: u64, // in basis points
                total_fees_collected: u64,
            }
            
            struct ActiveLoan has key {
                borrower: address,
                amount: u64,
                fee: u64,
                must_repay_by: u64,
            }
            
            public fun borrow_flash_loan(
                borrower: &signer,
                amount: u64
            ) acquires FlashLoanPool {
                let pool = borrow_global_mut<FlashLoanPool>(@0x1);
                
                assert!(amount <= pool.available_liquidity, 1);
                
                let fee = (amount * pool.fee_rate) / 10000;
                let loan = ActiveLoan {
                    borrower: signer::address_of(borrower),
                    amount,
                    fee,
                    must_repay_by: aptos_framework::timestamp::now_seconds() + 1, // 1 second
                };
                
                move_to(borrower, loan);
                pool.available_liquidity = pool.available_liquidity - amount;
            }
        }
