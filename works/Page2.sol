//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.0;

contract Page2{
    //Mappings
    mapping(uint=>string)public names;
    mapping(uint=>Book) public books;
    mapping(address=>mapping(uint=>Book))public myBooks;

    struct Book{
        string title;
        string author;
    }
    
    constructor(){
        names[1] = "Dante";
        names[2] = "Vergil";
        names[3] = "Nero";
    }

    function addBook(
        uint _id,
        string memory _title,
        string memory _author
    )public{
        books[_id] = Book(_title,_author);

    }

    function addMyBook(
        uint _id,
        string memory _title,
        string memory _author
    )public{
        myBooks[msg.sender][_id] = Book(_title,_author);

    }
}