select *
from dbo.CovidDeaths$
order by 3,4

--select *
--from dbo.CovidVaccination$
--order by 3,4


select Location, date, total_cases, new_cases, total_deaths, population
from dbo.CovidDeaths$
order by 1,2

select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
from dbo.CovidDeaths$
where location like '%cote%'
order by 1,2

select Location, date, population, total_cases, (total_cases/population)*100 as DeathsPercentage
from dbo.CovidDeaths$
where location like '%cote%'
order by 1,2

select Location, population,MAX(total_cases)as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from dbo.CovidDeaths$
--where location like '%cote%'
group by location, population
order by PercentPopulationInfected desc


select continent, Max(cast(total_deaths as int))*100 as TotalDeathCount
from dbo.CovidDeaths$
--where location like '%cote%'
where continent is not null
group by continent
order by TotalDeathCount desc

select continent, Max(cast(total_deaths as int))*100 as TotalDeathCount
from dbo.CovidDeaths$
--where location like '%cote%'
where continent is not null
group by continent
order by TotalDeathCount desc

select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from dbo.CovidDeaths$
--where location like %cote%
where continent is not null
--group by date
order by 1,2

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from dbo.CovidDeaths$ dea
join dbo.CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from dbo.CovidDeaths$ dea
join dbo.CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3




with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from dbo.CovidDeaths$ dea
join dbo.CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/population)*100
from PopvsVac


Drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(225),
Location nvarchar(225),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)


insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from dbo.CovidDeaths$ dea
join dbo.CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

select *, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated



Create View PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) 
as RollingPeopleVaccinated
from dbo.CovidDeaths$ dea
join dbo.CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3