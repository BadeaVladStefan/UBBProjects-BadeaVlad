//
// Created by Vlad on 5/11/2023.
//

#ifndef T2_BADEAVLADSTEFAN_1_CLIENT_H
#define T2_BADEAVLADSTEFAN_1_CLIENT_H
#include "Dwelling.h"
#include "string"

class Client{

protected:
    std::string name;
    double income;
public:
    Client(std::string name,double income);

    std::string getName() {return this->name;}

    virtual double totalIncome();
    virtual std::string toString();
    virtual bool isInterested(Dwelling d);


};

class Person: public Client{
public:
    Person(std::string name,double income);

    bool isInterested(Dwelling d) override;

};

class Company:public Client{
private:
    double moneyFromInvestments;
public:
    Company(std::string name, double income, double moneyFromInvestments);
    std::string toString() override;
    double totalIncome() override;
    bool isInterested(Dwelling d) override;

};

#endif //T2_BADEAVLADSTEFAN_1_CLIENT_H
