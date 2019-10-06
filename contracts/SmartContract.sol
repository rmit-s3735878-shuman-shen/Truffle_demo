pragma solidity ^0.5.0;

contract SmartContract {

    address owner = msg.sender;

    uint256 public balance; // Unit in ether
    address public payer;
    address payable payee;
    //string internal contents;

    struct Verification {
        string verifier;
        uint256 chunkPayment;
        string condition;
        bool state;

    }

    mapping(uint => Verification) verifications;
    uint verifierCount = 0;

    // restrict access to payer
    modifier onlyOwner() {
        require(msg.sender == owner,
        "Sender not authorized.");
        _;
    }

    // modifier isActive() {
    //     require(balance>0,
    //     "Contract has been paid up or deactived.");
    //     _;
    // }

    event Transaction (
        address indexed _payer,
        address _payee,
        uint256 _amount
    );

    constructor(  //string memory _contents,
        address _payer,
        address payable _payee,
        uint256 _balance)
        public {

            payer = _payer;
            payee = _payee;
            balance = 1 ether * _balance;
            //contents = _contents;

        }

    function addVerifier(
        string memory _verifier,
        uint256 _chunkPayment,
        string memory _condition)
        public onlyOwner {

        verifierCount += 1;
        verifications[verifierCount] = Verification(_verifier, _chunkPayment, _condition, false);

    }

    function makePayments() public payable onlyOwner {

        require(msg.value <= balance,
        "Insufficient fund for the payment.");

        // transfer payments from payer to payee
        payee.transfer(msg.value);

        // update balance
        updateBalance(msg.value);
        emit Transaction(payer, payee, msg.value);

    }

    function updateBalance(uint256 _amount) internal {
        balance -= _amount;
    }

    function deactiveContract() public onlyOwner {
        balance = 0;
    }



}