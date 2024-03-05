#include "GUI.h"
#include <QtWidgets/QApplication>
#include "weather.h"
#include "Repository.h"
#include "Service.h"


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Repository repo("file.txt");
    Service serv(repo);
    serv.readFromFile();

    GUI w(serv);
    w.show();
    return a.exec();
}
