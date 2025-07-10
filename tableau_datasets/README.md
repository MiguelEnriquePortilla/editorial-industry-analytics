# 📊 Tableau Dashboard Datasets

This directory contains 5 strategically designed CSV files optimized for executive dashboard creation in Tableau.

## 📋 Dataset Overview

### 1. 📈 `01_publishing_explosion_timeline.csv`
**Digital Publishing Growth Analysis**
- Era-based publication trends (1952-2020)
- Growth factor calculations
- Visual sizing for timeline charts

**Key Fields:**
- `growth_factor` - Productivity multiplier vs baseline
- `era_icon_size` - For proportional visualizations
- `timeline_position` - Sequential ordering

### 2. 👑 `02_author_success_matrix.csv`
**Author Commercial Potential Ranking**
- Top 12 authors by commercial formula
- Strategy type classification
- Success tier segmentation

**Key Fields:**
- `commercial_potential` - Rating × Popularity × Productivity ÷ 100
- `crown_size` - Visual scaling for impact charts
- `strategy_type` - Business model classification

### 3. 🏢 `03_publisher_performance_skyline.csv`
**Publisher Efficiency Analysis**
- Specialization vs volume strategies
- Hit rate calculations
- Building height metaphors for skyline charts

**Key Fields:**
- `efficiency_score` - % of books rated 4.0+
- `building_height` - Skyline visualization scaling
- `strategy_type` - Publisher business model

### 4. 👥 `04_user_engagement_pyramid.csv`
**User Value Hierarchy**
- 5-tier user segmentation
- Engagement ratio analysis
- Power user identification

**Key Fields:**
- `user_value_score` - Composite engagement metric
- `pyramid_level` - Hierarchical positioning
- `engagement_ratio_percent` - Review/rating ratio

### 5. 💰 `05_business_impact_metrics.csv`
**Executive KPIs & Strategic Insights**
- Business impact quantification
- Priority-ranked recommendations
- ROI projections

**Key Fields:**
- `impact_level` - Strategic importance classification
- `priority` - Implementation ranking
- `dashboard_section` - Organizational grouping

## 🎨 Visualization Guidelines

### Color Coding Standards:
- **Gold (#FFD700)** - Premium/Elite performance
- **Red (#FF6B6B)** - High impact/priority
- **Teal (#4ECDC4)** - Standard/balanced performance
- **Purple (#9C27B0)** - Quality focus
- **Green (#4CAF50)** - Growth/opportunity

### Sizing Conventions:
- `crown_size` - Author commercial dominance (10-100)
- `building_height` - Publisher efficiency (35-100)
- `icon_size` - User segment importance (15-50)
- `era_icon_size` - Historical impact (10-35)

## 📊 Tableau Implementation

### Dashboard Structure:
1. **Landing Page** - Publishing explosion overview
2. **Authors** - Success matrix with crown visualizations
3. **Publishers** - Performance skyline with efficiency metrics
4. **Users** - Engagement pyramid with value scoring
5. **Impact** - Business metrics with ROI projections

### Interactive Features:
- **Time filters** - Era-based analysis
- **Strategy filters** - Business model comparisons
- **Tier selections** - Performance level focus
- **Metric drill-downs** - Detailed KPI exploration

## 🔗 Data Relationships

```
Publishing Timeline ←→ Business Impact (temporal context)
Author Success ←→ Publishers (content strategy)
User Engagement ←→ All datasets (audience targeting)
Business Impact → Strategic recommendations
```

## 🚀 Quick Start

1. Import all 5 CSV files into Tableau
2. Create relationships based on shared dimensions
3. Build visualizations using pre-calculated sizing fields
4. Apply color coding for consistent brand presentation
5. Implement filters for interactive exploration

---

**🎯 Optimized for executive decision-making and strategic planning**
