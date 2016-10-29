#ifndef COUNTRY_STATISTICS_H
#define COUNTRY_STATISTICS_H

#include "json.h"
#include <string>

namespace Statistics {

struct CountryStatistics {
  std::string country;
  double temp_min = 9999.99, temp_max = 00.00;

  void parse(js::Serializer &serializer) const noexcept {
    serializer.parse(country, "country");
    serializer.parse(temp_max, "temp_max");
    serializer.parse(temp_min, "temp_min");
  }
  void parse(js::Deserializer &serializer) {
    serializer.parse(country, "country");
    serializer.parse(temp_max, "temp_max");
    serializer.parse(temp_min, "temp_min");
  }
};
} // Statistics

#endif /* COUNTRY-STATISTICS_H */
