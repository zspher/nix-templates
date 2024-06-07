{
  description = "a collection of templates";
  outputs = {self}: {
    templates = {
      c-cpp = {
        path = ./c-cpp;
      };
      rust = {
        path = ./rust;
      };
      c-sharp = {
        path = ./c-sharp;
      };
      python = {
        path = ./python;
      };
    };
  };
}
