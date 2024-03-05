//
// Created by Vlad on 4/27/2023.
//

#include "Service.h"
#include "algorithm"

Service::Service(Repository &repo):repo{repo} {
    this->repo = repo;
}

void Service::Add(School &school) {
    this->repo.add(school);
}

std::vector<School> Service::getData() {
    return this->repo.getData();
}



void Service::Remove(School &school) {
    this->repo.remove(school);
}

void Service::sort() {
    this->repo.sort();
}

Service::~Service() =default;