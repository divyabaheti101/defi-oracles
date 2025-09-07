const Oracle = artifacts.require("Oracle");
const Consumer = artifacts.require("Consumer");

module.exports = async function (deployer, _network, _accounts) {
    const [admin, reporter1, _] = _accounts;

    // Deploy Oracle first
    await deployer.deploy(Oracle, admin);
    const oracle = await Oracle.deployed();
    oracle.updateReporter(reporter1, true);

    // Deploy Consumer with Oracle address
    await deployer.deploy(Consumer, oracle.address);
};
