pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop} from "../codegen/index.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";
import {MerkleProof} from "../utility/MerkleProof.sol";

contract AirDropSystem is System {

    address constant TokenA = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;

    function claim(bytes32[] memory proof, uint256 amount) public {
        require(!PlayerAirdrop.get(_msgSender()), "You have already claimed your tokens");
        require(amount > 0, "Amount must be greater than 0");

        bytes32 merkleRoot = GlobalConfig.getMerkleRoot();
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid Merkle Proof");

        PlayerAirdrop.set(_msgSender(), true);
        IERC20(TokenA).transfer(_msgSender(), amount);
    }

    function setMerkleRoot(bytes32 _merkleRoot) public onlyOwner {
        GlobalConfig.setMerkleRoot(_merkleRoot);
    }

    modifier onlyOwner() {
        require(_msgSender() == GlobalConfig.getOwner(), "Only the contract owner can call this function.");
        _;
    }

}