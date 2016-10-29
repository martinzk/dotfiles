#ifndef SYS_H_
#define SYS_H_
#include <string>
#include <map>
#include <memory>
#include "persistent_lib.h"

namespace wdata {
class Sys : public persistent::Persistent {
private:
  static std::map<std::string, std::shared_ptr<Sys>> shared_sys;

public:
  std::string pod;
  void accept(persistent::Deserializer *parser) override;
  void accept(persistent::Serializer *parser) const override;
  std::shared_ptr<Sys> getSharedInstance();
};
}
#endif
