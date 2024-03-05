//
// Created by Vlad on 4/27/2023.
//

#include "School.h"

School::School(): name{""},longi{0},lati{0},date{""},visited{false} {

}

School::School(const std::string name, float longi,  float lati, const std::string date,
               bool visited):name{name},longi{longi},lati{lati},date{date},visited{visited} {

}

School::School(const School& school) {
    this->name = school.name;
    this->longi = school.longi;
    this->lati= school.lati;
    this->date = school.date;
    this->visited = school.visited;
}





std::string School::getName() const {
    return this->name;
}

float School::getLongi() const {
    return this->longi;
}

float School::getLati() const {
    return this->lati;
}

std::string School::getDate() const {
    return this->date;
}

bool School::getVisited() const {
    return this->visited;
}

bool School::operator==(School &school) const {
    return this->name==school.name && this->longi ==school.longi && this->lati == school.lati;
}

bool School::operator<(School &school)  {
    return this->name< school.name;
}

std::string School::toString() {
    std::string lon,lat,vis;
    lon = std::to_string(this->longi);
    lat = std::to_string(this->lati);
    vis = std::to_string(this->visited);
    if(vis == "0")
        return this->name+" | "+lon+","+lat+" | "+ this->date+" | "+"false";
    else
        return this->name+" | "+lon+","+lat+" | "+ this->date+" | "+"true";
}



School::~School() = default;
