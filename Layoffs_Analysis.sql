-- Exploratory Data Analysis 

SELECT *
FROM layoffs_stagging2 ;

SELECT max(total_laid_off) , max(percentage_laid_off)
FROM layoffs_stagging2 ;

SELECT *
FROM layoffs_stagging2 
where percentage_laid_off = 1 
order by total_laid_off desc;

-- company analysis

select company , sum(total_laid_off)
from layoffs_stagging2 
group by company 
order by 2 desc;

select company , max(total_laid_off)
from layoffs_stagging2 
group by company 
order by 2 desc;

select company , max(total_laid_off),percentage_laid_off
from layoffs_stagging2
where percentage_laid_off = 1
group by company ;

-- industry , country and stage analysis

select industry , sum(total_laid_off)
from layoffs_stagging2 
group by industry 
order by 2 desc;

select country , sum(total_laid_off)
from layoffs_stagging2 
group by country
order by 2 desc;

select stage , sum(total_laid_off)
from layoffs_stagging2
group by  stage
order by 2 desc;

-- Yearly Trend 

select year(`date`) , sum(total_laid_off)
from layoffs_stagging2
group by year(`date`)
order by 1 desc;

select min(`date`) , max (`date`)
from layoffs_stagging2 ;

-- Rolling Total Layoffs 

select substring(`date`,1,7) as `month`,  sum(total_laid_off)
from layoffs_stagging2
where substring(`date`,1,7) is not null 
group by `month` 
order by 1;

with Rolling_total as (
select substring(`date`,1,7) as `month`,  sum(total_laid_off) as total_off
from layoffs_stagging2
where substring(`date`,1,7) is not null
group by `month` 
order by 1 )
select `month`, total_off ,sum(total_off )over (order by `month`) as rolling_total 
from Rolling_total;

--  Company Ranking By Year 

select company , year(`date`), sum(total_laid_off)
from layoffs_stagging2
group by company , year(`date`)
order by 3 desc;

with company_year as(
select company , year(`date`), sum(total_laid_off)
from layoffs_stagging2
group by company , year(`date`)
order by 3 desc
) select *
from company_year ;

with company_year (company , years,total_lay_off) as (
select company , year(`date`), sum(total_laid_off)
from layoffs_stagging2
group by company , year(`date`)
order by 3 desc) ,
company_year_ranking as (
select * ,dense_rank() over(partition by years order by total_lay_off desc)  as ranking 
from company_year
WHERE years is not null )
select *
from company_year_ranking
where	ranking <= 5;
