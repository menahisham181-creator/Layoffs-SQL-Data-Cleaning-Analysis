select *
from world_layoffs.layoffs;

-- create stagging table

create table layoffs_stagging 
like layoffs ;

insert	layoffs_stagging
select * from layoffs ;

-- remove duplicate 

select * ,
row_number () over(partition by company ,industry,total_laid_off,percentage_laid_off,`date`) as row_num
from layoffs_stagging ;

with duplicate_cte as (select *,
row_number () over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_stagging )
delete
from duplicate_cte
where row_num >1 ;

-- Creating a second staging table because MySQL does not allow deleting rows directly from a CTE that uses window functions. 
-- Adding row_num as a physical column so we can delete duplicate rows.

CREATE TABLE `layoffs_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_stagging2
select *,
row_number () over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_stagging ;

select *
from layoffs_stagging2 
where Row_num >1;

delete
from layoffs_stagging2 
where Row_num >1;

-- standardizing data 

select company ,trim(company)
from layoffs_stagging2 ;

update layoffs_stagging2
set company = trim(company);

select distinct location
from layoffs_stagging2
order by 1; 

select distinct industry
from layoffs_stagging2 
order by 1 ;

select * 
from layoffs_stagging2
where industry like 'crypto%';

update layoffs_stagging2
set industry ='crypto'
where industry like'crypto%';

select distinct country 
from layoffs_stagging2 
order by 1;

update layoffs_stagging2
set country = trim(trailing'.' from country )
where country like 'United States%';

select `date`
from layoffs_stagging2;

update layoffs_stagging2
set `date`= str_to_date(`date`,'%m/%d/%Y');

alter table layoffs_stagging2
modify column `date` date ;

-- Handel nulls 

select *
from layoffs_stagging2
where total_laid_off is null 
and percentage_laid_off is null ;

select * 
from layoffs_stagging2 
where industry is null or  industry ='' ;

select * 
from layoffs_stagging2
where company like 'airbnb' ;

select t1.industry , t2.industry
from layoffs_stagging2 t1
join layoffs_stagging2 t2
on t1.company = t2.company 
where t1.industry is null
and t2.industry is not null ;


update layoffs_stagging2 
set industry = null
where industry = '';

update layoffs_stagging2 t1
join layoffs_stagging2 t2
on t1.company = t2.company 
set t1.industry = t2.industry 
where t1.industry is null
and t2. industry is not null ;

-- Remove useless rows 

delete 
from layoffs_stagging2
where total_laid_off is null 
and percentage_laid_off is null ;

-- Remove unnecessary columns 

select *
from layoffs_stagging2 ;

alter table layoffs_stagging2
drop column Row_num ;
