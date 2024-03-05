//
// Created by Vlad on 4/27/2023.
//

#ifndef T1_BADEAVLADSTEFAN_1_SERVICE_H
#define T1_BADEAVLADSTEFAN_1_SERVICE_H
#include "Repository.h"
class Service{
private:
    Repository repo;
public:
    Service(Repository& repo);

    void Add(School& school);
    std::vector<School> getData();
    void sort();
    void Remove(School& school);
    ///removes a given school

    ~Service();
};
#endif //T1_BADEAVLADSTEFAN_1_SERVICE_H
