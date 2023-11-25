#pragma once
#include "RepositoryAdmin.h"
#include <vector>
class ServiceAdmin
{
private:
	RepositoryAdmin& repo;
public:
	/// <summary>
	/// Constructor
	/// </summary>
	/// <param name="repo"></param>
	ServiceAdmin(RepositoryAdmin& repo);
	/// <summary>
	/// if a dog with the given name and breed is not found add it to the repo, throw exception otherwise
	/// </summary>
	/// <param name="_name"></param>
	/// <param name="_breed"></param>
	/// <param name="_age"></param>
	/// <param name="_photoLink"></param>
	void addDogServ(std::string _name, std::string _breed, int _age, std::string _photoLink);
	/// <summary>
	/// if a dog with the given name and breed is found remove it to the repo, throw exception otherwise
	/// </summary>
	/// <param name="_name"></param>
	/// <param name="_breed"></param>
	void removeDogServ(std::string _name, std::string _breed);
	/// <summary>
	/// if a dog with the given name and breed is found update it, throw exception otherwise
	/// </summary>
	/// <param name="_name"></param>
	/// <param name="_breed"></param>
	/// <param name="newAge"></param>
	/// <param name="newPhotoLink"></param>
	void updateDogServ(std::string _name, std::string _breed, int newAge, std::string newPhotoLink);
	/// <summary>
	/// returns a vector which is the dogs list
	/// </summary>
	/// <returns></returns>
	std::vector<Dog> getDogList();
	/// <summary>
	/// Destructor
	/// </summary>
	~ServiceAdmin();
	
};

