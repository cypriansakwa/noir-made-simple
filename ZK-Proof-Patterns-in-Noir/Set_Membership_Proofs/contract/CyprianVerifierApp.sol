// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Verifier.sol";

contract CyprianVerifierApp {
    HonkVerifier public verifier;
    uint256 public verifiedCount;

    event ProofVerified(address indexed by, uint256 newCount);

    constructor(HonkVerifier _verifier) {
        verifier = _verifier;
    }

    function getVerifiedCount() public view returns (uint256) {
        return verifiedCount;
    }

    /// @notice Verify a proof with no public inputs.
    function verifyProof(bytes calldata proof) public returns (bool) {
        // Accept any proof length (real ZK proofs are not empty)
        bool result = verifier.verify(proof, new bytes32[](0));
        require(result, "Invalid proof");

        verifiedCount++;
        emit ProofVerified(msg.sender, verifiedCount);
        return result;
    }
}