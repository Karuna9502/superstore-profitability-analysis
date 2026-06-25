# superstore-profitability-analysis
End-to-end retail profitability analysis using SQL Server &amp; Python  — uncovering $155K in losses and a -0.86 discount-profit correlation  across 9,994 transactions (2014–2017)-Profitability analysis of 9,994 retail transactions using SQL Server 
& Python | Identified $155K losses | -0.86 discount-profit correlation 
| 5 business recommendations


# 🛒 Superstore Profitability Analysis

> **"1 in 5 orders was losing money. Discount policy was the cause."**

A full end-to-end data analytics project analysing 4 years of retail transaction data to identify profit drivers, loss sources, and actionable business recommendations.

---

## 📌 Business Problem

A retail superstore wanted to understand:
- Which products, regions, and customer segments are profitable?
- Which are actively destroying value?
- What is causing losses — and how much can be recovered?

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL Server (SSMS)** | Data import, cleaning, validation, extraction |
| **Python** | Analysis and visualisation |
| **Pandas** | Data manipulation and aggregation |
| **Matplotlib & Seaborn** | Charts and visual storytelling |
| **Jupyter Notebook** | Analysis environment |

---

## 📂 Project Structure

```
superstore-profitability-analysis/
│
├── Sample_store.ipynb        ← Full analysis notebook (6 charts + findings)
├── SQLQuery1.sql             ← SQL queries: validation, cleaning, extraction
├── superstore_clean.csv      ← Cleaned dataset exported from SQL Server
├── README.md                 ← You are here
│
└── outputs/
    ├── chart1_subcategory_profit.png
    ├── chart2_discount_vs_profit.png
    ├── chart3_regional_profit.png
    ├── chart4_yearly_trend.png
    ├── chart5_discount_bucket.png
    └── chart6_segment_comparison.png
```

---

## 📊 Dataset

| Property | Detail |
|---|---|
| Source | Sample Superstore — Tableau Public |
| Rows | 9,994 transactions |
| Columns | 21 fields |
| Period | January 2014 – December 2017 |
| Geography | United States (4 regions) |
| Categories | Furniture, Office Supplies, Technology |

---

## 🔍 Methodology

### Phase 1 — Data Validation (SQL Server)
- Imported raw CSV into SQL Server with correct data types
- Identified and resolved 1 NULL value in Profit column
- Detected 8 duplicate Order+Product combinations
- Flagged 856 orders with discounts above 50%
- Confirmed 1,870 loss-making transactions out of 9,994

### Phase 2 — Exploratory Analysis (SQL)
- Sub-category profitability ranking
- Discount bucket impact analysis
- Regional performance comparison
- Customer segment breakdown
- Yearly trend analysis
- Top 10 profitable and loss-making customers

### Phase 3 — Visualisation & Storytelling (Python)
- 6 business-focused charts built in Matplotlib and Seaborn
- Each chart designed to answer one specific business question
- Correlation analysis to quantify discount-profit relationship

---

## 📈 Key Findings

### Finding 1 — Scale of the Problem
> **18.7% of all transactions (1,870 orders) are loss-making, totalling -$155,711 in losses.**

### Finding 2 — The Root Cause
> **Discount rate has a -0.86 correlation with profit margin.**
> This means discount policy explains 86% of profit margin variation.
> It is the single largest controllable driver of profitability.

### Finding 3 — Furniture is a Loss Leader
| Sub-Category | Revenue | Profit | Avg Discount |
|---|---|---|---|
| Tables | $206,966 | **-$17,305** | 26.1% |
| Bookcases | $114,880 | **-$3,473** | 21.1% |
| Supplies | $46,674 | **-$1,189** | 7.7% |

### Finding 4 — Central Region is Over-Discounting
| Region | Avg Discount | Profit Margin | Total Profit |
|---|---|---|---|
| West | 10.9% | 14.94% | $108,418 |
| East | 14.5% | 13.48% | $91,523 |
| South | 14.7% | 12.04% | $47,169 |
| **Central** | **24.0%** | **7.92%** | **$39,706** |

### Finding 5 — Discount Buckets Tell the Real Story
| Discount Tier | Total Profit | Avg Margin |
|---|---|---|
| No Discount | +$320,988 | +34.02% |
| Low 1–10% | +$10,448 | +11.25% |
| High 21–30% | +$90,338 | +17.68% |
| Very High 31–50% | **-$58,397** | **-21.91%** |
| Extreme 50%+ | **-$76,559** | **-113.88%** |

### Finding 6 — Growth Without Margin Improvement
| Year | Revenue | Profit | Margin |
|---|---|---|---|
| 2014 | $484,247 | $49,544 | 10.23% |
| 2015 | $470,532 | $61,619 | 13.10% |
| 2016 | $609,206 | $81,795 | 13.43% ← peak |
| 2017 | $733,215 | $93,859 | **12.80%** ← declining |

> Revenue grew 51% from 2014–2017 but profit margin peaked in 2016 and declined in 2017 — volume growth is masking margin compression.

---

## 📉 Charts

### Chart 1 — Sub-Category Profitability
![Sub-Category Profitability](https://github.com/Karuna9502/superstore-profitability-analysis/blob/main/chart1_subcategory_profit.png)

### Chart 2 — Discount vs Profit Distribution
![Discount vs Profit](https://github.com/Karuna9502/superstore-profitability-analysis/blob/main/chart2_discount_vs_profit.png)

### Chart 3 — Regional Performance
![Regional Performance](https://github.com/Karuna9502/superstore-profitability-analysis/blob/main/chart3_regional_profit.png)

### Chart 4 — Yearly Sales vs Profit Trend
![Yearly Trend](https://github.com/Karuna9502/superstore-profitability-analysis/blob/main/chart4_yearly_trend.png)

### Chart 5 — Discount Bucket Impact
![Discount Bucket](https://github.com/Karuna9502/superstore-profitability-analysis/blob/main/chart5_discount_bucket.png)

### Chart 6 — Customer Segment Comparison
![Segment Comparison](outputs/chart6_segment_comparison.png)

---

## 💡 Business Recommendations

### 1. Implement a Discount Cap Policy 🔴 High Priority
Cap all standard discounts at **20% maximum**.
Require VP-level approval for any discount above 30%.
**Estimated annual profit recovery: ~$134,956**

### 2. Audit Furniture Category Pricing 🔴 High Priority
Tables and Bookcases are loss-making despite strong revenue.
The issue is not demand — it is excessive discounting (21–26% average).
Review cost structure and implement minimum price floors.

### 3. Investigate Central Region Discount Practices 🟠 Medium Priority
Central region averages 24% discount vs West's 10.9%.
This is a sales management and authorisation control problem, not a market problem.
Top profitable customers exist in Central — proving the market can support better pricing.

### 4. Scale High-Margin Products 🟠 Medium Priority
| Product | Margin | Action |
|---|---|---|
| Copiers | 37.2% | Increase sales focus |
| Paper | 43.4% | Scale volume |
| Accessories | 25.1% | Protect from heavy discounting |

### 5. Target Home Office Segment 🟢 Lower Priority
Despite lowest order volume (1,783 orders), Home Office has the highest
profit margin at 14.03%. Targeted marketing to this segment would
improve overall portfolio margins without requiring discount changes.

---

## 🔗 Correlation Analysis

```python
Discount vs Profit (absolute):    -0.2193  (weak)
Discount vs Profit Margin:        -0.8644  (very strong)
```

The -0.86 correlation between discount rate and profit margin is the
quantitative proof underlying every recommendation in this project.
Discount policy is not a minor factor — it is the defining variable
in this business's profitability.

---

## ✅ Data Quality Notes

| Issue | Resolution |
|---|---|
| 1 NULL in Profit column | Set to 0 — documented |
| 8 duplicate Order+Product rows | Investigated, retained as split shipments |
| CSV exported without headers | Fixed via Python — permanently saved with headers |
| BOM character in CSV | Handled via utf-8-sig encoding |
| Postal codes as integers | Imported as nvarchar(10) to preserve leading zeros |

---

## 👤 Author

**Karuna**
Aspiring Data Analyst | SQL · Python · Excel

📧 Gmail:- karunakumari0231@gmail.com
🔗 LINKEDIN:- www.linkedin.com/in/karuna-kumari-85463a25a

---

*Dataset source: Sample Superstore — Tableau Public Community. Used for educational purposes only.*

