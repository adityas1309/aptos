module MyModule::FairTradeRegistry {
    use aptos_framework::signer;
    use aptos_framework::timestamp;
    
    /// Struct representing a fair trade product in the registry
    struct Product has store, key {
        producer_id: address,         // Address of the producer
        product_name: vector<u8>,     // Name of the product
        origin: vector<u8>,           // Origin location
        certification_date: u64,      // When the product was certified
        verified: bool,               // Verification status
    }

    /// Error codes
    const E_NOT_AUTHORIZED: u64 = 1;
    const E_PRODUCT_EXISTS: u64 = 2;
    const E_PRODUCT_NOT_FOUND: u64 = 3;

    /// Function to register a new fair trade product
    public entry fun register_product(
        producer: &signer, 
        product_name: vector<u8>, 
        origin: vector<u8>
    ) {
        let producer_addr = signer::address_of(producer);
        
        // Ensure the product doesn't already exist
        assert!(!exists<Product>(producer_addr), E_PRODUCT_EXISTS);
        
        // Create new product entry
        let product = Product {
            producer_id: producer_addr,
            product_name,
            origin,
            certification_date: timestamp::now_seconds(),
            verified: false,
        };
        
        // Store the product under the producer's address
        move_to(producer, product);
    }

    /// Function to verify a product by an authorized verifier
    public entry fun verify_product(
        verifier: &signer,
        producer_addr: address
    ) acquires Product {
        // In a real implementation, we would check if the verifier is authorized
        // For simplicity, we're allowing any signer to verify products

        // Check if the product exists
        assert!(exists<Product>(producer_addr), E_PRODUCT_NOT_FOUND);
        
        // Get mutable reference to the product
        let product = borrow_global_mut<Product>(producer_addr);
        
        // Mark as verified
        product.verified = true;
    }
}