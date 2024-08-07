pragma solidity ^0.8.24;
 
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
 
contract BNBbet is ERC1155, Ownable, ReentrancyGuard {
    using Strings for uint256;
    uint256 public constant Bnbbet = 1;
    uint256 public constant maxBNBbets = 10000;
    uint256 public totalBNBbetSupply = 0;

    string private baseTokenURI = "ipfs://QmfEjEsGWMFtmi1EfspwLzqjDKesr3zb28RTWrG1tkZtDw/";
 
    constructor() ERC1155("ipfs://QmfEjEsGWMFtmi1EfspwLzqjDKesr3zb28RTWrG1tkZtDw/{id}") Ownable(msg.sender){
        
    }

    modifier canMintBNBbets(uint256 _id,uint256 numberOfTokens) {
        require(numberOfTokens > 0,"Mint count must be greater than 0");
        require(
             totalBNBbetSupply + numberOfTokens <=
                maxBNBbets,
            "Not enough bnbbets remaining to mint"
        );
        _;
    }

    // ============ ACCESS CONTROL/SANITY MODIFIERS ============
    modifier isNotContract() {
        require(tx.origin == msg.sender,"contract is not allowed to operate");
        _;
    }
 
    function setBaseURI(string memory baseURI) external onlyOwner {
        baseTokenURI = baseURI;
    }

    function uri(uint256 _tokenid) override public view returns (string memory) {
        return string(
            abi.encodePacked(
                baseTokenURI,
                Strings.toString(_tokenid)
            )
        );
    }

    function airDrop(address to, uint256 amount) 
    external
    isNotContract
    nonReentrant
    onlyOwner
    canMintBNBbets(Bnbbet,amount)
    {
        _mint(to, Bnbbet, amount, "");
        totalBNBbetSupply += amount;
    }

    function burnBnbbet(uint256 amount) 
    external
    isNotContract 
    {   
        
        require(balanceOf(msg.sender, Bnbbet) >= amount, "ERC1155: no enough token");
        _burn(msg.sender, Bnbbet, amount);
    }
}