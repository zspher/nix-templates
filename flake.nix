{
  description = "a collection of templates";
  outputs = {self}: {
    templates = {
      c-cpp = {path = ./c-cpp;};
      c-sharp = {path = ./c-sharp;};
      latex = {path = ./latex;};
      notebook = {path = ./notebook;};
      python = {path = ./python;};
      rust = {path = ./rust;};
    };
  };
}
