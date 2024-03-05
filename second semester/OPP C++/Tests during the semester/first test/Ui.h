//
// Created by Vlad on 4/27/2023.
//

#ifndef T1_BADEAVLADSTEFAN_1_UI_H
#define T1_BADEAVLADSTEFAN_1_UI_H
#include "Service.h"
class Ui{
private:
    Service service;

    void handleRemove();
    void handlePrint();

public:
    Ui(Service& service);
    void run();
    ~Ui();
};

#endif //T1_BADEAVLADSTEFAN_1_UI_H
