// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    error InvalidItem();

    enum InGameItems {
        SuperHero,
        BestVillian,
        HighestWin,
        BestCaptain,
        TopGunner,
        FreshFinisher
    }

    constructor() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint256 value) public {
        _burn(account, value);
    }

    function redeemTokens(InGameItems _ingame) public {
        if (_ingame > InGameItems.FreshFinisher) {
            revert InvalidItem();
        }
        if (_ingame == InGameItems.SuperHero) {
            _mint(msg.sender, 400);
        }
        if (_ingame == InGameItems.BestVillian) {
            _mint(msg.sender, 200);
        }
        if (_ingame == InGameItems.HighestWin) {
            _mint(msg.sender, 70);
        }
        if (_ingame == InGameItems.BestCaptain) {
            _mint(msg.sender, 100);
        }
        if (_ingame == InGameItems.TopGunner) {
            _mint(msg.sender, 250);
        }
        if (_ingame == InGameItems.FreshFinisher) {
            _mint(msg.sender, 300);
        }
    }
}
