import {useMUD} from "./MUDContext";
import {useState} from 'react';

const styleUnset = {all: "unset"} as const;

export const App = () => {
  const {
    network: { tables, useStore },
    systemCalls: {
      spawnPlayer, spawnCapital,
      marchArmy, attack, garrison,
      buyInfantry, buyCavalryA, buyCavalryB, buyCavalryC,
      stakeTokenB, stakeTokenC, unStakeTokenB, unStakeTokenC, farming,
      setMerkleRoot, claim, swapA2B, swapA2C, withdrawToken,
      // getCapitalPower
    }
  } = useMUD();


  const PlayerDetail = useStore((state) => {
    const records = Object.values(state.getRecords(tables.PlayerDetail));
    return records;
  });


  (window as any).mud = {
    // state:state,
    data:{
      PlayerDetail
    },
    tables: tables,
    method: {
      spawnPlayer: spawnPlayer,
      buyInfantry: buyInfantry
    }
  }

  const [marchData, setMarchData] = useState({
    destination: '',
    infantry: '',
    cavalryA: '',
    cavalryB: '',
    cavalryC: '',
    army_id: '',
  });

  const [attackData, setAttackData] = useState({
    army_id: '',
  });

  const handleSpawnPlayer = () => {
    spawnPlayer();
  };

  const handleMarchInputChange = (event: any) => {
    const {name, value} = event.target;
    setMarchData((prevData) => ({...prevData, [name]: value}));
  };

  const [buyInfantryData, setBuyInfantryData] = useState({
    amount: '',
  });

  const handleBuyInfantryAmontInputChange = (event: any) => {
    const {name, value} = event.target;
    setBuyInfantryData((prevData) => ({...prevData, [name]: value}));
  }

  const handleAttackInputChange = (event: any) => {
    const {name, value} = event.target;
    setAttackData((prevData) => ({...prevData, [name]: value}));
  };

  const handleMarch = () => {
    console.log(marchData);
    marchArmy(
      Number(marchData.destination),
      Number(marchData.infantry),
      Number(marchData.cavalryA),
      Number(marchData.cavalryB),
      Number(marchData.cavalryC),
      Number(marchData.army_id)
    );
  };

  const handleAttack = () => {
    console.log(attackData);
    attack(Number(attackData.army_id));
  };

  const [garrisonData, setGarrisonData] = useState({
    capital_id: '',
    infantry: '',
    cavalryA: '',
    cavalryB: '',
    cavalryC: '',
  });

  const handleGarrisonInputChange = (event: any) => {
    const {name, value} = event.target;
    setGarrisonData((prevData) => ({...prevData, [name]: value}));
  };

  const handleGarrison = () => {
    console.log(garrisonData);
    garrison(
      Number(garrisonData.capital_id),
      Number(garrisonData.infantry),
      Number(garrisonData.cavalryA),
      Number(garrisonData.cavalryB),
      Number(garrisonData.cavalryC)
    );
  };


  const handleBuyInfantry = () => {
    console.log(buyInfantryData);
    buyInfantry(Number(buyInfantryData.amount));
  };


  const [buyCavalryAData, setBuyCavalryAData] = useState({
    amount: '',
  });

  const [buyCavalryBData, setBuyCavalryBData] = useState({
    amount: '',
  });

  const [buyCavalryCData, setBuyCavalryCData] = useState({
    amount: '',
  });

  const handleBuyCavalryAInputChange = (event: any) => {
    const {name, value} = event.target;
    setBuyCavalryAData((prevData) => ({...prevData, [name]: value}));
  }

  const handleBuyCavalryBInputChange = (event: any) => {
    const {name, value} = event.target;
    setBuyCavalryBData((prevData) => ({...prevData, [name]: value}));
  }

  const handleBuyCavalryCInputChange = (event: any) => {
    const {name, value} = event.target;
    setBuyCavalryCData((prevData) => ({...prevData, [name]: value}));
  }

  const handleBuyCavalryA = () => {
    console.log(buyCavalryAData);
    buyCavalryA(Number(buyCavalryAData.amount));
  };

  const handleBuyCavalryB = () => {
    console.log(buyCavalryBData);
    buyCavalryB(Number(buyCavalryBData.amount));
  };

  const handleBuyCavalryC = () => {
    console.log(buyCavalryCData);
    buyCavalryC(Number(buyCavalryCData.amount));
  };

  const [spawnCapitalData, setSpawnCapitalData] = useState({
    capital_id: '',
  });

  const handleSpawnCapitalInputChange = (event: any) => {
    const {name, value} = event.target;
    setSpawnCapitalData((prevData) => ({...prevData, [name]: value}));
  }

  const handleSpawnCapital = () => {
    console.log(spawnCapitalData);
    spawnCapital(Number(spawnCapitalData.capital_id));
  }

  const [stakeTokenBData, setStakeTokenBData] = useState({
    amount: '',
  });

  const handleStakeTokenBInputChange = (event: any) => {
    const {name, value} = event.target;
    setStakeTokenBData((prevData) => ({...prevData, [name]: value}));
  }

  const handleStakeTokenB = () => {
    console.log(stakeTokenBData);
    stakeTokenB(Number(stakeTokenBData.amount));
  }

  const [stakeTokenCData, setStakeTokenCData] = useState({
    amount: '',
  });

  const handleStakeTokenCInputChange = (event: any) => {
    const {name, value} = event.target;
    setStakeTokenCData((prevData) => ({...prevData, [name]: value}));
  }

  const handleStakeTokenC = () => {
    console.log(stakeTokenCData);
    stakeTokenC(Number(stakeTokenCData.amount));
  }


  const [farmingData, setSetFarmingData] = useState({
    capital_id: ""
  });

  const handleSetFarmingInputChange = (event: any) => {
    const {name, value} = event.target;
    setSetFarmingData((prevData) => ({...prevData, [name]: value}));
  }

  const handleFarming = () => {
    console.log(farmingData);
    farming(Number(farmingData.capital_id));
  }

  const [claimData, setClaimData] = useState({
    proof: "",
    amount: ""
  });

  const handleClaimInputChange = (event: any) => {
    const {name, value} = event.target;
    setClaimData((prevData) => ({...prevData, [name]: value}));
  }

  const handleClaim = () => {
    console.log(claimData);
    claim(claimData.proof.split(','), Number(claimData.amount));
  }

  const [merkleRootData, setMerkleRootData] = useState({
    merkleRoot: ""
  });

  const handleSetMerkleRootInputChange = (event: any) => {
    const {name, value} = event.target;
    setMerkleRootData((prevData) => ({...prevData, [name]: value}));
  }

  const handleSetMerkleRoot = () => {
    console.log(merkleRootData);
    setMerkleRoot(merkleRootData.merkleRoot);
  }

  const [swapA2BData, setSwapA2BData] = useState({
    amount: ""
  });

  const handleSwapA2BInputChange = (event: any) => {
    const {name, value} = event.target;
    setSwapA2BData((prevData) => ({...prevData, [name]: value}));
  }

  const handleSwapA2B = () => {
    console.log(swapA2BData);
    swapA2B(Number(swapA2BData.amount));
  }

  const [swapA2CData, setSwapA2CData] = useState({
    amount: ""
  });

  const handleSwapA2CInputChange = (event: any) => {
    const {name, value} = event.target;
    setSwapA2CData((prevData) => ({...prevData, [name]: value}));
  }

  const handleSwapA2C = () => {
    console.log(swapA2CData);
    swapA2C(Number(swapA2CData.amount));
  }

  const [withdrawTokenData, setWithdrawTokenData] = useState({
    token_address: "",
    amount: ""
  });

  const handleWithdrawTokenInputChange = (event: any) => {
    const {name, value} = event.target;
    setWithdrawTokenData((prevData) => ({...prevData, [name]: value}));
  }

  const handleWithdrawToken = () => {
    console.log(withdrawTokenData);
    withdrawToken(withdrawTokenData.token_address, Number(withdrawTokenData.amount));
  }

  const [unStakeTokenBData, setUnStakeTokenBData] = useState({
    staker: "",
    amount: ""
  });

  const handleUnStakeTokenBInputChange = (event: any) => {
    const {name, value} = event.target;
    setUnStakeTokenBData((prevData) => ({...prevData, [name]: value}));
  }

  const handleUnStakeTokenB = () => {
    console.log(unStakeTokenBData);
    unStakeTokenB(unStakeTokenBData.staker, Number(unStakeTokenBData.amount));
  }

  const [unStakeTokenCData, setUnStakeTokenCData] = useState({
    staker: "",
    amount: ""
  });

  const handleUnStakeTokenCInputChange = (event: any) => {
    const {name, value} = event.target;
    setUnStakeTokenCData((prevData) => ({...prevData, [name]: value}));
  }

  const handleUnStakeTokenC = () => {
    console.log(unStakeTokenCData);
    unStakeTokenC(unStakeTokenCData.staker, Number(unStakeTokenCData.amount));
  }

  return (
    <>
      <div style={{gridRowGap: "10px", display: "grid"}}>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <button onClick={handleSpawnPlayer}>Spawn Player</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="destination"
            placeholder="destination"
            value={marchData.destination}
            onChange={handleMarchInputChange}
          />
          <input
            name="infantry"
            placeholder="infantry"
            value={marchData.infantry}
            onChange={handleMarchInputChange}
          />
          <input
            name="cavalryA"
            placeholder="cavalryA"
            value={marchData.cavalryA}
            onChange={handleMarchInputChange}
          />
          <input
            name="cavalryB"
            placeholder="cavalryB"
            value={marchData.cavalryB}
            onChange={handleMarchInputChange}
          />
          <input
            name="cavalryC"
            placeholder="cavalryC"
            value={marchData.cavalryC}
            onChange={handleMarchInputChange}
          />
          <input
            name="army_id"
            placeholder="army_id"
            value={marchData.army_id}
            onChange={handleMarchInputChange}
          />
          <button onClick={handleMarch}>March</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="army_id"
            placeholder="army_id"
            value={attackData.army_id}
            onChange={handleAttackInputChange}
          />
          <button onClick={handleAttack}>Attack</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="capital_id"
            placeholder="capital_id"
            value={garrisonData.capital_id}
            onChange={handleGarrisonInputChange}
          />
          <input
            name="infantry"
            placeholder="infantry"
            value={garrisonData.infantry}
            onChange={handleGarrisonInputChange}
          />
          <input
            name="cavalryA"
            placeholder="cavalryA"
            value={garrisonData.cavalryA}
            onChange={handleGarrisonInputChange}
          />
          <input
            name="cavalryB"
            placeholder="cavalryB"
            value={garrisonData.cavalryB}
            onChange={handleGarrisonInputChange}
          />
          <input
            name="cavalryC"
            placeholder="cavalryC"
            value={garrisonData.cavalryC}
            onChange={handleGarrisonInputChange}
          />
          <button onClick={handleGarrison}>Garrison</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={buyInfantryData.amount}
            onChange={handleBuyInfantryAmontInputChange}
          />
          <button onClick={handleBuyInfantry}>buyInfantry</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={buyCavalryAData.amount}
            onChange={handleBuyCavalryAInputChange}
          />
          <button onClick={handleBuyCavalryA}>buyCavalryA</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={buyCavalryBData.amount}
            onChange={handleBuyCavalryBInputChange}
          />
          <button onClick={handleBuyCavalryB}>buyCavalryB</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={buyCavalryCData.amount}
            onChange={handleBuyCavalryCInputChange}
          />
          <button onClick={handleBuyCavalryC}>buyCavalryC</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="capital_id"
            placeholder="capital_id"
            value={spawnCapitalData.capital_id}
            onChange={handleSpawnCapitalInputChange}
          />
          <button onClick={handleSpawnCapital}>Spawn Capital</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={stakeTokenBData.amount}
            onChange={handleStakeTokenBInputChange}
          />
          <button onClick={handleStakeTokenB}>Stake Token B</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={stakeTokenCData.amount}
            onChange={handleStakeTokenCInputChange}
          />
          <button onClick={handleStakeTokenC}>Stake Token C</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="staker"
            placeholder="staker"
            value={unStakeTokenBData.staker}
            onChange={handleUnStakeTokenBInputChange}
          />
          <input
            name="amount"
            placeholder="amount"
            value={unStakeTokenBData.amount}
            onChange={handleUnStakeTokenBInputChange}
          />
          <button onClick={handleUnStakeTokenB}>UnStake Token B</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="staker"
            placeholder="staker"
            value={unStakeTokenCData.staker}
            onChange={handleUnStakeTokenCInputChange}
          />
          <input
            name="amount"
            placeholder="amount"
            value={unStakeTokenCData.amount}
            onChange={handleUnStakeTokenCInputChange}
          />
          <button onClick={handleUnStakeTokenC}>UnStake Token C</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="capital_id"
            placeholder="capital_id"
            value={farmingData.capital_id}
            onChange={handleSetFarmingInputChange}
          />
          <button onClick={handleFarming}>Farming</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="proof"
            placeholder="proof"
            value={claimData.proof}
            onChange={handleClaimInputChange}
          />
          <input
            name="amount"
            placeholder="amount"
            value={claimData.amount}
            onChange={handleClaimInputChange}
          />
          <button onClick={handleClaim}>Claim Airdrop</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="merkleRoot"
            placeholder="merkleRoot"
            value={merkleRootData.merkleRoot}
            onChange={handleSetMerkleRootInputChange}
          />
          <button onClick={handleSetMerkleRoot}>Set Merkle Root</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={swapA2BData.amount}
            onChange={handleSwapA2BInputChange}
          />
          <button onClick={handleSwapA2B}>Swap A2B</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="amount"
            placeholder="amount"
            value={swapA2CData.amount}
            onChange={handleSwapA2CInputChange}
          />
          <button onClick={handleSwapA2C}>Swap A2C</button>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
          <input
            name="token_address"
            placeholder="token_address"
            value={withdrawTokenData.token_address}
            onChange={handleWithdrawTokenInputChange}
          />
          <input
            name="amount"
            placeholder="amount"
            value={withdrawTokenData.amount}
            onChange={handleWithdrawTokenInputChange}
          />
          <button onClick={handleWithdrawToken}>Withdraw Token</button>
        </div>

        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>
        <div style={{backgroundColor: "gray", padding: "5px"}}>
        </div>


        <div>
        </div>
      </div>
    </>
  );
};