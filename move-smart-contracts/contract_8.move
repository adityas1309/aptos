// Question: Implement a multi-signature wallet
// Generated: 2025-06-25 21:54:39


        module 0x1::MultiSigWallet {
            use std::vector;
            use std::signer;
            
            struct MultiSigWallet has key {
                owners: vector<address>,
                required_confirmations: u64,
                transactions: vector<Transaction>,
            }
            
            struct Transaction has store {
                to: address,
                amount: u64,
                confirmations: vector<address>,
                executed: bool,
            }
            
            public fun create_wallet(
                creator: &signer,
                owners: vector<address>,
                required_confirmations: u64
            ) {
                let wallet = MultiSigWallet {
                    owners,
                    required_confirmations,
                    transactions: vector::empty<Transaction>(),
                };
                move_to(creator, wallet);
            }
        }
