# 🚗 Automotive Sales Data Analysis (2023)

## 📊 Project Overview

The goal of this analysis is to identify and evaluate the **key factors that contributed to a 24% increase in automotive sales in 2023** compared to 2022, using historical vehicle sales data.

### 🔍 Focus Areas:
- **Sales Trends** – Seasonality, growth spikes, and monthly patterns over 24 months.
- **Product Performance** – Top-performing models, new launches, and product mix or pricing shifts.

---

## 📂 Key Project Files

| File Description | Link |
|------------------|------|
| Data Cleaning in SQL | *[Insert Link]* |
| Data Inspection in SQL | *[Insert Link]* |
| Data Validation in SQL | *[Insert Link]* |
| Normalization in SQL | *[Insert Link]* |
| Power BI Dashboard | *[Insert Link]* |

---

## 🧱 Data Structure Overview

This project uses several relational tables:

### `car_table`
- **Columns**: `car_id`, `sale_date`, `color`, `price`, `cust_id`, `model_id`, `transmission_id`, `dealer_id`
- **Description**: Transaction-level data for each car sold, with foreign keys linking to related details.

### `customer_table`
- **Columns**: `cust_id`, `customer_name`, `gender`, `annual_income`, `phone`
- **Description**: Customer demographics and contact info.

### `dealer_table`
- **Columns**: `dealer_id`, `dealer_name`, `dealer_number`, `dealer_region`
- **Description**: Dealership details including region and contact number.

### `model_table`
- **Columns**: `model_id`, `company`, `model`, `body_style`
- **Description**: Manufacturer, model name, and vehicle body style.

### `transmission_table`
- **Columns**: `trans_id`, `transmission`, `engine`
- **Description**: Transmission type and engine specifications.

---

## 🧾 Executive Summary

- **Total Sales (2023)**: $371.19 million (**+23.59% YoY**)
- **Units Sold**: 13,261 (**+24.57% YoY**)
- **Top Model**: *Oldsmobile Silhouette* – 234 units sold
- **Top Manufacturer by Revenue**: *Chevrolet* – $27.11M
- **Top Regional Sales**: *Austin* – $65.04M
- **Customer Preferences**: 
  - Color: Pale White (48%)
  - Transmission: Automatic (52.17%)
  - Gender: Male (77.57%)

These insights inform future **marketing strategies and inventory planning** for 2024.

---

## 📈 Insights Deep Dive

### 1️⃣ Sales Trends

- **Peak Months**: 
  - December: 14.62% of revenue
  - November: 13.90%
- **Lowest Month**: February (3.19%)
- **Strongest Sales Spike**: September (+104.47% MoM)
- **Highest Quarterly Sales**: Q4 ($133.92M)

> 📌 Both 2022 and 2023 show recurring seasonal patterns with high sales in Q4, particularly November and December.

### 2️⃣ Product Performance (2023)

- **Best-Selling Unit**: *Silhouette* – 234 units
- **Top Revenue Model**: *Lexus LS400* – $7.92M
- **Worst-Performing Model**: *Sebring Convertible* – 5 units ($82K)

#### Body Style Performance:
| Body Style | % of Sales | Top Brand (Revenue) |
|------------|------------|---------------------|
| SUV        | 26.91%     | Dodge – $10.27M     |
| Sedan      | –          | Oldsmobile – $10.53M|
| Passenger  | –          | Volkswagen – $6.27M |
| Hatchback  | 22.30%     | Ford – $6.86M       |
| Hardtop    | 13.85%     | Chevrolet – $6.67M  |

- **Transmission Split**:
  - Automatic: 6,918 units
  - Manual: 6,343 units

> ⚠️ Hatchbacks showed the largest difference, with automatic transmission outselling manual by 454 units.

---

## ✅ Recommendations & Strategic Actions

1. **Phase Out Low-Performing Models**  
   - Consider discontinuing the *Chrysler Sebring Convertible* due to low unit sales and revenue.

2. **Boost Hardtop Sales During High-Traffic Months**  
   - Focus promotions around months like **September** and **October** where spikes were observed.

3. **Expand High-Performing Brands**  
   - Launch new models under **Chevrolet, Volvo, and BMW** to leverage brand momentum.

4. **Target Weak Sales Months with Campaigns**  
   - Enhance marketing in **January** and **October** using incentives or limited-time offers.

5. **Use Dynamic Pricing During Peak Months**  
   - Implement value-added promotions in **May, September, November, and December** to maximize revenue.

6. **Dealer Strategy**  
   - Reassess pricing and marketing in underperforming regions like **Pasco (+21.89% YoY)** and **Middletown (+20.21% YoY)**.

---

## 🖼️ Reference

- Dashboard images sourced from: [https://www.carlogos.org/](https://www.carlogos.org/)

---

## 📘 Glossary

| Term | Meaning |
|------|---------|
| **MoM** | Month-over-month |
| **YoY** | Year-over-year |

---

## 📌 Author & Credits

*Author*: *[Sanele Zondo]*  

---

