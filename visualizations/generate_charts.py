#!/usr/bin/env python3
"""
📊 EDITORIAL INDUSTRY ANALYTICS - VISUALIZATION GENERATOR
=========================================================
This script generates publication-ready charts for the editorial industry analysis.
Creates high-quality PNG files optimized for GitHub README display.

Key Visualizations:
- Digital Publishing Explosion (1952-2020)
- Author Commercial Success Matrix  
- Publisher Efficiency Comparison
- User Engagement Hierarchy
- Strategic Recommendations Dashboard

Author: Miguel Enrique Portilla
Date: 2024
"""

import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
from pathlib import Path

# Configuration
plt.style.use('default')
sns.set_palette("husl")
plt.rcParams['figure.figsize'] = (12, 8)
plt.rcParams['savefig.dpi'] = 300  # High quality for GitHub
plt.rcParams['savefig.bbox'] = 'tight'

# Create output directory
output_dir = Path('visualizations')
output_dir.mkdir(exist_ok=True)

def create_publishing_explosion_chart():
    """
    📈 Digital Publishing Explosion Visualization
    Shows the 10.8x growth factor post-2000
    """
    # Data from analysis
    era_data = {
        'Era': ['Pre-2000\n(Analog Era)', 'Post-2000\n(Digital Era)'],
        'Books': [181, 819],
        'Books_per_Year': [181/48, 819/20],
        'Percentage': [18.1, 81.9]
    }
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 8))
    fig.suptitle('🚀 THE DIGITAL PUBLISHING EXPLOSION', fontsize=20, fontweight='bold', y=0.95)
    
    # Pie Chart: Era Distribution
    colors = ['#ff6b6b', '#4ecdc4']
    wedges, texts, autotexts = ax1.pie(era_data['Books'], 
                                       labels=era_data['Era'],
                                       colors=colors,
                                       autopct='%1.1f%%',
                                       startangle=90,
                                       explode=(0.05, 0.15))
    
    ax1.set_title('📊 Era Distribution\n82% Post-2000 Dominance', fontsize=14, fontweight='bold', pad=20)
    
    # Bar Chart: Productivity Explosion
    bars = ax2.bar(era_data['Era'], era_data['Books_per_Year'], 
                   color=['#ff7f7f', '#7fbf7f'], alpha=0.8, width=0.6)
    
    ax2.set_title('⚡ Productivity Revolution\n10.8x Growth Factor', fontsize=14, fontweight='bold')
    ax2.set_ylabel('Books Published per Year', fontsize=12)
    
    # Add values
    for i, value in enumerate(era_data['Books_per_Year']):
        ax2.text(i, value + 0.5, f'{value:.1f}', ha='center', va='bottom', 
                 fontweight='bold', fontsize=14)
    
    # Add growth factor annotation
    ax2.annotate('10.8x GROWTH', xy=(1, era_data['Books_per_Year'][1]), 
                xytext=(0.5, 35), fontsize=16, fontweight='bold', color='red',
                arrowprops=dict(arrowstyle='->', color='red', lw=3))
    
    plt.tight_layout()
    plt.savefig(output_dir / 'publishing_explosion.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✅ Generated: publishing_explosion.png")

def create_author_success_matrix():
    """
    👑 Author Commercial Success Matrix
    J.K. Rowling dominance visualization
    """
    # Data from analysis
    authors_data = {
        'Author': ['J.K. Rowling', 'Stephen King', 'Nicholas Sparks', 'John Grisham', 
                  'Jodi Picoult', 'James Patterson', 'Terry Pratchett', 'J.R.R. Tolkien'],
        'Commercial_Potential': [66.9, 55.9, 43.0, 39.0, 30.0, 29.6, 27.3, 21.1],
        'Strategy': ['Saga Epic', 'Volume Beast', 'Emotional Pure', 'Thriller Machine',
                    'Drama Focus', 'Volume Beast', 'Fantasy Humor', 'Fantasy Cult']
    }
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(18, 8))
    fig.suptitle('👑 AUTHOR SUCCESS MATRIX: Commercial Potential Leaders', 
                 fontsize=18, fontweight='bold', y=0.95)
    
    # Commercial Potential Ranking
    colors_gradient = ['#FF1744', '#FF5722', '#FF9800', '#FFC107', 
                      '#8BC34A', '#4CAF50', '#009688', '#00BCD4']
    
    bars = ax1.barh(range(len(authors_data['Author'])), authors_data['Commercial_Potential'], 
                    color=colors_gradient, alpha=0.85, edgecolor='black')
    
    ax1.set_yticks(range(len(authors_data['Author'])))
    ax1.set_yticklabels(authors_data['Author'], fontsize=11, fontweight='bold')
    ax1.set_title('💰 Commercial Potential Ranking', fontsize=14, fontweight='bold')
    ax1.set_xlabel('Commercial Potential Score', fontsize=12)
    
    # Add values
    for i, value in enumerate(authors_data['Commercial_Potential']):
        ax1.text(value + 1, i, f'{value}', va='center', fontweight='bold')
    
    # Highlight J.K. Rowling
    ax1.text(75, 0, '← QUEEN OF\nCOMMERCE', va='center', fontweight='bold', 
             fontsize=12, color='darkred')
    
    # Strategy Distribution Pie
    strategy_counts = pd.Series(authors_data['Strategy']).value_counts()
    colors_strategy = ['#FFD700', '#FF6B6B', '#4ECDC4', '#96CEB4', '#FECA57', '#E74C3C']
    
    wedges, texts, autotexts = ax2.pie(strategy_counts.values, 
                                       labels=strategy_counts.index,
                                       colors=colors_strategy[:len(strategy_counts)],
                                       autopct='%1.0f%%',
                                       startangle=45)
    
    ax2.set_title('🎯 Success Strategy Distribution', fontsize=14, fontweight='bold')
    
    plt.tight_layout()
    plt.savefig(output_dir / 'author_success_matrix.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✅ Generated: author_success_matrix.png")

def create_publisher_performance():
    """
    🏢 Publisher Performance: Specialization vs Volume
    """
    # Data from analysis
    publishers_data = {
        'Publisher': ['Vertigo', 'Simon Pulse', 'Delta', 'HarperTorch', 'Berkley', 
                     'Modern Library', 'Ballantine', 'Dell Publishing'],
        'Efficiency_Score': [90.0, 88.9, 84.6, 80.0, 70.6, 66.7, 63.2, 62.5],
        'Volume': [10, 9, 13, 10, 17, 9, 19, 8],
        'Strategy': ['Premium', 'YA Specialist', 'Balanced', 'Romance', 
                    'General', 'Classic', 'Popular', 'Mystery']
    }
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(18, 8))
    fig.suptitle('🏢 PUBLISHER PERFORMANCE: Specialization Beats Volume', 
                 fontsize=18, fontweight='bold', y=0.95)
    
    # Efficiency Ranking
    colors_efficiency = plt.cm.RdYlGn([x/100 for x in publishers_data['Efficiency_Score']])
    
    bars = ax1.barh(range(len(publishers_data['Publisher'])), publishers_data['Efficiency_Score'], 
                    color=colors_efficiency, alpha=0.8, edgecolor='black')
    
    ax1.set_yticks(range(len(publishers_data['Publisher'])))
    ax1.set_yticklabels(publishers_data['Publisher'], fontsize=11, fontweight='bold')
    ax1.set_title('📊 Publisher Efficiency Score (%)', fontsize=14, fontweight='bold')
    ax1.set_xlabel('Efficiency Score (% High-Quality Books)', fontsize=12)
    
    # Add efficiency values
    for i, value in enumerate(publishers_data['Efficiency_Score']):
        ax1.text(value + 1, i, f'{value}%', va='center', fontweight='bold')
    
    # Volume vs Quality Scatter
    scatter = ax2.scatter(publishers_data['Volume'], publishers_data['Efficiency_Score'], 
                         s=[x*20 for x in publishers_data['Volume']], 
                         c=publishers_data['Efficiency_Score'], cmap='RdYlGn', 
                         alpha=0.7, edgecolors='black', linewidth=2)
    
    ax2.set_xlabel('Volume (Number of Books)', fontsize=12)
    ax2.set_ylabel('Efficiency Score (%)', fontsize=12)
    ax2.set_title('📈 Volume vs Quality Strategy\nSpecialization Wins', fontsize=14, fontweight='bold')
    
    # Add trend line
    z = np.polyfit(publishers_data['Volume'], publishers_data['Efficiency_Score'], 1)
    p = np.poly1d(z)
    ax2.plot(publishers_data['Volume'], p(publishers_data['Volume']), 
             "r--", alpha=0.8, linewidth=2, label='Trend: Quality ↓ as Volume ↑')
    
    # Annotate key players
    ax2.annotate('VERTIGO\n(90% Efficiency)', (10, 90), xytext=(15, 85), 
                arrowprops=dict(arrowstyle='->', color='red', lw=2), 
                fontweight='bold', fontsize=11)
    
    ax2.legend()
    
    plt.tight_layout()
    plt.savefig(output_dir / 'publisher_performance.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✅ Generated: publisher_performance.png")

def create_user_engagement_pyramid():
    """
    👥 User Engagement Hierarchy: Power User Analysis
    """
    # Data from analysis
    user_data = {
        'Segment': ['POWER\nUSERS', 'ACTIVE\nUSERS', 'REGULAR\nUSERS', 
                   'OCCASIONAL\nUSERS', 'NOVICE\nUSERS'],
        'Count': [9, 151, 300, 400, 240],
        'Avg_Reviews': [24.3, 17.1, 8.5, 3.2, 1.1],
        'Engagement_Ratio': [45.8, 43.0, 25.0, 15.0, 8.0]
    }
    
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(18, 8))
    fig.suptitle('👥 USER ENGAGEMENT HIERARCHY: The Power User Advantage', 
                 fontsize=18, fontweight='bold', y=0.95)
    
    # User Pyramid
    colors_pyramid = ['#FFD700', '#FF6B6B', '#4ECDC4', '#95E1D3', '#F38181']
    bars = ax1.bar(range(len(user_data['Segment'])), user_data['Count'], 
                   color=colors_pyramid, alpha=0.85, edgecolor='black', linewidth=2)
    
    ax1.set_xticks(range(len(user_data['Segment'])))
    ax1.set_xticklabels(user_data['Segment'], fontsize=11, fontweight='bold')
    ax1.set_title('📊 User Engagement Pyramid\nPower Users = 0.8% of Base', 
                  fontsize=14, fontweight='bold')
    ax1.set_ylabel('Number of Users')
    
    # Add user counts
    for i, value in enumerate(user_data['Count']):
        ax1.text(i, value + 15, str(value), ha='center', va='bottom', fontweight='bold')
    
    # Highlight power users
    ax1.text(0, 450, '👑 ELITE\n(0.8%)', ha='center', fontweight='bold', 
             fontsize=12, color='goldenrod')
    
    # Review Productivity Comparison
    productivity_values = [24.3, 17.1, 2.4]  # Power, Active, Average
    productivity_labels = ['Power Users', 'Active Users', 'Average User']
    
    bars2 = ax2.bar(productivity_labels, productivity_values, 
                    color=['#FFD700', '#FF6B6B', '#CCCCCC'], alpha=0.85, edgecolor='black')
    
    ax2.set_title('⚡ Review Productivity Comparison\n15x More Productive', 
                  fontsize=14, fontweight='bold')
    ax2.set_ylabel('Average Reviews per User')
    
    # Add productivity values
    for i, value in enumerate(productivity_values):
        ax2.text(i, value + 0.5, f'{value:.1f}', ha='center', va='bottom', fontweight='bold')
    
    # Highlight 15x difference
    ax2.text(0, 27, '15x MORE\nVALUABLE', ha='center', fontweight='bold', 
             fontsize=12, color='red')
    
    plt.tight_layout()
    plt.savefig(output_dir / 'user_engagement_pyramid.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✅ Generated: user_engagement_pyramid.png")

def create_strategic_dashboard():
    """
    📊 Strategic Recommendations Dashboard
    """
    # Key metrics from analysis
    metrics = {
        'Metric': ['Digital Era\nDominance', 'Publishing\nGrowth', 'Top Author\nPotential', 
                  'Best Publisher\nEfficiency', 'Power User\nMultiplier', 'Engagement\nThreshold'],
        'Value': [82, 10.8, 66.9, 90, 15, 40],
        'Unit': ['%', 'x', 'pts', '%', 'x', '%'],
        'Color': ['#FF6B35', '#FF1744', '#FFD700', '#4ECDC4', '#9C27B0', '#4CAF50']
    }
    
    fig, ax = plt.subplots(figsize=(14, 8))
    fig.suptitle('📊 STRATEGIC INSIGHTS DASHBOARD', fontsize=18, fontweight='bold', y=0.95)
    
    bars = ax.bar(range(len(metrics['Metric'])), metrics['Value'], 
                  color=metrics['Color'], alpha=0.8, edgecolor='black', linewidth=2)
    
    ax.set_xticks(range(len(metrics['Metric'])))
    ax.set_xticklabels(metrics['Metric'], fontsize=12, fontweight='bold')
    ax.set_title('Key Performance Indicators for Reading Platform Strategy', 
                 fontsize=14, fontweight='bold', pad=20)
    ax.set_ylabel('Metric Value', fontsize=12)
    
    # Add values with units
    for i, (value, unit) in enumerate(zip(metrics['Value'], metrics['Unit'])):
        ax.text(i, value + 2, f'{value}{unit}', ha='center', va='bottom', 
                fontweight='bold', fontsize=12)
    
    # Add reference lines
    ax.axhline(y=50, color='orange', linestyle='--', alpha=0.6, linewidth=2)
    ax.text(5.2, 52, 'High Impact Zone', fontweight='bold', color='orange')
    
    plt.tight_layout()
    plt.savefig(output_dir / 'strategic_dashboard.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✅ Generated: strategic_dashboard.png")

def main():
    """
    🚀 Generate all visualization charts
    """
    print("📊 GENERATING EDITORIAL ANALYTICS VISUALIZATIONS")
    print("=" * 60)
    
    create_publishing_explosion_chart()
    create_author_success_matrix()
    create_publisher_performance()
    create_user_engagement_pyramid()
    create_strategic_dashboard()
    
    print("\n🎉 ALL VISUALIZATIONS GENERATED SUCCESSFULLY!")
    print("📁 Files saved in: visualizations/ directory")
    print("🌟 Ready for GitHub README integration")

if __name__ == "__main__":
    main()
