# beamcontract
Contract used by the game beamon

## Deployment

### To load the variables in the .env file
source .env

### To deploy and verify our contract
forge script script/Beamon.s.sol --rpc-url beamTestnet --broadcast --chain-id 13337 --verify -vvvv --verifier sourcify