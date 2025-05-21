// Question: Implement a simple marketplace
// Generated: 2025-06-25 21:54:39


        module 0x1::Marketplace {
            use std::signer;
            use aptos_framework::coin;
            
            struct Item has key, store {
                id: u64,
                name: vector<u8>,
                price: u64,
                seller: address,
                is_sold: bool,
            }
            
            struct Marketplace has key {
                items: vector<Item>,
                next_item_id: u64,
            }
            
            public fun list_item(
                seller: &signer,
                name: vector<u8>,
                price: u64
            ) acquires Marketplace {
                let seller_addr = signer::address_of(seller);
                let marketplace = borrow_global_mut<Marketplace>(seller_addr);
                
                let item = Item {
                    id: marketplace.next_item_id,
                    name,
                    price,
                    seller: seller_addr,
                    is_sold: false,
                };
                
                vector::push_back(&mut marketplace.items, item);
                marketplace.next_item_id = marketplace.next_item_id + 1;
            }
        }
