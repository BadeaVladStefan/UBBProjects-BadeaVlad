#include "MicrobialWorld.h"
#include <QtWidgets/QApplication>
#include "BiologistWindow.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    //MicrobialWorld w;
    
    vector<BiologistWindow*> biologistWindow;

    Repository repo;
    Service serv{ repo };
    for (auto i : repo.getAllBiologist())
    {
        biologistWindow.push_back(new BiologistWindow{ serv,i.getName() });
    }
    for (auto i : biologistWindow)
        i->show();

    //w.show();
    return a.exec();
}
