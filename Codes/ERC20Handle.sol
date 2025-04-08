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
    
    interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    }

    library SafeERC20 {
    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        require(token.transfer(to, value), "SafeERC20: Transfer failed");
        }
    }

    function wdERC20(address tokenContract, uint8 ownerOption, uint256 amount) external onlyOwner whenUnlocked nonReentrant {
        require(withdrawalApproved && withdrawalApproved2, "Two proposals required");

        require(msg.sender != lastApprover && msg.sender != secondApprover, "Proposers cannot operate withdrawal");

        require(ownerOption >= 1 && ownerOption <= 4, "Invalid owner number (must be 1-4)");
        address recipient = ownerOption == 1 ? owner1 :
                            ownerOption == 2 ? owner2 :
                            ownerOption == 3 ? owner3 : owner4;

        IERC20 token = IERC20(tokenContract);
        require(token.balanceOf(address(this)) >= amount, "Not enough tokens");
        require(amount > 0, "No Tokens to Withdraw");

        token.safeTransfer(recipient, amount);

        resetApproval();
        emit TokensWithdrawn(tokenContract, recipient, amount);
        }