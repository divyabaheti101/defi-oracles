const CoinGecko = require('coingecko-api');
const Oracle = artifacts.require("Oracle");

const pollInterval = 5000; // 5 seconds
const CoinGeckoClient = new CoinGecko();

module.exports = async done => {
    const[_, reporter] = await web3.eth.getAccounts();
    const oracle = await Oracle.deployed();

    while (true) {
        const response = await CoinGeckoClient.coins.fetch('bitcoin', {});
        let currPrice = parseFloat(response.data.market_data.current_price.usd);
        currPrice = parseInt(currPrice * 100); // two decimals
        await oracle.updateData(
            web3.utils.soliditySha3("BTC/USD"),
            currPrice,
            { from: reporter}
        );
        console.log(`Current BTC price: $${currPrice/100}`);

        await new Promise(r => setTimeout(r, pollInterval));
    }

    done();
}