#pragma once
#include "Domain.h"
#include <vector>
#include <string>

class RepositoryUser
{
protected:
	std::vector<Dog> adoptionList;
	std::string fileName;
public:
	/// <summary>
	/// Constructor
	/// </summary>
	RepositoryUser();

	/// <summary>
	/// Adds a dog to the adoption list
	/// </summary>
	/// <param name="dog"></param>
	virtual void addDogUserRepo(Dog dog) = 0;

	/// <summary>
	/// Returns the adoption list
	/// </summary>
	/// <returns></returns>
	virtual std::vector<Dog> getAdoptingList() = 0;

	/// <summary>
	/// Returns the fileName
	/// </summary>
	/// <returns></returns>
	virtual std::string getFileName() = 0;

	/// <summary>
	/// Writes the dogs from the adoption list to the file
	/// </summary>
	virtual void writeToFile() = 0;

	/// <summary>
	/// Destructor
	/// </summary>
	virtual ~RepositoryUser();
};

