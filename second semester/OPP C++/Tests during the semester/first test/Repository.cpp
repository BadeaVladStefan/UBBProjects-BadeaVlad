//
// Created by Vlad on 4/27/2023.
//

#include "Repository.h"
#include "algorithm"
#include "iostream"
Repository::Repository() = default;

std::vector<School> Repository::getData() {
    return this->data;
}

void Repository::add(School &school) {
    this->data.push_back(school);
}

void Repository::operator=(Repository &repo) {
    this->data.clear();
    for(auto it:repo.data)
        this->data.push_back(it);
}

void Repository::remove(School &school) {
    /*
     * Input: one parameter
     * Output: the modified vector without the given school if found, otherwise an exception1
     */
for(auto it: this->data)
    if(it == school)
        remove(it);
    throw std::invalid_argument("No school in repo");
}

void Repository::sort() {
        std::vector<School> arr = this->getData();
        std::sort(arr.begin(),arr.end());
        Repository repo = Repository();
        for(auto it:arr)
            repo.data.push_back(it);
    this->data=repo.data;

}

Repository::~Repository() = default;