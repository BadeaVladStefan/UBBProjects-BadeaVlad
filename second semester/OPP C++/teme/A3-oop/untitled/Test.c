//
// Created by Vlad on 3/19/2023.
//

#include "Test.h"
#include "Country.h"
#include "DynamicArray.h"
#include "Repository.h"
#include "Service.h"
#include "stdio.h"

void testCountry()
{
    Country* country = createCountry("Romania","Europa",15);
    assert(strcmp(getName(country),"Romania")==0);
    assert(strcmp(getContinent(country),"Europa")==0);
    assert(getPopulation(country)==15);
    setContinent(country,"Asia");
    setPopulation(country,10);
    assert(strcmp(getContinent(country),"Asia")==0);
    assert(getPopulation(country)==10);
    destroyCountry(country);

    printf("The Country test went ok!\n");
}

void testDynamicArray()
{
    DynamicArray* arr = createDynamicArray(10, (DestroyElementFunction) destroyCountry,
                                           (CopyElementFunction) copyCountry);
    Country* country = createCountry("Romania","Europa",10);
    addElement(arr,country);
    assert(arr->length==1);
    assert(getArrayLength(arr)==1);
    Country* c1 = getElementAtIndex(arr,0);
    assert(country->population==c1->population);
    deleteElement(arr,0);
    assert(arr->length==0);
    destroyDynamicArray(arr);

    printf("The Dynamic array went ok!\n");
}

void testRepository()
{
    Repository* repository = createRepository(15);
    Country* country = createCountry("Romania","Europa",13);
    assert(getRepoCountries(repository)==repository->countriesData);
    addCountry(repository,country);
    assert(repository->countriesData->elements[0]==country);
    assert(getRepoLength(repository)==1);
    updateCountry(repository,"Romania","Asia",101);
    Country* c2 = createCountry("Bulgaria","Europa",1);
    addCountry(repository,c2);
    migrateCountry(repository,"Romania","Bulgaria",100);
    assert(getPopulation(repository->countriesData->elements[0])==1);
    assert(getPopulation(repository->countriesData->elements[1])==101);
    assert(strcmp(getContinent(repository->countriesData->elements[0]),"Asia")==0);
    deleteCountry(repository,"Romania");
    assert(repository->countriesData->length == 1);
    destroyRepository(repository);
    printf("The repo test went ok!\n");
}

void testService()
{
    Repository* repo = createRepository(15);
    Service* service = createService(repo);

    add(service,"Bogdan","Oceania",11);
    assert(getRepoLength(service->repository)==11);
    update(service,"Bogdan","Europa",100);
    assert(getPopulation(service->repository->countriesData->elements[10])==100);
    add(service,"Andrei","Europa",10);
    migrate(service,"Bogdan","Andrei",90);
    assert(getPopulation(service->repository->countriesData->elements[10])==10);
    printf("The service test went ok!\n");
}

void testAll()
{
    testCountry();
    testDynamicArray();
    testRepository();
    testService();
}
