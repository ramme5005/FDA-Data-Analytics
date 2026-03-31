# 📊 FDA Drug Approval Analytics Platform

**Transforming FDA Drug Approval Data into Strategic Pharmaceutical Insights**

---

## 🚀 Project Overview

This project builds an integrated analytics platform that converts large, unstructured FDA datasets into **actionable business intelligence** for pharmaceutical stakeholders.

The solution combines **descriptive, predictive, and prescriptive analytics** using **Power BI, SAS Viya, and Python** to support decision-making in regulatory strategy, drug development, and market planning. 

---

## ❗ Problem Statement

Pharmaceutical stakeholders face challenges in transforming **massive, unstructured FDA datasets** into meaningful insights.

* 190,000+ records
* 12+ disconnected tables
* Limited accessibility for business users

This results in gaps in:

* Drug approval analysis
* Outcome prediction
* Market opportunity identification 

---

## 🎯 Objective

To convert raw FDA datasets into **decision-ready intelligence** by building a unified analytics platform that delivers:

* 📈 Descriptive insights
* 🔮 Predictive forecasting
* 🧠 Prescriptive recommendations 

---

## 🧰 Tools & Technologies

* **Power BI** – Dashboarding & visualization
* **SAS Viya** – Predictive modeling & forecasting
* **Python** – Machine learning & time-series modeling

---

## 📂 Data Sources

* FDA Drug Sunmissions - https://www.fda.gov/drugs/drug-approvals-and-databases/drugsfda-data-files
* Supplemental geographic datasets for regional analysis 
<img width="832" height="460" alt="image" src="https://github.com/user-attachments/assets/6e6488d8-2f06-4e28-8dc9-af5f18fc9a20" />

---

## 🔧 Data Preparation

* Cleaned and merged multiple FDA data tables
* Handled missing values
* Engineered features such as:

  * Approval Count
  * Date to monthly and Yearly
  * Market status indicators 

---

## 📊 Key Features

### 1. Interactive Power BI Dashboard

* Drug approval trends over time
* Submission patterns by drug type
* Sponsor performance analysis
* Marketing status distribution
* Geographic insights

---

### 2. 📈 Forecasting Models (SAS Viya)

* **ARIMA Model**

  * 24-month forecast horizon
  * Predicted ~294 approvals (Mar 2028)
  * 95% CI: 79 – 509

* **Seasonal Exponential Smoothing**

  * Improved forecast: ~308 approvals
  * CI: 31 – 585 

---

### 3. 🤖 Classification Model ((SAS Viya))

#### 🔹 Market Continuity Prediction

* Models: Decision Tree, Gradient Boosting, Neural Network
* Objective: Predict whether a drug remains **Active vs Discontinued**
* Best Model: **Gradient Boosting**
* Performance: Lowest ASE (0.2051)

---

### 4. 🔮 Machine Learning Models (Python)

* Long-Term Forecasting (Prophet Model)
* * Training period: 1985 – 2025
* Forecast horizon: 2040
* Estimated submissions: ~6,600–7,100 per year
* Trend: Increasing pharmaceutical activity 

---

## 💡 Business Impact

* ⏱️ **Time & Cost Savings**
  Processes 100,000+ records in minutes, saving 200+ analyst hours

* 🔁 **Scalable & Automated Pipeline**
  Auto-ingestion, retraining, and scoring with minimal manual effort

* 🌍 **Reusable Framework**
  Applicable beyond FDA datasets to any structured data problem

* ✅ **Improved Data Reliability**
  Built-in validation ensures high-quality, trustworthy insights 

---

## 🧠 Key Insights

* Drug approval trends show long-term growth
* Predictive models enable proactive regulatory planning
* Market status prediction helps identify product lifecycle risks
* Geographic analysis reveals regional pharmaceutical activity patterns

---

## 📈 Architecture Overview

The platform integrates:

1. Data cleaning
2. Feature engineering
3. Visualization (Power BI)
4. Predictive modeling (SAS + Python)
5. Decision support insights

---

## 👥 Team – T.I.G.E.R.S

* **Ramesh** – SAS Viya Predictive Modeling & Forecasting
* **Lordina** – Python ML & Prescriptive Insights
* **Breana** – Data Preparation & Design 

---

## 🔮 Future Enhancements

* Real-time data integration
* Advanced deep learning models
* Expanded geographic and therapeutic analysis

---

## 📌 Conclusion

This project demonstrates how **public government datasets** can be transformed into **strategic intelligence platforms** that support pharmaceutical decision-making, improve forecasting accuracy, and uncover market opportunities. 

---

## 📚 References

* FDA Drug Submissions Data - https://www.fda.gov/drugs/drug-approvals-and-databases/drugsfda-data-files
* Resources for Information - https://www.fda.gov/drugs/drug-approvals-and-databases/resources-information-approved-drugs
---
