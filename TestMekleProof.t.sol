// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {MerkleProof} from "MerkleTree.sol";

contract TestMerkleProof is MerkleProof{
    bytes32[] hashes; 

    constructor(){
    string[4] memory transactions =
            ["alice -> bob", "bob -> dave", "carol -> alice", "dave -> bob"];

        for (uint256 i = 0; i < transactions.length; i++) {
            hashes.push(keccak256(abi.encodePacked(transactions[i])));
        }

        uint256 n = transactions.length;
        uint256 offset = 0;

        while(n>0){
            for(uint i=0; i < n-1; i +=2){
                keccak256(abi.encodePacked(hashes[offset+i], hashes[offset+i+1]));
            }
            offset += n; 
            n /= 2; 
        }
    }

    function getRoot() public view returns(bytes32){
        return hashes[hashes.length-1]; 
    }
}