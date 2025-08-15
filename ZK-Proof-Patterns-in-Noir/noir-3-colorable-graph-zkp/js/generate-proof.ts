import { Noir } from "@noir-lang/noir_js";
import { UltraHonkBackend } from "@aztec/bb.js";
import circuit from "../circuits/target/noir_3_colorable_graph_zkp.json";
import fs from "fs";

(async () => {
  try {
    const noir = new Noir(circuit as any);
    const honk = new UltraHonkBackend(circuit.bytecode, { threads: 1 });

    // CORRECT input shape
    const inputs = {
      inputs: {
        coloring: [0, 1, 2, 0, 1],
        edges_u: [0, 1, 2, 3, 0, 4],
        edges_v: [1, 2, 3, 4, 2, 3]
      }
    };

    const { witness } = await noir.execute(inputs);
    const { proof, publicInputs } = await honk.generateProof(witness, { keccak: true });

    fs.writeFileSync("../circuits/target/proof", proof);
    fs.writeFileSync("../circuits/target/public-inputs", JSON.stringify(publicInputs));

    console.log("Proof generated successfully");
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();