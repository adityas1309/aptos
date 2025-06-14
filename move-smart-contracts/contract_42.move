// Question: NFT marketplace with royalties
// Generated: 2025-06-25 21:54:44


        module 0x1::NFTMarketplace {
            struct NFT has key, store {
                id: u64,
                creator: address,
                owner: address,
                royalty_percentage: u8,
            }
            
            struct Listing has key {
                nft_id: u64,
                price: u64,
                seller: address,
            }
            
            public fun list_nft(seller: &signer, nft_id: u64, price: u64) {
                move_to(seller, Listing { nft_id, price, seller: signer::address_of(seller) });
            }
            
            public fun buy_nft(buyer: &signer, listing_addr: address, payment: u64) acquires Listing, NFT {
                let listing = move_from<Listing>(listing_addr);
                assert!(payment >= listing.price, 1);
                
                let nft = borrow_global_mut<NFT>(listing.seller);
                let royalty = (listing.price * (nft.royalty_percentage as u64)) / 100;
                nft.owner = signer::address_of(buyer);
            }
        }
