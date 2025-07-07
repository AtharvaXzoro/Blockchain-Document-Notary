// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Notary {
    struct Document {
        address owner;
        uint256 timestamp;
    }


    mapping(bytes32 => Document) private documents;

    event DocumentNotarized(address indexed owner, bytes32 indexed docHash, uint256 timestamp);

    // Store a new document hash
    function storeDocumentHash(bytes32 docHash) public {
        require(documents[docHash].timestamp == 0, "Document already notarized");
        documents[docHash] = Document(msg.sender, block.timestamp);
        emit DocumentNotarized(msg.sender, docHash, block.timestamp);
    }

    // Verify if a document hash exists
    function verifyDocumentHash(bytes32 docHash) public view returns (bool exists, address owner, uint256 timestamp) {
        Document memory doc = documents[docHash];
        if (doc.timestamp != 0) {
            return (true, doc.owner, doc.timestamp);
        } else {
            return (false, address(0), 0);
        }
    }
}
