// Question: Implement a basic auction contract
// Generated: 2025-06-25 21:54:41


        module 0x1::Auction {
            use std::signer;
            use aptos_framework::timestamp;
            
            struct Auction has key {
                item_name: vector<u8>,
                seller: address,
                highest_bidder: address,
                highest_bid: u64,
                end_time: u64,
                is_active: bool,
            }
            
            public fun create_auction(
                seller: &signer,
                item_name: vector<u8>,
                starting_bid: u64,
                duration: u64
            ) {
                let auction = Auction {
                    item_name,
                    seller: signer::address_of(seller),
                    highest_bidder: @0x0,
                    highest_bid: starting_bid,
                    end_time: timestamp::now_seconds() + duration,
                    is_active: true,
                };
                move_to(seller, auction);
            }
            
            public fun place_bid(bidder: &signer, bid_amount: u64) acquires Auction {
                let auction = borrow_global_mut<Auction>(@0x1);
                
                assert!(auction.is_active, 1);
                assert!(timestamp::now_seconds() < auction.end_time, 2);
                assert!(bid_amount > auction.highest_bid, 3);
                
                auction.highest_bidder = signer::address_of(bidder);
                auction.highest_bid = bid_amount;
            }
        }
