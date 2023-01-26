//DabbCoin ICO

pragma solidity ^0.4.11;

contract dabbcoin_ico{
    //total/max number of dabbcoins for sale
    uint public max_dabbcoins = 1000000;

    //INR to dabbcoin conversion rate
    uint public inr_to_dabbcoin = 1000;

    //total numbers for dabbcoins bought out
    uint public total_dabbcoins_bought = 0;

    //mapping from the investor address to it's equity in dabbcoin and INR
    mapping(address => uint) equity_dabbcoins;
    mapping(address => uint) equity_inr;

    //checking if an investor can buy Dabbcoins
    modifier can_buy_dabbcoins(uint inr_invested){
        require(inr_invested*inr_to_dabbcoin+total_dabbcoins_bought <= max_dabbcoins);
        _;
    }

    //getting the equity in Dabbcoins of an investor
    function equity_in_dabbcoins(address investor)external constant returns(uint){
        return equity_dabbcoins[investor];
    }

    //getting the equity in INR of an investor
    function equity_in_inr(address investor)external constant returns(uint){
        return equity_inr[investor];
    }

    //buying dabbcoins
    function buy_dabbcoins(address investor,uint inr_invested)external
    can_buy_dabbcoins(inr_invested){
        uint dabbcoins_bought = inr_invested * inr_to_dabbcoin;
        equity_dabbcoins[investor] += dabbcoins_bought;
        equity_inr[investor] += equity_dabbcoins[investor]/inr_to_dabbcoin;
        total_dabbcoins_bought += dabbcoins_bought;
    }

    //selling dabbcoins
    function sell_dabcoins(address investor, uint dabbcoins_to_sell)external{
        equity_dabbcoins[investor] -= dabbcoins_to_sell;
        equity_inr[investor] += equity_dabbcoins[investor]/inr_to_dabbcoin;
        total_dabbcoins_bought -= dabbcoins_to_sell;
    }
}