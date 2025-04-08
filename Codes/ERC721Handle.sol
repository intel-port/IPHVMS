    abstract contract ReentrancyGuard {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;
    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
        }

    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
        }
    }
    
    interface IERC721 {
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function ownerOf(uint256 tokenId) external view returns (address);
    }

    interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
    }

    function wdERC721(address nftContract, uint8 ownerOption, uint256 tokenId) external onlyOwner whenUnlocked nonReentrant {
        require(withdrawalApproved && withdrawalApproved2, "Two proposals required");
        
        require(msg.sender != lastApprover && msg.sender != secondApprover, "Proposers cannot operate withdrawal");
        
        require(ownerOption >= 1 && ownerOption <= 4, "Invalid owner number (must be 1-4)");
        address recipient = ownerOption == 1 ? owner1 :
                            ownerOption == 2 ? owner2 :
                            ownerOption == 3 ? owner3 : owner4;

        require(IERC721(nftContract).ownerOf(tokenId) == address(this), "No NFT to Withdraw");

        IERC721(nftContract).safeTransferFrom(address(this), recipient, tokenId);

        require(IERC721(nftContract).ownerOf(tokenId) == recipient, "Transfer failed");

        resetApproval();
        emit NFTWithdrawn(nftContract, recipient, tokenId);
        }

    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4) {
        return 0x150b7a02;
        }