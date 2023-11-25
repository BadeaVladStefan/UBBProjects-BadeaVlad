//
// Created by Vlad on 3/19/2023.
//

#ifndef UNTITLED_REPOSITORY_H
#define UNTITLED_REPOSITORY_H
#include "Country.h"
#include "DynamicArray.h"
#include "stdlib.h"

typedef struct {
    DynamicArray* countriesData;
}Repository;

/*
 * Creates a repository, only parameter represents the capacity of the repo
 */
Repository* createRepository(int capacity);

/*
 * destroys an existing repo
 */
void destroyRepository(Repository* repo);

/*
 * returns the length of the dynamic array in the repo
 */
int getRepoLength(Repository* repo);

/*
 * returns 1 if there exists an element in the dynamic array with the given name
 * 0 otherwise
 */
int findCountry(Repository* repository,char name[]);

/*
 * returns 1 if the given country was added successfully
 * 0 otherwise
 */
int addCountry(Repository* repository,Country* country);

/*
 * adds ten preset elements to a given repository
 */
void addTenElements(Repository* repository);

/*
 * returns 1 if a country with a given name was deleted
 * 0 otherwise
 */
int deleteCountry(Repository* repository,char name[]);

/*
 * returns 1 if the update of a country given by the name was successfully done
 * 0 otherwise
 */
int updateCountry(Repository* repository,char* name,char* newContinent,int newPopulation);

/*
 * returns 1 if the migration process worked properly
 * 0 otherwise
 */
int migrateCountry(Repository* repository,char name1[],char name2[],int population);
DynamicArray* getRepoCountries(Repository* repository);
Repository* copyRepo(Repository* repository);


#endif //UNTITLED_REPOSITORY_H
