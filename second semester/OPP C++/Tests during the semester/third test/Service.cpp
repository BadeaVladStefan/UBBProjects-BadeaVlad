#include "Service.h"

Service::Service(Repository& repo):repo{repo}
{
}

void Service::sortList()
{
	this->repo.sort();
}

std::vector<Weather> Service::getAll()
{
	return this->repo.getAll();
}

void Service::readFromFile()
{
	this->repo.readFromFile();
}

Service::~Service() = default;