#include "Ui.h"
#include "Errors.h"
#include <algorithm>

void Ui::handleAdd()
{
	std::string name, breed, photoLink;
	int age;
	std::cout << "Please input the name of the dog: ";
	std::getline(std::cin,  name);
	std::cout << "Please input the breed of the dog: ";
	std::getline(std::cin, breed);
	std::cout << "Please input the age of the dog: ";
	std::cin >> age;
	std::cin.get();
	if (std::cin.fail() || age <= 0 )
	{
		std::cout << "Invalid input! \n";
		std::cin.clear();
		std::cin.ignore(256, '\n');
		return;
	}
	std::cout << "Please input the Photo Link of the dog: ";
	std::getline(std::cin, photoLink);
	try {
		this->adminServ.addDogServ(name, breed, age, photoLink);
		std::cout << "Dog added successfully! \n";
	}
	catch (RepoError err)
	{
		std::cout << err.what() << "\n";
	}

}
	
void Ui::handleUpdate()
{
	std::string name, breed, newPhotoLink;
	int newAge;
	std::cout << "Plase input the name of the dog you want to update: ";
	std::getline(std::cin, name);
	std::cout << "Please input the breed of the dog you want to update: ";
	std::getline(std::cin, breed);
	std::cout << "Please input the new age of the dog: ";
	std::cin >> newAge;
	std::cin.get();
	if (std::cin.fail() || newAge <= 0)
	{
		std::cout << "Invalid input! \n";
		std::cin.clear();
		std::cin.ignore(256, '\n');
		return;
	}
	std::cout << "Please input the new Photo Link: ";
	std::getline(std::cin, newPhotoLink);
	try {
		this->adminServ.updateDogServ(name, breed, newAge, newPhotoLink);
		std::cout << "Dog updated successfully! \n";
	}
	catch (RepoError err)
	{
		std::cout << err.what() << "\n";
	}
}

void Ui::handleRemove()
{
	std::string name, breed;
	std::cout << "Please input the name of the dog: ";
	std::getline(std::cin, name);
	std::cout << "Please input the breed of the dog: ";
	std::getline(std::cin, breed);
	try {
		this->adminServ.removeDogServ(name, breed);
		std::cout << "Dog removed successfully!\n";
	}
	catch (RepoError err)
	{
		std::cout << err.what() << "\n";
	}
}

void Ui::handelPrintDogs()
{
	std::vector<Dog>  arr = this->adminServ.getDogList();
	for (auto i : arr)
		std::cout << i.toString() << "\n";
}

void Ui::displayAdminMenu()
{
	std::cout << "-----ADMIN MENU-----\n";
	std::cout << "1. Add dog \n";
	std::cout << "2. Remove dog \n";
	std::cout << "3. Update dog \n";
	std::cout << "4. Display dogs \n";
	std::cout << "5. Exit \n";
	std::cout << "Please choose an option: ";
	std::cout << "---------------\n";
}

void Ui::printAdoptionList()
{
	std::vector<Dog> arr = this->userServ.getAdoptionList();
	for (auto it : arr)
		std::cout << it << "\n";
}

void Ui::handleAdoptAll()
{
	std::vector<Dog> arr = this->adminServ.getDogList();
	int frequency[100], found=0, size;
	size = arr.size();
	for (int i = 0; i < size; i++)
		frequency[i] = 0;
	while (found < size)
	{
		for (auto i : arr)
		{
			auto it = std::find(arr.begin(), arr.end(), i);
			int index = std::distance(arr.begin(), it);
			if (frequency[index] == 0)
			{
				std::cout << i << "\n";
				std::string command = std::string("start ").append(i.getPhotoLink());
				system(command.c_str());
				int addToAdoptionList;
				std::cout << "Add to adoption list? (1.Yes/2.No): \n";
				std::cin >> addToAdoptionList;
				std::cin.get();
				if (addToAdoptionList == 1)
				{
					try
					{
						this->userServ.addDogUserServ(i.getName(), i.getBreed(), i.getAge(), i.getPhotoLink());
						frequency[index] = 1;
						found++;
					}
					catch (RepoError err)
					{
						std::cout << err.what() << "\n";
					}
				}
				int next;
				std::cout << "Continue (1.Yes/2.No): \n";
				std::cin >> next;
				std::cin.get();
				if (next != 1)
				{
					goto end_of_while;
				}
					
			}
		}
	}
	end_of_while:
	std::cout << "Done\n";
}

void Ui::handleAdoptFiltered()
{
	std::string breed;
	int age;

	std::cout << "Please input the breed: ";
	std::cin >> breed;

	std::cout << "Please input the age: ";
	std::cin >> age;

	std::vector<Dog> arr = this->adminServ.getDogList();
	int frequency[100], found = 0, size;
	size = arr.size();
	for (int i = 0; i < size; i++)
		frequency[i] = 0;
	while (found < size)
	{
		for (auto i : arr)
		{
			auto it = std::find(arr.begin(), arr.end(), i);
			int index = std::distance(arr.begin(), it);
			if (frequency[index] == 0)
			{
				if (breed == "-1" || (breed == i.getBreed() && age > i.getAge()))
				{
					std::cout << i << "\n";
					std::string command = std::string("start ").append(i.getPhotoLink());
					system(command.c_str());
					int addToAdoptionList;
					std::cout << "Add to adoption list? (1.Yes/2.No): \n";
					std::cin >> addToAdoptionList;
					std::cin.get();
					if (addToAdoptionList == 1)
					{
						try {
							this->userServ.addDogUserServ(i.getName(), i.getBreed(), i.getAge(), i.getPhotoLink());
							found++;
							frequency[index] = 1;
						}
						catch (RepoError err)
						{
							std::cout << err.what() << "\n";
						}
					}
					int next;
					std::cout << "Continue? (1.Yes/2.No): \n";
					std::cin >> next;
					std::cin.get();
					if (next != 1)
					{
						goto end_of_while;
					}
				}
			}
		}
	}
	end_of_while:
	std::cout << "Done\n";
}

void Ui::openFile()
{
	std::string command = std::string("start ").append(this->userServ.getFileName());
	system(command.c_str());
}

void Ui::displayUserMenu()
{
	std::cout << "-----USER MENU-----\n";
	std::cout << "1. See all dogs \n";
	std::cout << "2. See dogs of a given breed and age (if breed=-1, all dogs) \n";
	std::cout << "3. Display adopting list \n";
	std::cout << "4. Display adopting list in file\n";
	std::cout << "5. Exit\n";
	std::cout << "Please choose an option: ";
	std::cout << "-----------\n";
}


Ui::Ui(ServiceAdmin& adminServ, ServiceUser& userServ):adminServ{adminServ},userServ{userServ}
{
}

void Ui::run()
{
	int option;
	int userFile = 0;
	std::cout << "1. Administrator mode\n";
	std::cout << "2. User mode\n";
	std::cout << "3. Exit\n\n";
	std::cout << "Please choose an option: ";
	std::cin >> option;
	if (option == 1)
	{
		while (true)
		{
			displayAdminMenu();
			std::cin >> option;
			std::cin.get();
			if (std::cin.fail())
			{
				std::cout << "Invalid input!\n";
				std::cin.clear();
				std::cin.ignore(256, '\n');
				return;
			}
			if (option == 1)
			{
				this->handleAdd();
			}
			else if (option == 2)
			{
				this->handleRemove();
			}
			else if (option == 3)
			{
				this->handleUpdate();
			}
			else if (option == 4)
			{
				this->handelPrintDogs();
			}
			else if (option == 5)
			{
				return;
			}
			else
			{
				std::cout << "Invalid option! Try again!\n";
			}
		}
	}
	else if (option == 2)
	{
		if (userFile == 0)
		{
			int fileOption;
			std::cout << "File types:\n1.CSV\n2.HTML\n";
			std::cout << "Please choose the file type: ";
			std::cin >> fileOption;
			if (std::cin.fail())
			{
				std::cout << "Invalid input!\n";
				std::cin.clear();
				std::cin.ignore(256, '\n');
				return;
			}
			else if (fileOption == 1 || fileOption == 2)
			{
				this->userServ.chooseRepoType(fileOption);
				userFile = 1;
			}
		}
		while (true)
		{
			displayUserMenu();
			std::cin >> option;
			std::cin.get();
			if (std::cin.fail())
			{
				std::cout << "Invalid input!\n";
				std::cin.clear();
				std::cin.ignore(256, '\n');
				return;
			}
			if (option == 1)
			{
				this->handleAdoptAll();
			}
			else if (option == 2)
			{
				this->handleAdoptFiltered();
			}
			else if (option == 3)
			{
				this->printAdoptionList();
			}
			else if (option == 4)
			{
				this->openFile();
			}
			else if (option == 5)
			{
				return;
			}
			else
			{
				std::cout << "Invalid option! Try again!\n";
			}
		}
	}
	else
	{
		return;
	}
}

Ui::~Ui() = default;
