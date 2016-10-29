#include "json_serializer.h"
#include "json_deserializer.h"
#include "weather_data_statistics.h"
#include "weather_data.h"
#include <iostream>

using namespace std;
using namespace wdata;
using namespace wstat;
using namespace persistent;

int main(int argc, char *argv[]) {
  if (argc != 2) {
    cout << "Specify the path to the JSON file (i.e. ./program hourly_16.json)"
         << endl;
    return 0;
  }
  vector<WeatherData> wd;
  ReadJson jsonReader{argv[1]};
  while (jsonReader.getNextElement()) {
    WeatherData d;
    jsonReader.parse(d);
    wd.push_back(move(d));
  }
  cout << "time" << "\n";
  WeatherDataStatistics stats;
  for (auto th : wd) {
    th.accept(&stats);
  };
  WriteJson jsonWriter{"out.json"};
  for (auto st : stats.statistics) {
    jsonWriter.parse(st.second);
  }
  return 0;
}
