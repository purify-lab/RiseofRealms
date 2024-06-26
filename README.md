## Table of Contents

- [Overview](#overview)
- Game Mechanics
  - [Land Deployment](#land-deployment)
  - [Army Management](#army-management)
  - [Rewards System](#rewards-system)
  - [Token Impact Mechanism](#token-impact-mechanism)
- [User Interface](#User-Interface)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Overview

Rise of Realm is a Fully On-Chain SLG game, where the conquer and defence have the real power to affect and impact the real world. The game operates on a unique token system and integrates various in-game functions to present a new paradigm of crypto gaming experience.

## Game Mechanics

### Land Deployment

- **Purchase Permanent Castle:** Players can use ETH or Verse to buy plots of land, which serve as their bases. Once deployed, these bases are indestructible.
- **Realms Map:** There are 8,000 lands in the map, each corresponding to a Loot Realm. For now, they only share the name, holder utilies will be added in the future.

### Army Management

- **Purchase Armies:** Players use in-game tokens to purchase armies for their respective factions. 
- **Deploy Armies:** Army can be deployed to specific plots of land. Only one type of faction can be deployed on each command.
- **Garrison Armies:** Players must allocate a certain number of armies to defend occupied plots. Each plot has a maximum garrison limit.

###  Token Impact Mechanism

- **Token Usage:** Players use $TITANS and $FURY tokens to perform in-game actions such as recruiting and deploying armies.
- **Token Flow:** Tokens spent on army recruitment are added to the reward pool, creating a cyclical economy where players are incentivized to participate actively.
- **Staking:** Once player occupied a land, they can stake $TITANS or $FURY on selected land, the staking amount will affect the burning or minting amount of opponet's token.
- **Burning and Minting:** Every time the staking amount of any token is changed, Minting Net Values of both token are recorded on-chain, the values accumulates until an external executor triggle the execute contract.
- **Execution**: Any one who trigger the execution contract is called executor, and will be reward 10% of any token mint.
- **Dynamic Balance:** The idea is to convert players' in-game action, into real world impact, projectile the in-game attacking to token price. Players gaining the actual power on manipulating token trend by expand their empire, but the weak force will still have chance to fight back as their entry cost become extreamly low.

## User Interface

The defult front-end is develop by Purify Lab by leveraging UNIMUD. Players can process all the action in-side the game UI.

![361719387391_.pic](/Users/kaspar/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9/708b6649e814a8cbd9c4f3a001d17c27/Message/MessageTemp/c9aa98a6b5cd446ec503315d25aee8c7/Image/361719387391_.pic.jpg)

MODs and other self-made UI are welcome and encouraged.

## Roadmap

1. **Solidity Version:**
   - Initial development phase focused on integrating with Unity and verifying concepts using uniMUD.
   - Alpha version completion target: End of July.
2. **Testing Phase:**
   - Small-scale tests on Layer 2 solutions to evaluate in-game interactions and mechanics.
   - Duration: 2 weeks to 1 month.
3. **Mainnet Launch:**
   - Finalize and polish the game for release on Verse mainnet with Starknet assets.
   - Expected launch: Concurrent with Verse mainnet launch.
4. **Cairo Version:**
   - Key milestone involving the development of the Cairo version.
   - Start date: Mid-September.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Make your changes and commit them: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Submit a pull request.

## License

MIT

## Contact

For support or collaboration, find us in [Twitter](https://x.com/purifylab_xyz).
