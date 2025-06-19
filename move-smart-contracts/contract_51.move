// Question: Credit scoring system
// Generated: 2025-06-25 21:54:46


        module 0x1::CreditScore {
            struct CreditProfile has key {
                user: address,
                score: u64,
                payment_history: vector<bool>,
                total_debt: u64,
                credit_utilization: u64,
                last_updated: u64,
            }
            
            struct LoanRequest has key {
                borrower: address,
                amount: u64,
                interest_rate: u64,
                approved: bool,
                credit_check_passed: bool,
            }
            
            public fun update_credit_score(user_addr: address, payment_made: bool, new_debt: u64) acquires CreditProfile {
                let profile = borrow_global_mut<CreditProfile>(user_addr);
                vector::push_back(&mut profile.payment_history, payment_made);
                profile.total_debt = new_debt;
                
                // Simple scoring algorithm
                let payment_score = vector::length(&profile.payment_history) * 10;
                let debt_penalty = profile.total_debt / 1000;
                profile.score = if (payment_score > debt_penalty) {
                    payment_score - debt_penalty
                } else { 0 };
                
                profile.last_updated = aptos_framework::timestamp::now_seconds();
            }
        }
