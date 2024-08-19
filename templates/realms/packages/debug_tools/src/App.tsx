import {useMUD} from "./MUDContext";
import {useState} from 'react';

const styleUnset = {all: "unset"} as const;

export const App = () => {
  const {
    network: {useStore},
    systemCalls: {spawnPlayer, marchArmy},
  } = useMUD();

  const [marchData, setMarchData] = useState({
    destination: '',
    infantry: '',
    cavalryA: '',
    cavalryB: '',
    cavalryC: '',
    army_id: '',
  });

  const handleSpawnPlayer = () => {
    spawnPlayer();
  };

  const handleMarchInputChange = (event: any) => {
    const {name, value} = event.target;
    setMarchData((prevData) => ({...prevData, [name]: value}));
  };

  const handleMarch = () => {
    console.log(marchData);
    // marchArmy(marchData);
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
    </>
  );
};