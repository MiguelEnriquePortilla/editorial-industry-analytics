# 📚 Editorial Industry Analytics

> **Data-driven insights into the digital publishing revolution: analyzing 1,000+ books to decode engagement patterns and commercial success factors.**

![Python](https://img.shields.io/badge/python-v3.8+-blue.svg)
![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue.svg)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-orange.svg)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)

## 🎯 **Project Overview**

This comprehensive analysis explores the explosive growth of digital publishing and reading platforms during the pandemic era. Through advanced SQL queries and Python analytics, I uncovered critical patterns that define success in the modern reading app ecosystem.

### **Key Discoveries:**
- 📈 **82% of books** published after 2000 (10.8x growth explosion)
- 👑 **J.K. Rowling** leads commercial potential with 66.9 points
- 🏢 **Vertigo Publishers** achieves 90% hit rate vs industry average
- 👥 **Power users** (0.8%) generate 15x more value than average users

## 🛠️ **Tech Stack**

| Technology | Purpose |
|------------|---------|
| **Python** | Data analysis, statistical modeling, visualizations |
| **SQL (PostgreSQL)** | Complex queries across 5 relational tables |
| **Pandas & NumPy** | Data manipulation and numerical analysis |
| **Matplotlib & Seaborn** | Statistical visualizations and trend analysis |
| **Tableau** | Executive dashboard creation |
| **Jupyter Notebooks** | Analysis documentation and reproducibility |

## 📊 **Dataset Overview**

Analyzed comprehensive publishing ecosystem data:

```
📚 1,000 books    | 🎭 636 authors    | 🏢 340 publishers
⭐ 6,456 ratings  | 💬 2,793 reviews  | 📅 1952-2020 timeline
```

**Data Sources:**
- Books metadata (titles, pages, publication dates)
- User engagement (ratings, reviews, interaction patterns)
- Author productivity and quality metrics
- Publisher performance and specialization data

## 🔍 **Analysis Framework**

### **Phase 1: Temporal Analysis**
- Digital publishing explosion post-2000
- Era-based productivity comparisons
- Market transformation patterns

### **Phase 2: Engagement Intelligence**
- User behavior pattern identification
- Review-to-rating correlation analysis
- Content length vs engagement optimization

### **Phase 3: Commercial Success Mapping**
- Author potential scoring algorithm
- Publisher efficiency benchmarking
- Success strategy classification

### **Phase 4: User Segmentation**
- Power user identification (50+ book threshold)
- Engagement ratio predictive modeling
- Community value assessment

## 📈 **Key Findings & Business Impact**

### 🚀 **The Digital Revolution**
```sql
-- 82% of books published after 2000
SELECT 
    CASE WHEN publication_date > '2000-01-01' THEN 'Post-2000' ELSE 'Pre-2000' END as era,
    COUNT(*) as books,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books), 1) as percentage
FROM books 
GROUP BY era;
```
**Impact:** Confirms massive opportunity in digital reading platforms

### 👑 **Author Success Formula**
```python
# Commercial Potential = Rating × Popularity × Productivity
potencial_comercial = (rating_promedio * total_ratings * num_libros) / 100
```
**Top Performers:**
- J.K. Rowling: 66.9 points (Saga strategy)
- Stephen King: 55.9 points (Volume strategy)
- Nicholas Sparks: 43.0 points (Emotional strategy)

### 🏢 **Publisher Efficiency Matrix**
| Publisher | Hit Rate | Strategy |
|-----------|----------|----------|
| Vertigo | 90.0% | Premium Quality |
| Simon Pulse | 88.9% | YA Specialist |
| Delta | 84.6% | Balanced Portfolio |

### 👥 **User Value Hierarchy**
- **Power Users:** 9 users (0.8%) → 24.3 reviews average
- **Active Users:** 151 users (13.8%) → 17.1 reviews average
- **Regular Users:** 840+ users (86%) → 2.4 reviews average

## 📊 **Visualizations & Dashboard**

### **Executive Dashboard Components:**
1. **📈 Publishing Explosion Timeline** - Era-based growth visualization
2. **👑 Author Success Matrix** - Commercial potential mapping
3. **🏢 Publisher Performance Skyline** - Efficiency comparison
4. **👥 User Engagement Pyramid** - Value segmentation
5. **💰 Business Impact Metrics** - ROI and strategic recommendations

![Dashboard Preview](visualizations/dashboard_preview.png)

## 🎯 **Strategic Recommendations**

### **For Content Strategy:**
- ✅ Prioritize saga/series content over standalone books
- ✅ Focus on authors with 4.0+ ratings and multiple works
- ✅ Partner with specialized publishers (90%+ hit rates)

### **For User Acquisition:**
- ✅ Identify potential power users at 20+ book threshold
- ✅ Cultivate 40%+ engagement ratio users
- ✅ Convert lurkers (84% of users) into active contributors

### **For Platform Optimization:**
- ✅ Promote longer content (600+ pages = 6.7% more engagement)
- ✅ Leverage controversy for discussion generation
- ✅ Implement author-based recommendation algorithms

## 📁 **Repository Structure**

```
editorial-industry-analytics/
│
├── 📊 analysis/
│   ├── data_exploration.ipynb
│   ├── statistical_analysis.ipynb
│   └── engagement_modeling.ipynb
│
├── 🗄️ sql_queries/
│   ├── temporal_analysis.sql
│   ├── author_performance.sql
│   ├── publisher_metrics.sql
│   └── user_segmentation.sql
│
├── 📈 visualizations/
│   ├── publishing_explosion.png
│   ├── author_success_matrix.png
│   └── dashboard_preview.png
│
├── 📋 tableau_datasets/
│   ├── publishing_explosion_timeline.csv
│   ├── author_success_matrix.csv
│   ├── publisher_performance.csv
│   ├── user_engagement_pyramid.csv
│   └── business_impact_metrics.csv
│
└── 📖 documentation/
    ├── methodology.md
    ├── data_dictionary.md
    └── insights_summary.md
```

## 🚀 **How to Use This Analysis**

### **Prerequisites:**
```bash
pip install pandas numpy matplotlib seaborn sqlalchemy psycopg2
```

### **Database Connection:**
```python
# Configure PostgreSQL connection
db_config = {
    'host': 'your_host',
    'database': 'editorial_db',
    'user': 'your_user',
    'password': 'your_password'
}
```

### **Run Analysis:**
```bash
# Execute complete analysis pipeline
jupyter notebook analysis/data_exploration.ipynb
```

## 💡 **Insights for Reading Platform Strategy**

This analysis provides actionable intelligence for:
- **Content Acquisition Teams** → Which authors/publishers to prioritize
- **Product Managers** → User engagement optimization strategies
- **Marketing Teams** → High-value user identification and retention
- **C-Suite Executives** → Data-driven investment decisions

## 🔗 **Connect & Collaborate**

- 💼 **LinkedIn:** [miguel-enrique-portilla](https://www.linkedin.com/in/miguel-enrique-portilla-2a89782a0)
- 📧 **Email:** miguel.e.portilla@gmail.com
- 🌟 **Portfolio:** [View More Projects](https://github.com/MiguelEnriquePortilla)

---

**📊 Built with passion for data-driven insights | Transforming complex analytics into strategic advantage**
