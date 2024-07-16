const {MerkleTree} = require('merkletreejs');
const SHA256 = require('crypto-js/sha256');
const {keccak256} = require('js-sha3');
const ethers = require('ethers');
const xlsx = require('xlsx');


function readExcelFile(filePath, sheetName) {
    const workbook = xlsx.readFile(filePath);
    const worksheet = workbook.Sheets[sheetName];
    const data = xlsx.utils.sheet_to_json(worksheet);
    return data;
}

function hashWithSenderAndAmount(sender, amount) {
    const encodedData = ethers.utils.defaultAbiCoder.encode(
        ['address', 'uint256'],
        [sender.toLowerCase(), amount]
    );
    const hash = keccak256(encodedData);
    return hash;
}


const list = readExcelFile(__dirname + '/airdrop.xlsx', "Sheet1");
let leaves = [];
for (let i = 0; i < list.length; i++) {
    const item = list[i];
    const leaf = hashWithSenderAndAmount(item.address, item.amount);
    list[i].leaf = leaf;
    leaves.push(leaf);
    // console.log(list[i]);
}
// console.log(e);


leaves = leaves.map(x => SHA256(x))
const tree = new MerkleTree(leaves, SHA256)
const root = tree.getRoot().toString('hex')


console.log("root:" + root);
for (let i = 0; i < list.length; i++) {
    const item = list[i];
    const proof = tree.getProof(SHA256(item.leaf))
    const proof_hex = proof.map(x => x.data.toString('hex'));
    list[i].proof = proof_hex;
}

console.log(list);

// const leaf = SHA256('767740d0b2bae59aa198890ef824c3e30e7fe0b64a356e24ca5560009ca37dfc')
// const proof = tree.getProof(leaf)
// const proof_hex = proof.map(x => x.data.toString('hex'));
// console.log(proof_hex);
// console.log(tree.verify(proof, leaf, root)) // true

//
// const badLeaves = ['a', 'x', 'c'].map(x => SHA256(x))
// const badTree = new MerkleTree(badLeaves, SHA256)
// const badLeaf = SHA256('x')
// const badProof = badTree.getProof(badLeaf)
// console.log(badTree.verify(badProof, badLeaf, root)) // false