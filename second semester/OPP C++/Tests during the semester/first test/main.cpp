//
// Created by Vlad on 4/27/2023.
//

#include "iostream"
#include "Ui.h"
using namespace std;

int main()
{
    Repository repo=Repository();
    Service serv = Service(repo);
    School s1 = School("Avram",1,2,"2022.10.10",false);
    School s2 = School("George",2,1,"2022.03.03", true);
    School s3 = School("Alex",123,0.3,"2023.05.03",true);
    School s4 = School("Rom",2,6,"2021.01.01",true);
    School s5 = School("Colegiu",1,1,"2023.05.03",false);
    serv.Add(s1);
    serv.Add(s2);
    serv.Add(s3);
    serv.Add(s4);
    serv.Add(s5);
    Ui ui = Ui(serv);
    ui.run();
    std::cout<<"Done";
    return 0;
}
