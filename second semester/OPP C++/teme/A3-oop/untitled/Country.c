//
// Created by Vlad on 3/19/2023.
//

#include "Country.h"
#include <stdio.h>
#include "string.h"
#include "stdlib.h"
#include "assert.h"

Country* createCountry(char* name,char* continent, int population)
{
    Country* country = malloc(sizeof(Country));
    if(country == NULL)
        return NULL;
    country->name = (char*)malloc(sizeof(char) * (strlen(name) + 1));
    country->continent = (char*)malloc(sizeof(char) * (strlen(continent) + 1));
    if(country->name != NULL)
        memcpy(country->name,name, strlen(name)+1);
    if(country->continent != NULL)
        memcpy(country->continent,continent, strlen(continent)+1);
    country->population = population;
    return country;
}

void destroyCountry(Country* country){
    if(country == NULL)
    {
        return;
    }
    free(country->name);
    //free(country->continent);
    free(country);
    country = NULL;
}

Country* copyCountry(Country* country){
    if(country == NULL)
        return NULL;
    Country* country1 = createCountry(country->name,country->continent,country->population);
    return country1;
}

char* getName(Country* country){
    if(country == NULL){
        return NULL;
    }
    return country->name;
}

char* getContinent(Country* country){
    if(country == NULL){
        return NULL;
    }
    return country->continent;
}

int getPopulation(Country* country){
    if(country == NULL)
        return -1;
    return country->population;
}

void setContinent(Country* country,char* newContinent){
    strcpy(country->continent,newContinent);
}

void setPopulation(Country* country,int newPopulation){
    country->population = newPopulation;
}

void toString(Country* country, char str[]){
    if(country == NULL)
        return;
    sprintf(str,"Name: %s, Continent: %s, Population: %d",country->name,country->continent,country->population);
}