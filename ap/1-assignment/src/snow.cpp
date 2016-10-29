#include "snow.h"

using namespace persistent;
using namespace std;

namespace wdata {
map<double, shared_ptr<Snow>> Snow::shared_snow;
void Snow::accept(Deserializer *parser) { parser->parse(three_hour, "3h"); }
void Snow::accept(Serializer *parser) const { parser->parse(three_hour, "3h"); }
shared_ptr<Snow> Snow::getSharedInstance() {
  if (shared_snow.find(this->three_hour) == shared_snow.end())
    shared_snow[this->three_hour] = make_shared<Snow>(*this);
  return shared_snow[this->three_hour];
}
}
