// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../CyprianVerifierApp.sol";
import "../Verifier.sol";

contract CyprianVerifierAppTest is Test {
    CyprianVerifierApp public verifierApp;
    HonkVerifier public verifier;

    function setUp() public {
        verifier = new HonkVerifier();
        verifierApp = new CyprianVerifierApp(verifier);
    }

    function testVerifyProof() public {
        // Load proof from file
        bytes memory proof = vm.readFileBinary("../circuits/target/proof");
        console.log("Proof length:", proof.length);

        // Call the correct contract function (no publicInputs needed)
        verifierApp.verifyProof(proof);
    }
}