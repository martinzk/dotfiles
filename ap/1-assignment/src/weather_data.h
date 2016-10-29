#ifndef WEATHER_DATA_H
#define WEATHER_DATA_H
#include "city.h"
#include "data.h"
#include <memory>
#include <vector>
#include "persistent_lib.h"
#include "aggregator.h"

namespace wdata {
class WeatherData : public persistent::Root, public aggregator::Aggregatable {
public:
  City city;
  int time;
  std::vector<std::shared_ptr<Data>> data;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
  void accept(aggregator::Aggregator *aggregator) override;
};
}
#endif /* WEATHER_DATA_H */
