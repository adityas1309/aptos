// Question: Oracle pattern for external data
// Generated: 2025-06-25 21:54:43


        module 0x1::Oracle {
            struct PriceData has key {
                price: u64,
                timestamp: u64,
                source: address,
            }
            
            struct OracleRegistry has key {
                authorized_oracles: vector<address>,
            }
            
            public fun update_price(oracle: &signer, price: u64, target: address) acquires PriceData, OracleRegistry {
                let registry = borrow_global<OracleRegistry>(@0x1);
                assert!(vector::contains(&registry.authorized_oracles, &signer::address_of(oracle)), 1);
                
                let price_data = borrow_global_mut<PriceData>(target);
                price_data.price = price;
            }
        }
