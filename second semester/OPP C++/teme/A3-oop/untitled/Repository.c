//
// Created by Vlad on 3/19/2023.
//

#include "Repository.h"
#include "stdio.h"
#include "stdlib.h"
#include <string.h>
#include "assert.h"

Repository* createRepository(int capacity){
    Repository* repository = (Repository*) malloc(sizeof(Repository));
    if(repository == NULL)
        return NULL;
    repository->countriesData = createDynamicArray(capacity, (DestroyElementFunction) destroyCountry,
                                                   (CopyElementFunction) copyCountry);
    return repository;

}

void destroyRepository(Repository* repository)
{
    if(repository == NULL)
        return;
    destroyDynamicArray(repository->countriesData);
    free(repository);
    repository = NULL;
}

int getRepoLength(Repository* repository)
{
    return repository->countriesData->length;
}

int findCountry(Repository* repository,char name[])
{
    int length = getRepoLength(repository);
    for(int i = 0;i<length;i++)
        if(strcmp(getName(repository->countriesData->elements[i]),name)==0)
            return i;
    return -1;
}
int addCountry(Repository* repository,Country* country)
{
    int position = findCountry(repository,country->name);
    if(position == -1)
    {
        addElement(repository->countriesData,country);
        return 1;
    }
    else
    {
        return 0;
    }
    return 0;
}

void addTenElements(Repository* repository)
{
    addCountry(repository, createCountry("Romania","Europa",21));
    addCountry(repository, createCountry("Italia","Europa",143));
    addCountry(repository, createCountry("Egipt","Africa",392));
    addCountry(repository, createCountry("America","America",500));
    addCountry(repository, createCountry("India","Asia",1286));
    addCountry(repository, createCountry("Australia","Australia",94));
    addCountry(repository, createCountry("Albania","Europa",40));
    addCountry(repository, createCountry("Grecia","Europa",88));
    addCountry(repository, createCountry("Uganda","Africa",45));
    addCountry(repository, createCountry("Iran","Asia",775));
}

int deleteCountry(Repository* repository,char name[])
{
    int position = findCountry(repository,name);
    if(position != -1)
    {
        deleteElement(repository->countriesData,position);
        return 1;
    }
    else
        return 0;
}

int updateCountry(Repository* repository,char* name,char* newContinent,int newPopulation)
{
    int count = getArrayLength(repository->countriesData);
    for(int i=0;i<count;i++)
    {
        Country* country = getElementAtIndex(repository->countriesData,i);
        if(strcmp(getName(country),name)==0)
        {
            setContinent(country,newContinent);
            setPopulation(country,newPopulation);
            return 1;
        }
    }
    return 0;
}

int migrateCountry(Repository* repository,char name1[],char name2[],int population)
{
    int position1,position2;
    position1 = findCountry(repository,name1);
    position2 = findCountry(repository,name2);
    if(position1!=-1 && position2!=-1)
    {
        if(getPopulation(repository->countriesData->elements[position1])>=population)
        {
            setPopulation(repository->countriesData->elements[position1],getPopulation(repository->countriesData->elements[position1])-population);
            setPopulation(repository->countriesData->elements[position2],getPopulation(repository->countriesData->elements[position2])+population);
            return 1;
        }
        else
            return 0;
    } else
        return 0;
}

DynamicArray* getRepoCountries(Repository* repository)
{
    if(repository == NULL)
        return NULL;
    return repository->countriesData;
}

Repository* copyRepo(Repository* repository)
{
    Repository* newRepo = createRepository(repository->countriesData->capacity);
    destroyDynamicArray(newRepo->countriesData);
    newRepo->countriesData = copyDynamicArray(repository->countriesData);
    return newRepo;
}

