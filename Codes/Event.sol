event TimeLockSet(uint256 unlockTime);
    event WithdrawalApproved(address indexed approver);
    event EtherWithdrawn(address indexed recipient, uint256 amount);
    event TokensWithdrawn(address indexed token, address indexed recipient, uint256 amount);
    event NFTWithdrawn(address indexed nftContract, address indexed recipient, uint256 tokenId);
    event ERC1155Withdrawn(address indexed nftContract, address indexed recipient, uint256 tokenId, uint256 amount);
    event EtherReceived(address indexed sender, uint256 amount);