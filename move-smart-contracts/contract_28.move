// Question: Access control with multiple roles
// Generated: 2025-06-25 21:54:42


        module 0x1::AccessControl {
            struct Role has key, store {
                name: vector<u8>,
                permissions: vector<u8>,
            }
            
            struct RoleRegistry has key {
                roles: vector<Role>,
            }
            
            public fun grant_role(account: &signer, name: vector<u8>, permissions: vector<u8>) acquires RoleRegistry {
                let registry = borrow_global_mut<RoleRegistry>(signer::address_of(account));
                let role = Role { name, permissions };
                vector::push_back(&mut registry.roles, role);
            }
        }
