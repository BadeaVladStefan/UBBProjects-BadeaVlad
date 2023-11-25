#pragma once
#include <string>
#include <vector>
using std::string;
using std::vector;

class Biologist
{
private:
	string name;
	vector<string> bacterialSpecies;
public:
	Biologist();
	Biologist(const Biologist& other);
	Biologist(string name, vector<string> bacterialSpecies);

	string getName() const;
	vector<string> getBacterialList() const;

};

class Bacterium{
private:
	string name, species;
	int size;
	vector<string> diseases;
public:
	
	Bacterium(string name, string species, int size, vector<string> diseases);
	
	string getName() const;
	string getSpecies() const;
	int getSize() const;
	vector<string> getDiseases() const;
	
	void setSpecies(string neVal);
	void setSize(int newSize);
	void setDiseases(vector<string> newVal);

	string toString();
};

