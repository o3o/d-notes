import unit_threaded.runner;

int main(string[] args) {
    return args.runTests!(
          "tests.phobos_signal",
          "tests.event_d", 
          "tests.presenter_first",
          "tests.presenter_first2",
          "tests.orvid",
          );
}
