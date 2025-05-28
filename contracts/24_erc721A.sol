// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.4 <0.9.0;
import "https://github.com/chiru-labs/ERC721A/blob/main/contracts/ERC721A.sol";
import "openzeppelin/contracts/access/Ownable.sol";

contract HYTESTChain is ERC721A, Ownable {
    string private constant SUFFIX_URL = ".json";
    constructor() ERC721A("HYTESTChain", "HYT") {}
    function mint(uint256 quantity) external payable {
        _mint(msg.sender, quantity);
    }

    function safeMint(address to, uint256 quantity) public onlyOwner {
        _mint(to, quantity);
    }

    function _baseURI() internal pure override  returns (string memory) {
        return "https://tickets.hytestchain.com/api";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory)  {
        string memory baseTokenIdUri = super.tokenURI(tokenId);
        return string(abi.encodePacked(baseTokenIdUri, SUFFIX_URL));
    }
}