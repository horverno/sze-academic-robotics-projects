/* Include files */

#include <stddef.h>
#include "blas.h"
#include "simulink_SetTargetPioneerVelocity_sfun.h"
#include "c2_simulink_SetTargetPioneerVelocity.h"
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
static const char * c2_debug_family_names[4] = { "nargin", "nargout", "vel_rw",
  "vel_lw" };

/* Function Declarations */
static void initialize_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void initialize_params_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void enable_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void disable_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void c2_update_debugger_state_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void set_sim_state_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_st);
static void finalize_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void sf_gateway_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void initSimStructsc2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);
static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber);
static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData);
static real_T c2_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData);
static int32_T c2_b_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData);
static uint8_T c2_c_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_b_is_active_c2_simulink_SetTargetPioneerVelocity, const char_T
   *c2_identifier);
static uint8_T c2_d_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId);
static void init_dsm_address_info
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance);

/* Function Definitions */
static void initialize_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  chartInstance->c2_sfEvent = CALL_EVENT;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c2_is_active_c2_simulink_SetTargetPioneerVelocity = 0U;
}

static void initialize_params_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void enable_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void c2_update_debugger_state_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static const mxArray *get_sim_state_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  const mxArray *c2_st;
  const mxArray *c2_y = NULL;
  uint8_T c2_hoistedGlobal;
  uint8_T c2_u;
  const mxArray *c2_b_y = NULL;
  c2_st = NULL;
  c2_st = NULL;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_createcellmatrix(1, 1), false);
  c2_hoistedGlobal =
    chartInstance->c2_is_active_c2_simulink_SetTargetPioneerVelocity;
  c2_u = c2_hoistedGlobal;
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_u, 3, 0U, 0U, 0U, 0), false);
  sf_mex_setcell(c2_y, 0, c2_b_y);
  sf_mex_assign(&c2_st, c2_y, false);
  return c2_st;
}

static void set_sim_state_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_st)
{
  const mxArray *c2_u;
  chartInstance->c2_doneDoubleBufferReInit = true;
  c2_u = sf_mex_dup(c2_st);
  chartInstance->c2_is_active_c2_simulink_SetTargetPioneerVelocity =
    c2_c_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c2_u, 0)),
    "is_active_c2_simulink_SetTargetPioneerVelocity");
  sf_mex_destroy(&c2_u);
  c2_update_debugger_state_c2_simulink_SetTargetPioneerVelocity(chartInstance);
  sf_mex_destroy(&c2_st);
}

static void finalize_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void sf_gateway_c2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  real_T c2_hoistedGlobal;
  real_T c2_b_hoistedGlobal;
  real_T c2_vel_rw;
  real_T c2_vel_lw;
  uint32_T c2_debug_family_var_map[4];
  real_T c2_nargin = 2.0;
  real_T c2_nargout = 0.0;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  real_T c2_b_u;
  const mxArray *c2_b_y = NULL;
  real_T c2_c_u;
  const mxArray *c2_c_y = NULL;
  real_T *c2_b_vel_rw;
  real_T *c2_b_vel_lw;
  c2_b_vel_lw = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
  c2_b_vel_rw = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
  _SFD_SYMBOL_SCOPE_PUSH(0U, 0U);
  _sfTime_ = sf_get_time(chartInstance->S);
  _SFD_CC_CALL(CHART_ENTER_SFUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  _SFD_DATA_RANGE_CHECK(*c2_b_vel_rw, 0U);
  _SFD_DATA_RANGE_CHECK(*c2_b_vel_lw, 1U);
  chartInstance->c2_sfEvent = CALL_EVENT;
  _SFD_CC_CALL(CHART_ENTER_DURING_FUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  c2_hoistedGlobal = *c2_b_vel_rw;
  c2_b_hoistedGlobal = *c2_b_vel_lw;
  c2_vel_rw = c2_hoistedGlobal;
  c2_vel_lw = c2_b_hoistedGlobal;
  _SFD_SYMBOL_SCOPE_PUSH_EML(0U, 4U, 4U, c2_debug_family_names,
    c2_debug_family_var_map);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargin, 0U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML_IMPORTABLE(&c2_nargout, 1U, c2_sf_marshallOut,
    c2_sf_marshallIn);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_vel_rw, 2U, c2_sf_marshallOut);
  _SFD_SYMBOL_SCOPE_ADD_EML(&c2_vel_lw, 3U, c2_sf_marshallOut);
  CV_EML_FCN(0, 0);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 2);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, 3);
  c2_u = 0.0;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
  c2_b_u = c2_vel_rw;
  c2_b_y = NULL;
  sf_mex_assign(&c2_b_y, sf_mex_create("y", &c2_b_u, 0, 0U, 0U, 0U, 0), false);
  c2_c_u = c2_vel_lw;
  c2_c_y = NULL;
  sf_mex_assign(&c2_c_y, sf_mex_create("y", &c2_c_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_call_debug(sfGlobalDebugInstanceStruct, "setTargetVelocityPioneer", 0U,
                    3U, 14, c2_y, 14, c2_b_y, 14, c2_c_y);
  _SFD_EML_CALL(0U, chartInstance->c2_sfEvent, -3);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CC_CALL(EXIT_OUT_OF_FUNCTION_TAG, 1U, chartInstance->c2_sfEvent);
  _SFD_SYMBOL_SCOPE_POP();
  _SFD_CHECK_FOR_STATE_INCONSISTENCY
    (_simulink_SetTargetPioneerVelocityMachineNumber_,
     chartInstance->chartNumber, chartInstance->instanceNumber);
}

static void initSimStructsc2_simulink_SetTargetPioneerVelocity
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
{
  (void)chartInstance;
}

static void init_script_number_translation(uint32_T c2_machineNumber, uint32_T
  c2_chartNumber, uint32_T c2_instanceNumber)
{
  (void)c2_machineNumber;
  (void)c2_chartNumber;
  (void)c2_instanceNumber;
}

static const mxArray *c2_sf_marshallOut(void *chartInstanceVoid, void *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  real_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(real_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 0, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static real_T c2_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  real_T c2_y;
  real_T c2_d0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_d0, 1, 0, 0U, 0, 0U, 0);
  c2_y = c2_d0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_nargout;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  real_T c2_y;
  SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c2_nargout = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_nargout), &c2_thisId);
  sf_mex_destroy(&c2_nargout);
  *(real_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

const mxArray
  *sf_c2_simulink_SetTargetPioneerVelocity_get_eml_resolved_functions_info(void)
{
  const mxArray *c2_nameCaptureInfo = NULL;
  c2_nameCaptureInfo = NULL;
  sf_mex_assign(&c2_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1U, 0U, 2, 0, 1), false);
  return c2_nameCaptureInfo;
}

static const mxArray *c2_b_sf_marshallOut(void *chartInstanceVoid, void
  *c2_inData)
{
  const mxArray *c2_mxArrayOutData = NULL;
  int32_T c2_u;
  const mxArray *c2_y = NULL;
  SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c2_mxArrayOutData = NULL;
  c2_u = *(int32_T *)c2_inData;
  c2_y = NULL;
  sf_mex_assign(&c2_y, sf_mex_create("y", &c2_u, 6, 0U, 0U, 0U, 0), false);
  sf_mex_assign(&c2_mxArrayOutData, c2_y, false);
  return c2_mxArrayOutData;
}

static int32_T c2_b_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  int32_T c2_y;
  int32_T c2_i0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_i0, 1, 6, 0U, 0, 0U, 0);
  c2_y = c2_i0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void c2_b_sf_marshallIn(void *chartInstanceVoid, const mxArray
  *c2_mxArrayInData, const char_T *c2_varName, void *c2_outData)
{
  const mxArray *c2_b_sfEvent;
  const char_T *c2_identifier;
  emlrtMsgIdentifier c2_thisId;
  int32_T c2_y;
  SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  chartInstance = (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *)
    chartInstanceVoid;
  c2_b_sfEvent = sf_mex_dup(c2_mxArrayInData);
  c2_identifier = c2_varName;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c2_b_sfEvent),
    &c2_thisId);
  sf_mex_destroy(&c2_b_sfEvent);
  *(int32_T *)c2_outData = c2_y;
  sf_mex_destroy(&c2_mxArrayInData);
}

static uint8_T c2_c_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_b_is_active_c2_simulink_SetTargetPioneerVelocity, const char_T
   *c2_identifier)
{
  uint8_T c2_y;
  emlrtMsgIdentifier c2_thisId;
  c2_thisId.fIdentifier = c2_identifier;
  c2_thisId.fParent = NULL;
  c2_y = c2_d_emlrt_marshallIn(chartInstance, sf_mex_dup
    (c2_b_is_active_c2_simulink_SetTargetPioneerVelocity), &c2_thisId);
  sf_mex_destroy(&c2_b_is_active_c2_simulink_SetTargetPioneerVelocity);
  return c2_y;
}

static uint8_T c2_d_emlrt_marshallIn
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance, const
   mxArray *c2_u, const emlrtMsgIdentifier *c2_parentId)
{
  uint8_T c2_y;
  uint8_T c2_u0;
  (void)chartInstance;
  sf_mex_import(c2_parentId, sf_mex_dup(c2_u), &c2_u0, 1, 3, 0U, 0, 0U, 0);
  c2_y = c2_u0;
  sf_mex_destroy(&c2_u);
  return c2_y;
}

static void init_dsm_address_info
  (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance)
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

void sf_c2_simulink_SetTargetPioneerVelocity_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(4107055122U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(544978377U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(429884398U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(1067582573U);
}

mxArray *sf_c2_simulink_SetTargetPioneerVelocity_get_autoinheritance_info(void)
{
  const char *autoinheritanceFields[] = { "checksum", "inputs", "parameters",
    "outputs", "locals" };

  mxArray *mxAutoinheritanceInfo = mxCreateStructMatrix(1,1,5,
    autoinheritanceFields);

  {
    mxArray *mxChecksum = mxCreateString("xoRV6oX97dMjPglC4R0dMC");
    mxSetField(mxAutoinheritanceInfo,0,"checksum",mxChecksum);
  }

  {
    const char *dataFields[] = { "size", "type", "complexity" };

    mxArray *mxData = mxCreateStructMatrix(1,2,3,dataFields);

    {
      mxArray *mxSize = mxCreateDoubleMatrix(1,2,mxREAL);
      double *pr = mxGetPr(mxSize);
      pr[0] = (double)(1);
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
      pr[0] = (double)(1);
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
    mxSetField(mxAutoinheritanceInfo,0,"inputs",mxData);
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"parameters",mxCreateDoubleMatrix(0,0,
                mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"outputs",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  {
    mxSetField(mxAutoinheritanceInfo,0,"locals",mxCreateDoubleMatrix(0,0,mxREAL));
  }

  return(mxAutoinheritanceInfo);
}

mxArray *sf_c2_simulink_SetTargetPioneerVelocity_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c2_simulink_SetTargetPioneerVelocity_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c2_simulink_SetTargetPioneerVelocity
  (void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  const char *infoEncStr[] = {
    "100 S'type','srcId','name','auxInfo'{{M[8],M[0],T\"is_active_c2_simulink_SetTargetPioneerVelocity\",}}"
  };

  mxArray *mxVarInfo = sf_mex_decode_encoded_mx_struct_array(infoEncStr, 1, 10);
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c2_simulink_SetTargetPioneerVelocity_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static void chart_debug_initialization(SimStruct *S, unsigned int
  fullDebuggerInitialization)
{
  if (!sim_mode_is_rtw_gen(S)) {
    SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
    chartInstance = (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *)
      chartInfo->chartInstance;
    if (ssIsFirstInitCond(S) && fullDebuggerInitialization==1) {
      /* do this only if simulation is starting */
      {
        unsigned int chartAlreadyPresent;
        chartAlreadyPresent = sf_debug_initialize_chart
          (sfGlobalDebugInstanceStruct,
           _simulink_SetTargetPioneerVelocityMachineNumber_,
           2,
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
          _SFD_SET_DATA_PROPS(0,1,1,0,"vel_rw");
          _SFD_SET_DATA_PROPS(1,1,1,0,"vel_lw");
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
        _SFD_CV_INIT_EML_FCN(0,0,"eML_blk_kernel",0,-1,155);
        _SFD_SET_DATA_COMPILED_PROPS(0,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)NULL);
        _SFD_SET_DATA_COMPILED_PROPS(1,SF_DOUBLE,0,NULL,0,0,0,0.0,1.0,0,0,
          (MexFcnForType)c2_sf_marshallOut,(MexInFcnForType)NULL);

        {
          real_T *c2_vel_rw;
          real_T *c2_vel_lw;
          c2_vel_lw = (real_T *)ssGetInputPortSignal(chartInstance->S, 1);
          c2_vel_rw = (real_T *)ssGetInputPortSignal(chartInstance->S, 0);
          _SFD_SET_DATA_VALUE_PTR(0U, c2_vel_rw);
          _SFD_SET_DATA_VALUE_PTR(1U, c2_vel_lw);
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
  return "FpdSdvBEC5zxaghndKSeDH";
}

static void sf_opaque_initialize_c2_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  chart_debug_initialization
    (((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar
     )->S,0);
  initialize_params_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
  initialize_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_enable_c2_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  enable_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_disable_c2_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  disable_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

static void sf_opaque_gateway_c2_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  sf_gateway_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

extern const mxArray*
  sf_internal_get_sim_state_c2_simulink_SetTargetPioneerVelocity(SimStruct* S)
{
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
  ChartInfoStruct * chartInfo = (ChartInfoStruct *)(crtInfo->instanceInfo);
  mxArray *plhs[1] = { NULL };

  mxArray *prhs[4];
  int mxError = 0;
  prhs[0] = mxCreateString("chart_simctx_raw2high");
  prhs[1] = mxCreateDoubleScalar(ssGetSFuncBlockHandle(S));
  prhs[2] = (mxArray*) get_sim_state_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*)
     chartInfo->chartInstance);        /* raw sim ctx */
  prhs[3] = (mxArray*)
    sf_get_sim_state_info_c2_simulink_SetTargetPioneerVelocity();/* state var info */
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

extern void sf_internal_set_sim_state_c2_simulink_SetTargetPioneerVelocity
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
    sf_get_sim_state_info_c2_simulink_SetTargetPioneerVelocity();/* state var info */
  mxError = sf_mex_call_matlab(1, plhs, 3, prhs, "sfprivate");
  mxDestroyArray(prhs[0]);
  mxDestroyArray(prhs[1]);
  mxDestroyArray(prhs[2]);
  if (mxError || plhs[0] == NULL) {
    sf_mex_error_message("Stateflow Internal Error: \nError calling 'chart_simctx_high2raw'.\n");
  }

  set_sim_state_c2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*)
     chartInfo->chartInstance, mxDuplicateArray(plhs[0]));
  mxDestroyArray(plhs[0]);
}

static const mxArray*
  sf_opaque_get_sim_state_c2_simulink_SetTargetPioneerVelocity(SimStruct* S)
{
  return sf_internal_get_sim_state_c2_simulink_SetTargetPioneerVelocity(S);
}

static void sf_opaque_set_sim_state_c2_simulink_SetTargetPioneerVelocity
  (SimStruct* S, const mxArray *st)
{
  sf_internal_set_sim_state_c2_simulink_SetTargetPioneerVelocity(S, st);
}

static void sf_opaque_terminate_c2_simulink_SetTargetPioneerVelocity(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*)
                    chartInstanceVar)->S;
    ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)(ssGetUserData(S));
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_simulink_SetTargetPioneerVelocity_optimization_info();
    }

    finalize_c2_simulink_SetTargetPioneerVelocity
      ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
    utFree((void *)chartInstanceVar);
    if (crtInfo != NULL) {
      utFree((void *)crtInfo);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_init_subchart_simstructs(void *chartInstanceVar)
{
  initSimStructsc2_simulink_SetTargetPioneerVelocity
    ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*) chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c2_simulink_SetTargetPioneerVelocity(SimStruct *
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
    initialize_params_c2_simulink_SetTargetPioneerVelocity
      ((SFc2_simulink_SetTargetPioneerVelocityInstanceStruct*)
       (chartInfo->chartInstance));
  }
}

static void mdlSetWorkWidths_c2_simulink_SetTargetPioneerVelocity(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
    mxArray *infoStruct =
      load_simulink_SetTargetPioneerVelocity_optimization_info();
    int_T chartIsInlinable =
      (int_T)sf_is_chart_inlinable(sf_get_instance_specialization(),infoStruct,2);
    ssSetStateflowIsInlinable(S,chartIsInlinable);
    ssSetRTWCG(S,sf_rtw_info_uint_prop(sf_get_instance_specialization(),
                infoStruct,2,"RTWCG"));
    ssSetEnableFcnIsTrivial(S,1);
    ssSetDisableFcnIsTrivial(S,1);
    ssSetNotMultipleInlinable(S,sf_rtw_info_uint_prop
      (sf_get_instance_specialization(),infoStruct,2,
       "gatewayCannotBeInlinedMultipleTimes"));
    sf_update_buildInfo(sf_get_instance_specialization(),infoStruct,2);
    if (chartIsInlinable) {
      ssSetInputPortOptimOpts(S, 0, SS_REUSABLE_AND_LOCAL);
      ssSetInputPortOptimOpts(S, 1, SS_REUSABLE_AND_LOCAL);
      sf_mark_chart_expressionable_inputs(S,sf_get_instance_specialization(),
        infoStruct,2,2);
    }

    {
      unsigned int outPortIdx;
      for (outPortIdx=1; outPortIdx<=0; ++outPortIdx) {
        ssSetOutputPortOptimizeInIR(S, outPortIdx, 1U);
      }
    }

    {
      unsigned int inPortIdx;
      for (inPortIdx=0; inPortIdx < 2; ++inPortIdx) {
        ssSetInputPortOptimizeInIR(S, inPortIdx, 1U);
      }
    }

    sf_set_rtw_dwork_info(S,sf_get_instance_specialization(),infoStruct,2);
    ssSetHasSubFunctions(S,!(chartIsInlinable));
  } else {
  }

  ssSetOptions(S,ssGetOptions(S)|SS_OPTION_WORKS_WITH_CODE_REUSE);
  ssSetChecksum0(S,(3255657595U));
  ssSetChecksum1(S,(2552733364U));
  ssSetChecksum2(S,(1503046394U));
  ssSetChecksum3(S,(701076076U));
  ssSetmdlDerivatives(S, NULL);
  ssSetExplicitFCSSCtrl(S,1);
  ssSupportsMultipleExecInstances(S,1);
}

static void mdlRTW_c2_simulink_SetTargetPioneerVelocity(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlStart_c2_simulink_SetTargetPioneerVelocity(SimStruct *S)
{
  SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *chartInstance;
  ChartRunTimeInfo * crtInfo = (ChartRunTimeInfo *)utMalloc(sizeof
    (ChartRunTimeInfo));
  chartInstance = (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct *)
    utMalloc(sizeof(SFc2_simulink_SetTargetPioneerVelocityInstanceStruct));
  memset(chartInstance, 0, sizeof
         (SFc2_simulink_SetTargetPioneerVelocityInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.terminateChart =
    sf_opaque_terminate_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.enableChart =
    sf_opaque_enable_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.disableChart =
    sf_opaque_disable_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.mdlStart =
    mdlStart_c2_simulink_SetTargetPioneerVelocity;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c2_simulink_SetTargetPioneerVelocity;
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

void c2_simulink_SetTargetPioneerVelocity_method_dispatcher(SimStruct *S, int_T
  method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_c2_simulink_SetTargetPioneerVelocity(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c2_simulink_SetTargetPioneerVelocity(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c2_simulink_SetTargetPioneerVelocity(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c2_simulink_SetTargetPioneerVelocity_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
