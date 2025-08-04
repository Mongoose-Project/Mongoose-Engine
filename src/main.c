#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdio.h>

int
main(int argc, char *argv[])
{
  if(argc < 2) {
    fprintf(stderr, "Usage: %s <python_script.py>\n", argv[0]);
    return 1;
  }

  PyStatus status;
  PyConfig config;
  PyConfig_InitPythonConfig(&config);

  /* Set program name */
  status = PyConfig_SetBytesString(&config, &config.program_name, argv[0]);
  if(PyStatus_Exception(status)) {
    goto exception;
  }

  /* Initialize Python runtime */
  status = Py_InitializeFromConfig(&config);
  if(PyStatus_Exception(status)) {
    goto exception;
  }

  PyConfig_Clear(&config);

  /* Open and run the Python script */
  FILE *fp = fopen(argv[1], "r");
  if(!fp) {
    fprintf(stderr, "Could not open file: %s\n", argv[1]);
    Py_FinalizeEx();
    return 2;
  }

  PyRun_SimpleFileExFlags(fp, argv[1], 1, NULL); // 1 = close file after run

  if(Py_FinalizeEx() < 0) {
    return 120;
  }

  return 0;

exception:
  PyConfig_Clear(&config);
  Py_ExitStatusException(status);
}
