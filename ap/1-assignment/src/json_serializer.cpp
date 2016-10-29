#include "json_serializer.h"

using namespace std;

namespace persistent {

WriteJson::WriteJson(string filename) { stream.open(filename); }
// write root json element (because it has no name)
void WriteJson::parse(const Root &object) {
  element = "";
  element += "{";
  object.accept(this);
  element += "}\n";
  stream << element;
}
void WriteJson::parse(const Persistent &object, const string &&type) {
  // an element was written previously if we end on anything but [ or {
  // (ex } or ]) so we insert a comma separator
  if (element.back() != '[' && element.back() != '{') {
    element += ',';
  }
  element += "\"" + type + "\":{";
  object.accept(this);
  element += "}";
}
// parseNumerics template defined in header
void WriteJson::parse(const int &field, const string &&type) {
  parseNumerics(field, type);
}
void WriteJson::parse(const float &field, const string &&type) {
  parseNumerics(field, type);
}
void WriteJson::parse(const double &field, const string &&type) {
  parseNumerics(field, type);
}
void WriteJson::parse(const bool &field, const string &&type) {
  if (element.back() != '[' && element.back() != '{') {
    element += ',';
  }
  element += "\"" + type + "\":";
  element += field ? "true" : "false";
}
void WriteJson::parse(const string &field, const string &&type) {
  if (element.back() != '[' && element.back() != '{') {
    element += ',';
  }
  element += "\"" + type + "\":\"" + field + "\"";
}
// The decision to keep all container parameters of type shared_ptr<Persistent>
// and not raw pointers is to get RAII.
// The reason we have to use pointers in the first place is that we can not
// create a container of an abstract type.
// The derived type of the instances in the container can still be deduced,
// so it still works as intended.
void WriteJson::parse(const shared_ptr<Persistent> objects[], int size,
                      const string &&type) {
  if (element.back() != '[' && element.back() != '{') {
    element += ",";
  }
  element += "\"" + type + "\":[";
  if (size != 0) {
    for (int i = 0; i < size; i++) {
      if (element.back() != '[')
        element += ',';
      element += '{';
      objects[i]->accept(this);
      element += '}';
    }
  } else
    element += "{}"; // empty list
  element += "]";
}
// function template for parsing containers is defined in header
// file
void WriteJson::parse(const vector<shared_ptr<Persistent>> &objects,
                      const string &&type) {
  parseObjContainers(objects.begin(), objects.end(), type);
}
void WriteJson::parse(const vector<int> &values, const string &&type) {
  parseContainers(values.cbegin(), values.cend(), type);
}
void WriteJson::parse(const vector<float> &values, const string &&type) {
  parseContainers(values.cbegin(), values.cend(), type);
}
void WriteJson::parse(const vector<double> &values, const string &&type) {
  parseContainers(values.cbegin(), values.cend(), type);
}
void WriteJson::parse(const vector<bool> &values, const string &&type) {
  if (element.back() != '[' && element.back() != '{') {
    element += ",";
  }
  element += "\"" + type + "\":[";
  if (values.size() != 0) {
    for (auto val : values) {
      if (element.back() != '[')
        element += ',';
      element += val ? "true" : "false";
    }
  }
  element += "]";
}
void WriteJson::parse(const list<shared_ptr<Persistent>> &objects,
                      const string &&type) {
  parseObjContainers(objects.begin(), objects.end(), type);
}
void WriteJson::parse(const list<int> &values, const string &&type) {
  parseContainers(values.cbegin(), values.cend(), type);
}
void WriteJson::parse(const list<float> &values, const string &&type) {
  parseContainers(values.cbegin(), values.cend(), type);
}
void WriteJson::parse(const list<double> &values, const string &&type) {
  parseContainers(values.cbegin(), values.cend(), type);
}
void WriteJson::parse(const list<bool> &values, const string &&type) {
  if (element.back() != '[' && element.back() != '{') {
    element += ",";
  }
  element += "\"" + type + "\":[";
  if (values.size() != 0) {
    for (auto val : values) {
      if (element.back() != '[')
        element += ',';
      element += val ? "true" : "false";
    }
  }
  element += "]";
}
}
