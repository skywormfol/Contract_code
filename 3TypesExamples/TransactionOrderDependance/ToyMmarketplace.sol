/*
This occurs when the assumed state of the blockchain is not the blockchains
actual state when a transaction is executed. The order in which transactions
are mined can have adverse effects on the execution of any given transac-
tion.
This TOD vulnerabilities may need at leat two node to test.
*/

pragma solidity ^0.4.11;
contract MarketPlace{
	uint public price = 2 ether;
	uint public stock = 10;
	address owner;

	function MarketPlace(){
		owner = msg.sender;
	}

	// 2.the owner update the price later but may be mined first which leads a failure trade for the buyer.
	function updatePrice(uint _price){
		if(msg.sender == owner)
			price = _price;
	}

	// 1.the buyer order the stock first according to the price he see but may be mined later.
	function buy(uint quant) payable returns (uint){
		if(msg.value < quant * price || quant > stock) revert();
		stock -= quant;
	}
}
