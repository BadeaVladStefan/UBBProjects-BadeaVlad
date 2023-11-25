#include <assert.h>
#include <sstream>
#include <fstream>
#include "Test.h"
#include <iostream>
#include <string>

void testDomain()
{
    Dog dog("Bogdan", "Doberman", 14, "https://scontent.fclj2-1.fna.fbcdn.net/v/t1.6435-9/45153142_699058083796446_2018800938843635712_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=WHhtrZGBrTMAX8jdIp9&_nc_ht=scontent.fclj2-1.fna&oh=00_AfDcCJ1bt95f9d0bMsmjq-FEjBqBpxuX-M50nzcBbwZe4w&oe=6444E783");
    assert(dog.getName() == "Bogdan");
    assert(dog.getBreed() == "Doberman");
    assert(dog.getAge() == 14);
    assert(dog.getPhotoLink() == "https://scontent.fclj2-1.fna.fbcdn.net/v/t1.6435-9/45153142_699058083796446_2018800938843635712_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=WHhtrZGBrTMAX8jdIp9&_nc_ht=scontent.fclj2-1.fna&oh=00_AfDcCJ1bt95f9d0bMsmjq-FEjBqBpxuX-M50nzcBbwZe4w&oe=6444E783");
    std::string name, breed, photoLink;
    name = "a";
    breed = "b";
    photoLink = "p";
    dog.setName(name);
    dog.setBreed(breed);
    dog.setPhotoLink(photoLink);
    dog.setAge(12);
    assert(dog.getName() == "a");
    assert(dog.getBreed() == "b");
    assert(dog.getAge() == 12);
    assert(dog.getPhotoLink() == "p");
    assert(dog.toString() == "Name: a | Breed: b | Age: 12 | Photo Link: p");
    Dog dog2("a", "b", 12, "ok");
    assert(dog.operator==(dog2) == true);
    dog.operator=(dog2);
    assert(dog.getName() == "a");
    assert(dog.getBreed() == "b");
    assert(dog.getAge() == 12);
    assert(dog.getPhotoLink() == "ok");

    Dog d1("name1", "breed1", 1, "link1");
    Dog d2("name2", "breed2", 2, "link2");

    d1 = d2;
    assert(d1.getName() == "name2");
    assert(d1.getBreed() == "breed2");
    assert(d1.getAge() == 2);
    assert(d1.getPhotoLink() == "link2");

    Dog dog3("Buddy", "Golden Retriever", 5, "https://example.com/buddy.jpg");

    std::stringstream ss;
    ss << dog3;

    Dog dog4;
    ss >> dog4;

    assert(dog3 == dog4);

    Dog dog5("Buddy", "Golden Retriever", 5, "https://example.com/buddy.jpg");
    Dog dog6("Buddy", "Golden Retriver", 3, "https://example.com/buddy2.jpg");
    Dog dog7("Max", "Poodle", 2, "https://example.com/max.jpg");

    assert(!(dog5 == dog6));
    assert(!(dog5 == dog7));
    assert(!(dog6 == dog7));

    std::cout << "The Domain test worked!" << std::endl;
}

void testAdminRepo()
{
    Dog d1("abc", "breed1", 1, "link1");
    Dog d2("abcd", "breed2", 4, "link2");
    Dog d3("abc", "breed1", 3, "link3");

    RepositoryAdmin repository = RepositoryAdmin("");
    repository.addDogRepo(d1);
    repository.addDogRepo(d2);
    std::vector<Dog> arr = repository.getDogList();
    assert(arr[1].getName() == "abcd");
    try {
        repository.addDogRepo(d3);
        assert(false);
    }
    catch (RepoError)
    {
        assert(true);
    }
    Dog d4 = Dog();
    std::string name = "abcdef";
    d4.setName(name);

    repository.updateDogRepo("abc","breed1", d4);
    assert(repository.getDogList()[0].getName() == "abcdef");

    try
    {
        repository.updateDogRepo("a","breed1", d4);
        assert(false);
    }
    catch (RepoError)
    {
        assert(true);
    }

    repository.deleteDogRepo(d4.getName(),d4.getBreed());
    assert(repository.getDogList()[0].getName() == "abcd");
    assert(repository.findDogRepo("abcd","breed2").getAge() == 4);

    try
    {
        repository.deleteDogRepo("a","breed1");
        assert(false);
    }
    catch (RepoError)
    {
        assert(true);
    }
    std::cout << "The Repository test worked!" << std::endl;
}

void testAdminServ()
{
    RepositoryAdmin repo = RepositoryAdmin("");
    ServiceAdmin serv = ServiceAdmin(repo);
    serv.addDogServ("n1", "b1", 1, "l1");
    assert(serv.getDogList()[0].getName() == "n1");
    serv.addDogServ("n2", "b2", 2, "l2");
    assert(serv.getDogList()[1].getName() == "n2");
    try {
        serv.addDogServ("n1", "b1", 3, "l5");
        assert(false);
    }
    catch (RepoError)
    {
        assert(true);
    }
    serv.removeDogServ("n1", "b1");
    assert(serv.getDogList()[0].getName() == "n2");

    serv.updateDogServ("n2", "b2", 10, "newL");
    assert(serv.getDogList()[0].getPhotoLink() == "newL");

    try {
        serv.updateDogServ("nNull", "bNull", 1, "x");
        assert(false);
    }
    catch (RepoError)
    {
        assert(true);
    }
    std::cout << "The Service test worked!\n";
}

void testError()
{
    ValueError error("test message");
    const char* message = error.what();
    assert(strcmp(message, "test message") == 0 && "ValueError test failed");

    RepoError error2("test message");
    const char* message2 = error2.what();
    assert(strcmp(message2, "test message") == 0 && "RepoError test failed");
    std::cout << "The Error class test worked!" << std::endl;
}

void testUserRepo()
{
    Dog d1 = Dog("n1", "b1", 1, "l1");
    Dog d2 = Dog();
    std::string name="n2", breed="b2", photoLink="l2";
    d2.setName(name);
    d2.setBreed(breed);
    d2.setAge(2);
    d2.setPhotoLink(photoLink);
    assert(d2.getName() == "n2");
    assert(d2.getBreed() == "b2");
    assert(d2.getAge() == 2);
    assert(d2.getPhotoLink() == "l2");

    Dog d3 = Dog("n1", "b1", 3, "l3");

    RepositoryUserCSV repoCSV = RepositoryUserCSV("");
    RepositoryUserHTML repoHTML = RepositoryUserHTML("");

    repoCSV.addDogUserRepo(d1);
    repoHTML.addDogUserRepo(d1);

    repoCSV.addDogUserRepo(d2);
    repoHTML.addDogUserRepo(d2);

    std::vector<Dog> arr1 = repoCSV.getAdoptingList();
    std::vector<Dog> arr2 = repoHTML.getAdoptingList();

    assert(arr1[0].getName() == "n1");
    assert(arr1[1].getName() == "n2");

    assert(arr2[0].getName() == "n1");
    assert(arr2[1].getName() == "n2");

    try {
        repoCSV.addDogUserRepo(d3);
        assert(true);
    }
    catch (RepoError)
    {
        assert(false);
    }
    try {
        repoHTML.addDogUserRepo(d3);
        assert(true);
    }
    catch (RepoError)
    {
        assert(false);
    }
    std::cout << "The user repo test worked! \n";
}

void testUserServ()
{
    
    ServiceUser serv = ServiceUser();
    try {
        serv.chooseRepoType(1);
        assert(true);
    }
    catch (RepoError)
    {
        assert(false);
    }
    try {
        serv.chooseRepoType(2);
        assert(true);
    }catch(RepoError)
    {
        assert(false);
    }
    serv.addDogUserServ("n1", "b1", 1, "l1");
    serv.addDogUserServ("n2", "b2", 2, "l2");
    assert(serv.getAdoptionList()[0].getName() == "n1");
    assert(serv.getAdoptionList()[1].getName() == "n2");
    try {
        serv.addDogUserServ("n1", "n2", 3, "l3");
        assert(true);
    }
    catch (RepoError)
    {
        assert(false);
    }
    std::cout << "The user service worked! \n";
}



void testAll()
{
    std::cout << "~~~~~TESTS~~~~~\n";
    testDomain();
    testAdminRepo();
    testAdminServ();
    testError();
    testUserRepo();
    testUserServ();
    std::cout << "~~~~~~~~~~~~~\n";
}
