import {AbiCoder} from "ethers";
const inputForFunction1 = "0x000000000000000000000000c6dd7d2374073d4c1a4de12ed54e0f436572f917000000000000000000000000ffffffffffffffffffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000066a488de000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002b36a5aca3e51d2e73926e3d3bb59c979b60c7800000000000000000000000000000000000000000000000000000000667d02e600000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000041aba29adf251e846e778fa68f11a98205d4a1916d0a47fafc31fc203ca3b43f816661ad0ddb05a9f5e569208f7d7585e9d0a6a8e5fd78784ca1c5084142ac33f81b00000000000000000000000000000000000000000000000000000000000000";
const inputForFunction2 = "0x00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000de0b6b3a7640000000000000000000000000000000000000000000000000000000000e543e6f83400000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002bc6dd7d2374073d4c1a4de12ed54e0f436572f9170001f44200000000000000000000000000000000000006000000000000000000000000000000000000000000";
function extractPathFromV3(fullPath, reverse = false) {
    const fullPathWithoutHexSymbol = fullPath.substring(2);
    let path = [];
    let currentAddress = "";
    for (let i = 0; i < fullPathWithoutHexSymbol.length; i++) {
        currentAddress += fullPathWithoutHexSymbol[i];
        if (currentAddress.length === 40) {
            path.push('0x' + currentAddress);
            i = i + 6;
            currentAddress = "";
        }
    }
    if (reverse) {
        return path.reverse();
    }
    return path;
}
const abiCoder = new AbiCoder();
let decoded2 = abiCoder.decode(["address", "uint256", "uint256", "bytes", "bool"], inputForFunction2);
console.log(decoded2);
console.log(extractPathFromV3(decoded2[3]))
// struct PermitSingle {
//     // the permit data for a single token allowance
//     PermitDetails details;
//     // address permissioned on the allowed tokens
//     address spender;
//     // deadline on the permit signature
//     uint256 sigDeadline;
// }
//
// struct PermitDetails {
//     // ERC20 token address
//     address token;
//     // the maximum amount allowed to spend
//     uint160 amount;
//     // timestamp at which a spender's token allowances become invalid
//     uint48 expiration;
//     // an incrementing value indexed per owner,token,and spender for each signature
//     uint48 nonce;
// }
const str_types = "tuple(tuple(address,uint160,uint48,uint48),address,uint256)"
let decoded1 = abiCoder.decode([str_types,"bytes"], inputForFunction1)
console.log(decoded1);

