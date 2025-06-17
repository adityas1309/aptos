// Question: Insurance pool management
// Generated: 2025-06-25 21:54:45


        module 0x1::Insurance {
            struct InsurancePool has key {
                total_coverage: u64,
                total_premiums: u64,
                claims_reserve: u64,
                active_policies: u64,
            }
            
            struct Policy has key {
                holder: address,
                coverage_amount: u64,
                premium_paid: u64,
                expiry_time: u64,
                active: bool,
            }
            
            public fun purchase_policy(buyer: &signer, coverage: u64, premium: u64, duration: u64) acquires InsurancePool {
                let pool = borrow_global_mut<InsurancePool>(@0x1);
                pool.total_coverage = pool.total_coverage + coverage;
                pool.total_premiums = pool.total_premiums + premium;
                pool.active_policies = pool.active_policies + 1;
                
                move_to(buyer, Policy {
                    holder: signer::address_of(buyer),
                    coverage_amount: coverage,
                    premium_paid: premium,
                    expiry_time: aptos_framework::timestamp::now_seconds() + duration,
                    active: true,
                });
            }
        }
