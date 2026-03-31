# 🧠 Market Continuity Prediction for Approved Drugs

## 🎯 Objective
Predict whether an FDA-approved drug will remain **Active** or become **Discontinued** after approval, enabling better lifecycle and risk assessment.

---

## 📊 Dataset

### Source Tables
- Applications  
- Submissions  
- Products  
- Marketing Status  

### Target Variable
- **Market Status**
  - 1 → Active (Prescription, OTC)  
  - 0 → Discontinued / For Further Manufacturing Use  

### Dataset Size
- ~366,000 observations  

---

## 🔧 Feature Engineering

Key features used in modeling:
- Year  
- Submission Type  
- Submission Status  
- Application Type  
- Form  
- Priority Group  
- Submission Class Code  

👉 These features capture regulatory patterns and product characteristics.

---

## 🤖 Models Evaluated

Three models were developed and compared using SAS Viya Model Studio:

### 1. Gradient Boosting ✅ (Champion Model)
- Best performance
- Lowest ASE: **0.2051**

### 2. Decision Tree
- Interpretable model
- Slightly lower performance than Gradient Boosting

### 3. Neural Network
- Captures non-linear patterns
- Higher error compared to other models

---

## 📈 Model Performance

| Model              | ASE (Approx) | Performance |
|-------------------|-------------|------------|
| Gradient Boosting | **0.2051**  | Best ✅ |
| Decision Tree     | ~0.21       | Good |
| Neural Network    | ~0.25       | Moderate |

---

## 🏆 Champion Model: Gradient Boosting

### Why selected?
- Lowest error (ASE)
- Strong predictive accuracy
- Handles complex feature interactions

---

## 📊 Key Insights

### 🔹 Feature Importance
- **Year** is the most influential variable  
- Followed by:
  - Form  
  - Application Type  
  - Priority Group  

👉 Indicates strong **temporal trends** in drug lifecycle outcomes.

---

### 🔹 Model Behavior
- Gradient Boosting shows consistent prediction vs actual trends  
- Decision Tree provides interpretability but less accuracy  
- Neural Network shows higher variance  

---

## ⚙️ Model Training Details

- Platform: **SAS Viya Model Studio**  
- Automated pipeline for:
  - Data ingestion  
  - Feature selection  
  - Model training  
  - Model comparison  
- Evaluation Metric: **Average Squared Error (ASE)**  

---

## 📉 Validation Insights

- Gradient Boosting shows closest alignment between:
  - Predicted vs Observed values  
- Stable learning curve across iterations  
- No major overfitting observed  

---

## 🚀 Business Impact

- Identify drugs at risk of discontinuation  
- Support pharmaceutical lifecycle planning  
- Improve decision-making in:
  - Portfolio management  
  - Regulatory strategy  
  - Investment prioritization  

---

## ⚠️ Limitations

- External factors not included:
  - Market competition  
  - Policy changes  
  - Clinical trial outcomes  
- Model depends on historical patterns  

---

## 📷 Visualizations
- Gradient Boosting
  <img width="975" height="633" alt="image" src="https://github.com/user-attachments/assets/5617e776-541a-4278-b1d5-e5e2ac8aa813" />
- Decision Tree
  <img width="975" height="642" alt="image" src="https://github.com/user-attachments/assets/6a6d6074-bb6e-4be3-9af9-c784bb307a4e" />
- Neural Network
  <img width="975" height="640" alt="image" src="https://github.com/user-attachments/assets/dbeaf1f9-ac74-420a-ba59-6925bf0f44ef" />



- Model comparison
  <img width="975" height="641" alt="image" src="https://github.com/user-attachments/assets/f5a7a90d-47e0-4d04-be61-e45028f894e5" />
