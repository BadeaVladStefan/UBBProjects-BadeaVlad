//
// Created by Vlad on 3/19/2023.
//

#ifndef UNTITLED_SERVICE_H
#define UNTITLED_SERVICE_H
#pragma once
#include "Repository.h"

typedef struct {
    Repository* repository;
    DynamicArray* undoStack;
    int undoPointer;
}Service;

/*
 * creates an instance of a service and returns it
 */
Service* createService(Repository* repository);

/*
 * destroys the given service
 */
void destroyService(Service* service);

/*
 * returns the repository for the given service
 */
Repository* getRepository(Service* service);

/*
 * returns 1 if the country was successfully added
 * 0 otherwise
 */
int add(Service* service,char* name,char* continent,int population);

/*
 * returns 1 if a country with a given name was deleted
 * 0 otherwise
 */
int deleteCountryServ(Service* service,char* name);

/*
 * returns 1 if the update of a country given by the name was successfully done
 * 0 otherwise
 */
int update(Service* service,char* name,char* newContinent,int newPopulation);

/*
 * returns 1 if the migration process worked properly
 * 0 otherwise
 */
int migrate(Service* service,char* name1,char* name2,int population);

/*
 *returns the countries for a given service
 */
DynamicArray* getCountries(Service* service);

/*
 * Sorts the elements of a dynamic array containing countries based on the population,
 * the sort is done in ascending order
 */
void sortCountriesVectorAscendingByPeople(DynamicArray* arr);
int undo(Service* service);
int redo(Service* service);

#endif //UNTITLED_SERVICE_H
