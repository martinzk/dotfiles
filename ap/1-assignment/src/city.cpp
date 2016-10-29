#include "city.h"

using namespace std;
using namespace persistent;

namespace wdata {
map<string, shared_ptr<string>> City::shared_country;

void City::accept(Deserializer *parser) {
  parser->parse(id, "id");
  parser->parse(name, "name");
  string temp_country;
  parser->parse(temp_country, "country");
  if (City::shared_country.find(temp_country) == City::shared_country.end())
    City::shared_country[temp_country] = make_shared<string>(temp_country);
  country = City::shared_country[temp_country];
  parser->parse(coord, "coord");
}
void City::accept(Serializer *parser) const {
  parser->parse(id, "id");
  parser->parse(name, "name");
  parser->parse(*country, "country");
  parser->parse(coord, "coord");
}
}
