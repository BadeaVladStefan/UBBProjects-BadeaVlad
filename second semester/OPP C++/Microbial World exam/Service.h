#pragma once
#include <algorithm>
#include "Repository.h"
#include <set>

class Service
{
private:
	Repository& repo;
public:
	Service(Repository& repository);

	void addBacterium(Bacterium b);
	vector<Biologist> getAllBiologist();
	vector<Bacterium> getAllBacterium();

	Biologist getBiologistByName(string name);

	vector<string> sortBacterialsByName(vector<string> bacterials);

	string getDataOfBacteria(string bacteria);

	std::set<string> getAllSpecies();


};

