-- =====================================================
-- E-COMMERCE SQL PROJECT
-- Olist Dataset Analysis
-- =====================================================

-- Main Relationships
-- customers → orders → order_items → products
-- orders → payments
-- orders → reviews
-- order_items → sellers


-- =====================================================
-- 1. DELIVERY PERFORMANCE ANALYSIS
-- =====================================================

-- Detailed Delivery Time
SELECT 
    order_id, 
    EXTRACT(EPOCH FROM (order_delivered_customer_date - order_purchase_timestamp)) / 86400 AS time_to_be_delivered
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL;


-- Average Delivery Time
SELECT 
    AVG(EXTRACT(EPOCH FROM (order_delivered_customer_date - order_purchase_timestamp)) / 86400) AS avg_delivery_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL;


-- Delivery Delay in Days
SELECT 
    order_id, 
    EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 AS delivery_delay_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- Delivery Performance Classification
SELECT 
    order_id, 
    delivery_delay_days,
    CASE 
        WHEN delivery_delay_days > 0 THEN 'Late'
        WHEN delivery_delay_days < 0 THEN 'Early'
        ELSE 'On Time'
    END AS delivery_status
FROM (
    SELECT 
        order_id,
        EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 AS delivery_delay_days
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
) sub;


-- Count of Early, Late, and On-Time Deliveries
SELECT 
    delivery_status, 
    COUNT(*) AS delivery_count
FROM (
    SELECT 
        order_id, 
        delivery_delay_days,
        CASE 
            WHEN delivery_delay_days > 0 THEN 'Late'
            WHEN delivery_delay_days < 0 THEN 'Early'
            ELSE 'On Time'
        END AS delivery_status
    FROM (
        SELECT 
            order_id,
            EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 AS delivery_delay_days
        FROM orders
        WHERE order_status = 'delivered'
          AND order_delivered_customer_date IS NOT NULL
          AND order_estimated_delivery_date IS NOT NULL
    ) sub
) classified
GROUP BY delivery_status;


-- Late Delivery Percentage
SELECT 
    SUM(CASE WHEN delivery_status = 'Late' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS late_delivery_percentage,
    COUNT(*) AS total_orders
FROM (
    SELECT 
        order_id, 
        delivery_delay_days,
        CASE 
            WHEN delivery_delay_days > 0 THEN 'Late'
            WHEN delivery_delay_days < 0 THEN 'Early'
            ELSE 'On Time'
        END AS delivery_status
    FROM (
        SELECT 
            order_id,
            EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 AS delivery_delay_days
        FROM orders
        WHERE order_status = 'delivered'
          AND order_delivered_customer_date IS NOT NULL
          AND order_estimated_delivery_date IS NOT NULL
    ) sub
) classified;


-- Average Delay for Late Orders
SELECT 
    AVG(delivery_delay_days) AS avg_late_days
FROM (
    SELECT 
        order_id, 
        delivery_delay_days,
        CASE 
            WHEN delivery_delay_days > 0 THEN 'Late'
            WHEN delivery_delay_days < 0 THEN 'Early'
            ELSE 'On Time'
        END AS delivery_status
    FROM (
        SELECT 
            order_id,
            EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 AS delivery_delay_days
        FROM orders
        WHERE order_status = 'delivered'
          AND order_delivered_customer_date IS NOT NULL
          AND order_estimated_delivery_date IS NOT NULL
    ) sub
) classified
WHERE delivery_status = 'Late';


-- Average Early Delivery
SELECT 
    ABS(AVG(delivery_delay_days)) AS avg_early_days
FROM (
    SELECT 
        order_id, 
        delivery_delay_days,
        CASE 
            WHEN delivery_delay_days > 0 THEN 'Late'
            WHEN delivery_delay_days < 0 THEN 'Early'
            ELSE 'On Time'
        END AS delivery_status
    FROM (
        SELECT 
            order_id,
            EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 AS delivery_delay_days
        FROM orders
        WHERE order_status = 'delivered'
          AND order_delivered_customer_date IS NOT NULL
          AND order_estimated_delivery_date IS NOT NULL
    ) sub
) classified
WHERE delivery_status = 'Early';


-- Monthly Delivery Time Trend
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    AVG(EXTRACT(EPOCH FROM (order_delivered_customer_date - order_purchase_timestamp)) / 86400) AS avg_delivery_days
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp IS NOT NULL
GROUP BY month
ORDER BY month;


-- Monthly Late Delivery Percentage
SELECT 
    month,
    SUM(CASE WHEN delivery_status = 'Late' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS late_delivery_percentage
FROM (
    SELECT 
        DATE_TRUNC('month', order_purchase_timestamp) AS month,
        CASE 
            WHEN EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 > 0 THEN 'Late'
            WHEN EXTRACT(EPOCH FROM (order_delivered_customer_date - order_estimated_delivery_date)) / 86400 < 0 THEN 'Early'
            ELSE 'On Time'
        END AS delivery_status
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
      AND order_purchase_timestamp IS NOT NULL
) sub
GROUP BY month
ORDER BY month;


-- =====================================================
-- 2. SALES AND REVENUE ANALYSIS
-- =====================================================

-- Monthly Orders Trend
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month, 
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month ASC;


-- Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month, 
    SUM(payment_value) AS total_revenue
FROM orders o
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY month
ORDER BY month ASC;


-- Top Product Categories by Revenue
SELECT 
    product_category_name_english, 
    SUM(price) AS total_revenue
FROM order_items oi
LEFT JOIN products p
    ON p.product_id = oi.product_id
LEFT JOIN category_translation ct
    ON ct.product_category_name = p.product_category_name
GROUP BY product_category_name_english
ORDER BY total_revenue DESC;


-- Top Sellers by Revenue
SELECT 
    oi.seller_id,
    s.seller_city,
    s.seller_state,
    SUM(oi.price) AS total_revenue
FROM order_items oi
LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id
GROUP BY oi.seller_id, s.seller_city, s.seller_state
ORDER BY total_revenue DESC;
