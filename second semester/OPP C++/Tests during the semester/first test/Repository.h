//
// Created by Vlad on 4/27/2023.
//

#ifndef T1_BADEAVLADSTEFAN_1_REPOSITORY_H
#define T1_BADEAVLADSTEFAN_1_REPOSITORY_H
#include <vector>
#include "School.h"


class Repository{
private:
    std::vector<School> data;
public:

    Repository();

    std::vector<School> getData();
    void add(School& school);
    void operator=(Repository& repo);
    void remove(School& school);
    void sort();

    ~Repository();

};

#endif //T1_BADEAVLADSTEFAN_1_REPOSITORY_H
