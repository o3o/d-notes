import std.stdio;
import vibe.data.json;

version (unittest) {
   import unit_threaded;
} else {
   void main(string[] args) {
      writeln("USE dub test -- -d testname");
   }
}

unittest {
   auto j = parseJsonString(`{"title": {
            "text": "Acquisitore 0"
        },
        "xAxis": {
            "type": "datetime",
            "gridLineWidth": 1,
            "labels": {
                "overflow": "justify"
            }
        }
        }`);

   j["title"]["text"] = "cul";
   j["title"]["frit"] = "piss";
   writefln("JSON: %s", j.toString());
}

unittest {
   auto j = Json.emptyObject;
   j["title"] = Json.emptyObject;

   j["title"]["text"] = "cul";
   j["title"]["frit"] = "piss";
   writefln("JSON: %s", j.toPrettyString());
}
