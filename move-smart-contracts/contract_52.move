// Question: Supply chain tracking
// Generated: 2025-06-25 21:54:46


        module 0x1::SupplyChain {
            struct Product has key {
                id: u64,
                name: vector<u8>,
                manufacturer: address,
                current_owner: address,
                manufacturing_date: u64,
                expiry_date: u64,
            }
            
            struct TrackingRecord has store {
                location: vector<u8>,
                timestamp: u64,
                handler: address,
                condition: vector<u8>,
            }
            
            struct ProductHistory has key {
                product_id: u64,
                tracking_records: vector<TrackingRecord>,
            }
            
            public fun add_tracking_record(handler: &signer, product_id: u64, location: vector<u8>, condition: vector<u8>) acquires ProductHistory {
                let history = borrow_global_mut<ProductHistory>(@0x1);
                assert!(history.product_id == product_id, 1);
                
                let record = TrackingRecord {
                    location,
                    timestamp: aptos_framework::timestamp::now_seconds(),
                    handler: signer::address_of(handler),
                    condition,
                };
                vector::push_back(&mut history.tracking_records, record);
            }
        }
