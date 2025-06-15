// Question: Decentralized exchange order book
// Generated: 2025-06-25 21:54:45


        module 0x1::OrderBook {
            struct Order has store {
                id: u64,
                trader: address,
                is_buy: bool,
                price: u64,
                quantity: u64,
                filled: u64,
            }
            
            struct OrderBook has key {
                buy_orders: vector<Order>,
                sell_orders: vector<Order>,
                next_order_id: u64,
            }
            
            public fun place_order(trader: &signer, is_buy: bool, price: u64, quantity: u64) acquires OrderBook {
                let order_book = borrow_global_mut<OrderBook>(@0x1);
                let order = Order {
                    id: order_book.next_order_id,
                    trader: signer::address_of(trader),
                    is_buy,
                    price,
                    quantity,
                    filled: 0,
                };
                
                if (is_buy) {
                    vector::push_back(&mut order_book.buy_orders, order);
                } else {
                    vector::push_back(&mut order_book.sell_orders, order);
                };
                order_book.next_order_id = order_book.next_order_id + 1;
            }
        }
