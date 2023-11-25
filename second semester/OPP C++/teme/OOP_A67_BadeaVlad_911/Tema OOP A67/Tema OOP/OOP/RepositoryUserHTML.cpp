#include "RepositoryUserHTML.h"
#include <fstream>

RepositoryUserHTML::RepositoryUserHTML(std::string HTMLfileName)
{
	this->fileName = HTMLfileName;
}

void RepositoryUserHTML::addDogUserRepo(Dog dog)
{
	this->adoptionList.push_back(dog);
	this->writeToFile();
}

std::vector<Dog> RepositoryUserHTML::getAdoptingList()
{
	return this->adoptionList;
}

std::string RepositoryUserHTML::getFileName()
{
	return this->fileName;
}

void RepositoryUserHTML::writeToFile()
{
	std::ofstream fileOut(fileName);
	fileOut << "<!DOCTYPE html>\n<html><head><title>Adopting list</title></head><body>\n";
	fileOut << "<table border=\"1\">\n";
	fileOut << "<tr><td>Name</td><td>Breed</td><td>Age</td><td>Photo link</td></tr>\n";
	for (auto dog : adoptionList)
	{
		fileOut << "<tr><td>" << dog.getName() << "</td><td>" << dog.getBreed() << "</td><td>"
			<< std::to_string(dog.getAge()) << "</td>" << "<td><a href = \"" << dog.getPhotoLink()
			<< "\">" << dog.getPhotoLink() << "</a></td></tr>\n";
	}
	fileOut << "</table></body></html>";
	fileOut.close();
}

RepositoryUserHTML::~RepositoryUserHTML() = default;