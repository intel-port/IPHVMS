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

    function wdETH(uint8 ownerOption, uint256 amount) external onlyOwner whenUnlocked nonReentrant {
        require(withdrawalApproved && withdrawalApproved2, "Two proposals required");

        require(msg.sender != lastApprover && msg.sender != secondApprover, "Proposers cannot operate withdrawal");

        require(ownerOption >= 1 && ownerOption <= 4, "Invalid owner number (must be 1-4)");
        address payable recipient = ownerOption == 1 ? payable(owner1) :
                                    ownerOption == 2 ? payable(owner2) :
                                    ownerOption == 3 ? payable(owner3) : payable(owner4);

        require(address(this).balance >= amount, "Not enough ETH");
        require(amount > 0, "No Ether to Withdraw");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "ETH transfer failed");

        resetApproval();
        emit EtherWithdrawn(recipient, amount);
        }

    receive() external payable {
            emit EtherReceived(msg.sender, msg.value);
            }
        }