# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

gas-report:
	forge test -vv --gas-report --fork-url $(MAINNET_RPC)

trace:
	forge test -vvv --fork-url $(MAINNET_RPC) 

# --fork-block-number $(BLOCK_NUMBER)
# Verify Contracts
#forge verify-contract --chain-id 42161 --watch --constructor-args $(cast abi-encode "constructor((string,string,address,uint256))" "("Share" "Token","STO",0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8,1000000000)") 0xb428cC8Fe759D79037355138cc0987F65f704587 src/Minter.sol:Minter QSWEZY6SZZ213F5748W3U7MKUAR7GGI7YB --verifier-url "https://api.arbiscan.io/api"
