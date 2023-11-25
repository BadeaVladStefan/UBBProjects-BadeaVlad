//
// Created by Vlad on 3/19/2023.
//

#include "Ui.h"
#include "string.h"
#include "stdio.h"
#include "stdlib.h"

Ui *createUi(Service *service) {
    Ui *ui = malloc(sizeof(Ui));
    if (ui == NULL)
        return NULL;
    ui->service = service;
    return ui;
}

void destroyUi(Ui *ui) {
    if (ui == NULL)
        return;
    destroyService(ui->service);
    free(ui);
}

int undoUi(Ui *ui) {
    return undo(ui->service);
}

int redoUi(Ui *ui) {
    return redo(ui->service);
}

void printMenu() {
    printf("~~~~~Main Menu~~~~~\n");
    printf("0. Quit\n");
    printf("1. Print all countries\n");
    printf("2. Add a country\n");
    printf("3. Delete a country\n");
    printf("4. Update a country\n");
    printf("5. Migrate population from a country to another\n");
    printf("6. Search by a substring\n");
    printf("7. Display countries on a given continent, in ascending order based on population\n");
    printf("8. Undo\n");
    printf("9. Redo\n");
    printf("~~~~~~~~~~~~~~~~~~~\n");
}

void printAllCountries(Ui *ui) {
    int length = ui->service->repository->countriesData->length;
    for (int i = 0; i < length; i++) {
        char str[100];
        toString(ui->service->repository->countriesData->elements[i], str);
        printf("%d: %s \n", i + 1, str);
    }
}

int handleAddCountry(Ui *ui) {
    char name[50], continent[50];
    int population;
    printf("Please enter the name of the country: ");
    scanf_s("%49s", &name, 49);
    do {
        printf("Please enter a valid continent: ");
        scanf_s("%49s", &continent, 49);
    } while (strcmp("Europa", continent) != 0 && strcmp("Asia", continent) != 0 &&
             strcmp("Australia", continent) != 0 && strcmp("Africa", continent) != 0 &&
             strcmp("America", continent) != 0);
    do {
        printf("Please enter the population: ");
        scanf_s("%d", &population);
    } while (population <= 0);
    return add(ui->service, name, continent, population);
}

int handleDeleteCountry(Ui *ui) {
    char name[50];
    printf("Please enter the name of the country you want to be deleted: ");
    scanf_s("%s", &name);
    return deleteCountryServ(ui->service, name);

}

int handleUpdateCountry(Ui *ui) {
    char name[50], newContinent[50];
    int newPopulation;
    printf("Please enter the name of the country you want to be updated: ");
    scanf_s("%s", name);
    do {
        printf("Please enter a valid continent: ");
        scanf_s("%s", &newContinent);
    } while (strcmp("Europa", newContinent) != 0 && strcmp("Asia", newContinent) != 0 &&
             strcmp("Australia", newContinent) != 0 && strcmp("Africa", newContinent) != 0 &&
             strcmp("America", newContinent) != 0);
    do {
        printf("Please enter the population: ");
        scanf_s("%d", &newPopulation);
    } while (newPopulation <= 0);
    return update(ui->service, name, newContinent, newPopulation);
}

int handleMigrateCountry(Ui *ui) {
    char name1[50], name2[50];
    int population;
    printf("Please enter the name of the first country: ");
    scanf_s("%s", name1);
    printf("Please enter the name of the second country: ");
    scanf_s("%s", name2);
    printf("Please enter the number of people to migrate: ");
    scanf_s("%d", &population);
    return migrate(ui->service, name1, name2, population);
}

void printSmallerMenu() {
    printf("1. To the task for all the countries\n");
    printf("2. To the task for the European countries\n");
    printf("3. To the task for the Asian countries\n");
    printf("4. To the task for the America countries\n");
    printf("5. To the task for the African countries\n");
    printf("6. To the task for the Australian countries\n");
    printf(">>>");
}

void start(Ui *ui) {
    while (1) {
        printMenu();
        printf(">>>");
        int option;
        scanf_s("%d", &option);
        if (option == 0) {
            return;
        } else if (option == 1) {
            printAllCountries(ui);
        } else if (option == 2) {
            int addResult = handleAddCountry(ui);
            if (addResult == 1)
                printf("Country successfully added! \n");
            else
                printf("Country can not be added! \n");
        } else if (option == 3) {
            int deleteResult = handleDeleteCountry(ui);
            if (deleteResult == 1)
                printf("Country successfully deleted! \n");
            else
                printf("Country can not be deleted \n");
        } else if (option == 4) {
            int updateResult = handleUpdateCountry(ui);
            if (updateResult == 1)
                printf("Country successfully updated! \n");
            else
                printf("Country can not be updated! \n");
        } else if (option == 5) {
            int migrateResult = handleMigrateCountry(ui);
            if (migrateResult == 1)
                printf("The population successfully migrated! \n");
            else
                printf("The population can not migrate! \n");
        } else if (option == 6) {
            {
               char subString[100],str[100];
               subString[0] = '\0';
                printf("Enter substring: ");
                scanf_s("%c",&subString[0]);
                int i=-1;
                do{
                    i++;
                    scanf_s("%c",&subString[i]);
                    subString[i+1] ='\0';
                }while(subString[i]!='\n');
                subString[i] = '\0';
                for(int k=0;k<ui->service->repository->countriesData->length;k++)
                {
                   if(strstr(getName(ui->service->repository->countriesData->elements[k]),subString)!=NULL)
                    {
                        toString(ui->service->repository->countriesData->elements[k],str);
                        printf("%s\n",str);
                    }
                }
            }
        } else if (option == 7) {
            char str[100], continent[100];
            int option_continent, population;

            sortCountriesVectorAscendingByPeople(ui->service->repository->countriesData);

            printf("Please enter the population value: ");
            scanf_s("%d", &population);

            printSmallerMenu();
            scanf_s("%d", &option_continent);

            if (option_continent == 1) {
                int length = ui->service->repository->countriesData->length;
                for (int i = 0; i < length; i++) {
                    if (getPopulation(ui->service->repository->countriesData->elements[i]) >= population) {
                        toString(ui->service->repository->countriesData->elements[i], str);
                        printf("%s\n", str);
                    }
                }
            } else {

                if (option_continent == 2)
                    strcpy(continent, "Europa");
                else if (option_continent == 3)
                    strcpy(continent, "Asia");
                else if (option_continent == 4)
                    strcpy(continent, "America");
                else if (option_continent == 5)
                    strcpy(continent, "Africa");
                else if (option_continent == 6)
                    strcpy(continent, "Australia");

                for (int i = 0; i < ui->service->repository->countriesData->length; i++) {
                    if (strcmp(getContinent(ui->service->repository->countriesData->elements[i]), continent) == 0 &&
                        getPopulation(ui->service->repository->countriesData->elements[i]) >= population) {
                        toString(ui->service->repository->countriesData->elements[i], str);
                        printf("%s\n", str);
                    }
                }
            }


        } else if (option == 8) {
            int undoResult = undoUi(ui);
            if (undoResult == 1)
                printf("Operation successfully undone! \n");
            else
                printf("Operation cannot be undone! \n");
        } else if (option == 9) {
            int redoResult = redoUi(ui);
            if (redoResult == 1)
                printf("Operation successfully redone! \n");
            else
                printf("Operation cannot be redone \n");
        } else
            printf("Not a valid option! \n");


    }
}