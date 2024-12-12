--Select * From ProtfolioProjet..CovidDeaths
--where continent is not null
--order by 3,4

--Select * From ProtfolioProjet..CovidVaccinations
--Order By 3,4

Select Location,date,total_Cases,new_cases,total_deaths,Population
From ProtfolioProjet..CovidDeaths
Order By 1,2

--Looking Total Cases vs Total Deaths
Select 
Location,
convert(VARCHAR,DATE,103) As Date,
total_Cases,
total_deaths,
ROUND((total_deaths/total_cases)*100 ,2)As "Death%"
From ProtfolioProjet..CovidDeaths
Where Location like '%States%'
Order By 5,1,2 Desc

--Looking at the Total Cases vs Population
Select 
Location,
convert(VARCHAR,DATE,103) As Date,
total_Cases,
Population,
ROUND((total_cases/population)*100 ,2)As "Affected%"
From ProtfolioProjet..CovidDeaths
Where Location like '%States%'
Order By 5,1,2 Desc

--Looking countries with Highest Infection
Select 
Location,
Population,
MAX(total_Cases) As Total_Cases,
MAX(ROUND((total_cases/population)*100 ,2))As "Affected%"
From ProtfolioProjet..CovidDeaths
GROUP BY population,location
Order By 4 Desc

---Showing Countries with Highest death count
Select 
continent,
MAX(cast(total_deaths as int)) As Total_Cases,
MAX(ROUND((total_deaths/population)*100 ,2))As "Affected%"
From ProtfolioProjet..CovidDeaths
where continent is not null
GROUP BY continent
Order By 2 Desc

--Global Number's
Select date,total_Cases,new_cases,total_deaths,Population
From ProtfolioProjet..CovidDeaths
where continent is not null
group by date
order by 1,2

-----Total Population Vs Vaccination
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as Int))

	over
	(Partition by Dea.location 
		Order By 
		Dea.Location,
		dea.date) As Rolling_Covid_Vaccinated


From ProtfolioProjet..CovidDeaths dea
Join ProtfolioProjet..CovidVaccinations vac
on dea.location =vac.location and dea.date = vac.date
where dea.continent is not null 
order by 2,3



