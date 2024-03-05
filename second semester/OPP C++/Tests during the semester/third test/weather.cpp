#include "weather.h"

Weather::Weather(int s, int e, int t, int p, std::string d) :start{ s }, end{ e }, temp{ t }, precip{ p }, descrip{ d }
{
}

std::string Weather::toString()
{
	std::string s, e, t, p;
	s = std::to_string(this->start);
	e = std::to_string(this->end);
	t = std::to_string(this->temp);
	p = std::to_string(this->precip);
	return s + ";" + e + ";" + t + ";" + p+";"+this->descrip;

}

bool Weather::operator<(Weather w1)
{
	return this->start < w1.start;
}

Weather::~Weather() = default;