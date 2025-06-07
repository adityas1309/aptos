// Question: Multi-signature wallet basic
// Generated: 2025-06-25 21:54:43


        module 0x1::MultiSig {
            struct MultiSigWallet has key {
                owners: vector<address>,
                required_signatures: u8,
                balance: u64,
            }
            
            struct Transaction has store {
                to: address,
                amount: u64,
                signatures: vector<address>,
                executed: bool,
            }
            
            public fun create_wallet(account: &signer, owners: vector<address>, required: u8) {
                move_to(account, MultiSigWallet { 
                    owners, 
                    required_signatures: required, 
                    balance: 0 
                });
            }
        }
