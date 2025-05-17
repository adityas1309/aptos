# 🌍 Transparent Fair Trade Registry

A decentralized registry for fair trade products built on the **Move** smart contract language. It enables producers to register goods and provides transparency into product certification and verification processes.

---

## 📝 Project Description

**Transparent Fair Trade Registry** is a blockchain-powered platform that allows producers to register their fair trade products immutably on-chain. This system ensures that product origin, producer identity, and certification timestamps are publicly verifiable — reducing fraud and increasing consumer trust.

### 🔑 Key Features

- ✅ **On-chain Product Registration**  
  Producers can register their products directly on the blockchain.

- 🔐 **Immutable Certification Data**  
  Each product is tagged with a certification timestamp.

- 🔍 **Verification Mechanism**  
  Verifiers (currently unrestricted) can mark products as verified.

- 🌐 **Public Transparency**  
  All registered products and their states are accessible on-chain, ensuring data cannot be tampered with.

---

## 🔭 Project Vision

We envision a transparent, tamper-proof ecosystem that empowers **consumers, regulators, and producers** by:

- 🛡️ **Enhancing Consumer Trust**  
  Consumers can verify fair trade claims through the blockchain.

- 🌱 **Supporting Ethical Producers**  
  Producers gain credibility through independently verifiable certifications.

- 🌍 **Fostering a Global Fair Trade Network**  
  Creating a standard, decentralized registry that can be adopted globally by fair trade organizations and communities.

---

## 📦 Module Overview

### 🧱 Product Struct

- `producer_id`: `address` – Address of the producer  
- `product_name`: `string` – Name of the product  
- `origin`: `string` – Country or location of origin  
- `certification_date`: `u64` – UNIX timestamp of certification  
- `verified`: `bool` – Status indicating if the product is verified  

---

### 🔧 Key Functions

- `register_product`: Allows producers to register a new product.  
- `verify_product`: Allows any signer to verify an existing product (upgradeable to role-based model).

---

## 🛠️ Future Enhancements

- 🧑‍⚖️ Role-based access control for verifiers  
- 🖥️ Product listing and search frontend interface  
- 📱 Integration with QR codes for consumer scanning  
- 📦 Multi-product registry support per producer  

---

## 📜 Contract Address - 0x316dbfce65fa0b48f1eddf96e1cc2e27c70ae0d4d278889a066834ce1026b4ca

![image](https://github.com/user-attachments/assets/930b4e1d-d6c0-4b4e-87bd-d67bd8d6209e)
![image](https://github.com/user-attachments/assets/bc5a43c6-7200-4bcb-8bec-069b834b809c)
