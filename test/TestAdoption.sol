// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";


contract TestAdoption {
    // the Address of the Adoption used to tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    // the Id of the pet used to testing
    uint expectedPetId = 8;

    // The expected owner of adopted pet is this contract
    address expectedAdopter = address(this);

    // Testing  the adopt() function
    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(expectedPetId);

        Assert.equal(returnedId, expectedPetId, "Adoption of the expected");
    }

    // Testing retrieval of a signle pet's owner
    function testAdopterAddressByPetId() public {
        address adopter = adoption.adopters(expectedPetId);

        Assert.equal(adopter, expectedAdopter, "Owner of the expected pet");
    }

    // Testing retrieval of all pet owners
    function testGetAdopterAddressByPetIdInArray()  public {
        // Store adopter in memory rather than contract's storage
        address[16] memory adopters =  adoption.getAdopters();

        Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract");
    }
}
