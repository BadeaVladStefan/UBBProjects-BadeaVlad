#include "ServiceUser.h"
#include "Errors.h"
#include "RepositoryUserCSV.h"
#include "RepositoryUserHTML.h"


ServiceUser::ServiceUser()
{
}

ServiceUser::ServiceUser(RepositoryUser* userRepo)
{
	this->userRepo = userRepo;
}

void ServiceUser::addDogUserServ(std::string name, std::string breed, int age, std::string photoLink)
{
	Dog d = Dog(name, breed, age, photoLink);
	try {
		this->userRepo->addDogUserRepo(d);
	}
	catch (RepoError err)
	{
		throw err;
	}
}

std::vector<Dog> ServiceUser::getAdoptionList()
{
	return this->userRepo->getAdoptingList();
}

std::string ServiceUser::getFileName()
{
	return this->userRepo->getFileName();
}

void ServiceUser::chooseRepoType(int fileType)
{
	if (fileType == 1)
	{
		std::string file = "adoptionList.csv";
		auto repo = new RepositoryUserCSV{ file };
		this->userRepo = repo;
	}
	else if (fileType)
	{
		std::string file = "adoptionList.html";
		auto repo = new RepositoryUserHTML{ file };
		this->userRepo = repo;
	}
}

ServiceUser::~ServiceUser()
{
	delete this->userRepo;
}
