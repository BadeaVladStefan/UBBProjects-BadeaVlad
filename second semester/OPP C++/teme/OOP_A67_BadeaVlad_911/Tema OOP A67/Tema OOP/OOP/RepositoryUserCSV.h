#pragma once
#include "RepositoryUser.h"
class RepositoryUserCSV : public RepositoryUser
{
public:
	///THIS CLASS INHERITS THE USER REPO CLASS AND OVERRIDES ITS FUNCTIONS

	/// <summary>
	/// Constructor
	/// </summary>
	/// <param name="CSVfileName"></param>
	RepositoryUserCSV(std::string CSVfileName);

	/// <summary>
	/// Adds a dog to the adoption list
	/// </summary>
	/// <param name="dog"></param>
	void addDogUserRepo(Dog dog) override;

	/// <summary>
	/// Gets the adoption list
	/// </summary>
	/// <returns></returns>
	std::vector<Dog> getAdoptingList() override;

	/// <summary>
	/// Returns the CSV file name
	/// </summary>
	/// <returns></returns>
	std::string getFileName() override;

	/// <summary>
	/// Writes the adopting list to the given file
	/// </summary>
	void writeToFile() override;

	/// <summary>
	/// Destructor
	/// </summary>
	~RepositoryUserCSV();

};

