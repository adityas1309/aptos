// Question: Generic collections with vectors
// Generated: 2025-06-25 21:54:42


        module 0x1::GenericCollection {
            struct Collection<T: store> has key {
                items: vector<T>,
            }
            
            public fun create<T: store>(account: &signer) {
                move_to(account, Collection<T> { items: vector::empty() });
            }
            
            public fun add_item<T: store>(account: &signer, item: T) acquires Collection {
                let collection = borrow_global_mut<Collection<T>>(signer::address_of(account));
                vector::push_back(&mut collection.items, item);
            }
        }
