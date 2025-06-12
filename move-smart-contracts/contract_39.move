// Question: Token vesting schedule
// Generated: 2025-06-25 21:54:44


        module 0x1::Vesting {
            use aptos_framework::timestamp;
            
            struct VestingSchedule has key {
                beneficiary: address,
                total_amount: u64,
                released_amount: u64,
                start_time: u64,
                duration: u64,
            }
            
            public fun create_vesting(creator: &signer, beneficiary: address, amount: u64, duration: u64) {
                move_to(creator, VestingSchedule {
                    beneficiary,
                    total_amount: amount,
                    released_amount: 0,
                    start_time: timestamp::now_seconds(),
                    duration,
                });
            }
            
            public fun release_vested_tokens(beneficiary: &signer, vesting_addr: address) acquires VestingSchedule {
                let vesting = borrow_global_mut<VestingSchedule>(vesting_addr);
                assert!(signer::address_of(beneficiary) == vesting.beneficiary, 1);
                
                let elapsed = timestamp::now_seconds() - vesting.start_time;
                let vested_amount = if (elapsed >= vesting.duration) {
                    vesting.total_amount
                } else {
                    (vesting.total_amount * elapsed) / vesting.duration
                };
                
                let releasable = vested_amount - vesting.released_amount;
                vesting.released_amount = vesting.released_amount + releasable;
            }
        }
