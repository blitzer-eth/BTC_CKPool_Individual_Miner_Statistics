# ⛏️ BTC CKPool Individual Miner Statistics

**[View Dashboard on Dune](https://dune.com/blitzer/btc-lottery-miner)**

This dashboard provides a dual perspective on the world of Bitcoin solo mining. It combines historical data from the most successful solo mining pool with a real-time calculator to help users understand the statistical probability and economic costs associated with "hunting" for a Bitcoin block reward.

The suite is designed for miners and analysts to track the performance of **Solo CKPool** and evaluate the feasibility of solo mining hardware like the Antminer S21 or Bitaxe under current network difficulty.

---

## 🔍 Query Breakdown

### 1. Solo CKPool Historical Performance

An analysis of blocks successfully mined by Solo CKPool over the last 365 days.

* **Coinbase Tagging:** Decodes raw hex data from the coinbase transaction to identify blocks mined via `solo.ckpool.org`.
* **Market Share Tracking:** Calculates the "ckpool_share_percent," showing what percentage of the total global blocks were captured by solo miners using this pool.
* **Block Metrics:** Detailed reporting on block weight, transaction counts, and total rewards (subsidy + fees) for every successful solo strike.

### 2. Solo Mining Probability & Cost Calculator

A real-time financial model that converts abstract network difficulty into concrete dollar amounts.

* **Network Hashrate Derivation:** Dynamically calculates the current global hashrate (H/s) using the latest block difficulty.
* **Win Probability:** Uses your specific hardware hashrate (TH/s) to determine the mathematical likelihood of finding a block within a 10-minute window.
* **Efficiency Analysis:** Calculates the total electricity cost ($/USD) and energy consumption (kWh) required per block attempt, allowing for direct comparison against current BTC price.
---

## 📸 Snapshot
<img width="3734" height="3171" alt="image" src="https://github.com/user-attachments/assets/cae15816-7ea3-45b0-8be6-1571ed992af8" />
