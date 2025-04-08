    function govSignProp1() external onlyOwner {
        require(replacementProposed, "No replacement proposed yet");
        require(!replacementApproved1, "First proposal already done");
    
        replacementApproved1 = true;
        replacementApprover1 = msg.sender;
        emit WithdrawalApproved(msg.sender);
        }

    function govSignProp2() external onlyOwner {
        require(replacementProposed, "No replacement proposed yet");
        require(replacementApproved1, "First proposal required");
        require(!replacementApproved2, "Second proposal already done");
        require(msg.sender != replacementApprover1, "Second proposal must be from a different owner");

        replacementApproved2 = true;
        replacementApprover2 = msg.sender;
        emit WithdrawalApproved(msg.sender);
        }

    function govProp0(address newOwner, uint8 ownerNumber) external onlyOwner {
        require(block.timestamp >= lastGovProp0Timestamp[msg.sender] + GOVPROP0_COOLDOWN, "Must wait 12 hours before proposing again");
        require(!replacementProposed, "A replacement is already proposed");
        require(ownerNumber >= 1 && ownerNumber <= 4, "Invalid owner number (must be 1-4)");
        require(newOwner != address(0), "New owner cannot be zero address");
        require(newOwner != owner1 && newOwner != owner2 && newOwner != owner3 && newOwner != owner4, "New owner must not already be an owner");

        proposedNewOwner = newOwner;
        ownerToReplace = ownerNumber;
        replacementProposed = true;

        replacementApproved1 = false;
        replacementApproved2 = false;
        replacementApprover1 = address(0);
        replacementApprover2 = address(0);
        lastGovProp0Timestamp[msg.sender] = block.timestamp;
        } 