// Question: Lottery system with random selection
// Generated: 2025-06-25 21:54:46


        module 0x1::Lottery {
            use aptos_framework::randomness;
            
            struct LotteryRound has key {
                round_id: u64,
                ticket_price: u64,
                participants: vector<address>,
                prize_pool: u64,
                winner: address,
                ended: bool,
            }
            
            struct Ticket has key {
                round_id: u64,
                owner: address,
                numbers: vector<u8>,
            }
            
            public fun buy_ticket(player: &signer, round_addr: address, numbers: vector<u8>) acquires LotteryRound {
                let lottery = borrow_global_mut<LotteryRound>(round_addr);
                assert!(!lottery.ended, 1);
                
                vector::push_back(&mut lottery.participants, signer::address_of(player));
                lottery.prize_pool = lottery.prize_pool + lottery.ticket_price;
                
                move_to(player, Ticket {
                    round_id: lottery.round_id,
                    owner: signer::address_of(player),
                    numbers,
                });
            }
            
            public fun draw_winner(admin: &signer, round_addr: address) acquires LotteryRound {
                let lottery = borrow_global_mut<LotteryRound>(round_addr);
                assert!(!lottery.ended, 1);
                
                let participant_count = vector::length(&lottery.participants);
                let winner_index = randomness::u64_range(0, participant_count);
                lottery.winner = *vector::borrow(&lottery.participants, winner_index);
                lottery.ended = true;
            }
        }
