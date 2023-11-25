#include "RepositoryUserCSV.h"
#include <fstream>

RepositoryUserCSV::RepositoryUserCSV(std::string CSVfileName)
{
	this->fileName = CSVfileName;
}

void RepositoryUserCSV::addDogUserRepo(Dog dog)
{
	this->adoptionList.push_back(dog);
	this->writeToFile();
}

std::vector<Dog> RepositoryUserCSV::getAdoptingList()
{
	return this->adoptionList;
}

std::string RepositoryUserCSV::getFileName()
{
	return this->fileName;
}

void RepositoryUserCSV::writeToFile()
{
	std::ofstream fileOut(fileName);
	if (!adoptionList.empty())
	{
		for (auto dog : adoptionList)
		{
			fileOut << dog << "\n";
		}
	}
	fileOut.close();
}

RepositoryUserCSV::~RepositoryUserCSV() = default;
