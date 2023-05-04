// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MultiMintNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    constructor() ERC721("Demo Nft", "DNN") {
    }
    // tokenURI=https://bafybeidui2imugvtvbljtj2u3z3sg2phj3arikit7ph3qayqaskn5w7rfe.ipfs.nftstorage.link/1.json
    // baseURI=ipfs://bafybeidui2imugvtvbljtj2u3z3sg2phj3arikit7ph3qayqaskn5w7rfe/
    function mintNFT(uint256 numCopies,string memory tokenURI) public returns (uint256) {
        require(numCopies > 0, "Must mint at least one NFT");
        for (uint256 i = 0; i < numCopies; i++) {
            _tokenIdCounter.increment();
            uint256 tokenId = _tokenIdCounter.current();
            _mint(msg.sender, tokenId);
            _setTokenURI(tokenId, tokenURI);
        }
        return _tokenIdCounter.current() - 1;
    }
}
