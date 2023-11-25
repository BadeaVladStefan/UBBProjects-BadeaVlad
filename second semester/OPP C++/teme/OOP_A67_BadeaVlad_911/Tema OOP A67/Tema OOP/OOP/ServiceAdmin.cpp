#include "ServiceAdmin.h"
#include "Errors.h"

ServiceAdmin::ServiceAdmin(RepositoryAdmin& repo) :repo{ repo }
{
}

void ServiceAdmin::addDogServ(std::string _name, std::string _breed, int _age, std::string _photoLink)
{
	Dog d = Dog(_name, _breed, _age, _photoLink);
	try {
		this->repo.addDogRepo(d);
	}
	catch (RepoError err)
	{
		throw err;
	}
}

void ServiceAdmin::removeDogServ(std::string _name, std::string _breed)
{
	try
	{
		this->repo.deleteDogRepo(_name,_breed);
	}
	catch (RepoError err)
	{
		throw err;
	}
}

void ServiceAdmin::updateDogServ(std::string _name, std::string _breed, int newAge, std::string newPhotoLink)
{
	Dog newDog = Dog(_name, _breed, newAge, newPhotoLink);
	try
	{
		this->repo.updateDogRepo(_name, _breed, newDog);

	}
	catch (RepoError err)
	{
		throw err;
	}
}

std::vector<Dog> ServiceAdmin::getDogList()
{
	return this->repo.getDogList();
}

ServiceAdmin::~ServiceAdmin() = default;
