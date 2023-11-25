#pragma once
#include "RepositoryUser.h"

class RepositoryUserHTML : public RepositoryUser {
public:
	//THIS CLASS INHERITS THE USER REPO CLASS AND OVERRIDES ITS FUNCTIONS

	/// <summary>
	/// Constructor
	/// </summary>
	/// <param name="HTMLfileName"></param>
	RepositoryUserHTML(std::string HTMLfileName);

	/// <summary>
	/// Adds a dog to the adopting list
	/// </summary>
	/// <param name="dog"></param>
	void addDogUserRepo(Dog dog) override;

	/// <summary>
	/// Gets the adopting list
	/// </summary>
	/// <returns></returns>
	std::vector<Dog> getAdoptingList() override;

	/// <summary>
	/// Returns the html name of the file
	/// </summary>
	/// <returns></returns>
	std::string getFileName() override;

	/// <summary>
	/// Writes the adopting list into the given file
	/// </summary>
	void writeToFile() override;

	/// <summary>
	/// Destructor
	/// </summary>
	~RepositoryUserHTML() override;



};

