WITH src AS (
    SELECT
        date,
        time AS timestamp,
        height,
        to_hex(hash) AS block_hash,
        difficulty,
        total_fees,
        total_reward,
        mint_reward,
        transaction_count,
        weight,
        size,
        try(from_utf8(coinbase)) AS coinbase_text,
        COUNT(*) OVER () AS total_blocks_365
    FROM bitcoin.blocks
    WHERE date >= CURRENT_DATE - INTERVAL '365' day
),

ckpool_extracted AS (
    SELECT 
        *,
        regexp_extract(coinbase_text, '(?i).{0,10}(ckpool[^/]*|solo\.ckpool\.org).{0,10}') AS tag_snippet
    FROM src
    WHERE coinbase_text IS NOT NULL 
      AND regexp_like(coinbase_text, '(?i)(solo\.ckpool\.org|ckpool)')
),

filtered AS (
    SELECT 
        *,
        COUNT(height) OVER () AS unique_ckpool_heights
    FROM ckpool_extracted
    WHERE tag_snippet IS NULL 
       OR LOWER(tag_snippet) <> 'ckpoolxmi'
)

SELECT
    date,
    timestamp,
    height,
    block_hash,
    difficulty,
    total_fees,
    total_reward,
    mint_reward,
    transaction_count,
    weight,
    size,
    coinbase_text,
    tag_snippet,
    total_blocks_365,
    unique_ckpool_heights,
    CAST(unique_ckpool_heights AS DOUBLE) / total_blocks_365 * 100 AS ckpool_share_percent
FROM filtered
ORDER BY date DESC, height DESC;
