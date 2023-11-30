# beamcontract
Contract used by the game beamon

## Deployment

### To load the variables in the .env file
source .env

### To deploy and verify our contract
forge script script/Beamon.s.sol --rpc-url beamTestnet --broadcast --chain-id 13337 -vvvv

forge verify-contract --verifier sourcify 0x47D52aD31253dAae815d5207368f3BAc599699BB lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol:ProxyAdmin --chain-id 13337 

### Addresses
https://subnets-test.avax.network/beam/address/0xDBf0DC3b7921E9Ef897031db1DAe239B4E45Af5f