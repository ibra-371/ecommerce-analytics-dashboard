# E-commerce Performance Analysis Dashboard

> Portfolio project demonstrating SQL, Power BI, and DAX for end-to-end business analytics.

An end-to-end data analytics project analyzing **~100,000 orders** from a Brazilian e-commerce marketplace to uncover insights on revenue growth, product performance, seller concentration, and delivery reliability.

**Built with:** PostgreSQL • Power BI • DAX

---

## 📊 Dashboard Preview

The full Power BI dashboard is available as a PDF preview in `/powerbi/dashboard_preview.pdf`.

---

## 🎯 Business Questions Answered

- How is revenue performing over time?
- Which products and sellers drive the most value?
- How reliable is the delivery experience for customers?
- Where are the biggest opportunities for improvement?

---

## 🔑 Key Insights

| KPI | Value |
|---|---|
| Total Revenue | R$ 32.02M |
| Total Orders | 193K |
| Average Delivery Time | 12.56 days |
| Late Delivery Rate | 8.1% |
| On-Time/Early Deliveries | 91.89% |

**Top findings:**
- Revenue scaled aggressively through 2017 (from R$ 280K → R$ 2.4M/month), then stabilized in 2018
- **Health & Beauty, Watches & Gifts, and Bed & Bath** generate nearly 30% of total revenue
- **São Paulo sellers** dominate the marketplace with R$ 2.7M in revenue — almost 4x the next city
- Late deliveries spiked above 15% in early 2018, signaling operational strain during peak demand

---

## 💡 Recommendations

1. **Strengthen Peak-Season Delivery Capacity** — invest in regional fulfillment and carrier partnerships ahead of Q4
2. **Diversify the Seller and Category Base** — reduce dependency on São Paulo and top 3 categories
3. **Leverage Delivery Strength as a Marketing Advantage** — surface the 91.89% on-time rate as a differentiator

See `/presentation/` for the full deck with analysis and visuals.

---

## 🛠️ Tools & Techniques

| Layer | Tool | Used For |
|---|---|---|
| Data Extraction | **PostgreSQL** | CTEs, CASE logic, aggregations, date functions |
| Data Modeling | **Power BI** | Importing CSVs, building the data model |
| Measures | **DAX** | Total Revenue, Total Orders, Avg Delivery Days, Late Delivery % |
| Visualization | **Power BI** | KPI cards, line charts, bar charts, donut chart |
| Storytelling | **PowerPoint** | Executive-level narrative deck |

---

## 📁 Repository Structure

```
ecommerce-analytics-dashboard/
│
├── README.md                           ← you are here
│
├── sql/
│   └── final_analysis.sql              ← all SQL queries
│
├── data/                               ← processed datasets (outputs of SQL)
│   ├── monthly_revenue_trend.csv
│   ├── top_product_revenue.csv
│   ├── top_sellers_revenue.csv
│   ├── delivery_status_count.csv
│   ├── late_delivery_percentage.csv
│   ├── avg_delivery_time.csv
│   ├── avg_delay_late_orders.csv
│   ├── monthly_delivery_time_trend.csv
│   └── monthly_late_delivery_percentage.csv
│
├── powerbi/
│   └── dashboard_preview.pdf           ← Power BI dashboard (PDF export)
│
└── presentation/
    ├── ecommerce-analytics-dashboard.pptx
    └── ecommerce-analytics-dashboard.pdf
```

---

## 📦 Data Source

**Olist Brazilian E-commerce Public Dataset** — a real-world marketplace dataset covering ~100K orders between 2016 and 2018, with details on customers, sellers, products, payments, reviews, and geolocation.

- **Source:** [Olist on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Scope:** ~100K orders | ~193K order items | 9 relational tables | 2016–2018

The raw data is not included in this repository. To reproduce the analysis:
1. Download the dataset from the Kaggle link above
2. Load into a PostgreSQL database
3. Run the queries in `/sql/final_analysis.sql`
4. Import the resulting CSVs into Power BI (or use the ones in `/data/`)

---

## 🚀 How to View This Project

**Option 1 — Quick preview (no install):**
Open `/presentation/ecommerce-analytics-dashboard.pdf` for the full story, or `/powerbi/dashboard_preview.pdf` for the raw dashboard.

**Option 2 — Explore the SQL:**
Browse `/sql/final_analysis.sql` to see the full transformation pipeline.

**Option 3 — Explore the data:**
Browse `/data/` for the CSV outputs produced by the SQL queries.

---

## 👤 About Me

**Ibrahim Alhashim** — Data Analyst
Management Information Systems graduate | SQL • Python • Power BI

- 📧 alhasheem.ibrahim@gmail.com
- 🔗 [LinkedIn](https://www.linkedin.com/in/ibrahim-alhashim-21ba9a33a)
- 💻 [GitHub](https://github.com/ibra-371)

---

*If you found this project useful or have feedback, please ⭐ star the repo or reach out — I'd love to hear your thoughts.*
