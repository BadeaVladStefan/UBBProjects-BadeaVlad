//
// Created by Vlad on 5/11/2023.
//

#ifndef T2_BADEAVLADSTEFAN_1_UI_H
#define T2_BADEAVLADSTEFAN_1_UI_H

#include "RealEstateAgency.h"
#include "iostream"

class Ui{
private:
    RealEstateAgency& realEstateAgency;
    void handleRemoveClient();
    void handlePrintAll();
    void handleAddDwelling();
    void handleSave();
public:
    Ui(RealEstateAgency& realEstateAgency);
    void run();
};

#endif //T2_BADEAVLADSTEFAN_1_UI_H
