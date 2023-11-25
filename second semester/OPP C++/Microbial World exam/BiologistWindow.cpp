#include "BiologistWindow.h"
#include <qstandarditemmodel.h>
#include <qmessagebox.h>
#include <QMessageBox>
#include <set>

BiologistWindow::BiologistWindow(Service& serv,string userName,QWidget *parent)
	: QMainWindow(parent),serv{serv},userName{userName}
{
	ui.setupUi(this);
	this->setWindowTitle(QString::fromStdString(userName));
    this->populateBacteriaTable();
    this->populateBacteriaList();
    this->populateComboBox();

    this->connectSignals();
}

BiologistWindow::~BiologistWindow()
{}

void BiologistWindow::connectSignals()
{
    connect(ui.bacteriaComboBox, &QComboBox::currentTextChanged,
        this, &BiologistWindow::handleCategorySelection);
    connect(ui.addBacteriumButton, &QPushButton::clicked, this, &BiologistWindow::handleAdd);
    connect(ui.viewPushButton, &QPushButton::clicked, this, &BiologistWindow::handleView);
}

void BiologistWindow::populateBacteriaTable()
{
    QStandardItemModel* model = new QStandardItemModel(this);
    model->setHorizontalHeaderLabels(QStringList() << "Bacterium Table");

    Biologist b = this->serv.getBiologistByName(userName);
    vector<string> bacterias = this->serv.sortBacterialsByName(b.getBacterialList());
    for (const auto& item : bacterias)
    {   

        QString title = QString::fromStdString(this->serv.getDataOfBacteria(item));
        

        QList<QStandardItem*> rowItems;
        rowItems << new QStandardItem(title);
        
        model->appendRow(rowItems);
    }

    ui.bacteriaTable->setModel(model);
}

void BiologistWindow::populateBacteriaList()
{
    ui.allBacteriaList->clear();

    for (auto& item : this->serv.getAllBacterium())
    {
        QListWidgetItem* currentItem = new QListWidgetItem{ QString::fromStdString(item.toString()) };

        ui.allBacteriaList->addItem(currentItem);
    }
}

void BiologistWindow::populateComboBox()
{
    ui.bacteriaComboBox->clear();

    ui.bacteriaComboBox->addItem("All");

    std::set<string> allCategories = this->serv.getAllSpecies();
    for (auto& category : allCategories)
    {
        ui.bacteriaComboBox->addItem(QString::fromStdString(category));
    }
}

void BiologistWindow::handleCategorySelection()
{
    string requiredCategory = ui.bacteriaComboBox->currentText().toStdString();

    if (requiredCategory == "")
        return;

    ui.allBacteriaList->clear();
    for (auto& item : this->serv.getAllBacterium())
    {
        if (item.getSpecies() == requiredCategory)
        {
            QListWidgetItem* currentItem = new QListWidgetItem{ QString::fromStdString(item.toString()) };

            ui.allBacteriaList->addItem(currentItem);
        }
    }

}


void BiologistWindow::handleAdd()
{
    string name = ui.nameLine->text().toStdString();
    string species = ui.speciesLine->text().toStdString();
    string size = ui.sizeLine->text().toStdString();
    string disease = ui.diseaseLine->text().toStdString();
    int s = std::stoi(size);
    vector<string> diseaseVector;
    diseaseVector.push_back(disease);
    try {
        Bacterium b{ name,species,s,diseaseVector };
        this->serv.addBacterium(b);
        this->populateBacteriaList();
    }
    catch (std::exception& err) {
        QMessageBox::critical(this, "Error", err.what());
    }
   
}

void BiologistWindow::handleView()
{
    DrawCircle* circle = new DrawCircle;  
    circle->show();
}
