# Izumi Digital Security Standard

Optimized standard for issuing and managing digital security tokens on Ethereum, based on the proposed [ERC-1594](https://github.com/ethereum/EIPs/issues/1594) core security token interface

The base ERC-20 functionality is inherited from the well-regarded ERC-20 implementation by [Open-Zeppelin](https://github.com/OpenZeppelin/openzeppelin-solidity).

## Overview

Izumi Digital Security Standard is a new smart contract standard for issuing and managing security tokens in an efficient, regulatory-compliant manner. It directly inherits both ERC-20 and ERC-1594 to ensure compatibility, while creating rooms for necessary improvements that are unique to securities. 

Izumi Standard overrides ERC-20 `transfer` to check for transfer restrictions that security laws impose with an upgradable `RegulatorService`. The service is extended to `issuance` and `redemption` (burning), which follow the same laws. On top of traditional issuer or only regulator-initiated transfers, we have left room for individual investors to interact directly with the contract by providing proofs through `transferWith`. A feature that we believe will be increasingly used in the future as transfer restrictions and private information go off-chain.

To consolidate all KYC information for different tokens, we have implemented two contratcs `StoreKYC` and `AddressIdentities` to store all relevant KYC and whitelisted addresses, respectively. The contracts will only contain non-sensitive anonymous information, such as country code and accredited status for user id, that will be used to check for transfer restrictions.

To juggle different contracts with different roles--updating KYC information, changing transfer restrictions, issuing tokens, Izumi has taken Role Based Access Control [RBAC pattern](https://docs.openzeppelin.org/docs/learn-about-access-control.html#role-based-access-control-rolessol). This way, Izumi Standard can assign different roles to different players and create an integrated eco-system that's supported by all. 

## Getting Started

Pre-requisites, in install order:
- NodeJS and NPM, node v10+. Is this is new to you, we highly recommend using a flexible NodeJS version manager. Try [NVM](https://github.com/creationix/nvm).
- Embark `npm --global install embark`
- Project dependencies `npm install` (run in root of project dir)
- Go-ethereum.
    - Mac: `brew install ethereum` ([docs here](https://github.com/ethereum/go-ethereum/wiki/Installation-Instructions-for-Mac)).
    - Arch: `pacman -S go-ethereum` ([pkg here](https://www.archlinux.org/packages/community/x86_64/go-ethereum/)).
    - Docs for more platforms, and how to build form source: [go-ethereum wiki page here](https://github.com/ethereum/go-ethereum/wiki/Building-Ethereum)

To run the contracts in a local environment, you want to run your own node, configured to run its own test-net.
Fortunately, this is completely integrated into embark, and since it's your own freshly created network, it won't take days to sync, just a few seconds to start up.

How to run your node: simply run the command `embark blockchain` (it defaults to the development environment).

You can configure balance allocation to genesis accounts here: `./blockchain.js`.
Note that the same accounts are configured to be used in the `./contracts.js`.

After starting your local blockchain, you can run `embark build` to compile the contracts, and deploy them (it defaults to development mode).


