#include "Service.h"

Service::Service(Repository& repository):repo{repository}
{
}

void Service::addBacterium(Bacterium b)
{
	try {
		this->repo.addBacterium(b);
	}
	catch (std::exception& err)
	{
		throw err;
	}
}

vector<Biologist> Service::getAllBiologist()
{
	return this->repo.getAllBiologist();
}

vector<Bacterium> Service::getAllBacterium()
{
	return this->repo.getAllBacterium();
}

Biologist Service::getBiologistByName(string name)
{
	Biologist b;
	for (auto biog : this->getAllBiologist())
		if (biog.getName() == name)
			return biog;
	return b;
}

vector<string> Service::sortBacterialsByName(vector<string> bacterials)
{
	std::sort(bacterials.begin(), bacterials.end(),
		[](const string& s1,const string& s2)
		{
			return s1 <= s2;
		});
	return bacterials;
}

string Service::getDataOfBacteria(string bacteria)
{
	for (auto i : this->getAllBacterium())
		if (i.getName() == bacteria)
			return i.toString();
	return "";
}

std::set<string> Service::getAllSpecies()
{
	std::set<string> speciesSet;
	for (const auto& bacterium : this->getAllBacterium())
	{
		speciesSet.insert(bacterium.getSpecies());
	}
	return speciesSet;
}

