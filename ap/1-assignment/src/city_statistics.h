#ifndef CITY_STATISTICS_H
#define CITY_STATISTICS_H

#include "city.h"
#include "weather_data.h"
#include "persistent_lib.h"
#include "aggregator.h"

namespace wstat {

class CityStatistics : public persistent::Persistent,
                       public aggregator::Aggregator {
public:
  wdata::City city;
  double avg_daytime_temp = 0;
  double avg_nighttime_temp = 0;
  double daytime_variance = 0;
  double nighttime_variance = 0;
  void accept(persistent::Serializer *parser) const override;
  void accept(persistent::Deserializer *parser) override;
  void visit(wdata::WeatherData &) noexcept override;
};
}

#endif /* CITY_STATISTICS_H */
