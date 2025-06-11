// Question: Auction system with bidding
// Generated: 2025-06-25 21:54:44


        module 0x1::Auction {
            struct AuctionHouse has key {
                item_id: u64,
                highest_bid: u64,
                highest_bidder: address,
                end_time: u64,
                seller: address,
            }
            
            struct Bid has store {
                bidder: address,
                amount: u64,
                timestamp: u64,
            }
            
            public fun place_bid(bidder: &signer, auction_addr: address, amount: u64) acquires AuctionHouse {
                let auction = borrow_global_mut<AuctionHouse>(auction_addr);
                assert!(amount > auction.highest_bid, 1);
                auction.highest_bid = amount;
                auction.highest_bidder = signer::address_of(bidder);
            }
        }
