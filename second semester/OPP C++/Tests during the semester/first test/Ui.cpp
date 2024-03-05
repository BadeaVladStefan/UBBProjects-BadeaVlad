//
// Created by Vlad on 4/27/2023.
//

#include "Ui.h"
#include "iostream"
#include "string"

void Ui::handleRemove() {
std::string name;
float longi,lati;
std::cout<<"Name:";
std::cin>>name;
std::cout<<"Longitude:";
std::cin>>longi;
std::cout<<"Latitude:";
std::cin>>lati;
School s1 = School(name,longi,lati,"",false);
    try{
        this->service.Remove(s1);
        std::cout<<"Removed successfully!\n";
    }
    catch (std::invalid_argument& e)
    {
        std::cout<<e.what()<<"\n";
    }
}

void Ui::handlePrint() {
for(auto i: this->service.getData())
    std::cout<<i.toString()<<"\n";
}

Ui::Ui(Service &service): service{service} {
    this->service = service;
}

void Ui::run() {
int option;
while(1)
{
    std::cout<<"1.Print all\n";
    std::cout<<"2.Remove\n";
    std::cout<<"3.Sort\n";
    std::cout<<"0.Exit\n";
    std::cin>>option;

    if(option == 1)
        handlePrint();
    else if(option == 2) {
        try {
            handleRemove();
        }
        catch (std::invalid_argument &e) {
            std::cout << e.what() << "\n";
        }
    }
    else if(option == 3)
    {
        this->service.sort();
        std::vector<School> data;
        data = this->service.getData();
        for(auto it:data)
            std::cout<<it.toString()<<"\n";
    }
    else if(option == 0)
        return;
    else
        std::cout<<"Invalid argument\n";


}
}

Ui::~Ui() =default;
