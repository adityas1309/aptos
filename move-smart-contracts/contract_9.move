// Question: Create a lottery contract
// Generated: 2025-06-25 21:54:40


        module 0x1::Lottery {
            use std::vector;
            use std::signer;
            use aptos_framework::randomness;
            
            struct Lottery has key {
                participants: vector<address>,
                prize_pool: u64,
                is_active: bool,
                winner: address,
            }
            
            public fun enter_lottery(participant: &signer) acquires Lottery {
                let participant_addr = signer::address_of(participant);
                let lottery = borrow_global_mut<Lottery>(@0x1);
                
                assert!(lottery.is_active, 1);
                vector::push_back(&mut lottery.participants, participant_addr);
            }
            
            public fun draw_winner() acquires Lottery {
                let lottery = borrow_global_mut<Lottery>(@0x1);
                let participant_count = vector::length(&lottery.participants);
                
                if (participant_count > 0) {
                    let random_index = randomness::u64_integer() % participant_count;
                    lottery.winner = *vector::borrow(&lottery.participants, random_index);
                    lottery.is_active = false;
                };
            }
        }
