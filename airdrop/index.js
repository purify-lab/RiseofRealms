const {MerkleTree} = require('merkletreejs');
const SHA256 = require('crypto-js/sha256');
const {keccak256} = require('js-sha3');
const ethers = require('ethers');

function hashWithSenderAndAmount(sender, amount) {
    const encodedData = ethers.utils.defaultAbiCoder.encode(
        ['address', 'uint256'],
        [sender, amount]
    );
    const hash = keccak256(encodedData);
    return hash;
}

const whitelistAddress = [
    '0x6dC0c0be4c8B2dFE750156dc7d59FaABFb5B923D',
    '0xa8d17cc9caf29af964d19267ddeb4dff122697b0'
];

const leaves = whitelistAddress.map(x => SHA256(x))
const tree = new MerkleTree(leaves, SHA256)
const root = tree.getRoot().toString('hex')


console.log("root:" + root);

// const leaf = SHA256('a')
// const proof = tree.getProof(leaf)
// console.log(tree.verify(proof, leaf, root)) // true

//
// const badLeaves = ['a', 'x', 'c'].map(x => SHA256(x))
// const badTree = new MerkleTree(badLeaves, SHA256)
// const badLeaf = SHA256('x')
// const badProof = badTree.getProof(badLeaf)
// console.log(badTree.verify(badProof, badLeaf, root)) // false