function govReset() external onlyOwner {
        require(block.timestamp >= lastGovResetTimestamp[msg.sender] + COOLDOWN_TIME, "Cooldown period not met"); 
        require(replacementProposed, "No active governance proposal to reset");

        replacementProposed = false;
        proposedNewOwner = address(0);
        ownerToReplace = 0;

        replacementApproved1 = false;
        replacementApprover1 = address(0);
        lastGovResetTimestamp[msg.sender] = block.timestamp;
        }

function govPropSet() external onlyOwner {
        require(replacementProposed, "No replacement proposed yet");
        require(replacementApproved1 && replacementApproved2, "Two proposals required");
        require(msg.sender != replacementApprover1 && msg.sender != replacementApprover2, "Operator must be different from proposers");

        if (ownerToReplace == 1) {
            owner1 = proposedNewOwner;
        } else if (ownerToReplace == 2) {
            owner2 = proposedNewOwner;
        } else if (ownerToReplace == 3) {
            owner3 = proposedNewOwner;
        } else if (ownerToReplace == 4) {
            owner4 = proposedNewOwner;
        }

        replacementProposed = false;
        replacementApproved1 = false;
        replacementApproved2 = false;
        proposedNewOwner = address(0);
        ownerToReplace = 0;
        replacementApprover1 = address(0);
        replacementApprover2 = address(0);
        }