#include "Domain.h"

Biologist::Biologist()
{
}

Biologist::Biologist(const Biologist& other)
{
	this->name = other.name;
	this->bacterialSpecies = other.bacterialSpecies;
}

Biologist::Biologist(string name, vector<string> bacterialSpecies)
{
	this->name = name;
	this->bacterialSpecies = bacterialSpecies;
}

string Biologist::getName() const
{
	return this->name;
}

vector<string> Biologist::getBacterialList() const
{
	return this->bacterialSpecies;
}

Bacterium::Bacterium(string name, string species, int size, vector<string> diseases)
{
	this->name = name;
	this->species = species;
	this->size = size;
	this->diseases = diseases;
}

string Bacterium::getName() const
{
	return this->name;
}

string Bacterium::getSpecies() const
{
	return this->species;
}

int Bacterium::getSize() const
{
	return this->size;
}

vector<string> Bacterium::getDiseases() const
{
	return this->diseases;
}

void Bacterium::setSpecies(string neVal)
{
	this->species = neVal;
}

void Bacterium::setSize(int newSize)
{
	this->size = newSize;
}

void Bacterium::setDiseases(vector<string> newVal)
{
	this->diseases = newVal;
}

string Bacterium::toString()
{
	string result = this->name + "," + this->species + "," + std::to_string(this->size) + ",";
	for (auto i : this->diseases)
		result += i + "#";
	return result;
}
