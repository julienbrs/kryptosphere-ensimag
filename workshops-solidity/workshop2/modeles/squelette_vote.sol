// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Poll {
        string question;
        string[] options;
        mapping(uint256 => uint256) votes; // optionIndex => voteCount
        mapping(address => bool) hasVoted; // voter => hasVoted
        bool exists;
    }

    uint256 public pollCount;
    mapping(uint256 => Poll) public polls;

    function createPoll(string memory _question, string[] memory _options) public {
        // TODO: Implémenter la fonction pour créer un sondage.
    }

    function vote(uint256 _pollId, uint256 _optionIndex) public {
        // TODO: Implémenter la fonction pour voter.
    }

    function getPoll(uint256 _pollId) public view returns (string memory, string[] memory, uint256[] memory) {
        // TODO: Implémenter la fonction pour récupérer un sondage.
    }
}
