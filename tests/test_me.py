from brownie import Lottery, accounts, config, network
from web3 import Web3

# 0.025 or lmore


def test_getEntrance_fee():
    account = accounts[0]
    lottery = Lottery.deploy(
        config["networks"][network.show_active()].get("eth_usd_price_feed"),
        {"from": account},
    )

    assert lottery.getEntreanceFee() > Web3.toWei(0.016, "ether")
    assert lottery.getEntreanceFee() > Web3.toWei(0.019, "ether")
