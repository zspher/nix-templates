{
  description = "a collection of templates";
  outputs = {self}: {
    templates = {
        description = "c example";
      c-cpp = {
        path = ./c-cpp;
      };
      rust-example = {
        path = ./rust-example;
        description = "rust example";
      };
      c-sharp-example = {
        path = ./c-sharp-example;
        description = "c# example";
      };
    };
  };
}
