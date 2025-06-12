// Question: Merkle proof verification
// Generated: 2025-06-25 21:54:44


        module 0x1::MerkleProof {
            use std::hash;
            
            struct MerkleTree has key {
                root: vector<u8>,
                verified_leaves: vector<vector<u8>>,
            }
            
            public fun verify_proof(leaf: vector<u8>, proof: vector<vector<u8>>, root: vector<u8>): bool {
                let computed_hash = leaf;
                let i = 0;
                while (i < vector::length(&proof)) {
                    let proof_element = *vector::borrow(&proof, i);
                    computed_hash = hash::sha3_256(vector::append(&mut computed_hash, proof_element));
                    i = i + 1;
                };
                computed_hash == root
            }
        }
