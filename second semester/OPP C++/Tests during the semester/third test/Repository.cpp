#include "Repository.h"
#include <sstream>
#include <fstream>
#include <algorithm>

Repository::Repository(std::string filename):filename{filename}
{
}

void Repository::sort()
{
	std::sort(this->dataList.begin(), this->dataList.end());
}

void Repository::readFromFile()
{
	std::ifstream file(this->filename);
	if (file.is_open())
	{
		std::string line;
		while (std::getline(file, line))
		{
			std::stringstream ss(line);
			std::string startStr, endStr, temperatureStr, precipitationStr, descriptionStr;
			if (std::getline(ss, startStr, ';') &&
				std::getline(ss, endStr, ';') &&
				std::getline(ss, temperatureStr, ';') &&
				std::getline(ss, precipitationStr, ';') &&
				std::getline(ss, descriptionStr, ';')
				)
			{
				int start = std::stoi(startStr);
				int end = std::stoi(endStr);
				int temperature = std::stoi(temperatureStr);
				int precipitation = std::stoi(precipitationStr);
				Weather weather1 = Weather(start, end, temperature, precipitation, descriptionStr);
				this->dataList.push_back(weather1);
			}
		}
		file.close();
	}
}

std::vector<Weather> Repository::getAll()
{
	return this->dataList;
}

void Repository::add(Weather w1)
{
	this->dataList.push_back(w1);
}

Repository::~Repository() = default;
