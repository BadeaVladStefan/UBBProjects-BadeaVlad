//
// Created by Vlad on 5/11/2023.
//

#include "Client.h"

Client::Client(std::string name, double income):name{name},income{income} {

}

double Client::totalIncome() {
    return 0;
}

std::string Client::toString() {
    return "Person: "+this->name+" income: "+ std::to_string(this->income);
}

bool Client::isInterested(Dwelling d) {
    return this->income >= d.getPrice()/1000;
}

Person::Person(std::string name, double income) : Client(name, income){

}

bool Person::isInterested(Dwelling d) {
    return this->income >= d.getPrice()/1000;
}

Company::Company(std::string name, double income, double moneyFromInvestments): Client(name,income),moneyFromInvestments{moneyFromInvestments} {

}

std::string Company::toString() {
    return "Company: " + this->name+ " income: "+ std::to_string(this->income) + " money from investments: "+
                                                                                 std::to_string(this->moneyFromInvestments);
}

double Company::totalIncome() {
    return this->moneyFromInvestments+ this->income;
}

bool Company::isInterested(Dwelling d) {
    return d.getPrice()/100 <= this->totalIncome() && d.getIsProfitable();
}
