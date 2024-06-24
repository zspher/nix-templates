{
  description = "a collection of templates";
  outputs = {self}: {
    templates = {
      c-cpp = {path = ./c-cpp;};
      c-sharp = {path = ./c-sharp;};
      notebook = {path = ./notebook;};
      python = {path = ./python;};
      rust = {path = ./rust;};
    };
  };
}
