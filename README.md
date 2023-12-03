# beamcontract
Contract used by the game beamon

## Deployment

### To load the variables in the .env file
source .env

### To deploy and verify our contract
forge script script/Beamon.s.sol --rpc-url beamTestnet --broadcast --chain-id 13337 -vvvv

Use standard input json to verify proxy admin 

forge verify-contract --verifier sourcify 0x47D52aD31253dAae815d5207368f3BAc599699BB lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol:ProxyAdmin --chain-id 13337 --show-standard-json-input

forge verify-contract --verifier sourcify 0x397BE3f6c7BBFcc8d57fB993eE4C2468EC4017f4 src/Beamon.sol:Beamon --chain-id 13337  --compiler-version "v0.8.21+commit.d9974bed" --optimizer-runs 200  --watch

### Addresses
https://subnets-test.avax.network/beam/address/0xDBf0DC3b7921E9Ef897031db1DAe239B4E45Af5f

0x47D52aD31253dAae815d5207368f3BAc599699BB ProxyAdmin

0x30220a082292c105bd272e0BE4b5b429B0DDA416 Beamon

0x9069322A052eB8a0DCfe07DFE3856C3621BDa0e4 BeamonItem

0x6d4E64456E93C558B6B12319A4F880134c440cDA BeamCoin

0xFaC816134fdEb5264F27C2f71Eafd6C449EEa313 Minter

dbf1dc5c-da20-45da-8120-d01e3efd645d 0xc83A5A917985Fd4F0Ea80c9654e4C3eD834696B6 TestWallet

0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6 MinterRole
