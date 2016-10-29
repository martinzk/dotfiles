#ifndef COUNTRY_STATISTICS_H
#define COUNTRY_STATISTICS_H

#include "city_statistics.h"
#include "persistent_lib.h"
#include "aggregator.h"

namespace wstat {

class CountryStatistics : public persistent::Root,
                          public aggregator::Aggregator {
public:
  std::string country;
  std::vector<std::shared_ptr<CityStatistics>> cities;
  double temp_min;
  double temp_max;
  // constructor ensures that the values that are automatically assigned are not
  // greater or smaller than what is possible actual values received.
  CountryStatistics() : temp_min(9999), temp_max(0){};
  void accept(persistent::Serializer *parser) const override;
  void accept(persistent::Deserializer *parser) override;
  void visit(wdata::WeatherData &) noexcept override;
};
}

#endif /* COUNTRY_STATISTICS_H */
