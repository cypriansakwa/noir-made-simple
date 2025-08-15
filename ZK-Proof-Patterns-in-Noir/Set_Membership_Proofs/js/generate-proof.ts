import { Noir } from "@noir-lang/noir_js";
import { UltraHonkBackend } from "@aztec/bb.js";
import circuit from "../circuits/target/Set_Membership_Proofs.json";
import fs from "fs";

(async () => {
  try {
    const noir = new Noir(circuit as any);
    const honk = new UltraHonkBackend(circuit.bytecode, { threads: 1 });

    // CORRECT input shape
    const inputs = {
      inputs: {
        secret_country: 42,
        set0: 1,
        set1: 2,
        set2: 42,
        set3: 4,
        set4: 5
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