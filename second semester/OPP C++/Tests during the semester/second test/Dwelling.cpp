//
// Created by Vlad on 5/11/2023.
//

#include "Dwelling.h"

Dwelling::Dwelling(double price, bool isProfitable):price{price},isProfitable{isProfitable} {

}

std::string Dwelling::toString() {
    return "Dwelling with the price: "+ std::to_string(this->price) + " is profitable: "+ std::to_string(this->isProfitable);
}
