#ifndef CITY_STATISTICS_H
#define CITY_STATISTICS_H

#include "element.h"
#include "json.h"
#include <string>

using Element = WeatherData::Element;
namespace Statistics {
struct CityStatistics {
  std::string city;
  float avg_temp_night, avg_temp_day;
  CityStatistics(){};
  CityStatistics(std::string city, double avg_temp_night, double avg_temp_day)
      : city(city), avg_temp_night(avg_temp_night),
        avg_temp_day(avg_temp_day){};
  void parse(js::Serializer &serializer) const noexcept {
    serializer.parse(city, "city");
    serializer.parse(avg_temp_night, "avg_temp_night");
    serializer.parse(avg_temp_day, "avg_temp_day");
  }
  void parse(js::Deserializer &serializer) {
    serializer.parse(city, "city");
    serializer.parse(avg_temp_night, "avg_temp_night");
    serializer.parse(avg_temp_day, "avg_temp_day");
  }
};
} // Statistics

#endif /* CITY-STATISTICS_H */
