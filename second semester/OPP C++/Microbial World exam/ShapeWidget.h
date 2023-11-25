#pragma once

#include <QMainWindow>
#include "ui_ShapeWidget.h"

class ShapeWidget : public QMainWindow
{
	Q_OBJECT

public:
	ShapeWidget(QWidget *parent = nullptr);
	~ShapeWidget();

private:
	Ui::ShapeWidgetClass ui;
};
