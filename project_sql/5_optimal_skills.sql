/*
Quetion: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles:
WITH demanded_skills AS (
    SELECT 
        sj.skill_id,
        sd.skills,
        COUNT(sj.job_id) AS demand_count
    FROM 
        job_postings_fact AS jp
    
    INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst' AND
        jp.job_work_from_home = TRUE AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY sj.skill_id, sd.skills
),
-- Skills with high average salaries for Data Analyst roles:
 paying_skills AS (
    SELECT 
        sj.skill_id,
        sd.skills,
        ROUND(AVG(jp.salary_year_avg)) AS average_salary
    FROM 
        job_postings_fact AS jp
    
    INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst' AND
        jp.job_work_from_home = TRUE AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY sj.skill_id, sd.skills
)
-- Return high demand and high salaries for 10 skills:
SELECT
    demanded_skills.skill_id,
    demanded_skills.skills,
    demanded_skills.demand_count,
    paying_skills.average_salary
FROM
    demanded_skills
INNER JOIN paying_skills ON paying_skills.skill_id = demanded_skills.skill_id
WHERE demanded_skills.demand_count > 10
ORDER BY
    paying_skills.average_salary DESC,
    demanded_skills.demand_count DESC
LIMIT 25;

/*
Here’s a concise 3–4 line version you can place under your SQL query:

-Python and R are the most in-demand and widely used programming skills, combining high demand with strong salaries around $100K.
-Cloud and big data tools such as Snowflake, Azure, AWS, and Hadoop offer both high pay and relevance, reflecting the shift toward scalable data solutions.
-Visualization and BI tools like Tableau and Looker remain essential for translating complex data into actionable insights.
-Database and integration technologies such as Oracle and SQL Server continue to provide solid career value through data management expertise.
*/