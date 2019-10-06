const SmartContract = artifacts.require("SmartContract");

module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  const payer = "0x23c9DD8695A603BD31D401a7Ffc34588F13B9729";
  const payee = "0xfbA41cCE8D9C566eDbb7d6201100ee97e63E6fc2";
  const balance = 1;

  deployer.deploy(SmartContract, payer, payee, balance);
};
