// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalAssetRegistry {
    // Struct to represent a digital asset
    struct DigitalAsset {
        address owner;
        string metadata; // metadata can include information about the asset
    }

    // Mapping to store the ownership of each digital asset
    mapping(uint256 => DigitalAsset) public digitalAssets;

    // Event to emit when a digital asset is registered
    event AssetRegistered(uint256 assetId, address indexed owner, string metadata);

    // Modifier to ensure only the owner of the asset can perform certain actions
    modifier onlyOwner(uint256 assetId) {
        require(digitalAssets[assetId].owner == msg.sender, "Only the owner can perform this action");
        _;
    }

    // Function to register a new digital asset
    function registerAsset(uint256 assetId, string memory metadata) external {
        require(digitalAssets[assetId].owner == address(0), "Asset with this ID already exists");
        digitalAssets[assetId] = DigitalAsset(msg.sender, metadata);
        emit AssetRegistered(assetId, msg.sender, metadata);
    }

    // Function to transfer ownership of a digital asset
    function transferAsset(uint256 assetId, address newOwner) external onlyOwner(assetId) {
        digitalAssets[assetId].owner = newOwner;
    }

    // Function to retrieve metadata of a digital asset
    function getAssetMetadata(uint256 assetId) external view returns (string memory) {
        return digitalAssets[assetId].metadata;
    }
}