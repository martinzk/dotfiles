#ifndef CLOUDS_H
#define CLOUDS_H
#include "clouds.h"

using namespace persistent;
using namespace std;

namespace wdata {
  map<int,shared_ptr<Clouds>> Clouds::shared_clouds;
  void Clouds::accept(Deserializer *parser) {
    parser->parse(all, "all");
  }
  void Clouds::accept(Serializer *parser) const {
    parser->parse(all, "all");
  }
  shared_ptr<Clouds> Clouds::getSharedInstance() {
    if(shared_clouds.find(this->all) == shared_clouds.end())
      shared_clouds[this->all] = make_shared<Clouds>(*this);
    return shared_clouds[this->all];
  }
}

#endif /* CLOUDS_H */
