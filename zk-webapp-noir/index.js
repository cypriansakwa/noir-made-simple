import { UltraHonkBackend } from '@aztec/bb.js';
import { Noir } from '@noir-lang/noir_js';
import circuit from "./circuit/target/circuit.json";
const show = (id, content) => {
	const container = document.getElementById(id);
	container.appendChild(document.createTextNode(content));
	container.appendChild(document.createElement("br"));
};
		
document.getElementById("submit").addEventListener("click", async () => {
	try {
	const noir = new Noir(circuit);
    const backend = new UltraHonkBackend(circuit.bytecode);
    // --- Put the lines here! ---
    const age = document.getElementById("age").value;
    show("logs", "Generating witness... ");
    const { witness } = await noir.execute({ age });
    show("logs", "Generated witness... ");

    show("logs", "Generating proof... ");
    const proof = await backend.generateProof(witness);
    show("logs", "Generated proof... ");
    show("results", proof.proof);
    show('logs', 'Verifying proof... ');
		const isValid = await backend.verifyProof(proof);
		show("logs", `Proof is ${isValid ? "valid" : "invalid"}... `);
    // --- Up to here ---
	} catch {
		show("logs", "Oh ");
	}
});