#  Clinic Database System (SQL Project)

##  Project Overview
This project involves the design and implementation of a relational database system for a healthcare clinic using SQL.

The system is built to simulate real-world clinic operations, enabling structured management of:
- Patient records  
- Appointment scheduling  
- Healthcare services  
- Clinical attendance  
- Billing and payments  

The aim is to demonstrate how a well-designed database can support both **operational efficiency** and **data-driven decision-making** in a healthcare environment.

---

##  Problem Statement
Healthcare clinics often deal with fragmented data across multiple systems, making it difficult to:
- Track patient interactions efficiently  
- Monitor appointment activity  
- Manage billing and payments  
- Analyse service performance  

This project addresses these challenges by designing a **centralised relational database** that integrates all key operational components into a single system.

---

##  Objectives
- Design a structured relational database schema  
- Define clear relationships between entities  
- Populate the database with realistic, high-quality sample data (100+ patients)  
- Implement SQL queries to extract meaningful insights  
- Simulate real-world healthcare data workflows  

---

##  Technologies Used
- **Database:** MySQL  
- **Language:** SQL  
- **Concepts Applied:**
  - Relational modelling  
  - Primary & Foreign Keys  
  - Indexing  
  - Joins (INNER JOIN)  
  - Aggregation (SUM, COUNT)  
  - Conditional logic (CASE)  

---

##  Database Design

###  Entities

The database consists of six core entities:

1. **Patients**  
   Stores patient demographic and contact information.

2. **Professionals**  
   Contains details of healthcare staff (GPs, nurses, specialists).

3. **Services**  
   Defines the services offered by the clinic along with duration and cost.

4. **Appointments**  
   Central entity linking patients, professionals, and services.

5. **Attendance**  
   Records whether appointments were attended, cancelled, or missed.

6. **Bills**  
   Tracks financial transactions linked to appointments.

---

###  Relationships

- **Appointments → Patients, Professionals, Services**  
  One-to-many relationships where each appointment is linked to one entity, but each entity can have multiple appointments.

- **Appointments → Attendance & Bills**  
  One-to-one relationship ensuring each appointment has a single attendance and billing record.

- **Many-to-many relationships (indirect)**  
  Achieved through the Appointments table, allowing:
  - Patients to access multiple services  
  - Professionals to deliver multiple services  

---

##  Data Overview
- 100+ patients with realistic demographic data  
- Multiple healthcare services with varied pricing and duration  
- Appointment records covering:
  - Completed  
  - Booked  
  - Cancelled  
  - No-show scenarios  

The dataset is designed to reflect **real-world variability**, avoiding repetitive or ambiguous values.

---

##  Key Analytical Queries

### 1. Patient Demographics Analysis
Identifies patients within specific age and gender groups, useful for targeted healthcare services (e.g., screenings).

---

### 2. Appointment Monitoring
Tracks cancelled and missed appointments to identify operational inefficiencies and potential revenue loss.

---

### 3. Appointment Scheduling Insights
Retrieves upcoming appointments along with patient details to support resource planning.

---

### 4. Billing Status Analysis
Uses conditional logic to categorise payments as *Paid* or *Unpaid*, supporting financial tracking.

---

### 5. Revenue Analysis by Service
Calculates total revenue and number of transactions per service, helping identify high-performing services.

---

### 6. Patient Engagement Analysis
Measures the number of visits per patient to understand utilisation patterns and potential over/under usage.

---

##  Key Insights (Example)

- Some services generate higher revenue despite lower appointment volume  
- Missed and cancelled appointments directly impact clinic efficiency  
- Patient engagement varies significantly across the dataset  
- Billing data can highlight potential cash flow issues  

---

##  Business Value

This database structure enables:
- Efficient patient and appointment management  
- Better financial tracking and revenue analysis  
- Improved resource planning for healthcare professionals  
- Data-driven decision-making in clinic operations  

---

##  Limitations
- The dataset is simulated and does not represent real patient data  
- Does not include advanced features such as:
  - Real-time updates  
  - Multi-branch clinic support  
  - Integration with external healthcare systems  

---

##  Future Improvements
- Add stored procedures and triggers  
- Integrate reporting dashboards (Tableau / Power BI)  
- Extend schema for multi-location clinics  
- Include time-series analysis for appointment trends  

---

##  Conclusion
This project demonstrates how SQL and relational database design can be applied to solve real-world healthcare data challenges.  

It highlights the importance of structured data in improving operational workflows, financial tracking, and overall decision-making within a clinic environment.
