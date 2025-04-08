constructor(address _owner1, address _owner2, address _owner3, address _owner4) {
        require(_owner1 != address(0) && _owner2 != address(0) && _owner3 != address(0) && _owner4 != address(0), "Owners cannot be zero address");
        require(_owner1 != _owner2 && _owner1 != _owner3 && _owner1 != _owner4 && 
                _owner2 != _owner3 && _owner2 != _owner4 && _owner3 != _owner4, "Owners must be unique");
                owner1 = _owner1;
                owner2 = _owner2;
                owner3 = _owner3;
                owner4 = _owner4;
                }