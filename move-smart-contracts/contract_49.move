// Question: Subscription service management
// Generated: 2025-06-25 21:54:45


        module 0x1::Subscription {
            struct SubscriptionService has key {
                service_id: u64,
                price_per_period: u64,
                period_duration: u64,
                active_subscribers: u64,
            }
            
            struct Subscription has key {
                subscriber: address,
                service_id: u64,
                next_payment_due: u64,
                active: bool,
                auto_renew: bool,
            }
            
            public fun subscribe(user: &signer, service_addr: address, auto_renew: bool) acquires SubscriptionService {
                let service = borrow_global_mut<SubscriptionService>(service_addr);
                service.active_subscribers = service.active_subscribers + 1;
                
                move_to(user, Subscription {
                    subscriber: signer::address_of(user),
                    service_id: service.service_id,
                    next_payment_due: aptos_framework::timestamp::now_seconds() + service.period_duration,
                    active: true,
                    auto_renew,
                });
            }
        }
