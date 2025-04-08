    function wdSignProp1() external onlyOwner whenUnlocked {
        require(!withdrawalApproved, "Already proposed once");
        withdrawalApproved = true;
        lastApprover = msg.sender;
        emit WithdrawalApproved(msg.sender);
        }

        function resetApproval() internal {
        withdrawalApproved = false;
        withdrawalApproved2 = false;
        lastApprover = address(0);
        secondApprover = address(0);
        }

    function wdSignProp2() external onlyOwner whenUnlocked {
        require(withdrawalApproved, "First proposal required");
        require(msg.sender != lastApprover, "Second proposal must be from a different owner");
        require(!withdrawalApproved2, "Already proposed twice");
        
        withdrawalApproved2 = true;
        secondApprover = msg.sender;
        emit WithdrawalApproved(msg.sender);
        }