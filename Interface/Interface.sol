/**
 * SPDX-License-Identifier: MIT
 *
 *
 *    ██▓ ██▓███   ██░ ██  ██▒   █▓ ███▄ ▄███▓  ██████             
 *   ▓██▒▓██░  ██▒▓██░ ██▒▓██░   █▒▓██▒▀█▀ ██▒▒██    ▒             
 *   ▒██▒▓██░ ██▓▒▒██▀▀██░ ▓██  █▒░▓██    ▓██░░ ▓██▄               
 *   ░██░▒██▄█▓▒ ▒░▓█ ░██   ▒██ █░░▒██    ▒██   ▒   ██▒            
 *   ░██░▒██▒ ░  ░░▓█▒░██▓   ▒▀█░  ▒██▒   ░██▒▒██████▒▒            
 *   ░▓  ▒▓▒░ ░  ░ ▒ ░░▒░▒   ░ ▐░  ░ ▒░   ░  ░▒ ▒▓▒ ▒ ░            
 *    ▒ ░░▒ ░      ▒ ░▒░ ░   ░ ░░  ░  ░      ░░ ░▒  ░ ░            
 *    ▒ ░░░        ░  ░░ ░     ░░  ░      ░   ░  ░  ░              
 *    ░            ░  ░  ░      ░         ░         ░              
 *                             ░                                   
 *    ▄▄▄       ██▓             ██▓███   ▒█████   ██▀███  ▄▄▄█████▓
 *   ▒████▄    ▓██▒            ▓██░  ██▒▒██▒  ██▒▓██ ▒ ██▒▓  ██▒ ▓▒
 *   ▒██  ▀█▄  ▒██░            ▓██░ ██▓▒▒██░  ██▒▓██ ░▄█ ▒▒ ▓██░ ▒░
 *   ░██▄▄▄▄██ ▒██░            ▒██▄█▓▒ ▒▒██   ██░▒██▀▀█▄  ░ ▓██▓ ░ 
 *    ▓█   ▓██▒░██████▒ ██▓    ▒██▒ ░  ░░ ████▓▒░░██▓ ▒██▒  ▒██▒ ░ 
 *    ▒▒   ▓▒█░░ ▒░▓  ░ ▒▓▒    ▒▓▒░ ░  ░░ ▒░▒░▒░ ░ ▒▓ ░▒▓░  ▒ ░░   
 *     ▒   ▒▒ ░░ ░ ▒  ░ ░▒     ░▒ ░       ░ ▒ ▒░   ░▒ ░ ▒░    ░    
 *     ░   ▒     ░ ░    ░      ░░       ░ ░ ░ ▒    ░░   ░   ░      
 *         ░          ░  ░                  ░ ░     ░              
 *                       ░                                
 */

pragma solidity ^0.8.29;

/* ——————————————————————————————— IPCS
    */
    contract IPHVMSalPORT {
        event NewMultiSigCreated(address indexed multiSigAddress, address indexed creator);

        function create(address owner1, address owner2, address owner3, address owner4) external returns (address) {
        IPHVMS newMultiSig = new IPHVMS(owner1, owner2, owner3, owner4);
        emit NewMultiSigCreated(address(newMultiSig), msg.sender);
        return address(newMultiSig);
        }

        string public vAlPORT = "v1.0.5";

        address public tipJar = 0x77702b30a0276A4436BB688586147Ff75d64E97B;
        }

/* ———————————————————————————————.

     ██░ ██▓███   ▄████▄    ██████      
    ▓██▒▓██░  ██▒▒██▀ ▀█  ▒██    ▒      
    ▒██░░██░ ██▓▒▒▓█    ▄ ░ ▓██▄        
    ░██░▓██▄█▓▒ ▒▒▓▓▄ ▄██▒  ▒   ██▒     
    ░██░▒██▒ ░  ░▒ ▓███▀ ░▒██████▒▒ ██▓ 
    ░▓  ░▓▒░ ░  ░░ ░▒ ▒  ░▒ ▒▓▒ ▒ ░ ▒▓▒ 
     ▒ ░░▒ ░       ░  ▒   ░ ░▒  ░ ░ ░▒  
     ▒   ░       ░        ░  ░  ░   ░   
     ░           ░ ░            ░    ░  
                 ░                   ░         
    intel port contract security - @prog <XXXX> */