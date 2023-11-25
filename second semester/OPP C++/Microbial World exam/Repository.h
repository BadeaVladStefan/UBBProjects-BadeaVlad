#pragma once
#include <sstream>
#include <fstream>
#include "Domain.h"

class Repository
{
private:
	vector<Biologist> biologistList;
	vector<Bacterium> bacteriumList;
public:
	Repository();

	void readFromFileBiologist();
	void readFromFilesBacterium();
	void writeToFileBacterium();

	void addBiologist(Biologist b);
	void addBacterium(Bacterium b);

	vector<Biologist> getAllBiologist();
	vector<Bacterium> getAllBacterium();

	~Repository();
};

