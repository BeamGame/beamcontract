// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract Beamon is
    Initializable,
    ERC721Upgradeable,
    ERC721BurnableUpgradeable,
    AccessControlUpgradeable
{
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 private _nextTokenId;
    string public uri;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        address defaultAdmin,
        address minter,
        string calldata _uri
    ) public initializer {
        __ERC721_init("Beamon", "BM");
        __ERC721Burnable_init();
        __AccessControl_init();

        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
        uri = _uri;
    }

    function _baseURI() internal view override returns (string memory) {
        return uri;
    }

    function safeMint(address to) public onlyRole(MINTER_ROLE) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    function updateUri(string calldata newUri) public onlyRole(MINTER_ROLE) {
        uri = newUri;
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
