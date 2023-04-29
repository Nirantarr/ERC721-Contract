// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract nftmint is ERC721, Ownable{

 using Strings for uint256;
 uint256 public constant Max_Tokens = 10000;
 uint256 private constant Tokens_Reserved =1;
 uint256 public totalSupply;
 string public baseUri;
 string public baseExtension = ".json";

 constructor() ERC721("Brew-Block", "bb"){
//  base ipfs uri of demo nfts
     baseUri="ipfs://bafybeih4xpnrbnunng3hwxgvthgo3jz5fouvvkuryg225n4vch67lvnoqi/";
    //  loop will mint nft's equal to Tokens_Reserved while deploying
     for(uint256 i=1; i<=Tokens_Reserved; i++){
     _safeMint(msg.sender, i);
 }
 totalSupply= Tokens_Reserved;
 }

//  Minting Function
 function mint(uint256 _numTokens) external payable{
     uint256 curTotalSupply = totalSupply;
     require(curTotalSupply + _numTokens<=Max_Tokens,"Exceeds max tokens");
     for(uint256 i=1; i<=_numTokens; i++){
         _safeMint(msg.sender, curTotalSupply+i);
     }
     totalSupply += _numTokens;
 }
// Function to set baseUri
 function setBaseURI(string memory _baseUri) external onlyOwner{
     baseUri= _baseUri;
 }
// Function to get funds out of contract if in case Royalties charged.
 function withdrawAll() external payable onlyOwner{
     uint256 balance = address(this).balance;
     (bool transferOne, ) = payable(0xEnterAddress).call{value:balance}("");
     require(transferOne,"Transaction failed");
 }
// Function to set Tokenuri
 function tokenURI(uint256 tokenId) public view virtual override returns(string memory){
     require(_exists(tokenId),"ERC721Metadata: URI query for nonexistent token");
      string memory currentBaseURI = _baseURI();
      return bytes(currentBaseURI).length>0 ? string(abi.encodePacked(currentBaseURI, tokenId.toString(),baseExtension)):"";
 }

 function _baseURI() internal view virtual override returns (string memory){
     return baseUri;
 }

}