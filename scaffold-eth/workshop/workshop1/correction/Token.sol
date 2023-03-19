// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    // Déclaration des variables d'état
    string public name; // nom du token
    string public symbol; // symbole du token
    uint256 public totalSupply; // offre totale de tokens
    mapping(address => uint256) public balanceOf; // solde de chaque adresse en nombre de tokens
    address public admin; // adresse de l'administrateur du contrat

    // Déclaration des événements
    event Transfer(address from, address to, uint256 value); // événement émis lors d'un transfert de tokens

    // Déclaration du modifier onlyAdmin qui vérifie que l'adresse qui appelle la fonction est égale à l'adresse admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    // Constructeur qui initialise le contrat avec les paramètres donnés
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply; // attribution de tous les tokens à l'adresse qui déploie le contrat
        admin = msg.sender; // définition de l'adresse qui déploie le contrat comme administrateur
    }

    // Fonction qui permet de transférer des tokens d'une adresse à une autre
    function transfer(address _to, uint256 _value) public {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // vérification que l'émetteur a assez de tokens
        require(_to != address(0), "Invalid address"); // vérification que le destinataire n'est pas l'adresse nulle (0x0)
        balanceOf[msg.sender] -= _value; // soustraction du montant du solde de l'émetteur
        balanceOf[_to] += _value; // ajout du montant au solde du destinataire
        emit Transfer(msg.sender, _to, _value); // émission de l'événement Transfer avec les paramètres correspondants
    }

    // Fonction qui permet à l'administrateur de créer des nouveaux tokens et les ajouter au solde du bénéficiaire
    function mint(address _to, uint256 _value) public onlyAdmin {
        require(_to != address(0), "Invalid address");
        totalSupply += _value; // augmentation de l'offre totale de tokens
        balanceOf[_to] += _value; // ajout du montant au solde du bénéficiaire
        emit Transfer(address(0), _to, _value); // émission de l'événement Transfer avec l'adresse nulle comme émetteur
    }

    // Fonction qui permet à l'administrateur de détruire des tokens existants du solde du bénéficiaire
    function burn(address _from, uint256 _value) public onlyAdmin {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(_from != address(0), "Invalid address");
        totalSupply -= _value; // diminution de l'offre totale de tokens
        balanceOf[_from] -= _value; // soustraction du montant du solde du bénéficiaire
        emit Transfer(_from, address(0), _value); // émission de l'événement Transfer avec l'adresse nulle comme destinataire
    }

    // Fonction qui permet de consulter le solde d'une adresse en nombre de tokens
    function getBalance(address _account) public view returns (uint256) {
        return balanceOf[_account]; // retourne la valeur du mapping balanceOf pour l'adresse donnée
    }
}
