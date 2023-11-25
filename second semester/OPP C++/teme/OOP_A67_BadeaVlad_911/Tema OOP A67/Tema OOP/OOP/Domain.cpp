#include "Domain.h"
#include <vector>
#include <sstream>

Dog::Dog(): name{""},breed{""},age{0},photoLink{""}
{
}

Dog::Dog(const std::string& name, const std::string& breed, const int& age, const std::string& photoLink):
	name{name},breed{breed},age{age},photoLink{photoLink}
{
}

std::vector<std::string> tokenize(const std::string& str, char delimiter)
{
	std::vector<std::string> tokens;
	std::istringstream stream(str);
	std::string token;
	while (std::getline(stream, token, delimiter))
	{
		tokens.push_back(token);
	}
	return tokens;
}

Dog::Dog(const Dog& dog)
{
	this->name = dog.name;
	this->breed = dog.breed;
	this->age = dog.age;
	this->photoLink = dog.photoLink;
}

std::string Dog::getName() const
{
	return this->name;
}

std::string Dog::getBreed() const
{
	return this->breed;
}

std::string Dog::getPhotoLink() const
{
	return this->photoLink;
}

int Dog::getAge() const
{
	return this->age;
}

void Dog::setName(std::string& _name)
{
	this->name = _name;
}

void Dog::setBreed(std::string& _breed)
{
	this->breed = _breed;
}

void Dog::setPhotoLink(std::string& _photoLink)
{
	this->photoLink = _photoLink;
}

void Dog::setAge(int _age)
{
	this->age = _age;
}

std::string Dog::toString() const
{
	std::string ageStr = std::to_string(this->age);
	return "Name: " + this->name + " | Breed: " + this->breed + " | Age: " + ageStr + " | Photo Link: " + this->photoLink;
}

Dog& Dog::operator=(const Dog& dog)
{
	if (this == &dog)
	{
		return *this;
	}

	this->name = dog.name;
	this->breed = dog.breed;
	this->age = dog.age;
	this->photoLink = dog.photoLink;

	return *this;
}

bool Dog::operator==(const Dog& dog)
{
	return this->name == dog.name && this->breed == dog.breed;
}


std::ostream& operator<<(std::ostream& os, const Dog& dog)
{
	os << dog.getName() << ",";
	os << dog.getBreed() << ",";
	os << dog.getAge() << ",";
	os << dog.getPhotoLink();

	return os;
}

std::istream& operator>>(std::istream& reader, Dog& dog)
{
	std::string line;
	std::getline(reader, line);
	if (line.empty())
	{
		return reader;
	}
	std::vector<std::string> tokens;
	tokens = tokenize(line, ',');
	dog.name = tokens[0];
	dog.breed = tokens[1];
	dog.age = std::stoi(tokens[2]);
	dog.photoLink = tokens[3];
	return reader;
}

Dog::~Dog() = default;