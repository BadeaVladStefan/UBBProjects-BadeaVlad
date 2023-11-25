#include <iostream>
#include "Ui.h"
#include "Test.h"
#include <crtdbg.h>

int main()
{
    {
        testAll();
        
        std::string fileName = "Dogs.txt";
        RepositoryAdmin repo = RepositoryAdmin(fileName);
        repo.loadFromFile();
        ServiceAdmin serv = ServiceAdmin(repo);
        ServiceUser userServ = ServiceUser();
        Ui ui = Ui(serv, userServ);
        ui.run();
        
    }

    _CrtDumpMemoryLeaks();
}


