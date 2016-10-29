#include "sys.h"

using namespace persistent;
using namespace std;

namespace wdata {

map<string, shared_ptr<Sys>> Sys::shared_sys;
void Sys::accept(Deserializer *parser) { parser->parse(pod, "pod"); }
void Sys::accept(Serializer *parser) const { parser->parse(pod, "pod"); }
shared_ptr<Sys> Sys::getSharedInstance() {
  if (shared_sys.find(this->pod) == shared_sys.end())
    shared_sys[this->pod] = make_shared<Sys>(*this);
  return shared_sys[this->pod];
}
}
