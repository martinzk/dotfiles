#ifndef WEATHER_DATA_STATISTICS_H
#define WEATHER_DATA_STATISTICS_H

#include "aggregator.h"
#include "country_statistics.h"
#include "weather_data.h"
#include <string>
#include <map>

namespace wstat {

class WeatherDataStatistics : public aggregator::Aggregator {
private:
  CountryStatistics getCountryStatistics(const std::string &country);

public:
  std::map<std::string, CountryStatistics> statistics;
  // allow better optimizations with noexcept because we do not throw expections
  // here
  void visit(wdata::WeatherData &) noexcept override;
};
}

#endif /* WEATHER_DATA_STATISTICS_H */
