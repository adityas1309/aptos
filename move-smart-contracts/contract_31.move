// Question: State machine pattern
// Generated: 2025-06-25 21:54:43


        module 0x1::StateMachine {
            const STATE_PENDING: u8 = 0;
            const STATE_APPROVED: u8 = 1;
            const STATE_REJECTED: u8 = 2;
            
            struct Process has key {
                current_state: u8,
                data: vector<u8>,
            }
            
            public fun create_process(account: &signer, data: vector<u8>) {
                move_to(account, Process { current_state: STATE_PENDING, data });
            }
            
            public fun approve(account: address) acquires Process {
                let process = borrow_global_mut<Process>(account);
                assert!(process.current_state == STATE_PENDING, 1);
                process.current_state = STATE_APPROVED;
            }
        }
