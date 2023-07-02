// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Poll {
        string question;
        string[] options;
        mapping(uint256 => uint256) votes; // option index => votes count
        mapping(address => bool) hasVoted; // user => hasVoted
        bool exists;
    }

    uint256 public pollCount = 0;
    mapping(uint256 => Poll) public polls;

    function createPoll(string memory _question, string[] memory _options) public {
        Poll storage newPoll = polls[pollCount++];
        newPoll.question = _question;
        newPoll.options = _options;
        newPoll.exists = true;
    }

    function vote(uint256 _pollId, uint256 _optionIndex) public {
        require(_pollId < pollCount, "Poll does not exist.");
        require(_optionIndex < polls[_pollId].options.length, "Invalid option.");
        require(!polls[_pollId].hasVoted[msg.sender], "You have already voted.");

        polls[_pollId].votes[_optionIndex]++;
        polls[_pollId].hasVoted[msg.sender] = true;
    }

    function getPoll(uint256 _pollId) public view returns (string memory, string[] memory, uint256[] memory) {
        require(_pollId < pollCount, "Poll does not exist.");

        Poll storage poll = polls[_pollId];
        uint256[] memory voteCounts = new uint256[](poll.options.length);

        for (uint256 i = 0; i < poll.options.length; i++) {
            voteCounts[i] = poll.votes[i];
        }

        return (poll.question, poll.options, voteCounts);
    }
}