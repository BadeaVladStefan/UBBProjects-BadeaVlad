//
// Created by Vlad on 3/19/2023.
//

#ifndef UNTITLED_UI_H
#define UNTITLED_UI_H
#pragma once
#include "Service.h"
#include "Country.h"

typedef struct {
   Service* service;
}Ui;

Ui* createUi(Service* service);
void destroyUi(Ui* ui);

void printMenu();
int handleAddCountry(Ui* ui);
int handleDeleteCountry(Ui* ui);
int handleMigrateCountry(Ui* ui);
int handleMigrateCountry(Ui* ui);

void start(Ui* ui);
#endif //UNTITLED_UI_H
