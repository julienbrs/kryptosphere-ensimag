// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {LiquidityPool} from "../src/LiquidityPool.sol";
import {ERC20} from "../src/ERC20.sol";

contract LiquidityPoolTest is Test {
    LiquidityPool pool;
    ERC20 tokenA;
    ERC20 tokenB;

    /**
     @notice Cette fonction est appelée avant chaque test, elle permet de
            mettre en place l'environnement.
     */
    function setUp() public {
        // Crée deux tokens ERC20 et mint le maximum de tokens possible pour l'adresse du test
        tokenA = new ERC20("TokenA", "TKA");
        tokenB = new ERC20("TokenB", "TKB");

        // Deploy the liquidity pool
        pool = new LiquidityPool(
            "TokenA-TokenB Liquidity Pool",
            "TKA-TKB-LP",
            address(tokenA),
            address(tokenB)
        );
    }
}

contract LiquidityPoolRateTest is LiquidityPoolTest {
    error InvalidToken();
    error InsuffisantLiquidity();

    function initLiquidity() internal {
        uint256 amount = 1e18 * 100;
        // On approuve le contrat à dépenser les tokens
        tokenA.approve(address(pool), amount);
        tokenB.approve(address(pool), amount);

        // On ajoute de la liquidité
        pool.addLiquidity(address(tokenA), amount);
        pool.addLiquidity(address(tokenB), amount);
    }

    /**
     @notice Cette fonction teste le cas où le token n'est pas tokenA ou tokenB
     */
    function test_rate_shouldRevertIfNotTokenAOrTokenB() external {
        address anotherToken = address(0x99);
        // Avec cette fonction, on s'attend à ce que le contrat revert avec l'erreur InvalidToken
        vm.expectRevert(InvalidToken.selector);
        pool.rate(anotherToken, 1e18);
    }

    /**
     @notice Cette fonction teste le cas où le token n'est pas tokenA ou tokenB
    */
    function test_rate_shouldRevertIfNotEnoughLiquidity() external {
        // Avec cette fonction, on s'attend à ce que le contrat revert avec l'erreur InvalidToken
        vm.expectRevert(InsuffisantLiquidity.selector);
        pool.rate(address(tokenA), 1e18);
    }

    /**
     @notice Cette fonction teste le cas nominal de la fonction rate pour le tokenA
    */
    function test_rate_nominalCase_tokenA() external {
        initLiquidity();

        (uint256 rate, uint256 slippage) = pool.rate(address(tokenA), 0);

        // On s'attend à ce que la rate soit de 1:1
        assertEq(rate, 1e18);
        // On s'attend à ce que le slippage soit de 0
        assertEq(slippage, 0);
    }

    /**
        @notice Cette fonction teste le cas nominal de la fonction rate pour le tokenB
    */
    function test_rate_nominalCase_tokenB() external {
        initLiquidity();

        (uint256 rate, uint256 slippage) = pool.rate(address(tokenA), 0);

        // On s'attend à ce que la rate soit de 1:1
        assertEq(rate, 1e18);
        // On s'attend à ce que le slippage soit de 0
        assertEq(slippage, 0);
    }

    /**
        @notice Cette fonction teste le cas nominal de la fonction rate avec une autre quantité de tokens
    */
    function test_rate_nominalCase_tokenA_2() external {
        initLiquidity();
        uint256 amount = 1e18 * 50;
        ERC20(tokenA).approve(address(pool), amount);
        // On ajoute de la liquidité
        pool.addLiquidity(address(tokenA), amount);

        (uint256 rate, uint256 slippage) = pool.rate(address(tokenA), 0);

        // On s'attend à ce que le contrat retourne le bon ratio (3:2)
        assertEq(rate, 1.5e18);
        // On s'attend à ce que le slippage soit de 0
        assertEq(slippage, 0);
    }

    /**
        @notice Cette fonction teste le cas nominal de la fonction rate lors d'un swap de 10% de la liquidité
    */
    function test_rate_nominalCase_tokenA_3() external {
        initLiquidity();
        uint256 amount = 1e18 * 1;

        (uint256 rate, uint256 slippage) = pool.rate(address(tokenA), amount);

        // On s'attend à ce que le contrat retourne le bon ratio (1010101010101010101)
        assertEq(rate, 1010101010101010101);
        // On s'attend à ce que le slippage soit de ~1%
        assert(slippage < 1e16 + 1e15);
        assert(slippage > 1e16 - 1e15);
    }

    /**
        @notice Cette fonction teste le cas nominal de la fonction rate lors d'un swap de 10% de la liquidité
    */
    function test_rate_nominalCase_tokenB_3() external {
        initLiquidity();
        uint256 amount = 1e18 * 1;

        (uint256 rate, uint256 slippage) = pool.rate(address(tokenB), amount);

        // On s'attend à ce que le contrat retourne le bon ratio (990099009900990099)
        assertEq(rate, 990099009900990099);
        // On s'attend à ce que le slippage soit de ~1%
        assert(slippage < 1e16 + 1e15);
        assert(slippage > 1e16 - 1e15);
    }
}

contract LiquidityPoolSwapTest is LiquidityPoolTest {
    error InvalidToken();
    error SlippageTooHigh();
    error InsuffisantLiquidity();

    function initLiquidity() internal {
        uint256 amount = 1e18 * 100;
        // On approuve le contrat à dépenser les tokens
        tokenA.approve(address(pool), amount);
        tokenB.approve(address(pool), amount);

        // On ajoute de la liquidité
        pool.addLiquidity(address(tokenA), amount);
        pool.addLiquidity(address(tokenB), amount);
    }

    /**
     @notice Cette fonction teste le cas où le token n'est pas tokenA ou tokenB
     */
    function test_swap_shouldRevertIfNotTokenAOrTokenB() external {
        address anotherToken = address(0x99);
        // Avec cette fonction, on s'attend à ce que le contrat revert avec l'erreur InvalidToken
        vm.expectRevert(InvalidToken.selector);
        pool.swap(anotherToken, 1e18, 0);
    }

    /**
     @notice Cette fonction teste le cas où le slippage est trop élevé
     */
    function test_swap_shouldRevertIfSlippageTooHigh() external {
        initLiquidity();
        uint256 amount = 1e18 * 10;
        uint256 rate = 1e18; // rate = 1:1
        uint256 slippage = 1e17; // slippage = 10%
        // Mock la valeur de retour de la fonction rate
        vm.mockCall(
            address(pool),
            abi.encodeWithSelector(pool.rate.selector),
            abi.encode([rate, slippage])
        );

        ERC20(tokenA).approve(address(pool), amount);

        // Avec cette fonction, on s'attend à ce que le contrat revert avec l'erreur SlippageTooHigh
        vm.expectRevert(SlippageTooHigh.selector);
        // On swap des tokens A pour des tokens B avec un slippage de 1%
        pool.swap(address(tokenA), amount, 1e16);
    }

    /**
     @notice Cette fonction teste le cas nominal de la fonction swap pour le tokenA
     */
    function test_swap_nominalCase_tokenA() external {
        initLiquidity();
        uint256 amount = 1e18 * 10;
        uint256 rate = 1e18; // rate = 1:1
        uint256 slippage = 1e16; // slippage = 1%
        // Mock la valeur de retour de la fonction rate
        vm.mockCall(
            address(pool),
            abi.encodeWithSelector(pool.rate.selector),
            abi.encode([rate, slippage])
        );

        ERC20(tokenA).approve(address(pool), amount);

        // On s'attend à ce que le contrat appelle la fonction transferFrom de tokenA
        vm.expectCall(
            address(tokenA),
            abi.encodeCall(
                tokenA.transferFrom,
                (address(this), address(pool), amount)
            ),
            1
        );
        // On s'attend à ce que le contrat appelle la fonction transfer de tokenB
        vm.expectCall(
            address(tokenB),
            abi.encodeCall(
                tokenB.transfer,
                (address(this), (amount * rate) / 1e18)
            ),
            1
        );

        // On swap des tokens A pour des tokens B avec un slippage de 3%
        pool.swap(address(tokenA), amount, 1e16 * 3);
    }

    /**
     @notice Cette fonction teste le cas nominal de la fonction swap pour le tokenB
     */
    function test_swap_nominalCase_tokenB() external {
        initLiquidity();
        uint256 amount = 1e18 * 10;
        uint256 rate = 1e18; // rate = 1:1
        uint256 slippage = 1e16; // slippage = 1%
        // Mock la valeur de retour de la fonction rate
        vm.mockCall(
            address(pool),
            abi.encodeWithSelector(pool.rate.selector),
            abi.encode([rate, slippage])
        );

        ERC20(tokenB).approve(address(pool), amount);

        // On s'attend à ce que le contrat appelle la fonction transferFrom de tokenB
        vm.expectCall(
            address(tokenB),
            abi.encodeCall(
                tokenB.transferFrom,
                (address(this), address(pool), amount)
            ),
            1
        );
        // On s'attend à ce que le contrat appelle la fonction transfer de tokenA
        vm.expectCall(
            address(tokenA),
            abi.encodeCall(
                tokenA.transfer,
                (address(this), (amount * rate) / 1e18)
            ),
            1
        );

        // On swap des tokens B pour des tokens A avec un slippage de 3%
        pool.swap(address(tokenB), amount, 1e16 * 3);
    }

    /**
     @notice Cette fonction devrait tenter de swap jusqu'à provoquer une erreur InsuffisantLiquidity
     */
    function test_swap_nominalCase_tokenA_2() external {
        initLiquidity();
        uint256 amount = 1e18 * 10;

        ERC20(tokenA).approve(address(pool), amount * 100);
        ERC20(tokenB).approve(address(pool), amount * 100);

        // On swap des tokens A pour des tokens B avec un slippage de 3%
        for (uint256 i = 0; i < 17; i++) {
            pool.swap(address(tokenA), amount, 1e18 * 10000);
        }

        vm.expectRevert(InsuffisantLiquidity.selector);
        pool.swap(address(tokenA), amount, 1e18 * 10000);
    }
}

contract LiquidityPoolAddLiquidityTest is LiquidityPoolTest {
    error InvalidToken();

    /**
     @notice Cette fonction teste le cas où le token n'est pas tokenA ou tokenB
     */
    function test_addLiquidity_shouldRevertIfNotTokenAOrTokenB() external {
        address anotherToken = address(0x99);
        // Avec cette fonction, on s'attend à ce que le contrat revert avec l'erreur InvalidToken
        vm.expectRevert(InvalidToken.selector);
        pool.addLiquidity(anotherToken, 1e18);
    }

    /**
     @notice Cette fonction teste le cas nominal de la fonction addLiquidity pour le tokenA
     */
    function test_addLiquidity_nominalCase_tokenA() external {
        uint256 amount = 1e18;
        // On approuve le contrat à dépenser les tokens
        tokenA.approve(address(pool), amount);

        // On s'attend à ce que le contrat appelle la fonction transferFrom de tokenA
        vm.expectCall(
            address(tokenA),
            abi.encodeCall(
                tokenA.transferFrom,
                (address(this), address(pool), amount)
            ),
            1
        );

        // On ajoute de la liquidité
        pool.addLiquidity(address(tokenA), amount);

        // On vérifie que le contrat a bien mis à jour la variable aLiquidity
        assertEq(pool.aLiquidity(), amount);
        assertEq(pool.bLiquidity(), uint256(0));
    }

    /**
     @notice Cette fonction teste le cas nominal de la fonction addLiquidity pour le tokenB
     */
    function test_addLiquidity_nominalCase_tokenB() external {
        uint256 amount = 1e18;
        // On approuve le contrat à dépenser les tokens
        tokenB.approve(address(pool), amount);

        // On s'attend à ce que le contrat appelle la fonction transferFrom de tokenB
        vm.expectCall(
            address(tokenB),
            abi.encodeCall(
                tokenB.transferFrom,
                (address(this), address(pool), amount)
            ),
            1
        );

        // On ajoute de la liquidité
        pool.addLiquidity(address(tokenB), amount);

        // On vérifie que le contrat a bien mis à jour la variable bLiquidity
        assertEq(pool.aLiquidity(), uint256(0));
        assertEq(pool.bLiquidity(), amount);
    }

    /**
     @notice Cette fonction test le cas où on a plusieurs appels à addLiquidity
     */
    function test_addLiquidity_multipleCalls() external {
        uint256 amount = 1e18;
        // On approuve le contrat à dépenser les tokens
        tokenA.approve(address(pool), amount * 2);
        tokenB.approve(address(pool), amount * 2);

        // On s'attend à ce que le contrat appelle la fonction transferFrom de tokenA
        vm.expectCall(
            address(tokenA),
            abi.encodeCall(
                tokenA.transferFrom,
                (address(this), address(pool), amount)
            ),
            2
        );
        // On s'attend à ce que le contrat appelle la fonction transferFrom de tokenB
        vm.expectCall(
            address(tokenB),
            abi.encodeCall(
                tokenB.transferFrom,
                (address(this), address(pool), amount)
            ),
            2
        );

        // On ajoute de la liquidité
        pool.addLiquidity(address(tokenA), amount);
        pool.addLiquidity(address(tokenB), amount);
        pool.addLiquidity(address(tokenA), amount);
        pool.addLiquidity(address(tokenB), amount);

        // On vérifie que le contrat a bien mis à jour la variable aLiquidity
        assertEq(pool.aLiquidity(), amount * 2);
        assertEq(pool.bLiquidity(), amount * 2);
    }
}
