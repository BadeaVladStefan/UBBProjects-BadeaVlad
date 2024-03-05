//
// Created by Vlad on 5/11/2023.
//

#ifndef T2_BADEAVLADSTEFAN_1_REALESTATEAGENCY_H
#define T2_BADEAVLADSTEFAN_1_REALESTATEAGENCY_H

#include "Client.h"
#include "vector"

class RealEstateAgency{
private:
    std::vector<Dwelling> dwellingList;
    std::vector<Client*> clientList;
public:
    void addClient(Client* client);
    void removeClient(std::string name);
    Dwelling addDwelling(double price,bool isProfitable);
    std::vector<Dwelling> getDwellingList();
    std::vector<Client*> getClientList();
    std::vector<Client*> getInterestedClients(Dwelling d);
    void writeToFile(std::string filename);
};

#endif //T2_BADEAVLADSTEFAN_1_REALESTATEAGENCY_H
