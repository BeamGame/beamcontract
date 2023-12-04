// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol';

contract TokenOwner {

    function getOwners(address _contract, uint256[] calldata ids) external view returns (address[] memory owners) {
        owners = new address[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {            
            try IERC721(_contract).ownerOf(ids[i]) returns (address owner) {
            owners[i] = owner;
            } catch {
            owners[i] = address(0);
            }
        }
    }
    
}