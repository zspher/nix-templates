{
  description = "a collection of templates";
  outputs = {self}: {
    templates = {
      c-example = {
        path = ./c-example;
        description = "c example";
      };
      rust-example = {
        path = ./rust-example;
        description = "rust example";
      };
    };
  };
}
