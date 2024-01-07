// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    error InvalidItem();

    struct Player {
        address account;
        uint level;
        string item;
    }

    mapping(address => bool) playerExist;
    mapping(InGameItems => Player) playerItem;
    mapping(address => Player) playerDetails;

    enum InGameItems {
        SuperHero,
        BestVillian,
        HighestWin,
        BestCaptain,
        TopGunner,
        FreshFinisher
    }

    constructor() Ownable() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        if (playerExist[to] == false) {
            revert("Please Register as a Player");
        }
        _mint(to, amount);
    }

    function register() public view returns (bool success) {
        playerExist[msg.sender] == true;
        success = true;
    }

    function burn(uint256 value) public {
        if (playerExist[msg.sender] == false) {
            revert("Please Register as a Player");
        }
        _burn(msg.sender, value);
    }

    function moveLevel(address _player, uint _newLevel) public onlyOwner {
        Player storage player = playerDetails[_player];
        player.level = _newLevel;
        _mint(msg.sender, 50);
    }

    function giveItem(address _player, string memory _item) public onlyOwner {
        Player storage player = playerDetails[_player];
        player.item = _item;
        _mint(msg.sender, 50);
    }

    function redeemTokens(string memory _item) public {
        Player storage player = playerDetails[msg.sender];

        //SuperHero
        if (
            keccak256(abi.encodePacked(_item)) ==
            keccak256(abi.encodePacked(player.item))
        ) {
            _mint(msg.sender, 400);
        }

        //BestVillian
        if (
            keccak256(abi.encodePacked(_item)) ==
            keccak256(abi.encodePacked(player.item))
        ) {
            _mint(msg.sender, 400);
        }

        //HighestWin
        if (
            keccak256(abi.encodePacked(_item)) ==
            keccak256(abi.encodePacked(player.item))
        ) {
            _mint(msg.sender, 400);
        }

        //BestCaptain
        if (
            keccak256(abi.encodePacked(_item)) ==
            keccak256(abi.encodePacked(player.item))
        ) {
            _mint(msg.sender, 400);
        }

        //TopGunner
        if (
            keccak256(abi.encodePacked(_item)) ==
            keccak256(abi.encodePacked(player.item))
        ) {
            _mint(msg.sender, 400);
        }

        //FreshFinisher
        if (
            keccak256(abi.encodePacked(_item)) ==
            keccak256(abi.encodePacked(player.item))
        ) {
            _mint(msg.sender, 400);
        } else {
            revert("Invalid Item");
        }
    }
}
