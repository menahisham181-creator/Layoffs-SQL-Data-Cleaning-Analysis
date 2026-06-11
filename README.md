# Layoffs SQL Data Cleaning & Analysis

This project is an end‑to‑end SQL workflow for cleaning and analyzing a global layoffs dataset.  
It includes data cleaning, transformation, exploratory data analysis (EDA), and a final cleaned CSV ready for further use or visualization.

---

## 📌 Project Overview
The goal of this project is to take a raw layoffs dataset (sourced from Kaggle), clean it using SQL, remove inconsistencies, handle missing values, and perform exploratory analysis to uncover trends such as:

- Which companies had the highest layoffs  
- Which industries were most affected  
- Layoff trends by year and month  
- Rolling totals over time  
- Top companies per year based on layoffs  

This project demonstrates real‑world **data cleaning**, **problem‑solving**, and **analytical SQL skills**.

---

## 📂 Repository Contents

| File | Description |
|------|-------------|
| `layoffs_cleaning.sql` | Full SQL cleaning pipeline (staging, duplicates, standardization, null handling, date fixes). |
| `layoffs_analysis.sql` | EDA queries (company trends, industry totals, yearly/monthly analysis, rolling totals, rankings). |
| `Layoff_Data_Clean.csv` | Final cleaned dataset exported from MySQL. |
| `README.md` | Project documentation. |

---

## 🛠 Tools & Technologies
- **MySQL** — Data cleaning, transformations, EDA  
- **SQL Window Functions** — Ranking, rolling totals  
- **CTEs** — Organizing complex logic  
- **Kaggle Dataset** — Raw layoffs data  

---

## 🧹 Data Cleaning Steps
The cleaning pipeline includes:

- Creating staging tables  
- Identifying and removing duplicates  
- Standardizing company, industry, and country names  
- Fixing date formats  
- Handling null and blank values  
- Removing unusable rows  
- Creating a final cleaned table (`layoffs_stagging2`)  
- Exporting the cleaned dataset  

---

## 📊 Exploratory Data Analysis (EDA)
Key analysis performed:

- Total layoffs by company  
- Total layoffs by industry  
- Layoffs by country  
- Layoffs by startup stage  
- Yearly layoff trends  
- Monthly layoffs using substring date extraction  
- Rolling total layoffs over time  
- Ranking top companies per year using `DENSE_RANK()`  

---

## 💡 Key Insights
- Some companies had **100% workforce layoffs**.  
- The **tech industry** shows the highest concentration of layoffs.  
- Layoffs peaked in certain years, especially during global economic downturns.  
- Rolling totals reveal long‑term upward trends in layoffs.  
- Several companies consistently appear in the top layoffs list year after year.

---

## 📁 Dataset Source
This dataset comes from Kaggle:

https://www.kaggle.com/datasets/manjunathtl/layoffs/data


