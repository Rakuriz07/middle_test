select * from public. "item_bought"


SELECT item, COUNT(*) AS jumlah_pembelian
FROM item_bought
GROUP BY item;



#code untuk mencari pembelian paling banyak
SELECT item, COUNT(item) AS jumlah_pembelian
FROM item_bought
GROUP BY item
ORDER BY jumlah_pembelian DESC
LIMIT 1;

#code untuk mencari nilai penjualan yang berada ditengah diantara paling laku dan tidak laku
WITH RankedItems AS (
    SELECT item, COUNT(item) AS jumlah_pembelian,
           ROW_NUMBER() OVER (ORDER BY COUNT(item) DESC) AS rank_desc,
           ROW_NUMBER() OVER (ORDER BY COUNT(item) ASC) AS rank_asc
    FROM item_bought
    GROUP BY item
)
SELECT item, jumlah_pembelian
FROM RankedItems
WHERE rank_desc = (SELECT COUNT(DISTINCT item) FROM item_bought) / 2 + 1;

#code untuk mencari penjualan paling sedikit

SELECT item, COUNT(item) AS jumlah_pembelian
FROM item_bought
GROUP BY item
ORDER BY jumlah_pembelian ASC
LIMIT 1;


