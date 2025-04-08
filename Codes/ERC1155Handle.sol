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

    interface IERC1155Receiver {
    function onERC1155Received(address operator, address from, uint256 id, uint256 value, bytes calldata data) external returns (bytes4);
    function onERC1155BatchReceived(address operator, address from, uint256[] calldata ids, uint256[] calldata values, bytes calldata data) external returns (bytes4);
    }

    interface IERC1155 {
    function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes calldata data) external;
    function balanceOf(address account, uint256 id) external view returns (uint256);
    }

    function wdERC1155(address nftContract, uint8 ownerOption, uint256 tokenId, uint256 amount) external onlyOwner whenUnlocked nonReentrant {
        require(withdrawalApproved && withdrawalApproved2, "Two proposals required");
        
        require(msg.sender != lastApprover && msg.sender != secondApprover, "Proposers cannot operate withdrawal");
        
        require(ownerOption >= 1 && ownerOption <= 4, "Invalid owner number (must be 1-4)");
        address recipient = ownerOption == 1 ? owner1 :
                            ownerOption == 2 ? owner2 :
                            ownerOption == 3 ? owner3 : owner4;

        IERC1155 token = IERC1155(nftContract);
        uint256 contractBalance = token.balanceOf(address(this), tokenId);
        require(contractBalance >= amount, 
        string(abi.encodePacked("Insufficient ERC1155 balance. Available: ", uint2Str(contractBalance), " Requested: ", uint2Str(amount)))
        );
        uint256 beforeBalance = token.balanceOf(recipient, tokenId);

        token.safeTransferFrom(address(this), recipient, tokenId, amount, "");

        uint256 afterBalance = token.balanceOf(recipient, tokenId);

        require(afterBalance == beforeBalance + amount, "Transfer failed");

        resetApproval();
        emit ERC1155Withdrawn(nftContract, recipient, tokenId, amount);
        }

    function onERC1155Received(address, address, uint256, uint256, bytes calldata) external pure override returns (bytes4) {
        return 0xf23a6e61;
        }

        function onERC1155BatchReceived(address, address, uint256[] calldata, uint256[] calldata, bytes calldata) external pure override returns (bytes4) {
        return 0xbc197c81;
        }

        function uint2Str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
        return "0";
        }
        uint256 j = _i;
        uint256 length;
            while (j != 0) {
            length++;
            j /= 10;
            }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
            while (_i != 0) {
            k = k - 1;
            bstr[k] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
            }
        return string(bstr);
        }

        receive() external payable {
            emit EtherReceived(msg.sender, msg.value);
            }
    }