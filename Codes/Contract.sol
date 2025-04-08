contract IPHVMS is ReentrancyGuard, IERC721Receiver, IERC1155Receiver {        
    using SafeERC20 for IERC20;

    address private owner1;
    address private owner2;
    address private owner3;
    address private owner4;
    uint256 public unlockTime;