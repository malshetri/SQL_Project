/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
	sd.skills,
	COUNT(sj.job_id) AS demand_count
FROM 
    job_postings_fact AS jp
   
INNER JOIN skills_job_dim AS sj ON jp.job_id = sj.job_id
INNER JOIN skills_dim AS sd ON sj.skill_id = sd.skill_id
WHERE 
	jp.job_title_short = 'Data Analyst' AND
	jp.job_work_from_home = TRUE
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 5

/*
Here’s the breakdown of the most in-demand skills for data analysts in 2023:

-SQL (7,291 postings) and Excel (4,611 postings) remain the core requirements, highlighting the need for strong data querying and spreadsheet skills as the foundation of analysis.
-Python (4,330 postings) is critical for automation, data manipulation, and advanced analytics, cementing its role as a key programming language for analysts.
-Tableau (3,745 postings) and Power BI (2,609 postings) reflect the growing emphasis on data visualization and business intelligence, enabling analysts to communicate insights effectively.

-Together, these skills show that top data analysts are expected to combine foundational data handling with technical programming and strong visualization capabilities.
*/

/*
result:

[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/