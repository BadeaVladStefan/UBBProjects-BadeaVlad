#include "GUI.h"

GUI::GUI(Service& serv,QWidget *parent)
    : QMainWindow(parent),serv{serv}
{
    ui.setupUi(this);
    populate();
}

GUI::~GUI()
{}

void GUI::populate()
{
    this->ui.weatherListWidget->clear();
    this->serv.sortList();
    std::vector<Weather> data = this->serv.getAll();
    for (auto i : data)
    {
        QString str = QString::fromStdString(i.toString());
        QListWidgetItem* item = new QListWidgetItem{ str };
        this->ui.weatherListWidget->addItem(item);

    }
}


