// Question: Factory pattern for contract deployment
// Generated: 2025-06-25 21:54:43


        module 0x1::Factory {
            struct ContractRegistry has key {
                deployed_contracts: vector<address>,
            }
            
            struct ContractTemplate has store {
                code_hash: vector<u8>,
                init_data: vector<u8>,
            }
            
            public fun deploy_contract(deployer: &signer, template: ContractTemplate) acquires ContractRegistry {
                let registry = borrow_global_mut<ContractRegistry>(@0x1);
                let new_address = signer::address_of(deployer);
                vector::push_back(&mut registry.deployed_contracts, new_address);
            }
        }
