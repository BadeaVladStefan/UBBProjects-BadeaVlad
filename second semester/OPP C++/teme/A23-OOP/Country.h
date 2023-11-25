//
// Created by Vlad on 3/19/2023.
//

#ifndef UNTITLED_COUNTRY_H
#define UNTITLED_COUNTRY_H


/*
 * Creates a country which has 3 attributes -name, continent,population
 */
typedef struct
{
    char* name;
    char* continent;
    int population;
}Country;

/*
 * Input: 3 parameters , 2 chars and an int
 * Returns a country
 */
Country* createCountry(char* name,char* continent,int population);

/*
 *Deletes a country and frees the memory
 */
void destroyCountry(Country* country);

/*
 * Returns a copy for a given country
 */
Country* copyCountry(Country* country);


/*
 * Getter functions for name, continent,population
 */
char* getName(Country* country);
char* getContinent(Country* country);
int getPopulation(Country* country);

/*
 * Setter functions for continent and population
 */
void setContinent(Country* country, char* newContinent);
void setPopulation(Country* country,int newPopulation);

/*
 *Copy into the str[] parameter the format needed to print a country
 */
void toString(Country* country, char str[]);

#endif //UNTITLED_COUNTRY_H
