
# 📈 Approval Volume Forecasting (SAS Viya)

## 🎯 Objective
Forecast monthly FDA drug approval volumes using historical submission data to support proactive planning and trend analysis.

---

## 📊 Dataset
- Source Table: Submissions  
- Fields Used:
  - Date (monthly)
  - Approval Count  
- Historical Coverage: 1980 – Present  

---
### FDA Approval Volume Trends & Forecast (Full Dataset)
<img width="1106" height="645" alt="image" src="https://github.com/user-attachments/assets/c6c10f69-5294-4382-befd-0860f8c6be44" />

### FDA Approval Volume Trends & Forecast (From 1980)
<img width="975" height="538" alt="image" src="https://github.com/user-attachments/assets/9de7a9ed-d5a7-47f1-a16b-6fda5291fc03" />

<img width="138" height="67" alt="image" src="https://github.com/user-attachments/assets/5fa2c6fd-f504-4d80-97ee-c98ef393a6db" />

---
## 🔧 Methodology

### 1. Time Series Preparation
- Aggregated approval counts at monthly level  
- Handled missing values and inconsistencies  
- Ensured chronological ordering for modeling  

---

### 2. Models Used

#### 🔹 ARIMA Model
- Captures trend and autocorrelation in time series  
- Forecast Horizon: 24 months  

#### 🔹 Seasonal Exponential Smoothing (Final Model)
- Captures both trend and seasonality  
- Selected as improved model after comparison  

---

## 📈 Forecast Results

### ARIMA Model Output
- Forecast (March 2028): ~294 approvals  
- Confidence Interval (95%): 79 – 509  

### Final Model (Seasonal Exponential Smoothing)
- Forecast (March 2028): ~308 approvals  
- Confidence Interval (95%): 31 – 585  

---

## 📊 Key Insights
- Approval volumes show **long-term upward trend**  
- Presence of **seasonality patterns** across months  
- Wide confidence interval indicates **variability in regulatory activity**  

---

## 🧠 Model Interpretation
- ARIMA provided baseline forecasting using historical dependencies  
- Seasonal Exponential Smoothing improved results by capturing recurring patterns  
- Final model better reflects real-world fluctuations in approvals  

---

## ⚙️ Implementation (SAS Viya)
- Built using **SAS Viya Model Studio pipeline**  
- Automated:
  - Data ingestion  
  - Model training  
  - Forecast generation  
- Visual pipeline used for model comparison and selection  

---

## 🚀 Business Impact
- Enables forecasting of drug approval trends  
- Supports regulatory planning and resource allocation  
- Helps identify future growth in pharmaceutical activity  

