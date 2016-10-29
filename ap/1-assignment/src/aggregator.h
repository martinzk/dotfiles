#ifndef AGGREGATOR_H
#define AGGREGATOR_H
#include "persistent_lib.h"

namespace wdata {
class WeatherData;
}

namespace aggregator {

class Aggregator {
public:
  virtual void visit(wdata::WeatherData &) = 0;
};

class Aggregatable {
  virtual void accept(Aggregator *aggregator) = 0;
};
}
#endif
