// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Beamon.sol";
import "../src/BeamonCoin.sol";
import "../src/BeamonItem.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract BeamonScript is Script {
    ProxyAdmin public proxyAdmin;
    Beamon public beamon;
    BeamonCoin public beamonCoin;
    BeamonItem public beamonItem;
    uint256 private deployerPrivateKey;

    function setUp() public {}

    function run() public {
        deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        address deployer = vm.addr(deployerPrivateKey);
        proxyAdmin = new ProxyAdmin(deployer);

        beamon = Beamon(
            payable(
                _deployProxy(
                    address(new Beamon()),
                    abi.encodeWithSelector(
                        Beamon.initialize.selector,
                        deployer,
                        deployer,
                        "https://beam-server.azurewebsites.net/api/monster/"
                    )
                )
            )
        );

        beamonItem = BeamonItem(
            payable(
                _deployProxy(
                    address(new BeamonItem()),
                    abi.encodeWithSelector(
                        BeamonItem.initialize.selector,
                        deployer,
                        deployer,
                        "https://beam-server.azurewebsites.net/api/item/{id}"
                    )
                )
            )
        );

        beamonCoin = BeamonCoin(
            payable(
                _deployProxy(
                    address(new BeamonCoin()),
                    abi.encodeWithSelector(
                        BeamonCoin.initialize.selector,
                        deployer,
                        deployer
                    )
                )
            )
        );

        vm.stopBroadcast();
    }

    function _deployProxy(
        address implementation_,
        bytes memory initializer_
    ) internal returns (address) {
        return
            address(
                new TransparentUpgradeableProxy(
                    implementation_,
                    address(proxyAdmin),
                    initializer_
                )
            );
    }
}
