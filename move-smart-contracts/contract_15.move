// Question: Create a decentralized identity contract
// Generated: 2025-06-25 21:54:41


        module 0x1::Identity {
            use std::string::String;
            use std::vector;
            
            struct Identity has key {
                owner: address,
                name: String,
                email: vector<u8>,
                verified_attributes: vector<String>,
                reputation_score: u64,
            }
            
            struct VerificationRequest has key {
                identity_owner: address,
                attribute: String,
                verifier: address,
                is_verified: bool,
            }
            
            public fun create_identity(
                owner: &signer,
                name: String,
                email: vector<u8>
            ) {
                let identity = Identity {
                    owner: signer::address_of(owner),
                    name,
                    email,
                    verified_attributes: vector::empty<String>(),
                    reputation_score: 0,
                };
                move_to(owner, identity);
            }
            
            public fun verify_attribute(
                verifier: &signer,
                identity_owner: address,
                attribute: String
            ) acquires Identity {
                let identity = borrow_global_mut<Identity>(identity_owner);
                vector::push_back(&mut identity.verified_attributes, attribute);
                identity.reputation_score = identity.reputation_score + 10;
            }
        }
