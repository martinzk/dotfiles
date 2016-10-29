#include "data.h"

using namespace std;
using namespace persistent;

namespace wdata {

map<string, shared_ptr<string>> Data::shared_dt_text;

void Data::accept(Deserializer *parser) {
  parser->parse(dt, "dt");
  parser->parse(main, "main");
  // tell parser a list of type weather is comming
  parser->parseListBegin("weather");
  do {
    // deserialize into temporary object
    Weather temp_weather;
    parser->parseListElement(temp_weather);
    // get or create the shared instance of this object
    // and store it in weather
    weather.push_back(temp_weather.getSharedInstance());
  } while (parser->moreElements());
  // end list
  parser->parseListEnd();
  // same as before without the list usage
  Clouds temp_clouds;
  parser->parse(temp_clouds, "clouds");
  clouds = temp_clouds.getSharedInstance();
  parser->parse(wind, "wind");
  Snow temp_snow;
  parser->parse(temp_snow, "snow");
  snow = temp_snow.getSharedInstance();
  Rain temp_rain;
  parser->parse(temp_rain, "rain");
  rain = temp_rain.getSharedInstance();
  Sys temp_sys;
  parser->parse(temp_sys, "sys");
  sys = temp_sys.getSharedInstance();
  string temp_dt_text;
  parser->parse(temp_dt_text, "dt_txt");
  // see if there already is an instance of dt_text and use it or create it.
  if (Data::shared_dt_text.find(temp_dt_text) == Data::shared_dt_text.end())
    Data::shared_dt_text[temp_dt_text] = make_shared<string>(temp_dt_text);
  dt_text = Data::shared_dt_text[temp_dt_text];
}
void Data::accept(Serializer *parser) const {
  parser->parse(dt, "dt");
  parser->parse(main, "main");
  // cast vector<shared_ptr<Weather>> to vector<shared_ptr<Persistent>>
  // this is required because it is the type that the serializer knows
  vector<shared_ptr<Persistent>> parsable(weather.begin(), weather.end());
  parser->parse(parsable, "weather");
  parser->parse(*clouds, "clouds");
  parser->parse(wind, "wind");
  parser->parse(*snow, "snow");
  parser->parse(*rain, "rain");
  parser->parse(*sys, "sys");
  parser->parse(*dt_text, "dt_txt");
}
}
