// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ILiquidityPool {
    /**
     * @dev Retourne le taux de change entre les deux tokens.
     * @param _token Le token à échanger.
     * @param _amount Le montant à échanger.
     * @return _ Le taux de change et le slippage.
     * @custom:throws InvalidToken Si le token n'est pas dans la pool.
     * @custom:throws InsuffisantLiquidity Si la pool n'a pas assez de liquidité.
     */
    function rate(
        address _token,
        uint256 _amount
    ) external view returns (uint256, uint256);

    /**
     * @dev Retourne la liquidité disponible dans la pool.
     * @param _token Le token dont on souhaite connaitre la liquidité.
     * @return _ La liquidité disponible.
     * @custom:throws InvalidToken Si le token n'est pas dans la pool.
     */
    function getLiquidity(address _token) external view returns (uint256);

    /**
     * @dev Retourne l'adresse du token A.
     */
    function getTokenA() external view returns (address);

    /**
     * @dev Retourne l'adresse du token B.
     */
    function getTokenB() external view returns (address);

    /**
     * @dev Echange une quantité de token A contre une quantité de token B.
     * @param _fromToken Le token à échanger.
     * @param _amountIn Le montant à échanger.
     * @param _slippageTolerance La tolérance de slippage.
     * @return _ Le montant de token B reçu.
     * @custom:throws InvalidToken Si le token n'est pas dans la pool.
     * @custom:throws SlippageTooHigh Si le slippage est plus élevé que le paramètre indiquant la tolérance de slippage.
     */
    function swap(
        address _fromToken,
        uint256 _amountIn,
        uint256 _slippageTolerance
    ) external returns (uint256);

    /**
     * @dev Ajoute de la liquidité à la pool.
     * @param _token Le token à ajouter.
     * @param _amount Le montant à ajouter.
     * @custom:throws InvalidToken Si le token n'est pas dans la pool.
     */
    function addLiquidity(address _token, uint256 _amount) external;
}
