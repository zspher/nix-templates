{
  description = "a collection of templates";
  outputs = {self}: {
    templates = {
      c-cpp = {
        path = ./c-cpp;
      };
      rust-example = {
        path = ./rust-example;
      };
      c-sharp-example = {
        path = ./c-sharp-example;
      };
    };
  };
}
