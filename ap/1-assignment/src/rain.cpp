#include "rain.h"

using namespace persistent;
using namespace std;

namespace wdata {

map<double, shared_ptr<Rain>> Rain::shared_rain;

void Rain::accept(Deserializer *parser) { parser->parse(three_hour, "3h"); }
void Rain::accept(Serializer *parser) const { parser->parse(three_hour, "3h"); }
shared_ptr<Rain> Rain::getSharedInstance() {
  if (shared_rain.find(this->three_hour) == shared_rain.end())
    shared_rain[this->three_hour] = make_shared<Rain>(*this);
  return shared_rain[this->three_hour];
}
}
