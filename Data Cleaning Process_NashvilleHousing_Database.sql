select *
from dbo.NashvilleHousing

select  saledate
from dbo.NashvilleHousing

select  saledate, convert(date,saledate)
from dbo.NashvilleHousing

update NashvilleHousing
set saledate =  convert(date,saledate)

alter table NashvilleHousing
add saledateconverted date;

update NashvilleHousing
set saledateconverted =  convert(date,saledate)

select  saledateconverted, convert(date,saledate)
from dbo.NashvilleHousing


select  *
from dbo.NashvilleHousing
--where PropertyAddress is not null
order by ParcelID

select  *
from dbo.NashvilleHousing a
join dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]

select  a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
from dbo.NashvilleHousing a
join dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select  a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull( a.PropertyAddress, b.PropertyAddress)
from dbo.NashvilleHousing a
join dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
SET PropertyAddress = isnull( a.PropertyAddress, b.PropertyAddress)
from dbo.NashvilleHousing a
join dbo.NashvilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


select  PropertyAddress
from dbo.NashvilleHousing
--where PropertyAddress is not null
--order by ParcelID

select
SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address

from dbo.NashvilleHousing

select
SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
, SUBSTRING (PropertyAddress,CHARINDEX(',',PropertyAddress)+1, len(PropertyAddress)) as Address
from dbo.NashvilleHousing


alter table NashvilleHousing
add PropertySplitAddress nvarchar(225);

update NashvilleHousing
set PropertySplitAddress =  SUBSTRING (PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

alter table NashvilleHousing
add PropertySplitCity nvarchar(225);

update NashvilleHousing
set PropertySplitCity =  SUBSTRING (PropertyAddress,CHARINDEX(',',PropertyAddress)+1, len(PropertyAddress))

select *
from dbo.NashvilleHousing

select OwnerAddress
from dbo.NashvilleHousing

select
PARSENAME(OwnerAddress,1)
from dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress, ',','.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',','.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',','.') , 1)
from dbo.NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress nvarchar(225);

update NashvilleHousing
set OwnerSplitAddress =  PARSENAME(REPLACE(OwnerAddress, ',','.') , 3)

alter table NashvilleHousing
add OwnerSplitCity nvarchar(225);

update NashvilleHousing
set OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress, ',','.') , 2)

alter table NashvilleHousing
add OwnerSplitState nvarchar(225);

update NashvilleHousing
set OwnerSplitState =  PARSENAME(REPLACE(OwnerAddress, ',','.') , 1)



select distinct(SoldAsVacant)
from [Portfolio Projects].dbo.NashvilleHousing


select distinct(SoldAsVacant), count(SoldAsVacant)
from [Portfolio Projects].dbo.NashvilleHousing
group by SoldAsVacant
order by 2


select SoldAsVacant
, case when SoldAsVacant = 'Y' then 'Yes'
       when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end
from [Portfolio Projects].dbo.NashvilleHousing





UPDATE NashvilleHousing
SET SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
       when SoldAsVacant = 'N' then 'No'
	   else SoldAsVacant
	   end


select *
from [Portfolio Projects].dbo.NashvilleHousing


Alter Table[Portfolio Projects].dbo.NashvilleHousing
Drop column OwnerAddress, TaxDistrict, PropertyAddress


Alter Table[Portfolio Projects].dbo.NashvilleHousing
Drop column saledate