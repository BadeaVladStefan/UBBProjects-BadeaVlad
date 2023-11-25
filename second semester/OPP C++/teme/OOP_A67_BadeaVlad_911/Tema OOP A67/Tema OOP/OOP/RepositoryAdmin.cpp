#include "RepositoryAdmin.h"
#include "Errors.h"
#include <fstream>

void RepositoryAdmin::loadFromFile()
{
	if (!fileName.empty())
	{
		Dog fileDog;
		std::ifstream fileIn(fileName);
		while (fileIn >> fileDog)
		{
			if (std::find(adminDogList.begin(), adminDogList.end(), fileDog) == adminDogList.end())
				adminDogList.push_back(fileDog);
		}
		fileIn.close();
	}
}

void RepositoryAdmin::writeToFile()
{
	if (!fileName.empty())
	{
		std::ofstream fileOut(fileName);
		for (auto dog : adminDogList)
			fileOut << dog << "\n";
		fileOut.close();
	}
}

RepositoryAdmin::RepositoryAdmin(std::string _fileName)
{
	this->fileName = _fileName;
}

Dog RepositoryAdmin::findDogRepo(std::string _name, std::string _breed)
{
	for (auto i : adminDogList)
		if (i.getName() == _name && i.getBreed() == _breed)
			return i;
	throw ValueError("Dog not found in repo!");

}

void RepositoryAdmin::addDogRepo(Dog dog)
{
	try {
		Dog d = findDogRepo(dog.getName(), dog.getBreed());
		throw RepoError("This dog already exists in the repo");
	}
	catch (ValueError)
	{
		this->adminDogList.push_back(dog);
		this->writeToFile();
	}
}

void RepositoryAdmin::deleteDogRepo(std::string _name, std::string _breed)
{
	auto it = std::remove_if(adminDogList.begin(), adminDogList.end(), [_name,_breed](Dog d) { return (d.getName() == _name && d.getBreed() == _breed); });
	if (it == adminDogList.end())
	{
		throw RepoError("Dog does not exist !");
	}
	adminDogList.pop_back();
	this->writeToFile();
}

void RepositoryAdmin::updateDogRepo(std::string _name, std::string _breed, Dog newDog)
{
	int k = 0;
	for (auto it : adminDogList)
	{
		if (it.getName() == _name && it.getBreed() == _breed)
		{
			adminDogList.at(k) = newDog;
			return;
		}
		k++;
	}
	throw RepoError("Dog does not exist !");
}

std::vector<Dog> RepositoryAdmin::getDogList()
{
	return this->adminDogList;
}

RepositoryAdmin::~RepositoryAdmin() = default;
