//
// Created by Vlad on 5/11/2023.
//
#include "iostream"
#include "Ui.h"

int main()
{
    RealEstateAgency realEstateAgency = RealEstateAgency();
    realEstateAgency.addDwelling(15000,true);
    realEstateAgency.addDwelling(20000, true);
    Person* p1 = new Person("Badea",16);
    Person* p2 = new Person("Bianca",7);
    Company* c1 = new Company("UBB",70,150);
    Company* c2 = new Company("UCluj",30,40);
    Company* c3 = new  Company("Mama_manu",12,37);
    realEstateAgency.addClient(c3);
    realEstateAgency.addClient(p1);
    realEstateAgency.addClient(p2);
    realEstateAgency.addClient(c1);
    realEstateAgency.addClient(c2);
    Ui ui = Ui(realEstateAgency);
    ui.run();

    return 0;
}
