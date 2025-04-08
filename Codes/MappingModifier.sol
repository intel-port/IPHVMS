mapping(address => uint256) private lastGovResetTimestamp;
    uint256 private constant COOLDOWN_TIME = 2 hours;

    mapping(address => uint256) private lastGovProp0Timestamp;
    uint256 private constant GOVPROP0_COOLDOWN = 12 hours;

    function governList() external view returns (uint8[4] memory, address[4] memory) {
        return ([1, 2, 3, 4], [owner1, owner2, owner3, owner4]);
        }

    modifier onlyOwner() {
    require(
        msg.sender == owner1 || msg.sender == owner2 || msg.sender == owner3 || msg.sender == owner4,
        "Only the owners can perform this action"
                );
            _;
        }

    modifier whenUnlocked() {
        require(block.timestamp >= unlockTime, "Assets are still locked!");
        _;
    }