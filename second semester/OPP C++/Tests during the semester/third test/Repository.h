#pragma once
#include "weather.h"
#include <vector>

class Repository
{
private:
	std::string filename;
	std::vector<Weather> dataList;
public:
	Repository(std::string filename);

	void sort();
	void readFromFile();
	std::vector<Weather> getAll();
	void add(Weather w1);

	~Repository();
};

