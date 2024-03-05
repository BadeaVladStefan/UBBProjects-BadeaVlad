//
// Created by Vlad on 4/27/2023.
//

#ifndef T1_BADEAVLADSTEFAN_1_SCHOOL_H
#define T1_BADEAVLADSTEFAN_1_SCHOOL_H
#include "string"
class School{
private:
    std::string name;
    float longi;
    float lati;
    std::string  date;
    bool visited{};
public:
    School();
    School(const std::string name, const float longi,const float lati, const std::string date, const bool visited);
    School(const School& school);

    std::string getName() const;
    float getLongi() const;
    float getLati() const;
    std::string  getDate() const;
    bool getVisited() const;

    bool operator==(School& school) const;
    bool operator<(School& school);

    std::string toString();

    ~School();


};
#endif //T1_BADEAVLADSTEFAN_1_SCHOOL_H
