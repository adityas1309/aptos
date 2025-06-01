// Question: Create a cross-chain bridge
// Generated: 2025-06-25 21:54:42


        module 0x1::CrossChainBridge {
            use std::vector;
            use std::signer;
            
            struct Bridge has key {
                supported_chains: vector<u64>,
                validators: vector<address>,
                min_validators: u64,
                locked_tokens: u64,
            }
            
            struct CrossChainTransfer has key {
                from_chain: u64,
                to_chain: u64,
                sender: address,
                recipient: address,
                amount: u64,
                nonce: u64,
                confirmations: vector<address>,
                is_completed: bool,
            }
            
            public fun initiate_transfer(
                sender: &signer,
                to_chain: u64,
                recipient: address,
                amount: u64
            ) acquires Bridge {
                let bridge = borrow_global_mut<Bridge>(@0x1);
                
                let transfer = CrossChainTransfer {
                    from_chain: 1, // Assuming current chain ID is 1
                    to_chain,
                    sender: signer::address_of(sender),
                    recipient,
                    amount,
                    nonce: bridge.locked_tokens, // Simple nonce
                    confirmations: vector::empty<address>(),
                    is_completed: false,
                };
                
                move_to(sender, transfer);
                bridge.locked_tokens = bridge.locked_tokens + amount;
            }
        }
