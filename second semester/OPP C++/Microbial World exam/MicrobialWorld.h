#pragma once

#include <QtWidgets/QMainWindow>
#include "ui_MicrobialWorld.h"

class MicrobialWorld : public QMainWindow
{
    Q_OBJECT

public:
    MicrobialWorld(QWidget *parent = nullptr);
    ~MicrobialWorld();

private:
    Ui::MicrobialWorldClass ui;
};
