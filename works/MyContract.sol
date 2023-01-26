//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.0;

contract MyContract{
    //Array
    uint[] public uintArray = [1,2,3];
    string[] public stringArray = ["apple","banana","carrot"];
    string[] public values;
    uint256[][] public array2D = [[1,2,3],[4,5,6]];

    function addValue(string memory _value)public{
        values.push(_value);
    }

    function valueCount()public view returns(uint){
        return values.length;
    }

    //unsigned integer
    int256 myInt = 1;
    uint public myUint = 1;
    uint256 public myUint256 =1;
    uint8 public myuint8 = 1;

    //string
    string public myString = "Hello, world!";
    bytes32 public myBytes32 = "Hello, world";

    //address
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    //custom datatype
    struct MyStruct{
        uint256 myUint256;
        string MyString;
    }

    //instance of custom datatype
    MyStruct public data = MyStruct(1,"Text data");

    function getvalue()public pure returns(uint){
        uint value = 1;
        return value;
    }
}