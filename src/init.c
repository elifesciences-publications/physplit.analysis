#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .C calls */
extern void ApplySum(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void BroadcastMultiply(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void ComputeGtsnk(void *, void *, void *, void *);
extern void ComputeLambda(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void ComputeQ(void *, void *, void *, void *);

static const R_CMethodDef CEntries[] = {
  {"ApplySum",          (DL_FUNC) &ApplySum,          11},
  {"BroadcastMultiply", (DL_FUNC) &BroadcastMultiply, 12},
  {"ComputeGtsnk",      (DL_FUNC) &ComputeGtsnk,       4},
  {"ComputeLambda",     (DL_FUNC) &ComputeLambda,     11},
  {"ComputeQ",          (DL_FUNC) &ComputeQ,           4},
  {NULL, NULL, 0}
};

void R_init_physplit_analysis(DllInfo *dll)
{
  R_registerRoutines(dll, CEntries, NULL, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
