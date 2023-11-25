#pragma once

#include <string>
#include <iostream>

class Dog {
private:
	std::string name;
	std::string breed;
	int age;
	std::string photoLink;
public:
	/*
	* 3 constructors:
	* 1.empty constructor
	* 2.with parameters
	* 3.copy constructor
	*/
	Dog();
	Dog(const std::string& name, const std::string& breed, const int& age, const std::string& photoLink);
	Dog(const Dog& dog);

	/*
	* Getters and setters:
	*/
	std::string getName() const;
	std::string getBreed() const;
	std::string getPhotoLink() const;
	int getAge() const;

	void setName(std::string& _name);
	void setBreed(std::string& _breed);
	void setPhotoLink(std::string& _photoLink);
	void setAge(int _age);

	//To string:
	std::string toString() const;

	/*
	* Operators:
	*/

	Dog& operator=(const Dog& dog);
	bool operator==(const Dog& dog);
	
	friend std::ostream& operator<<(std::ostream& os, const Dog& dog);
	friend std::istream& operator>>(std::istream& reader, Dog& dog);

	//Destructor
	~Dog();
};