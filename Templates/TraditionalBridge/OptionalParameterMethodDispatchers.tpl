<CODEGEN_FILENAME><INTERFACE_NAME>MethodDispatchers.dbl</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_CODEGEN_VERSION>5.4.6</REQUIRES_CODEGEN_VERSION>
;//****************************************************************************
;//
;// Title:       MethodDispatchers.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates dispatcher classes for exposed methods that uses the
;//              RCB API to call the underlying methods. This is done in order
;//              to have support for optional parameters.
;//
;// Copyright (c) 2018, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;;*****************************************************************************
;;
;; Title:       <INTERFACE_NAME>MethodDispatchers.dbl
;;
;; Description: Dispatcher classes for exposed methods that uses the RCB API
;;              to call the underlying methods. This is done in order to have
;;              support for optional parameters.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import Json
import Harmony.TraditionalBridge
import System.Collections
import <MODELS_NAMESPACE>

.ifdef DBLV11
import System.Text.Json
.define JSON_ELEMENT @JsonElement
.else
.define JSON_ELEMENT @JsonValue
.endc

namespace <NAMESPACE>.<INTERFACE_NAME>

<METHOD_LOOP>

    ;;-------------------------------------------------------------------------
    ;;; <summary>
    ;;; Dispatcher for method <INTERFACE_NAME>.<METHOD_NAME>
    ;;; </summary>
    public class <METHOD_NAME>_Dispatcher extends RoutineStub

  <IF STRUCTURE_PARAMETERS>
        ;;Declare handles for metadata objects for structure parameters
        <PARAMETER_LOOP>
        <IF STRUCTURE>
        <IF FIRST_INSTANCE_OF_STRUCTURE>
        private m<ParameterStructureNoplural>Metadata, @DataObjectMetadataBase
        </IF FIRST_INSTANCE_OF_STRUCTURE>
        </IF STRUCTURE>
        </PARAMETER_LOOP>

        public method <METHOD_NAME>_Dispatcher
        proc
            ;;Initialize the meta data for any data objects that are used by parameters to the method
            <PARAMETER_LOOP>
            <IF STRUCTURE>
            <IF FIRST_INSTANCE_OF_STRUCTURE>
            m<ParameterStructureNoplural>Metadata = DataObjectMetadataBase.LookupType("<ParameterStructureNoplural>")
            </IF FIRST_INSTANCE_OF_STRUCTURE>
            </IF STRUCTURE>
            </PARAMETER_LOOP>
        endmethod

  </IF STRUCTURE_PARAMETERS>
        ;;Declare our RCB ID
        private mRcbid, D_HANDLE

        protected override method DispatchInternal, void
            required in name,       string
            required in callFrame,  JSON_ELEMENT
            required in serializer, @DispatchSerializer
            required in dispatcher, @RoutineDispatcher
            record
                requestId,          int
                arguments,          JSON_ELEMENT
                argumentDefinition, @ArgumentDataDefinition

<COUNTER_1_RESET>
<PARAMETER_LOOP>
    <COUNTER_1_INCREMENT>
;//
;//=========================================================================================================================
;// Declare variables for arguments
;//
                ;;Argument <COUNTER_1_VALUE> (<PARAMETER_REQUIRED> <PARAMETER_DIRECTION> <PARAMETER_NAME> <IF COLLECTION_ARRAY>[*]</IF COLLECTION_ARRAY><IF COLLECTION_HANDLE>memory handle collection of </IF COLLECTION_HANDLE><IF COLLECTION_ARRAYLIST>ArrayList collection of </IF COLLECTION_ARRAYLIST><IF STRUCTURE>structure </IF STRUCTURE><IF ENUM>enum </IF ENUM><IF STRUCTURE>@<ParameterStructureNoplural><ELSE><PARAMETER_DEFINITION></IF STRUCTURE><IF DATE> <PARAMETER_DATE_FORMAT> date</IF DATE><IF TIME> <PARAMETER_DATE_FORMAT> time</IF TIME><IF REFERENCE> passed by REFERENCE</IF REFERENCE><IF VALUE> passed by VALUE</IF VALUE><IF DATATABLE> returned as DataTable</IF DATATABLE>)
    <IF COLLECTION>
        <IF IN_OR_INOUT>
                arg<COUNTER_1_VALUE>Array,          JSON_ELEMENT
        </IF IN_OR_INOUT>
        <IF COLLECTION_ARRAY>
                arg<COUNTER_1_VALUE>Handle,         D_HANDLE
                arg<COUNTER_1_VALUE>HandlePos,      int
        </IF COLLECTION_ARRAY>
        <IF COLLECTION_HANDLE>
                arg<COUNTER_1_VALUE>Handle,         D_HANDLE
                arg<COUNTER_1_VALUE>HandlePos,      int
        </IF COLLECTION_HANDLE>
        <IF COLLECTION_ARRAYLIST>
                arg<COUNTER_1_VALUE>,               @ArrayList
        </IF COLLECTION_ARRAYLIST>
    <ELSE>
                arg<COUNTER_1_VALUE>,               a<PARAMETER_SIZE>
                arg<COUNTER_1_VALUE>Passed,         boolean
    </IF COLLECTION>
</PARAMETER_LOOP>
;//
;//=========================================================================================================================
;// Declare variable for function return value
;//
<IF FUNCTION>
                returnValue,        <IF HATVAL>i4<ELSE><METHOD_RETURN_TYPE></IF HATVAL>
</IF FUNCTION>
;//=========================================================================================================================
            endrecord
<COUNTER_1_RESET>
<PARAMETER_LOOP>
  <COUNTER_1_INCREMENT>
  <IF COLLECTION_ARRAY>

            ;;Temp structure tempstr<COUNTER_1_VALUE>
            structure tempstr<COUNTER_1_VALUE>
                arry, <IF STRUCTURE>@<ParameterStructureNoplural><ELSE>[1]<PARAMETER_DEFINITION></IF STRUCTURE>
            endstructure
  </IF COLLECTION_ARRAY>
</PARAMETER_LOOP>

        proc
;//
;//=========================================================================================================================
;// Assign values to argument variables
;//
            ;;------------------------------------------------------------
            ;;Process inbound arguments

<IF PARAMETERS>
            arguments = callFrame.GetProperty("params")
<ELSE>
            ;;There are no inbound arguments to process
</IF PARAMETERS>
;//

            RCBInit(name, <METHOD_PARAMETERS> + 1, mRcbid)

            try
            begin
<COUNTER_1_RESET>
<COUNTER_2_RESET>
<IF FUNCTION>
    <IF HATVAL>
    <ELSE>
                rcb_setarg(mRcbid, returnValue, 1)
                <COUNTER_2_INCREMENT>
    </IF HATVAL>
</IF FUNCTION>
            <PARAMETER_LOOP>
            <COUNTER_1_INCREMENT>
                <IF OUT>RCBOutArg<ELSE>RCBArg</IF>(<COUNTER_1_VALUE> + <COUNTER_2_VALUE>, arguments[<COUNTER_1_VALUE>], FieldDataType.<PARAMETER_TYPE>Field, arg<COUNTER_1_VALUE>, mRcbid, 0<PARAMETER_PRECISION>, arg<COUNTER_1_VALUE>Passed)
            </PARAMETER_LOOP>
                <IF FUNCTION>
                    <IF HATVAL>
                returnValue = %rcb_call(mRcbid)
                RCBSerializeArg(0, true, FieldDataType.IntegerField, ^a(returnValue), %size(returnValue), 0, serializer)
                    <ELSE>
                rcb_call(mRcbid)
                RCBSerializeArg(0, true, FieldDataType.IntegerField, ^a(returnValue), %size(returnValue), 0, serializer)
                    </IF HATVAL>
                <ELSE>
                rcb_call(mRcbid)
                </IF FUNCTION>
            <COUNTER_1_RESET>
            <PARAMETER_LOOP>
            <COUNTER_1_INCREMENT>
            <IF OUT_OR_INOUT>
                RCBSerializeArg(<COUNTER_1_VALUE>, arg<COUNTER_1_VALUE>Passed, FieldDataType.<PARAMETER_TYPE>Field, arg<COUNTER_1_VALUE>, <PARAMETER_SIZE>, 0<PARAMETER_PRECISION>, serializer)
            </IF OUT_OR_INOUT>
            </PARAMETER_LOOP>
            end
            finally
            begin
                ;;Clear out the rcb handle to prevent a dangling pointer issue!
                mRcbid = %rcb_create(<METHOD_PARAMETERS> + 1, DM_STATIC, mRcbid)
            end
            endtry
        endmethod

    endclass
</METHOD_LOOP>

endnamespace