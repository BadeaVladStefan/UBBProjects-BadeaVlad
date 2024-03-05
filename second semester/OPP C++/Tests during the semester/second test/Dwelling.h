//
// Created by Vlad on 5/11/2023.
//

#ifndef T2_BADEAVLADSTEFAN_1_DWELLING_H
#define T2_BADEAVLADSTEFAN_1_DWELLING_H
#include "string"

class Dwelling{
private:
    double price;
    bool isProfitable;
public:
    Dwelling(double price, bool isProfitable);
    double getPrice() const {return this->price;}
    bool getIsProfitable() const {return this->isProfitable;}
    std::string toString();
};

#endif //T2_BADEAVLADSTEFAN_1_DWELLING_H
