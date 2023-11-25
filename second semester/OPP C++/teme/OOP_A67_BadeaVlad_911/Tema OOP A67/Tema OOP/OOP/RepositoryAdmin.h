#pragma once
#include "Domain.h"
#include <vector>

class RepositoryAdmin
{
private:
	std::vector<Dog> adminDogList;
	std::string fileName;
public:
	
	//Function which are used to read and write from a file given by the "fileName"
	void loadFromFile();
	void writeToFile();

	//Constructor, with one parameter filename
	RepositoryAdmin(std::string _fileName);

	//Returns the dog if the name is found, else throws exception
	Dog findDogRepo(std::string _name, std::string _breed);

	/// <summary>
	/// Adds a given dog to the repo, throws exception if it is already in repo
	/// </summary>
	/// <param name="dog"></param>
	void addDogRepo(Dog dog);
	/// <summary>
	/// Removes a dog from the repo, throw exception if the dog is not found
	/// </summary>
	/// <param name="_name"></param>
	/// <param name="_breed"></param>
	void deleteDogRepo(std::string _name, std::string _breed);
	/// <summary>
	/// Updares a dog from the repo, throws exception if the dog is not found
	/// </summary>
	/// <param name="_name"></param>
	/// <param name="_breed"></param>
	/// <param name="newDog"></param>
	void updateDogRepo(std::string _name, std::string _breed, Dog newDog);

	//Returns a vector that contains the dog list
	std::vector<Dog> getDogList();


	//Destructor
	~RepositoryAdmin();
	

};

