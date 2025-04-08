function tlSet(uint256 durationAsSec) external onlyOwner {
        require(timeLockApproved, "Time-lock proposal required, use another owner to call tlProp");
        require(msg.sender != timeLockApprover, "Operator must be different from proposal");
        require(block.timestamp >= unlockTime, "Cannot set a new time-lock until the current one expires");
        require(durationAsSec >= 600, "Minimum time-lock is 10 minutes");
        require(durationAsSec <= 157680000, "Invalid duration (max 5 years)");

        unlockTime = block.timestamp + durationAsSec;
    
        timeLockApproved = false;
        timeLockApprover = address(0);

        emit TimeLockSet(unlockTime);
        }

function tlProp() external onlyOwner {
        require(!timeLockApproved, "Time-lock already proposed");
        timeLockApproved = true;
        timeLockApprover = msg.sender;
        emit WithdrawalApproved(msg.sender);
        }    