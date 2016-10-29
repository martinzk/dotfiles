#include "weather_data_statistics.h"
#include "aggregator.h"
#include "weather_data.h"
#include <cmath>

using namespace aggregator;
using namespace wdata;
using namespace std;

namespace wstat {

CountryStatistics
WeatherDataStatistics::getCountryStatistics(const string &country) {
  CountryStatistics country_statistics;
  // get the instance that we already added data to if it exists
  country_statistics = statistics[country];
  if (country_statistics.country.empty()) {
    country_statistics.country = country;
  }
  return country_statistics;
}

void WeatherDataStatistics::visit(WeatherData &weatherData) noexcept {
  // ensure the pointer is not a not a nullptr and that the "city" has
  // an associated country
  if (weatherData.city.country && !weatherData.city.country->empty()) {
    CountryStatistics country_statistics =
        getCountryStatistics(*weatherData.city.country);
    weatherData.accept(&country_statistics);
    shared_ptr<CityStatistics> city_statistics = make_shared<CityStatistics>();
    weatherData.accept(&*city_statistics);
    // update statistics
    country_statistics.cities.push_back(city_statistics);
    statistics[country_statistics.country] = country_statistics;
  }
}
}
