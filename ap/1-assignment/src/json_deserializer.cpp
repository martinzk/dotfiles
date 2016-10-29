#include "json_deserializer.h"

using namespace persistent;
using namespace std;

namespace persistent {
ReadJson::ReadJson(string filename) { file.open(filename); }
bool ReadJson::getNextElement() {
  getline(file, element);
  stream.str(element);
  pos = 0;
  // no json element on line
  if (element[pos] != '{') {
    eof = true;
    file.close();
  }
  return !eof;
}
void ReadJson::parse(Root &object) {
  if (!eof) {
    object.accept(this);
    if (element[pos] != '}')
      throw runtime_error("Expected end of element but found: " +
                          to_string(element[pos]));
  }
}
size_t ReadJson::endOfType(const string &type) {
  // we should always end on comma before another element so next char should
  // be "
  if (element[pos + 1] == '"') {
    // find the next " and get the name between the quotes
    size_t end_of_type = element.find('"', pos + 2);
    string actual_type = element.substr(pos + 2, end_of_type - pos - 2);
    // If the types are equal we return the position of the char after the type
    // which should be :
    if (actual_type.compare(type) == 0) {
      return end_of_type + 1;
    }
  }
  // If we do not get the expected type we return 0 to indicate.
  return 0;
}
// parseNumerics defined in header file
void ReadJson::parse(int &value, const string &&type) {
  parseNumerics(value, type);
}
void ReadJson::parse(float &value, const string &&type) {
  parseNumerics(value, type);
}
void ReadJson::parse(double &value, const string &&type) {
  parseNumerics(value, type);
}
void ReadJson::parse(string &value, const string &&type) {
  size_t newPos = endOfType(type);
  if (newPos != 0) {
    // if we get a new position update pos.
    pos = newPos;
    if (element[pos] != ':')
      throw runtime_error("Expected separator but got: " +
                          to_string(element[pos]));
    if (element[pos + 1] != '"')
      throw runtime_error("Expected start of string but got: " +
                          to_string(element[pos]));
    size_t end_of_value = element.find('"', pos + 2);
    value = element.substr(pos + 2, end_of_value - pos - 2);
    pos = end_of_value + 1;
  }
  // If we do not get a new position (the expected type was not the actual type)
  // we leave pos unchanged such that the can check the actual type with the
  // expected type when we get a new type. This means that the expected type
  // is optional in the JSON structure.
}
void ReadJson::parse(Persistent &object, const string &&type) {
  size_t newPos = endOfType(type);
  if (newPos != 0) {
    pos = newPos;
    if (element[pos] != ':')
      throw runtime_error("Expected separator but got: " +
                          to_string(element[pos]));
    if (element[++pos] != '{') {
      throw runtime_error("Expected start of object but got: " +
                          to_string(element[pos]));
    }
    stream.seekg(pos);
    object.accept(this);
    if (element[pos] != '}') {
      throw runtime_error("Expected end of object but got: " +
                          to_string(element[pos]));
    }
    pos++;
    stream.seekg(pos);
  }
}
// tell the parser that a list is comming of type type.
void ReadJson::parseListBegin(const string &&type) {
  size_t newPos = endOfType(type);
  if (newPos != 0) {
    pos = newPos;
    if (element[pos] != ':')
      throw runtime_error("Expected separator but got: " +
                          to_string(element[pos]));
    if (element[++pos] != '[')
      throw runtime_error("Expected start of list but got: " +
                          to_string(element[pos]));
  }
}
// parses a single list element of class type. This function is necessary
// because we do not write a type name every time we parse a list element
// unlike when we parse an element outside of a list.
void ReadJson::parseListElement(Persistent &object) {
  if (element[pos + 1] == '{') {
    pos++;
  }
  object.accept(this);
}
// check if there are more list elements to be read.
bool ReadJson::moreElements() {
  if (element[pos] == '}')
    pos++;
  if (element[pos] == ',')
    return true;
  return false;
}
// tell the parser that the list is closed
void ReadJson::parseListEnd() {
  if (element[pos] == '}')
    pos++;
  if (element[pos] != ']') {
    throw runtime_error{"Expected end of list but got: " +
                        to_string(element[pos])};
  }
  // go to next comma or end of object/element/list } } ]
  pos++;
}
}

// 4412
