/* Include files */

#include <stddef.h>
#include "blas.h"
#include "simulink_SetTargetPioneerVelocity_sfun.h"
#include "c1_simulink_SetTargetPioneerVelocity.h"
#define CHARTINSTANCE_CHARTNUMBER      (chartInstance->chartNumber)
#define CHARTINSTANCE_INSTANCENUMBER   (chartInstance->instanceNumber)
#include "simulink_SetTargetPioneerVelocity_sfun_debug_macros.h"
#define _SF_MEX_LISTEN_FOR_CTRL_C(S)   sf_mex_listen_for_ctrl_c(sfGlobalDebugInstanceStruct,S);

/* Type Definitions */

/* Named Constants */
#define CALL_EVENT                     (-1)

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;
static const char * c1_debug_family_names[6] = { "ximg1", "ximg2", "nargin",
  "nargout", "img1", "img2" };

/* Function Declarations */
static void initialize_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void initialize_params_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void enable_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void disable_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void c1_update_debugger_state_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void set_sim_state_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_st);
static void finalize_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void sf_gateway_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void initSimStructsc1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber);
static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData);
static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static real_T c1_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static void c1_b_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_ximg1, const char_T *c1_identifier, real_T c1_y[156]);
static void c1_c_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[156]);
static void c1_d_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_ximg2, const char_T *c1_identifier, real_T c1_y[122]);
static void c1_e_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[122]);
static const mxArray *c1_e_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData);
static int32_T c1_f_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData);
static uint8_T c1_g_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_b_is_active_c1_simulink_SetTargetPioneerVelocity, const char_T
   *c1_identifier);
static uint8_T c1_h_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId);
static void init_dsm_address_info
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  chartInstance->c1_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c1_is_active_c1_simulink_SetTargetPioneerVelocity = 0U;
}

static void initialize_params_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c1_update_debugger_state_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  const mxArray *c1_st;
  const mxArray *c1_y = NULL;
  int32_T c1_i0;
  real_T c1_u[156];
  const mxArray *c1_b_y = NULL;
  int32_T c1_i1;
  real_T c1_b_u[122];
  const mxArray *c1_c_y = NULL;
  uint8_T c1_hoistedGlobal;
  uint8_T c1_c_u;
  const mxArray *c1_d_y = NULL;
  real_T (*c1_img2)[122];
  real_T (*c1_img1)[156];
  c1_img2 = (real_T (*)[122])ssGetOutputPortSignal(chartInstance->S, 2);
  c1_img1 = (real_T (*)[156])ssGetOutputPortSignal(chartInstance->S, 1);
  c1_st = NULL;
  c1_st = NULL;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_createcellmatrix(3, 1), false);
  for (c1_i0 = 0; c1_i0 < 156; c1_i0++) {
    c1_u[c1_i0] = (*c1_img1)[c1_i0];
  }

  c1_b_y = NULL;
  sf_mex_assign(&c1_b_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 1, 156), false);
  sf_mex_setcell(c1_y, 0, c1_b_y);
  for (c1_i1 = 0; c1_i1 < 122; c1_i1++) {
    c1_b_u[c1_i1] = (*c1_img2)[c1_i1];
  }

  c1_c_y = NULL;
  sf_mex_assign(&c1_c_y, sf_mex_create("y", c1_b_u, 0, 0U, 1U, 0U, 1, 122),
                false);
  sf_mex_setcell(c1_y, 1, c1_c_y);
  c1_hoistedGlobal =
    chartInstance->c1_is_active_c1_simulink_SetTargetPioneerVelocity;
  c1_c_u = c1_hoistedGlobal;
  c1_d_y = NULL;
  sf_mex_assign(&c1_d_y, sf_mex_create("y", &c1_c_u, 3, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c1_y, 2, c1_d_y);
  sf_mex_assign(&c1_st, c1_y, false);
  return c1_st;
}

static void set_sim_state_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_st)
{
  const mxArray *c1_u;
  real_T c1_dv0[156];
  int32_T c1_i2;
  real_T c1_dv1[122];
  int32_T c1_i3;
  real_T (*c1_img1)[156];
  real_T (*c1_img2)[122];
  c1_img2 = (real_T (*)[122])ssGetOutputPortSignal(chartInstance->S, 2);
  c1_img1 = (real_T (*)[156])ssGetOutputPortSignal(chartInstance->S, 1);
  chartInstance->c1_doneDoubleBufferReInit = true;
  c1_u = sf_mex_dup(c1_st);
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 0)),
                        "img1", c1_dv0);
  for (c1_i2 = 0; c1_i2 < 156; c1_i2++) {
    (*c1_img1)[c1_i2] = c1_dv0[c1_i2];
  }

  c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 1)),
                        "img2", c1_dv1);
  for (c1_i3 = 0; c1_i3 < 122; c1_i3++) {
    (*c1_img2)[c1_i3] = c1_dv1[c1_i3];
  }

  chartInstance->c1_is_active_c1_simulink_SetTargetPioneerVelocity =
    c1_g_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c1_u, 2)),
    "is_active_c1_simulink_SetTargetPioneerVelocity");
  sf_mex_destroy(&c1_u);
  c1_update_debugger_state_c1_simulink_SetTargetPioneerVelocity(chartInstance);
  sf_mex_destroy(&c1_st);
}

static void finalize_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  uint32_T c1_debug_family_var_map[6];
  const mxArray *c1_ximg1 = NULL;
  const mxArray *c1_ximg2 = NULL;
  real_T c1_nargin = 0.0;
  real_T c1_nargout = 2.0;
  real_T c1_img1[156];
  real_T c1_img2[122];
  const mxArray *c1_b_ximg2 = NULL;
  const mxArray *c1_b_ximg1 = NULL;
  int32_T c1_i4;
  int32_T c1_i5;
  real_T c1_dv2[156];
  int32_T c1_i6;
  real_T c1_dv3[122];
  int32_T c1_i7;
  int32_T c1_i8;
  int32_T c1_i9;
  int32_T c1_i10;
  int32_T c1_i11;
  real_T (*c1_b_img1)[156];
  real_T (*c1_b_img2)[122];
  c1_b_img2 = (real_T (*)[122])ssGetOutputPortSignal(chartInstance->S, 2);
  c1_b_img1 = (real_T (*)[156])ssGetOutputPortSignal(chartInstance->S, 1);
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  chartInstance->c1_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 6U, 6U, c1_debug_family_names,
    c1_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_ximg1, 0U, c1_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c1_ximg2, 1U, c1_d_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargin, 2U, c1_c_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c1_nargout, 3U, c1_c_sf_marshallOut,
    c1_c_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_img1, 4U, c1_b_sf_marshallOut,
    c1_b_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(c1_img2, 5U, c1_sf_marshallOut,
    c1_sf_marshallIn);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 2);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 3);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "getVisionScanner", 2U, 0U,
                    &c1_b_ximg1, &c1_b_ximg2);
  sf_mex_assign(&c1_ximg1, sf_mex_dup(c1_b_ximg1), false);
  sf_mex_assign(&c1_ximg2, sf_mex_dup(c1_b_ximg2), false);
  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 4);
  for (c1_i4 = 0; c1_i4 < 156; c1_i4++) {
    c1_img1[c1_i4] = 0.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 5);
  for (c1_i5 = 0; c1_i5 < 122; c1_i5++) {
    c1_img2[c1_i5] = 0.0;
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 6);
  c1_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_ximg1), "ximg1", c1_dv2);
  for (c1_i6 = 0; c1_i6 < 156; c1_i6++) {
    c1_img1[c1_i6] = c1_dv2[c1_i6];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, 7);
  c1_d_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_ximg2), "ximg2", c1_dv3);
  for (c1_i7 = 0; c1_i7 < 122; c1_i7++) {
    c1_img2[c1_i7] = c1_dv3[c1_i7];
  }

  _SFD_EML_CALL(0U, chartInstance->c1_sfEvent, -7);
  _SFD_SYMBOL_SCOPE_POP();
  sf_mex_destroy(&c1_ximg1);
  sf_mex_destroy(&c1_ximg2);
  sf_mex_destroy(&c1_b_ximg1);
  sf_mex_destroy(&c1_b_ximg2);
  for (c1_i8 = 0; c1_i8 < 156; c1_i8++) {
    (*c1_b_img1)[c1_i8] = c1_img1[c1_i8];
  }

  for (c1_i9 = 0; c1_i9 < 122; c1_i9++) {
    (*c1_b_img2)[c1_i9] = c1_img2[c1_i9];
  }

  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 0U, chartInstance->c1_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY
    (_simulink_SetTargetPioneerVelocityMachineNumber_,
     chartInstance->chartNumber, chartInstance->instanceNumber);
  for (c1_i10 = 0; c1_i10 < 156; c1_i10++) {
    _SFD_DATA_RANGE_CHECK((*c1_b_img1)[c1_i10], 0U);
  }

  for (c1_i11 = 0; c1_i11 < 122; c1_i11++) {
    _SFD_DATA_RANGE_CHECK((*c1_b_img2)[c1_i11], 1U);
  }
}

static void initSimStructsc1_simulink_SetTargetPioneerVelocity
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c1_machineNumber, uint32_T
  c1_chartNumber, uint32_T c1_instanceNumber)
{
  (void)c1_machineNumber;
  (void)c1_chartNumber;
  (void)c1_instanceNumber;
}

static const mxArray *c1_sf_marshallOut(void *chartInstanceVoid, void *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i12;
  real_T c1_b_inData[122];
  int32_T c1_i13;
  real_T c1_u[122];
  const mxArray *c1_y = NULL;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  for (c1_i12 = 0; c1_i12 < 122; c1_i12++) {
    c1_b_inData[c1_i12] = (*(real_T (*)[122])c1_inData)[c1_i12];
  }

  for (c1_i13 = 0; c1_i13 < 122; c1_i13++) {
    c1_u[c1_i13] = c1_b_inData[c1_i13];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 1, 122), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static void c1_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_ximg2;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y[122];
  int32_T c1_i14;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_ximg2 = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_ximg2), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_ximg2);
  for (c1_i14 = 0; c1_i14 < 122; c1_i14++) {
    (*(real_T (*)[122])c1_outData)[c1_i14] = c1_y[c1_i14];
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_b_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_i15;
  real_T c1_b_inData[156];
  int32_T c1_i16;
  real_T c1_u[156];
  const mxArray *c1_y = NULL;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  for (c1_i15 = 0; c1_i15 < 156; c1_i15++) {
    c1_b_inData[c1_i15] = (*(real_T (*)[156])c1_inData)[c1_i15];
  }

  for (c1_i16 = 0; c1_i16 < 156; c1_i16++) {
    c1_u[c1_i16] = c1_b_inData[c1_i16];
  }

  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", c1_u, 0, 0U, 1U, 0U, 1, 156), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static void c1_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_ximg1;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y[156];
  int32_T c1_i17;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_ximg1 = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_ximg1), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_ximg1);
  for (c1_i17 = 0; c1_i17 < 156; c1_i17++) {
    (*(real_T (*)[156])c1_outData)[c1_i17] = c1_y[c1_i17];
  }

  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_c_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  real_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(real_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static real_T c1_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  real_T c1_y;
  real_T c1_d0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_d0, 1, 0, 0U, 0, 0U, 0);
  c1_y = c1_d0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_c_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_nargout;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  real_T c1_y;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_nargout = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_nargout), &c1_thisId);
  sf_mex_destroy(&c1_nargout);
  *(real_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static const mxArray *c1_d_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  const mxArray *c1_u;
  const mxArray *c1_y = NULL;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = sf_mex_dup(*(const mxArray **)c1_inData);
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_duplicatearraysafe(&c1_u), false);
  sf_mex_destroy(&c1_u);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

const mxArray
  *sf_c1_simulink_SetTargetPioneerVelocity_get_eml_resolved_functions_info(void)
{
  const mxArray *c1_nameCaptureInfo = NULL;
  c1_nameCaptureInfo = NULL;
  sf_mex_assign(&c1_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c1_nameCaptureInfo;
}

static void c1_b_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_ximg1, const char_T *c1_identifier, real_T c1_y[156])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_c_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_ximg1), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_ximg1);
}

static void c1_c_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[156])
{
  real_T c1_dv4[156];
  int32_T c1_i18;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv4, 1, 0, 0U, 1, 0U, 1, 156);
  for (c1_i18 = 0; c1_i18 < 156; c1_i18++) {
    c1_y[c1_i18] = c1_dv4[c1_i18];
  }

  sf_mex_destroy(&c1_u);
}

static void c1_d_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_ximg2, const char_T *c1_identifier, real_T c1_y[122])
{
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_e_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_ximg2), &c1_thisId, c1_y);
  sf_mex_destroy(&c1_ximg2);
}

static void c1_e_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId, real_T c1_y[122])
{
  real_T c1_dv5[122];
  int32_T c1_i19;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), c1_dv5, 1, 0, 0U, 1, 0U, 1, 122);
  for (c1_i19 = 0; c1_i19 < 122; c1_i19++) {
    c1_y[c1_i19] = c1_dv5[c1_i19];
  }

  sf_mex_destroy(&c1_u);
}

static const mxArray *c1_e_sf_marshallOut(void *chartInstanceVoid, void
  *c1_inData)
{
  const mxArray *c1_mxArrayOutData = NULL;
  int32_T c1_u;
  const mxArray *c1_y = NULL;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_mxArrayOutData = NULL;
  c1_u = *(int32_T *)c1_inData;
  c1_y = NULL;
  sf_mex_assign(&c1_y, sf_mex_create("y", &c1_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c1_mxArrayOutData, c1_y, false);
  return c1_mxArrayOutData;
}

static int32_T c1_f_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  int32_T c1_y;
  int32_T c1_i20;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_i20, 1, 6, 0U, 0, 0U, 0);
  c1_y = c1_i20;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void c1_d_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c1_mxArrayInData, const char_T *c1_varName, void *c1_outData)
{
  const mxArray *c1_b_sfEvent;
  const char_T *c1_identifier;
  emlrtMsgIdentifier c1_thisId;
  int32_T c1_y;
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c1_b_sfEvent = sf_mex_dup(c1_mxArrayInData);
  c1_identifier = c1_varName;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_f_emlrt_marshallIn(chartInstance, sf_mex_dup(c1_b_sfEvent),
    &c1_thisId);
  sf_mex_destroy(&c1_b_sfEvent);
  *(int32_T *)c1_outData = c1_y;
  sf_mex_destroy(&c1_mxArrayInData);
}

static uint8_T c1_g_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_b_is_active_c1_simulink_SetTargetPioneerVelocity, const char_T
   *c1_identifier)
{
  uint8_T c1_y;
  emlrtMsgIdentifier c1_thisId;
  c1_thisId.fIdentifier = c1_identifier;
  c1_thisId.fParent = NULL;
  c1_y = c1_h_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c1_b_is_active_c1_simulink_SetTargetPioneerVelocity), &c1_thisId);
  sf_mex_destroy(&c1_b_is_active_c1_simulink_SetTargetPioneerVelocity);
  return c1_y;
}

static uint8_T c1_h_emlrt_marshallIn
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c1_u, const emlrtMsgIdentifier *c1_parentId)
{
  uint8_T c1_y;
  uint8_T c1_u0;
  (void)chartInstance;
  sf_mex_import(c1_parentId, sf_mex_dup(c1_u), &c1_u0, 1, 3, 0U, 0, 0U, 0);
  c1_y = c1_u0;
  sf_mex_destroy(&c1_u);
  return c1_y;
}

static void init_dsm_address_info
  (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

/* SFunction Glue Code */
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

void sf_c1_simulink_SetTargetPioneerVelocity_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(2339216064U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(1149946236U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(819073458U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(418145356U);
}

mxArray *sf_c1_simulink_SetTargetPioneerVelocity_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("AwaR6OVfL5un3DYORQrKsE");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(156);
      pr[1] = (double)(1);
      mxSetField(mxData,0,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,0,"type",mxType);
    }

    mxSetField(mxData,0,"complexity",mxCreateDoubleScalar(0));

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(122);
      pr[1] = (double)(1);
      mxSetField(mxData,1,"size",mxSize);
    }

    {
      const char *typeFields[] = { "base", "fixpt" };

      mxArray *mxType = mxCreateStructMatrix(1,1,2,typeFields);
      mxSetField(mxType,0,"base",mxCreateDoubleScalar(10));
      mxSetField(mxType,0,"fixpt",mxCreateDoubleMatrix(0,0,mxREAL));
      mxSetField(mxData,1,"type",mxType);
    }

    mxSetField(mxData,1,"complexity",mxCreateDoubleScalar(0));
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c1_simulink_SetTargetPioneerVelocity_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c1_simulink_SetTargetPioneerVelocity_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c1_simulink_SetTargetPioneerVelocity
  (void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S1x3'type','srcId','name','auxInfo'{{M[1],M[7],T\"img1\",},{M[1],M[8],T\"img2\",},{M[8],M[0],T\"is_active_c1_simulink_SetTargetPioneerVelocity\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 3, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c1_simulink_SetTargetPioneerVelocity_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
    chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
      chartInfo->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _simulink_SetTargetPioneerVelocityMachineNumber_,
           1,
           1,
           1,
           0,
           2,
           0,
           0,
           0,
           0,
           0,
           &(chartInstance->chartNumber),
           &(chartInstance->instanceNumber),
           (void *)S);

        /* Each instance must initialize ist own list of scripts */
        init_script_number_translation
          (_simulink_SetTargetPioneerVelocityMachineNumber_,
           chartInstance->chartNumber,chartInstance->instanceNumber);
        if (chartAlreadyPresent==0) {
          /* this is the first instance */
          sf_debug_set_chart_disable_implicit_casting
            (sfGlobalDebugInstanceStruct,
             _simulink_SetTargetPioneerVelocityMachineNumber_,
             chartInstance->chartNumber,1);
          sf_debug_set_chart_event_thresholds(sfGlobalDebugInstanceStruct,
            _simulink_SetTargetPioneerVelocityMachineNumber_,
            chartInstance->chartNumber,
            0,
            0,
            0);
          _SFD_SET_DATA_PROPS(0,2,0,1,"img1");
          _SFD_SET_DATA_PROPS(1,2,0,1,"img2");
          _SFD_STATE_INFO(0,0,2);
          _SFD_CH_SUBSTATE_COUNT(0);
          _SFD_CH_SUBSTATE_DECOMP(0);
        }

        _SFD_CV_INIT_CHART(0,0,0,0);

        {
          _SFD_CV_INIT_STATE(0,0,0,0,0,0,NULL,NULL);
        }

        _SFD_CV_INIT_TRANS(0,0,NULL,NULL,0,NULL);

        /* Initialization of MATLAB Function Model Coverage */
        _SFD_CV_INIT_EML(0,1,1,0,0,0,0,0,0,0,0);
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,246);

        {
          unsigned int dimVector[1];
          dimVector[0]= 156;
          _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_b_sf_marshallOut,(MexInFcnForType)
            c1_b_sf_marshallIn);
        }

        {
          unsigned int dimVector[1];
          dimVector[0]= 122;
          _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,1,&(dimVector[0]),0,0,0,0.0,
            1.0,0,0,(MexFcnForType)c1_sf_marshallOut,(MexInFcnForType)
            c1_sf_marshallIn);
        }

        {
          real_T (*c1_img1)[156];
          real_T (*c1_img2)[122];
          c1_img2 = (real_T (*)[122])ssGetOutputPortSignal(chartInstance->S, 2);
          c1_img1 = (real_T (*)[156])ssGetOutputPortSignal(chartInstance->S, 1);
          _SFD_SET_DATA_VALUE_PTR(0U, *c1_img1);
          _SFD_SET_DATA_VALUE_PTR(1U, *c1_img2);
        }
      }
    } else {
      sf_debug_reset_current_state_configuration(sfGlobalDebugInstanceStruct,
        _simulink_SetTargetPioneerVelocityMachineNumber_,
        chartInstance->chartNumber,chartInstance->instanceNumber);
    }
  }
}

static const char* sf_get_instance_specialization(void)
{
  return "wLujI6Hul1U263MO1acxrE";
}

static void sf_opaque_initialize_c1_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  chart_debug_initialization
    (((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar
     )->S,0);
  initialize_params_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
  initialize_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c1_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  enable_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c1_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  disable_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c1_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  sf_gateway_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c1_simulink_SetTargetPioneerVelocity(SimStruct* S)
{
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
  ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c1_simulink_SetTargetPioneerVelocity();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 4, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  mxDestroyArray(prhs[3]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_raw2high'.\n");
  }

  return plhs[0];
}

extern void sf_internal_set_sim_state_c1_simulink_SetTargetPioneerVelocity
  (SimStruct* S, const mxArray *st)
{
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
  ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[3];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_high2raw");
  prhs[1] = mxDuplicateArray(st);      /* high level simctx */
  prhs[2] = (mxArray*)
    sf_get_sim_state_info_c1_simulink_SetTargetPioneerVelocity();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 3, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c1_simulink_SetTargetPioneerVelocity(SimStruct* S)
{
  return sf_internal_get_sim_state_c1_simulink_SetTargetPioneerVelocity(S);
}

static void sf_opaque_set_sim_state_c1_simulink_SetTargetPioneerVelocity
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c1_simulink_SetTargetPioneerVelocity(S, st);
}

static void sf_opaque_terminate_c1_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*)
                    chartInstanceVar)->S;
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_simulink_SetTargetPioneerVelocity_optimization_info();
    }

    finalize_c1_simulink_SetTargetPioneerVelocity
      ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
    utFree((void *)chartInstanceVar);
    if (crtInfo != NULL) {
      utFree((void *)crtInfo);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc1_simulink_SetTargetPioneerVelocity
    ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c1_simulink_SetTargetPioneerVelocity(SimStruct *
  S)
{
  int i;
  for (i=0;i<ssGetNumRunTimeParams(S);i++) {
    if (ssGetSFcnParamTunable(S,i)) {
      ssUpdateDlgParamAsRunTimeParam(S,i);
    }
  }

  if (sf_machine_global_initializer_called()) {
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
    initialize_params_c1_simulink_SetTargetPioneerVelocity
      ((SFc1_simulink_SetTargetPioneerVelocityInstanceStruct*)
       (chartInfo->chartInstance));
  }
}

static void mdlSetWorkWidths_c1_simulink_SetTargetPioneerVelocity(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_simulink_SetTargetPioneerVelocity_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,1);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(sf_get_instance_specialization(),
                infoStruct,1,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,1,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(sf_get_instance_specialization(),infoStruct,1);
    if (chartIsInlinable) {
      sf_mark_chart_reusable_outputs(S,sf_get_instance_specialization(),
        infoStruct,1,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=2; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,1);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(2006422769U));
  ssSetChecksum1(S,(540274804U));
  ssSetChecksum2(S,(1370107572U));
  ssSetChecksum3(S,(167567022U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c1_simulink_SetTargetPioneerVelocity(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c1_simulink_SetTargetPioneerVelocity(SimStruct *S)
{
  SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)utMalloc(sizeof
    (ChartRunTimeInfo));
  chartInstance = (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct *)
    utMalloc(sizeof(SFc1_simulink_SetTargetPioneerVelocityInstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc1_simulink_SetTargetPioneerVelocityInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c1_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.debugInstance = sfGlobalDebugInstanceStruct;
  chartInstance->S = S;
  crtInfo->instanceInfo = (&(chartInstance->chartInfo));
  crtInfo->isJITEnabled = false;
  ssSetUserData(S,(void *)(crtInfo));  /* register the chart instance with simstruct */
  init_dsm_address_info(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  sf_opaque_init_subchart_simstructs(chartInstance->chartInfo.chartInstance);
  chart_debug_initialization(S,1);
}

void c1_simulink_SetTargetPioneerVelocity_method_dispatcher(SimStruct *S, int_T
  method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c1_simulink_SetTargetPioneerVelocity(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c1_simulink_SetTargetPioneerVelocity(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c1_simulink_SetTargetPioneerVelocity(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c1_simulink_SetTargetPioneerVelocity_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
