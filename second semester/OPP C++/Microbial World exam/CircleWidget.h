#pragma once

#include <QMainWindow>
#include "ui_CircleWidget.h"

class CircleWidget : public QMainWindow
{
	Q_OBJECT

public:
	CircleWidget(QWidget *parent = nullptr);
	~CircleWidget();

private:
	Ui::CircleWidgetClass ui;
};
