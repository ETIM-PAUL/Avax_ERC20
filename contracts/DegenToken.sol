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

    mapping(address => bool) public playerExist;
    mapping(address => Player) public playerDetails;

    constructor() Ownable() ERC20("Degen", "DGN") {}

    function mint(address to, uint256 amount) public onlyOwner {
        if (playerExist[to] == false) {
            revert("Please Register as a Player");
        }
        _mint(to, amount);
    }

    function register(address newPlayer) public returns (bool success) {
        if (playerExist[newPlayer] == true) {
            revert("Already Registered");
        }
        Player storage player = playerDetails[msg.sender];
        playerExist[newPlayer] = true;
        player.account = newPlayer;
        player.level = 1;
        success = true;
    }

    function burn(uint256 value) public {
        if (playerExist[msg.sender] == false) {
            revert("Please Register as a Player");
        }
        _burn(msg.sender, value);
    }

    function moveLevel(address _player, uint _newLevel) public onlyOwner {
        if (playerExist[msg.sender] == false) {
            revert("Please Register as a Player");
        }
        Player storage player = playerDetails[_player];
        player.level = _newLevel;
        _mint(msg.sender, 50);
    }

    function giveItem(address _player, string memory _item) public onlyOwner {
        if (playerExist[_player] == false) {
            revert("Please Register as a Player");
        }
        Player storage player = playerDetails[_player];
        player.item = _item;
    }

    function returnItem() public view returns (string memory it) {
        Player memory player = playerDetails[msg.sender];
        it = player.item;
    }

    function redeemTokens() public {
        Player memory player = playerDetails[msg.sender];

        //SuperHero
        if (
            keccak256(abi.encodePacked(player.item)) ==
            keccak256(abi.encodePacked("SuperHero"))
        ) {
            _mint(msg.sender, 400);
        }

        //BestVillian
        if (
            keccak256(abi.encodePacked(player.item)) ==
            keccak256(abi.encodePacked("BestVillian"))
        ) {
            _mint(msg.sender, 1000);
        }

        //HighestWin
        if (
            keccak256(abi.encodePacked(player.item)) ==
            keccak256(abi.encodePacked("HighestWin"))
        ) {
            _mint(msg.sender, 1200);
        }

        //BestCaptain
        if (
            keccak256(abi.encodePacked(player.item)) ==
            keccak256(abi.encodePacked("BestCaptain"))
        ) {
            _mint(msg.sender, 1500);
        }

        //TopGunner
        if (
            keccak256(abi.encodePacked(player.item)) ==
            keccak256(abi.encodePacked("TopGunner"))
        ) {
            _mint(msg.sender, 2000);
        }

        //FreshFinisher
        if (
            keccak256(abi.encodePacked(player.item)) ==
            keccak256(abi.encodePacked("FreshFinisher"))
        ) {
            _mint(msg.sender, 1800);
        }
    }
}
