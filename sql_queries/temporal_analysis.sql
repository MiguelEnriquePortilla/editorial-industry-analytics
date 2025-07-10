-- ================================================================
-- TEMPORAL ANALYSIS: Digital Publishing Explosion Post-2000
-- ================================================================
-- This analysis reveals the 10.8x growth explosion in publishing
-- after the year 2000, demonstrating the digital transformation impact

-- Main Query: Books published after January 1, 2000
SELECT 
    COUNT(*) as libros_post_2000,
    MIN(publication_date) as primera_fecha_post_2000,
    MAX(publication_date) as ultima_fecha_post_2000
FROM books 
WHERE publication_date > '2000-01-01';

-- Comparative Analysis: Pre vs Post 2000
SELECT 
    CASE 
        WHEN publication_date <= '2000-01-01' THEN 'Pre-2000'
        ELSE 'Post-2000'
    END as periodo,
    COUNT(*) as cantidad_libros,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books), 2) as porcentaje
FROM books 
GROUP BY 
    CASE 
        WHEN publication_date <= '2000-01-01' THEN 'Pre-2000'
        ELSE 'Post-2000'
    END
ORDER BY periodo;

-- Decade-by-Decade Analysis
SELECT 
    CASE 
        WHEN EXTRACT(YEAR FROM publication_date) < 1960 THEN '1950s'
        WHEN EXTRACT(YEAR FROM publication_date) < 1970 THEN '1960s'
        WHEN EXTRACT(YEAR FROM publication_date) < 1980 THEN '1970s'
        WHEN EXTRACT(YEAR FROM publication_date) < 1990 THEN '1980s'
        WHEN EXTRACT(YEAR FROM publication_date) < 2000 THEN '1990s'
        WHEN EXTRACT(YEAR FROM publication_date) < 2010 THEN '2000s'
        WHEN EXTRACT(YEAR FROM publication_date) < 2020 THEN '2010s'
        ELSE '2020s'
    END as decada,
    COUNT(*) as libros,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM books), 1) as porcentaje_total
FROM books 
GROUP BY 
    CASE 
        WHEN EXTRACT(YEAR FROM publication_date) < 1960 THEN '1950s'
        WHEN EXTRACT(YEAR FROM publication_date) < 1970 THEN '1960s'
        WHEN EXTRACT(YEAR FROM publication_date) < 1980 THEN '1970s'
        WHEN EXTRACT(YEAR FROM publication_date) < 1990 THEN '1980s'
        WHEN EXTRACT(YEAR FROM publication_date) < 2000 THEN '1990s'
        WHEN EXTRACT(YEAR FROM publication_date) < 2010 THEN '2000s'
        WHEN EXTRACT(YEAR FROM publication_date) < 2020 THEN '2010s'
        ELSE '2020s'
    END
ORDER BY decada;

-- Productivity Analysis: Books per year by era
WITH era_analysis AS (
    SELECT 
        CASE 
            WHEN publication_date <= '2000-01-01' THEN 'Analógica'
            ELSE 'Digital'
        END as era,
        COUNT(*) as total_libros,
        CASE 
            WHEN publication_date <= '2000-01-01' THEN 48  -- 1952-2000
            ELSE 20  -- 2000-2020
        END as años_periodo
    FROM books 
    GROUP BY 
        CASE 
            WHEN publication_date <= '2000-01-01' THEN 'Analógica'
            ELSE 'Digital'
        END,
        CASE 
            WHEN publication_date <= '2000-01-01' THEN 48
            ELSE 20
        END
)
SELECT 
    era,
    total_libros,
    años_periodo,
    ROUND(total_libros::DECIMAL / años_periodo, 2) as libros_por_año,
    ROUND(
        (total_libros::DECIMAL / años_periodo) / 
        (SELECT MIN(total_libros::DECIMAL / años_periodo) FROM era_analysis), 
        1
    ) as factor_crecimiento
FROM era_analysis
ORDER BY libros_por_año DESC;
