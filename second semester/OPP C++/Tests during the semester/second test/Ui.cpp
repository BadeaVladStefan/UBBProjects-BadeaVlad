//
// Created by Vlad on 5/11/2023.
//

#include "Ui.h"

void Ui::handleRemoveClient() {
    std::string name;
    std::cout<<"Name: ";
    std::cin>>name;

    this->realEstateAgency.removeClient(name);

}

void Ui::handlePrintAll() {
for(auto i : this->realEstateAgency.getClientList())
    std::cout<<i->toString()<<"\n";
for(auto j : this->realEstateAgency.getDwellingList())
    std::cout<<j.toString()<<"\n";
}

void Ui::handleAddDwelling() {
    double price;
    bool isProfitable;
    int option;
    std::cout<<"Price: ";
    std::cin>>price;
    std::cout<<"Profitable: 1.YES/2.NO: ";
    std::cin>>option;
    if(option == 1)
        isProfitable = true;
    else
        isProfitable = false;
    Dwelling d = this->realEstateAgency.addDwelling(price,isProfitable);
    std::cout<<"Added!\n";
    std::vector<Client*> arr = this->realEstateAgency.getInterestedClients(d);
    for(auto i : arr)
        std::cout<<i->toString()<<"\n";
}

void Ui::handleSave() {
std::string filename;
std::cout<<"Filename: ";
std::cin>>filename;
    this->realEstateAgency.writeToFile(filename);
    std::cout<<"Saved!\n";
}

Ui::Ui(RealEstateAgency &realEstateAgency): realEstateAgency{realEstateAgency} {

}

void Ui::run() {
    std::string option;
    while(true)
    {
        std::cout<<"1.Remove client\n";
        std::cout<<"2.Print clients and dwelling\n";
        std::cout<<"3.Add dwelling\n";
        std::cout<<"4.Save to file\n";
        std::cout<<"0.Quit\n";
        std::cin>>option;
        if(option == "1")
            this->handleRemoveClient();
        else if(option == "2")
            this->handlePrintAll();
        else if(option == "3")
            this->handleAddDwelling();
        else if(option == "4")
            this->handleSave();
        else if(option == "0")
            return;
        else
            std::cout<<"invalid!\n";
    }
}
