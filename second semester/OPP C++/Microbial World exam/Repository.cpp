#include "Repository.h"
#include <exception>

Repository::Repository()
{
	readFromFileBiologist();
	readFromFilesBacterium();
}

void Repository::readFromFileBiologist()
{
	std::ifstream file("biologist.txt");
	string line;
	while (std::getline(file, line))
	{
		string name, bacterialString,bs;
		std::stringstream ss(line);
		std::getline(ss, name, ',');
		std::vector<string> bacterials;
		std::getline(ss, bacterialString, ',');
		std::stringstream sa(bacterialString);
		while (std::getline(sa, bs, '#'))
		{
			bacterials.push_back(bs);
		}
		Biologist b{ name,bacterials };
		this->biologistList.push_back(b);
	}
	file.close();
}

void Repository::readFromFilesBacterium()
{
	std::ifstream file("bacterium.txt");
	std::string line;
	while (std::getline(file, line))
	{
		std::string name, species, count, diseasesString;
		std::stringstream ss(line);
		std::getline(ss, name, ',');
		std::getline(ss, species, ',');
		std::getline(ss, count, ',');
		std::getline(ss, diseasesString, ',');

		std::vector<std::string> diseases;

		std::stringstream sa(diseasesString);
		std::string disease;
		while (std::getline(sa, disease, '#'))
		{
			if (!disease.empty())
				diseases.push_back(disease);
		}

		int bacteriaCount = std::stoi(count);

		Bacterium b{ name, species, bacteriaCount, diseases };
		this->bacteriumList.push_back(b);
	}
	file.close();
}

void Repository::writeToFileBacterium()
{
	std::ofstream fileOut("bacterium.txt");
	for (auto bacteria : this->bacteriumList)
	{
		fileOut << bacteria.toString() << "\n";
	}
	fileOut.close();
}

void Repository::addBiologist(Biologist b)
{
	this->biologistList.push_back(b);
}

void Repository::addBacterium(Bacterium b)
{
	for (auto bacteria : this->bacteriumList)
		if (b.getName() == bacteria.getName() && b.getSpecies() == bacteria.getSpecies())
			throw std::exception("Cannot add bacteria! Name and species already in repo");
	this->bacteriumList.push_back(b);
}

vector<Biologist> Repository::getAllBiologist()
{
	return this->biologistList;
}

vector<Bacterium> Repository::getAllBacterium()
{
	return this->bacteriumList;
}

Repository::~Repository()
{
	writeToFileBacterium();
}

