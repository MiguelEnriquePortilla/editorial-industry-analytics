-- ================================================================
-- AUTHOR PERFORMANCE ANALYSIS: Commercial Potential & Success Patterns
-- ================================================================
-- This analysis identifies top-performing authors using a composite
-- commercial potential formula: Rating × Popularity × Productivity

-- Main Query: Top Authors with Commercial Potential (Minimum 50 ratings)
WITH author_stats AS (
    SELECT 
        a.author_id,
        a.author,
        COUNT(DISTINCT b.book_id) as num_libros,
        COUNT(DISTINCT r.rating_id) as total_ratings,
        ROUND(AVG(r.rating), 3) as rating_promedio,
        ROUND(STDDEV(r.rating), 3) as rating_consistencia,
        COUNT(DISTINCT rev.review_id) as total_reviews,
        ROUND(AVG(b.num_pages), 0) as paginas_promedio
    FROM authors a
    JOIN books b ON a.author_id = b.author_id
    JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rev ON b.book_id = rev.book_id
    GROUP BY a.author_id, a.author
    HAVING COUNT(DISTINCT r.rating_id) >= 50
)
SELECT 
    author,
    num_libros,
    total_ratings,
    rating_promedio,
    rating_consistencia,
    total_reviews,
    paginas_promedio,
    ROUND(total_ratings::DECIMAL / num_libros, 1) as ratings_por_libro,
    ROUND(total_reviews::DECIMAL / num_libros, 1) as reviews_por_libro,
    -- Commercial Potential Formula
    ROUND((rating_promedio * total_ratings * num_libros) / 100, 1) as potencial_comercial
FROM author_stats
ORDER BY potencial_comercial DESC, rating_promedio DESC;

-- Author Segmentation by Popularity Tiers
WITH author_metrics AS (
    SELECT 
        a.author_id,
        a.author,
        COUNT(DISTINCT b.book_id) as num_libros,
        COUNT(DISTINCT r.rating_id) as total_ratings,
        ROUND(AVG(r.rating), 2) as rating_promedio,
        COUNT(DISTINCT rev.review_id) as total_reviews
    FROM authors a
    JOIN books b ON a.author_id = b.author_id
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rev ON b.book_id = rev.book_id
    GROUP BY a.author_id, a.author
    HAVING COUNT(DISTINCT r.rating_id) >= 20
)
SELECT 
    CASE 
        WHEN total_ratings >= 100 THEN 'SUPERSTARS (100+ ratings)'
        WHEN total_ratings >= 50 THEN 'ESTRELLAS (50-99 ratings)'
        WHEN total_ratings >= 30 THEN 'POPULARES (30-49 ratings)'
        ELSE 'EMERGENTES (20-29 ratings)'
    END as tier_popularidad,
    COUNT(*) as num_autores,
    ROUND(AVG(rating_promedio), 2) as rating_promedio_tier,
    ROUND(AVG(num_libros), 1) as libros_promedio,
    ROUND(AVG(total_reviews), 1) as reviews_promedio
FROM author_metrics
GROUP BY 
    CASE 
        WHEN total_ratings >= 100 THEN 'SUPERSTARS (100+ ratings)'
        WHEN total_ratings >= 50 THEN 'ESTRELLAS (50-99 ratings)'
        WHEN total_ratings >= 30 THEN 'POPULARES (30-49 ratings)'
        ELSE 'EMERGENTES (20-29 ratings)'
    END
ORDER BY rating_promedio_tier DESC;

-- Top Authors by Strategy Type
WITH author_strategies AS (
    SELECT 
        a.author,
        COUNT(DISTINCT b.book_id) as num_libros,
        COUNT(DISTINCT r.rating_id) as total_ratings,
        ROUND(AVG(r.rating), 2) as rating_promedio,
        COUNT(DISTINCT rev.review_id) as total_reviews,
        ROUND(AVG(b.num_pages), 0) as paginas_promedio,
        ROUND((AVG(r.rating) * COUNT(DISTINCT r.rating_id) * COUNT(DISTINCT b.book_id)) / 100, 1) as potencial_comercial
    FROM authors a
    JOIN books b ON a.author_id = b.author_id
    LEFT JOIN ratings r ON b.book_id = r.book_id
    LEFT JOIN reviews rev ON b.book_id = rev.book_id
    GROUP BY a.author_id, a.author
    HAVING COUNT(DISTINCT r.rating_id) >= 30
)
SELECT 
    author,
    num_libros,
    total_ratings,
    rating_promedio,
    total_reviews,
    paginas_promedio,
    potencial_comercial,
    -- Strategy Classification
    CASE 
        WHEN num_libros <= 5 AND rating_promedio >= 4.2 THEN 'Saga Epic'
        WHEN num_libros >= 10 AND total_ratings >= 100 THEN 'Volume Beast'
        WHEN rating_promedio >= 4.0 AND paginas_promedio < 300 THEN 'Emotional Pure'
        WHEN rating_promedio >= 4.3 THEN 'Classic Timeless'
        WHEN num_libros <= 3 AND rating_promedio >= 4.2 THEN 'Fantasy Cult'
        ELSE 'Balanced Strategy'
    END as strategy_type
FROM author_strategies
ORDER BY potencial_comercial DESC
LIMIT 15;

-- Authors with Highest Quality Consistency (Low Standard Deviation)
WITH author_quality AS (
    SELECT 
        a.author,
        COUNT(DISTINCT r.rating_id) as total_ratings,
        ROUND(AVG(r.rating), 2) as rating_promedio,
        ROUND(STDDEV(r.rating), 3) as rating_stddev,
        COUNT(DISTINCT b.book_id) as num_libros
    FROM authors a
    JOIN books b ON a.author_id = b.author_id
    JOIN ratings r ON b.book_id = r.book_id
    GROUP BY a.author_id, a.author
    HAVING COUNT(DISTINCT r.rating_id) >= 30
)
SELECT 
    author,
    total_ratings,
    rating_promedio,
    rating_stddev,
    num_libros,
    -- Quality Consistency Score
    ROUND(rating_promedio / NULLIF(rating_stddev, 0), 2) as consistency_score
FROM author_quality
WHERE rating_stddev IS NOT NULL
ORDER BY consistency_score DESC, rating_promedio DESC
LIMIT 10;

-- Most Polarizing Authors (High Standard Deviation but High Engagement)
SELECT 
    a.author,
    COUNT(DISTINCT r.rating_id) as total_ratings,
    ROUND(AVG(r.rating), 2) as rating_promedio,
    ROUND(STDDEV(r.rating), 3) as rating_stddev,
    COUNT(DISTINCT rev.review_id) as total_reviews,
    -- Polarization creates discussion
    ROUND(STDDEV(r.rating) * COUNT(DISTINCT rev.review_id), 2) as discussion_index
FROM authors a
JOIN books b ON a.author_id = b.author_id
JOIN ratings r ON b.book_id = r.book_id
LEFT JOIN reviews rev ON b.book_id = rev.book_id
GROUP BY a.author_id, a.author
HAVING COUNT(DISTINCT r.rating_id) >= 30
   AND STDDEV(r.rating) >= 1.0  -- High polarization
ORDER BY discussion_index DESC, total_reviews DESC
LIMIT 10;
