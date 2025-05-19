// Question: Implement a basic coin transfer function
// Generated: 2025-06-25 21:54:39


        module 0x1::CoinTransfer {
            use std::signer;
            use aptos_framework::coin;
            
            public entry fun transfer_coins<CoinType>(
                sender: &signer,
                recipient: address,
                amount: u64
            ) {
                coin::transfer<CoinType>(sender, recipient, amount);
            }
        }
