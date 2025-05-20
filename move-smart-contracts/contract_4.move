// Question: Implement a basic NFT structure
// Generated: 2025-06-25 21:54:39


        module 0x1::SimpleNFT {
            use std::string::String;
            
            struct NFT has key, store {
                id: u64,
                name: String,
                description: String,
                image_url: String,
            }
            
            struct Collection has key {
                nfts: vector<NFT>,
                next_id: u64,
            }
            
            public fun create_collection(account: &signer) {
                let collection = Collection {
                    nfts: vector::empty<NFT>(),
                    next_id: 1,
                };
                move_to(account, collection);
            }
        }
