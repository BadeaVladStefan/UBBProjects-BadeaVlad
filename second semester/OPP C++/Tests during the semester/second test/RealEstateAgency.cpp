//
// Created by Vlad on 5/11/2023.
//

#include "RealEstateAgency.h"
#include "algorithm"
#include "exception"
#include "fstream"


void RealEstateAgency::addClient(Client *client) {
    this->clientList.push_back(client);
}

void RealEstateAgency::removeClient(std::string name) {
    auto it = std::find_if(this->clientList.begin(), this->clientList.end(),[name](Client* client){return client->getName() == name;});
    if (it != this->clientList.end()) {
        std::remove_if(this->clientList.begin(), this->clientList.end(),
                       [name](Client *client) { return client->getName() == name; });
        this->clientList.pop_back();
    } else
        throw std::exception();
}

Dwelling RealEstateAgency::addDwelling(double price, bool isProfitable) {
    Dwelling d = Dwelling(price,isProfitable);
    this->dwellingList.push_back(d);
    return d;
}

std::vector<Dwelling> RealEstateAgency::getDwellingList() {
    return this->dwellingList;
}

std::vector<Client *> RealEstateAgency::getClientList() {
    return this->clientList;
}

std::vector<Client *> RealEstateAgency::getInterestedClients(Dwelling d) {
    std::vector<Client*> arr;
    for(auto i : this->clientList)
        if(i->isInterested(d))
            arr.push_back(i);
    return arr;
}

void RealEstateAgency::writeToFile(std::string filename) {
std::ofstream  f(filename);
for(auto i : this->clientList)
    f<<i->toString()<<"\n";
f.close();
}
