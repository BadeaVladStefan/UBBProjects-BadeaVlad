#pragma once
#include "ServiceAdmin.h"
#include "ServiceUser.h"

class Ui
{
private:
	ServiceAdmin& adminServ;
	ServiceUser& userServ;

	/// <summary>
	/// ADMIN MENU OPTIONS
	/// </summary>
	void handleAdd();
	void handleUpdate();
	void handleRemove();
	void handelPrintDogs();
	void displayAdminMenu();

	/// <summary>
	/// USER MENU OPTIONS
	/// </summary>
	
	void printAdoptionList();
	void handleAdoptAll();
	void handleAdoptFiltered();
	void openFile();
	void displayUserMenu();

public:
	Ui(ServiceAdmin& adminServ, ServiceUser& userServ);
	void run();
	~Ui();
};

