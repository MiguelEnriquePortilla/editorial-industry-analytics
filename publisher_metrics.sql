-- ================================================================
-- PUBLISHER PERFORMANCE ANALYSIS: Efficiency vs Volume Strategies
-- ================================================================
-- This analysis reveals that specialization beats volume:
-- Vertigo achieves 90% hit rate vs Penguin's 36% despite lower volume

-- Main Query: Top Publishers by Content Quality (+50 pages threshold)
SELECT 
    p.publisher,
    COUNT(b.book_id) as total_libros,
    COUNT(CASE WHEN b.num_pages > 50 THEN 1 END) as libros_50_plus,
    ROUND(AVG(b.num_pages), 0) as paginas_promedio,
    ROUND(AVG(rating_data.avg_rating), 2) as rating_promedio,
    COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) as libros_alta_calidad,
    -- Efficiency Score: % of books that are high quality
    ROUND(COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) * 100.0 / COUNT(b.book_id), 1) as efficiency_score
FROM publishers p
JOIN books b ON p.publisher_id = b.publisher_id
LEFT JOIN (
    SELECT book_id, AVG(rating) as avg_rating
    FROM ratings 
    GROUP BY book_id
) rating_data ON b.book_id = rating_data.book_id
GROUP BY p.publisher_id, p.publisher
HAVING COUNT(b.book_id) >= 5  -- Minimum 5 books for statistical relevance
ORDER BY efficiency_score DESC, rating_promedio DESC
LIMIT 20;

-- Publisher Segmentation by Quality Tiers
WITH publisher_ratings AS (
    SELECT 
        p.publisher,
        p.publisher_id,
        ROUND(AVG(rating_data.avg_rating), 2) as rating_promedio_editorial,
        COUNT(b.book_id) as total_libros,
        ROUND(AVG(b.num_pages), 0) as paginas_promedio
    FROM publishers p
    JOIN books b ON p.publisher_id = b.publisher_id
    LEFT JOIN (
        SELECT book_id, AVG(rating) as avg_rating
        FROM ratings 
        GROUP BY book_id
    ) rating_data ON b.book_id = rating_data.book_id
    WHERE rating_data.avg_rating IS NOT NULL
    GROUP BY p.publisher, p.publisher_id
    HAVING COUNT(b.book_id) >= 5
)
SELECT 
    CASE 
        WHEN rating_promedio_editorial >= 4.2 THEN 'Premium Elite (4.2+)'
        WHEN rating_promedio_editorial >= 3.8 THEN 'High Quality (3.8-4.2)'
        WHEN rating_promedio_editorial >= 3.5 THEN 'Standard (3.5-3.8)'
        ELSE 'Basic (<3.5)'
    END as tier_calidad,
    COUNT(*) as num_editoriales,
    SUM(total_libros) as total_libros,
    ROUND(AVG(paginas_promedio), 0) as paginas_promedio,
    ROUND(AVG(rating_promedio_editorial), 2) as rating_promedio_tier
FROM publisher_ratings
GROUP BY 
    CASE 
        WHEN rating_promedio_editorial >= 4.2 THEN 'Premium Elite (4.2+)'
        WHEN rating_promedio_editorial >= 3.8 THEN 'High Quality (3.8-4.2)'
        WHEN rating_promedio_editorial >= 3.5 THEN 'Standard (3.5-3.8)'
        ELSE 'Basic (<3.5)'
    END
ORDER BY rating_promedio_tier DESC;

-- Volume vs Quality: The Specialization Advantage
SELECT 
    p.publisher,
    COUNT(b.book_id) as volumen_libros,
    ROUND(AVG(rating_data.avg_rating), 2) as calidad_promedio,
    COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) as hits_alta_calidad,
    ROUND(COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) * 100.0 / COUNT(b.book_id), 1) as porcentaje_hits,
    -- Strategy Classification
    CASE 
        WHEN COUNT(b.book_id) >= 30 AND ROUND(COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) * 100.0 / COUNT(b.book_id), 1) < 50 THEN 'Volume Strategy'
        WHEN COUNT(b.book_id) <= 15 AND ROUND(COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) * 100.0 / COUNT(b.book_id), 1) >= 80 THEN 'Premium Specialist'
        WHEN ROUND(COUNT(CASE WHEN rating_data.avg_rating >= 4.0 THEN 1 END) * 100.0 / COUNT(b.book_id), 1) >= 60 THEN 'Quality Focus'
        ELSE 'Balanced Approach'
    END as strategy_type
FROM publishers p
JOIN books b ON p.publisher_id = b.publisher_id
LEFT JOIN (
    SELECT book_id, AVG(rating) as avg_rating
    FROM ratings 
    GROUP BY book_id
) rating_data ON b.book_id = rating_data.book_id
WHERE rating_data.avg_rating IS NOT NULL
GROUP BY p.publisher_id, p.publisher
HAVING COUNT(b.book_id) >= 8  -- Minimum volume for strategy analysis
ORDER BY porcentaje_hits DESC, calidad_promedio DESC
LIMIT 15;

-- Publisher Specialization Analysis: Page Length Preferences
WITH publisher_specialization AS (
    SELECT 
        p.publisher,
        COUNT(b.book_id) as total_books,
        ROUND(AVG(b.num_pages), 0) as avg_pages,
        ROUND(AVG(rating_data.avg_rating), 2) as avg_rating,
        -- Page length specialization
        COUNT(CASE WHEN b.num_pages < 200 THEN 1 END) as short_books,
        COUNT(CASE WHEN b.num_pages BETWEEN 200 AND 400 THEN 1 END) as medium_books,
        COUNT(CASE WHEN b.num_pages BETWEEN 400 AND 600 THEN 1 END) as long_books,
        COUNT(CASE WHEN b.num_pages > 600 THEN 1 END) as epic_books
    FROM publishers p
    JOIN books b ON p.publisher_id = b.publisher_id
    LEFT JOIN (
        SELECT book_id, AVG(rating) as avg_rating
        FROM ratings 
        GROUP BY book_id
    ) rating_data ON b.book_id = rating_data.book_id
    WHERE rating_data.avg_rating IS NOT NULL
    GROUP BY p.publisher_id, p.publisher
    HAVING COUNT(b.book_id) >= 8
)
SELECT 
    publisher,
    total_books,
    avg_pages,
    avg_rating,
    -- Specialization percentages
    ROUND(short_books * 100.0 / total_books, 1) as pct_short,
    ROUND(medium_books * 100.0 / total_books, 1) as pct_medium,
    ROUND(long_books * 100.0 / total_books, 1) as pct_long,
    ROUND(epic_books * 100.0 / total_books, 1) as pct_epic,
    -- Dominant specialization
    CASE 
        WHEN short_books * 100.0 / total_books >= 60 THEN 'Short Form Specialist'
        WHEN medium_books * 100.0 / total_books >= 50 THEN 'Medium Length Focus'
        WHEN long_books * 100.0 / total_books >= 40 THEN 'Long Form Publisher'
        WHEN epic_books * 100.0 / total_books >= 30 THEN 'Epic Content Creator'
        ELSE 'Diversified Portfolio'
    END as specialization_type
FROM publisher_specialization
ORDER BY avg_rating DESC, total_books DESC;

-- Market Overview: Editorial Landscape Summary
SELECT 
    COUNT(DISTINCT p.publisher_id) as total_editoriales,
    COUNT(b.book_id) as total_libros,
    COUNT(CASE WHEN b.num_pages > 50 THEN 1 END) as libros_sustanciales,
    ROUND(COUNT(CASE WHEN b.num_pages > 50 THEN 1 END) * 100.0 / COUNT(b.book_id), 2) as porcentaje_calidad,
    ROUND(AVG(b.num_pages), 0) as paginas_promedio_mercado,
    ROUND(AVG(rating_data.avg_rating), 2) as rating_promedio_mercado
FROM publishers p
JOIN books b ON p.publisher_id = b.publisher_id
LEFT JOIN (
    SELECT book_id, AVG(rating) as avg_rating
    FROM ratings 
    GROUP BY book_id
) rating_data ON b.book_id = rating_data.book_id;
