// Question: Implement a subscription service
// Generated: 2025-06-25 21:54:40


        module 0x1::Subscription {
            use std::signer;
            use aptos_framework::timestamp;
            
            struct Subscription has key {
                subscriber: address,
                service_provider: address,
                monthly_fee: u64,
                start_time: u64,
                last_payment: u64,
                is_active: bool,
            }
            
            public fun create_subscription(
                subscriber: &signer,
                service_provider: address,
                monthly_fee: u64
            ) {
                let subscription = Subscription {
                    subscriber: signer::address_of(subscriber),
                    service_provider,
                    monthly_fee,
                    start_time: timestamp::now_seconds(),
                    last_payment: timestamp::now_seconds(),
                    is_active: true,
                };
                move_to(subscriber, subscription);
            }
            
            public fun pay_subscription(subscriber: &signer) acquires Subscription {
                let subscriber_addr = signer::address_of(subscriber);
                let subscription = borrow_global_mut<Subscription>(subscriber_addr);
                
                let current_time = timestamp::now_seconds();
                let month_in_seconds = 30 * 24 * 3600; // Approximate
                
                assert!(current_time >= subscription.last_payment + month_in_seconds, 1);
                subscription.last_payment = current_time;
            }
        }
