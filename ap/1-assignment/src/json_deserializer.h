#ifndef JSON_LIB_H
#define JSON_LIB_H
#include <string>
#include <fstream>
#include <sstream>
#include <memory>
#include <list>
#include <vector>
#include "persistent_lib.h"

namespace persistent {

// the definition of a Json Deserializer
// It has been implemented with three cases in mind after reading a value:
// We end on a end of object }, or end of list ], or comma.
// This way we can always tell if there are more elements in the Json
// element/list/object.
// The implemenetation throws an error if it detects ill-formed Json
class ReadJson : public Deserializer {
private:
  bool eof = false;
  std::string element;
  std::ifstream file;
  std::istringstream stream;
  size_t pos;
  size_t endOfType(const std::string &type);
  // template for int, float, and double because they are structure-wise
  // similar in JSON
  template <typename T> void parseNumerics(T &value, const std::string &type) {
    size_t newPos = endOfType(type);
    if (newPos != 0) {
      pos = newPos;
      // we read the type and what to ensure that the next character is :
      if (element[pos] != ':')
        throw std::runtime_error("Expected separator but got: " +
                                 std::to_string(element[pos]));
      pos++;
      // move to pos in stream and read the value
      stream.seekg(pos);
      stream >> value;
      // end on , or } or ]
      pos = stream.tellg();
    }
  }

public:
  ReadJson(std::string filename);
  bool getNextElement();
  void parse(Root &object) override;
  void parse(int &value, const std::string &&type) override;
  void parse(float &value, const std::string &&type) override;
  void parse(double &value, const std::string &&type) override;
  void parse(std::string &value, const std::string &&type) override;
  void parse(Persistent &object, const std::string &&type) override;
  // see persistent_lib for explanation
  void parseListBegin(const std::string &&type) override;
  void parseListElement(Persistent &object) override;
  bool moreElements() override;
  void parseListEnd() override;
};
}
#endif
