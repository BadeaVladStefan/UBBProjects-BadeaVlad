#pragma once
#include <string>

class Weather

{
private:
	int start, end, temp, precip;
	std::string descrip;
public:
	Weather(int s, int e, int t, int p, std::string d);

	std::string toString();
	bool operator<(Weather w1);


	~Weather();

};

