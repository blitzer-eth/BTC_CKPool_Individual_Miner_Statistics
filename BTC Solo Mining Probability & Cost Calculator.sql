WITH params AS (
  SELECT
    {{Hashrate - TH/s:}} AS hashrate_ths,
    {{Power Watts - kW:}} AS power_watts,
    {{Electricity Price - USD/kWh:}} AS electricity_price,
    {{Num Machines:}} AS num_machines
),

latest AS (
  SELECT 
    difficulty,
    mint_reward,
    total_reward,
    height,
    time
  FROM bitcoin.blocks
  ORDER BY height DESC
  LIMIT 1
),

calc AS (
  SELECT
    l.difficulty,
    (l.difficulty * POW(2,32) / 600) AS network_hashrate_hs,
    (p.hashrate_ths * 1e12 * p.num_machines) AS miner_hashrate_hs,
    l.total_reward / 1e8 AS block_reward_btc,
    (p.power_watts * p.num_machines) AS total_power_watts,
    p.electricity_price,
    p.num_machines
  FROM latest l
  CROSS JOIN params p
),

prob AS (
  SELECT
    c.*,
    miner_hashrate_hs / network_hashrate_hs AS block_probability,
    1 / NULLIF(miner_hashrate_hs / network_hashrate_hs, 0) AS expected_blocks_needed
  FROM calc c
),

costs AS (
  SELECT
    p.*,
    CAST(total_power_watts AS DOUBLE) / 1000.0 AS total_kw,
    -- kWh = (Power in kW) * (Hours per block attempt)
    (CAST(total_power_watts AS DOUBLE) / 1000.0) * (600.0 / 3600.0) / NULLIF(block_probability, 0) AS kwh_per_block,
    -- Cost = kWh * Price
    ((CAST(total_power_watts AS DOUBLE) / 1000.0) * (600.0 / 3600.0) / NULLIF(block_probability, 0)) * electricity_price AS cost_per_block_usd
  FROM prob p
)

SELECT
  difficulty,
  network_hashrate_hs,
  miner_hashrate_hs,
  num_machines,
  block_probability,
  expected_blocks_needed,
  kwh_per_block,
  cost_per_block_usd
FROM costs;
