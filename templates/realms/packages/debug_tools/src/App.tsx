import { useMUD } from "./MUDContext";
import { useState } from 'react';

const styleUnset = { all: "unset" } as const;

export const App = () => {
  const {
    network: { useStore },
    systemCalls: { spawnPlayer, marchArmy, attack ,garrison},
  } = useMUD();

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
    const { name, value } = event.target;
    setMarchData((prevData) => ({ ...prevData, [name]: value }));
  };

  const handleAttackInputChange = (event: any) => {
    const { name, value } = event.target;
    setAttackData((prevData) => ({ ...prevData, [name]: value }));
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
    const { name, value } = event.target;
    setGarrisonData((prevData) => ({ ...prevData, [name]: value }));
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

  return (
    <>
      <div style={{border: "red 1px solid"}}>
        <button onClick={handleSpawnPlayer}>Spawn Player</button>
      </div>
      <div style={{border: "red 1px solid"}}>
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
      <div style={{border: "red 1px solid"}}>
        <input
          name="army_id"
          placeholder="army_id"
          value={attackData.army_id}
          onChange={handleAttackInputChange}
        />
        <button onClick={handleAttack}>Attack</button>
      </div>
      <div style={{border: "red 1px solid"}}>
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
    </>
  );
};