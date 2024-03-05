#pragma once
#include "Repository.h"


class Service
{private:
	Repository& repo;
public:
	Service(Repository& repo);

	void sortList();
	std::vector<Weather> getAll();
	void readFromFile();

	~Service();
};

