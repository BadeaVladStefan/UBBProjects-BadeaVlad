#pragma once

#include <QtWidgets/QMainWindow>
#include "ui_GUI.h"
#include "Service.h"

class GUI : public QMainWindow
{
    Q_OBJECT

public:
    GUI(Service& serv,QWidget *parent = nullptr);
    ~GUI();

private:
    Ui::GUIClass ui;
    Service& serv;
    void populate();
};
