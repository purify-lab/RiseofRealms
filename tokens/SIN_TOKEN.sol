// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
//import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/universal-router/contracts/interfaces/IUniversalRouter.sol";
//import {IAllowanceTransfer} from '@uniswap/universal-router/contracts/permit2/src/interfaces/IAllowanceTransfer.sol';

contract SOUL_TOKEN_AIRDROP is Context, Ownable {
    IERC20 public token;
    bytes32 public merkleRoot;
    mapping(address => uint256) public claimAmounts;
    mapping(address => bool) public claimed;

    constructor(address token_address) Ownable(msg.sender) {
        token = IERC20(token_address);
    }

    function claim(bytes32[] memory proof, uint256 amount) public {
        require(!claimed[msg.sender], "You have already claimed your tokens");
        require(amount > 0, "Amount must be greater than 0");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid Merkle Proof");

        claimed[msg.sender] = true;
        claimAmounts[msg.sender] = amount;
        token.transfer(msg.sender, amount);
    }

    function setMerkleRoot(bytes32 _merkleRoot) public onlyOwner {
        merkleRoot = _merkleRoot;
    }
}

contract SOUL_TOKEN is ERC20, Ownable {
    IUniswapV3Pool public uniswapPool;

    constructor() ERC20("SOUL", "SOUL") Ownable(msg.sender) {

        address airdrop = address(new SOUL_TOKEN_AIRDROP(address(this)));

        // Create a new Uniswap V3 pool
        IUniswapV3Factory uniswapFactory = IUniswapV3Factory(
            0x338F6033D373F610510e0F285637Ef5DDA776742
        );

        uniswapPool = IUniswapV3Pool(uniswapFactory.createPool(
            address(this),
            0x4200000000000000000000000000000000000006,//WETH
            3000  // Fee tier: 0.3%
        ));

        // Initialize the pool
        //uniswapPool.initialize(1 << 96); // Initial price of 1 ETH = 1 SIN
        uniswapPool.initialize(10_000_000 << 96); // Initial price of 1 ETH = 10,000,000 SIN

        // Mint 7,777,777 SIN tokens to the contract owner
        _mint(airdrop, 7_777_777 * 10 ** decimals());

        ////



        TITANS titans = new TITANS();
        FURY fury = new FURY();

        StableSwapPool stablePool = new StableSwapPool(address(this), address(titans), address(fury));
        titans.transfer(address(stablePool), 400_000_000 * 10 ** 18);
        fury.transfer(address(stablePool), 400_000_000 * 10 ** 18);
        titans.transfer(address(msg.sender), 400_000_000 * 10 ** 18);
        fury.transfer(address(msg.sender), 400_000_000 * 10 ** 18);

//        IUniswapV3Pool SOULBPool = IUniswapV3Pool(uniswapFactory.createPool(
//            TITANS,
//            FURY,
//            3000  // Fee tier: 0.3%
//        ));
//
//        SOULBPool.initialize(1 << 96); // Initial price of 1 TOKEN_A = TOKEN_B
    }
}

address constant FACTORY_ADDRESS = 0x338F6033D373F610510e0F285637Ef5DDA776742;
address constant WETH_ADDRESS = 0x4200000000000000000000000000000000000006;
address constant ROUTER_ADDRESS = 0x02b36A5aCa3e51d2E73926E3D3bB59C979B60C78;
address constant NONFUNGIBLE_POSITION_MANAGER_ADDRESS = 0xa46F04F08Ea3AA4e1D22dFEe7f1C014C85Fc2EF9;
address constant PERMIT2_ADDRESS = 0x000000000022D473030F116dDEE9F6B43aC78BA3;

contract TITANS is ERC20, Ownable, ERC20Burnable, IERC721Receiver {

    IUniswapV3Pool public uniswapPool;
    mapping(address => bool) public blacklist;
//    INonfungiblePositionManager public immutable nonfungiblePositionManager;

    constructor() ERC20("TITANS", "TITANS") Ownable(msg.sender) {
        _mint(msg.sender, 800_000_000 * 10 ** decimals());

        // Create a new Uniswap V3 pool
        IUniswapV3Factory uniswapFactory = IUniswapV3Factory(FACTORY_ADDRESS);

        uniswapPool = IUniswapV3Pool(uniswapFactory.createPool(
            address(this),
            WETH_ADDRESS,
            3000  // Fee tier: 0.3%
        ));

        TransferHelper.safeApprove(address(this), ROUTER_ADDRESS, type(uint256).max);

    }

    function addToBlacklist(address account) public onlyOwner {
        blacklist[account] = true;
    }

    function removeFromBlacklist(address account) public onlyOwner {
        blacklist[account] = false;
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(!blacklist[_msgSender()], "MyToken: sender is on the blacklist");
        require(!blacklist[recipient], "MyToken: recipient is on the blacklist");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        require(!blacklist[sender], "MyToken: sender is on the blacklist");
        require(!blacklist[recipient], "MyToken: recipient is on the blacklist");
        return super.transferFrom(sender, recipient, amount);
    }
//
    function getToken0Token1() public view returns (address token0, address token1) {
        if (address(this) < WETH_ADDRESS) {
            return (address(this), WETH_ADDRESS);
        } else {
            return (WETH_ADDRESS, address(this));
        }
    }

//    function ultraMint(address to, int256 amount, bool zeroForOne) public {
//        bytes memory data = new bytes(0);
//        (int256 amount0, int256 amount1) = uniswapPool.swap(to, zeroForOne, amount, 0, data);
////        uniswapPool.mint()
//    }

    function swapExactInputSingle(uint256 titansAmount, uint256 wethAmount) external {
        uint256 deadline = block.timestamp + 60;
        // Approve the router contract to spend DAI
        IERC20(address(this)).approve(ROUTER_ADDRESS, titansAmount);

        // Create an array of commands
        bytes memory commands = new bytes(2);
        commands[0] = 0x0a; // PERMIT2_PERMIT
        commands[1] = 0x00; // V3_SWAP_EXACT_IN

        // Create an array of inputs
        bytes[] memory inputs = new bytes[](2);

        //PERMIT2_PERMIT
        inputs[0] = abi.encode()//无法采用合约代替EOA签名，因为没有私钥

        //V3_SWAP_EXACT_IN
        address recipient = address(msg.sender);//The recipient of the output of the trade
        uint256 input = titansAmount;// The amount of input tokens for the trade
        uint256 output = wethAmount;//The minimum amount of output tokens the user wants
        bytes memory path = abi.encode(address(this), WETH_ADDRESS);
        bool flag = true; //A flag for whether the input tokens should come from the msg.sender (through Permit2) or whether the funds are already in the UniversalRouter
        inputs[1] = abi.encode(recipient, input, output, path, flag);

        // Call the execute function of the universal router contract
        IUniversalRouter universalRouter = IUniversalRouter(ROUTER_ADDRESS);
        universalRouter.execute(commands, inputs, deadline);
    }

    /// @notice Increases liquidity in the current range
    /// @dev Pool must be initialized already to add liquidity
    /// @param tokenId The id of the erc721 token
    /// @param amount0 The amount to add of token0
    /// @param amount1 The amount to add of token1
    function increaseLiquidityCurrentRange(
        uint256 tokenId,
        uint256 amountAdd0,
        uint256 amountAdd1
    )
    external
    returns (
        uint128 liquidity,
        uint256 amount0,
        uint256 amount1
    )
    {
//        INonfungiblePositionManager.IncreaseLiquidityParams memory params = INonfungiblePositionManager.IncreaseLiquidityParams({
//                tokenId: tokenId,
//                amount0Desired: amountAdd0,
//                amount1Desired: amountAdd1,
//                amount0Min: 0,
//                amount1Min: 0,
//                deadline: block.timestamp
//            });
//
//        (liquidity, amount0, amount1) = nonfungiblePositionManager.increaseLiquidity(params);
    }

    function onERC721Received(
        address operator,
        address,
        uint256 tokenId,
        bytes calldata
    ) external override returns (bytes4) {
        // get position information

        //todo
//        _createDeposit(operator, tokenId);

        return this.onERC721Received.selector;
    }

//    function ultraMint(address to, int256 amount, bool zeroForOne, uint256 userTokenAmount) public {
//        bytes memory data = new bytes(0);
//
//        // Transfer user tokens to the contract
//        require(IERC20(address(this)).transferFrom(msg.sender, address(this), userTokenAmount), "Failed to transfer user tokens");
//
//        // Swap the user tokens using the Uniswap V3 pool
//        (int256 amount0, int256 amount1) = uniswapPool.swap(to, zeroForOne, amount, 0, data);
//
//        // Refund any unused user tokens
//        uint256 unusedTokens = IERC20(address(this)).balanceOf(address(this)) - userTokenAmount;
//        if (unusedTokens > 0) {
//            IERC20(address(this)).transfer(msg.sender, unusedTokens);
//        }
//    }

}

contract FURY is ERC20, Ownable, ERC20Burnable {

    IUniswapV3Pool public uniswapPool;
    mapping(address => bool) public blacklist;

    constructor() ERC20("FURY", "FURY") Ownable(msg.sender) {
        _mint(msg.sender, 800_000_000 * 10 ** decimals());

        // Create a new Uniswap V3 pool
        IUniswapV3Factory uniswapFactory = IUniswapV3Factory(
            0x338F6033D373F610510e0F285637Ef5DDA776742
        );

        uniswapPool = IUniswapV3Pool(uniswapFactory.createPool(
            address(this),
            0x4200000000000000000000000000000000000006,//WETH
            3000  // Fee tier: 0.3%
        ));
    }

    function addToBlacklist(address account) public onlyOwner {
        blacklist[account] = true;
    }

    function removeFromBlacklist(address account) public onlyOwner {
        blacklist[account] = false;
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(!blacklist[_msgSender()], "MyToken: sender is on the blacklist");
        require(!blacklist[recipient], "MyToken: recipient is on the blacklist");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        require(!blacklist[sender], "MyToken: sender is on the blacklist");
        require(!blacklist[recipient], "MyToken: recipient is on the blacklist");
        return super.transferFrom(sender, recipient, amount);
    }
}

contract StakingContract is Pausable, Ownable {
    uint256 public unStakeFee;
    address public unStakeFeeAddress;

    IERC20 public SOUL;
    IERC20 public TITANS_TOKEN;

    struct Stake {
        uint256 tokenType;
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => Stake[]) public stakes;

    event Staked(address indexed user, uint256 tokenType, uint256 amount);
    event Withdrawn(address indexed user, uint256 tokenType, uint256 amount, uint256 fee);
    event UnstakeFeeRateChanged(uint256 newRate);
    event UnstakeFeeAddressChanged(address newAddress);

    constructor(address _SOUL, address _TITANS) Ownable(msg.sender) {
        SOUL = IERC20(_SOUL);
        TITANS_TOKEN = IERC20(_TITANS);
        unStakeFee = 2; // 2%
        unStakeFeeAddress = msg.sender;
    }

    function stakeTokens(uint256 tokenType, uint256 amount) public whenNotPaused {
        require(tokenType == 0 || tokenType == 1, "Invalid token type");
        require(amount > 0, "Cannot stake 0 tokens");

        IERC20 token = tokenType == 0 ? SOUL : TITANS_TOKEN;
        token.transferFrom(msg.sender, address(this), amount);

        stakes[msg.sender].push(Stake(tokenType, amount, block.timestamp));

        emit Staked(msg.sender, tokenType, amount);
    }

    function unStakeTokens(uint256 tokenType, uint256 amount) public whenNotPaused {
        require(tokenType == 0 || tokenType == 1, "Invalid token type");

        Stake[] storage userStakes = stakes[msg.sender];
        uint256 totalAmount = 0;
        uint256 index = 0;

        for (uint256 i = 0; i < userStakes.length; i++) {
            if (userStakes[i].tokenType == tokenType) {
                if (userStakes[i].amount <= amount) {
                    amount -= userStakes[i].amount;
                    totalAmount += userStakes[i].amount;
                    index = i;
                } else {
                    userStakes[i].amount -= amount;
                    totalAmount += amount;
                    break;
                }
            }
        }

        require(totalAmount >= amount, "Insufficient staked tokens");

        uint256 fee = (totalAmount * unStakeFee) / 100;
        uint256 amountAfterFee = totalAmount - fee;

        IERC20 token = tokenType == 0 ? SOUL : TITANS_TOKEN;
        token.transfer(msg.sender, amountAfterFee);
        token.transfer(unStakeFeeAddress, fee);

        if (amount == userStakes[index].amount) {
            userStakes[index] = userStakes[userStakes.length - 1];
            userStakes.pop();
        }

        emit Withdrawn(msg.sender, tokenType, amountAfterFee, fee);
    }

    function setUnStakeFeeRate(uint256 rate) public onlyOwner {
        require(rate <= 100, "Unstake fee rate cannot exceed 100%");
        unStakeFee = rate;
        emit UnstakeFeeRateChanged(rate);
    }

    function setUnstakeFeeAddress(address _addr) public onlyOwner {
        unStakeFeeAddress = _addr;
        emit UnstakeFeeAddressChanged(_addr);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}

contract StableSwapPool is Pausable {
    IERC20 public SOUL;
    IERC20 public TITANS_TOKEN;
    IERC20 public FURY_TOKEN;

    constructor(address _SOUL, address _TITANS, address _FURY) {
        SOUL = IERC20(_SOUL);
        TITANS_TOKEN = IERC20(_TITANS);
        FURY_TOKEN = IERC20(_FURY);
    }

    function swapA2B(uint256 amount) public whenNotPaused {
        SOUL.transferFrom(msg.sender, address(this), amount);
        TITANS_TOKEN.transfer(msg.sender, amount);
    }

    function swapA2C(uint256 amount) public whenNotPaused {
        SOUL.transferFrom(msg.sender, address(this), amount);
        FURY_TOKEN.transfer(msg.sender, amount);
    }
}


