<cfscript>
  param name="url.handler" default="Api";
  param name="url.action" default="default";

  handlerPath = "handlers.#url.handler#";
  if (fileExists(expandPath("/handlers/"&url.handler& ".cfc"))) {
      handler = createObject("component", handlerPath);
      if (structKeyExists(handler, url.action)) {
          writeOutput(handler[url.action]());
      } else {
          writeOutput("Action '#url.action#' tidak ditemukan.");
      }
  } else {
      writeOutput("Handler '#url.handler#' tidak ditemukan.");
  }

  // memanggil cfc yang menggunakan cftag
  writeOutput("<br><hr>");
  example = new models.Example();
  writeOutput(example.halo());
  writeOutput("<br><hr>");
  example = new cfc.Example();
  writeOutput(example.halo());
</cfscript>

<!---
  http://localhost:8888/
  http://localhost:8888/index.cfm?handler=Api&action=tambah&a=5&b=7
  http://localhost:8888/index.cfm?handler=Api&action=halo&nama=Andi
  http://localhost:8888/index.cfm?handler=Api&action=besar&text=halo world
--->
