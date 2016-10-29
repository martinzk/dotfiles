#include "weather_data.h"

using namespace std;
using namespace aggregator;
using namespace persistent;

namespace wdata {
void WeatherData::accept(Deserializer *parser) {
  parser->parse(city, "city");
  parser->parse(time, "time");
  parser->parseListBegin("data");
  do {
    shared_ptr<Data> datael = make_shared<Data>();
    parser->parseListElement(*datael);
    data.push_back(move(datael));
  } while (parser->moreElements());
  parser->parseListEnd();
}
void WeatherData::accept(Serializer *parser) const {
  parser->parse(city, "city");
  parser->parse(time, "time");
  vector<shared_ptr<Persistent>> parsable(data.begin(), data.end());
  parser->parse(parsable, "data");
}

void WeatherData::accept(Aggregator *aggregator) { aggregator->visit(*this); }
}
