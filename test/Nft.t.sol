// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Beamon.sol";
import "../src/TestGas.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {TransparentUpgradeableProxy} from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract SubscriptionTest is Test {
    ProxyAdmin public proxyAdmin;
    Beamon public beamon;
    TestGas public testGas;

    address deployer = makeAddr("Deployer");
    address alice = makeAddr("Alice");
    address bob = makeAddr("Bob");
    address charlie = makeAddr("Charlie");
    address daniel = makeAddr("Daniel");

    function setUp() public {
        vm.startPrank(deployer);

        proxyAdmin = new ProxyAdmin(deployer);

        // deploy proxy contract with deployer as owner
        beamon = Beamon(
            _deployProxy(
                address(new Beamon()),
                abi.encodeWithSelector(
                    Beamon.initialize.selector,
                    deployer,
                    deployer,
                    "https://beamon.game"
                )
            )
        );

        testGas = new TestGas(deployer, deployer, "https://beamon.game");

        vm.stopPrank();
    }

    function testFuzzMintProxy(address[] calldata users) public {
        vm.startPrank(deployer);
        for (uint i = 0; i < users.length; i++) {
            vm.assume(users[i].code.length == 0);
            beamon.safeMint(users[i]);
        }
        vm.stopPrank();
    }

    function testFuzzMint(address[] calldata users) public {
        vm.startPrank(deployer);
        for (uint i = 0; i < users.length; i++) {
            vm.assume(users[i].code.length == 0);
            testGas.safeMint(users[i]);
        }
        vm.stopPrank();
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
