/*
Covid 19 Data Exploration 
Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/
-- 
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidDeaths'


DESCRIBE CovidDeaths

Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
order by 3,4

-- Change the Date formate
SELECT FORMAT(CAST(date AS datetime), 'yyyy-MM-dd') AS date
FROM PortfolioProject..CovidDeaths

-- Select Data Columns which will be use


Select location, FORMAT(CAST(date AS datetime), 'yyyy-MM-dd') AS date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order by 1, 2

-- Looking at Total Cases Vs Total Deaths



SELECT 
    CAST(total_cases AS FLOAT) / 100.0 AS total_cases,
    CAST(total_deaths AS FLOAT) / 100.0 AS total_deaths
FROM PortfolioProject..CovidDeaths
ORDER BY total_cases

--- LOOKING AT TOTAL CASES VS TOTAL DEATHS
---(THIS SHOWS LIKELIHOOD OF DYING IF YOU CONTRACT CVID IN YOUR COUNTRY)

Select location, FORMAT(CAST(date AS datetime), 'yyyy-MM-dd') AS date, total_cases,  total_deaths, (CAST(total_deaths AS FLOAT) *100/CAST(total_cases AS FLOAT)) as DeathPercentage
From PortfolioProject..CovidDeaths
WHERE total_cases > 0 AND location LIKE '%STATE%'
Order by 1, 2

-- LOOKING AT TOTA CASES VS POPULATION
-- (what percentage of population got covid)
Select location, FORMAT(CAST(date AS datetime), 'yyyy-MM-dd') AS date, total_cases,  population, (CAST(total_cases AS FLOAT))*100/(CAST(population AS FLOAT))  as PercentageOfPopulationInfected
From PortfolioProject..CovidDeaths
WHERE total_cases > 0 AND location LIKE '%STATE%'
Order by 1, 2


-- looking at countries with highest infection rate compared to population

Select location, population, Max(CAST(total_cases AS FLOAT)) AS HighestInfectiobCount, MAX(CAST(total_cases AS FLOAT))*100/(CAST(population AS FLOAT))  as PercentageOfPopulationInfected
From PortfolioProject..CovidDeaths
--WHERE total_cases > 0 AND location LIKE '%STATE%'
Group By location, population
Order by PercentageOfPopulationInfected desc

-- Showing Countries with Highest Death count Per population

Select location, population, Max(CAST(total_deaths AS FLOAT)) AS HighestInfectiobCount, MAX(CAST(total_cases AS FLOAT))*100/(CAST(population AS FLOAT))  as PercentageOfPopulationInfected
From PortfolioProject..CovidDeaths
--WHERE total_cases > 0 AND location LIKE '%STATE%'
Group By location, population
Order by PercentageOfPopulationInfected desc

--  Breaking things down by continene
-- Showing continent with the highest death count per population

Select continent, Max(CAST(total_deaths AS float)) AS TotalDeathCount
From PortfolioProject..CovidDeaths
--WHERE total_cases > 0 AND location LIKE '%STATE%'
Where continent is not null 
Group By continent
Order by TotalDeathCount desc


-- GLOBAL NUMBERS

Select SUM(CAST(new_cases AS float))as total_cases, SUM(cast(new_deaths as float)) as total_deaths, SUM(cast(new_deaths as float))/SUM(CAST(New_Cases AS float))*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3



-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(FLOAT,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists PercentPopulationVaccinated

Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into master.dbo.PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(FLOAT,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

Select *, (RollingPeopleVaccinated/Population)*100
From PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(float,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 