#pragma once
#include "RepositoryUser.h"
class ServiceUser
{
private:
	RepositoryUser* userRepo;
public:
	/// <summary>
	/// Empty Constructor
	/// </summary>
	ServiceUser();

	/// <summary>
	/// Constructor with repo
	/// </summary>
	/// <param name="userRepo"></param>
	ServiceUser(RepositoryUser* userRepo);

	/// <summary>
	/// Adds a dog to the adopting list
	/// </summary>
	/// <param name="name"></param>
	/// <param name="breed"></param>
	/// <param name="age"></param>
	/// <param name="photoLink"></param>
	void addDogUserServ(std::string name, std::string breed, int age, std::string photoLink);

	/// <summary>
	/// Returns the adopting list
	/// </summary>
	/// <returns></returns>
	std::vector<Dog> getAdoptionList();

	/// <summary>
	/// Returns the file name
	/// </summary>
	/// <returns></returns>
	std::string getFileName();

	/// <summary>
	/// Chooses the type of file where the adopting list is stored
	/// </summary>
	/// <param name="fileType"></param>
	void chooseRepoType(int fileType);

	/// <summary>
	/// Destructor
	/// </summary>
	~ServiceUser();

};

