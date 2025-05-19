// Question: Create a simple Move module with a struct
// Generated: 2025-06-25 21:54:38


        module 0x1::BasicStruct {
            struct User has key {
                name: vector<u8>,
                age: u8,
            }
            
            public fun create_user(account: &signer, name: vector<u8>, age: u8) {
                let user = User { name, age };
                move_to(account, user);
            }
        }
