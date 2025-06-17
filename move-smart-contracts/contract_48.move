// Question: Rental agreement smart contract
// Generated: 2025-06-25 21:54:45


        module 0x1::Rental {
            struct RentalAgreement has key {
                landlord: address,
                tenant: address,
                property_id: u64,
                monthly_rent: u64,
                security_deposit: u64,
                lease_start: u64,
                lease_end: u64,
                rent_paid_until: u64,
            }
            
            public fun create_rental(landlord: &signer, tenant: address, property_id: u64, rent: u64, deposit: u64, duration: u64) {
                let start_time = aptos_framework::timestamp::now_seconds();
                move_to(landlord, RentalAgreement {
                    landlord: signer::address_of(landlord),
                    tenant,
                    property_id,
                    monthly_rent: rent,
                    security_deposit: deposit,
                    lease_start: start_time,
                    lease_end: start_time + duration,
                    rent_paid_until: start_time,
                });
            }
            
            public fun pay_rent(tenant: &signer, rental_addr: address, amount: u64) acquires RentalAgreement {
                let rental = borrow_global_mut<RentalAgreement>(rental_addr);
                assert!(signer::address_of(tenant) == rental.tenant, 1);
                assert!(amount >= rental.monthly_rent, 2);
                
                rental.rent_paid_until = rental.rent_paid_until + 2629746; // ~30 days in seconds
            }
        }
