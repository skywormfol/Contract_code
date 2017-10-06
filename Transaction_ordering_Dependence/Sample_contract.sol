contract MarketPlace{
	uint public price;
	uint public stock;
	/.../

	// 2.the owner update the price later but may be mined first which leads a
	failure trade for the buyer.

	function updatePrice(uint _price){
		if(msg.sender == owner)
			price = _price;
	}

	// 1.the buyer order the stock first according to the price he see but may be
	mined later.

	function buy(uint quant) returns (uint){
		if(msg.value < quant * price || quant > stock) throw;
		stock -= quant;
	}
}
