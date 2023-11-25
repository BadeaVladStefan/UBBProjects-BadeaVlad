#pragma once

#include <QMainWindow>
#include "ui_BiologistWindow.h"
#include "Service.h"
#include <QPainter>
#include <QPaintEvent>
#include <QDialog>
#include <QVBoxLayout>
#include "DrawCircle.h"

class BiologistWindow : public QMainWindow
{
	Q_OBJECT

public:
	BiologistWindow(Service& serv,string userName,QWidget *parent = nullptr);
	~BiologistWindow();

	void connectSignals();

	void populateBacteriaTable();
	void populateBacteriaList();
	void populateComboBox();
	void handleCategorySelection();

	void handleAdd();
	void handleView();


private:
	Ui::BiologistWindowClass ui;
	Service& serv;
	string userName;
};
