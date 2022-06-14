<CODEGEN_FILENAME><INTERFACE_NAME>Dispatcher.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.8.5</REQUIRES_CODEGEN_VERSION>
;//****************************************************************************
;//
;// Title:       InterfaceDispatcher.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Creates a class that declares dispacher classes for exposed methods
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
;; Title:       <INTERFACE_NAME>Dispatcher.dbl
;;
;; Description: Declares dispacher classes for exposed methods
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import Harmony.TraditionalBridge
import <NAMESPACE>.<INTERFACE_NAME>

namespace <NAMESPACE>

    public partial class <INTERFACE_NAME>Dispatcher extends RoutineDispatcher

        public method <INTERFACE_NAME>Dispatcher
        proc
<IF DEFINED_ENABLE_BRIDGE_SAMPLE_DISPATCHERS>
            ;;Declare dispatcher classes fotr the sample methods
            mDispatchStubs.Add("AddTwoNumbers", new AddTwoNumbersDispatcher())
            mDispatchStubs.Add("GetEnvironment", new GetEnvironmentDispatcher())
            mDispatchStubs.Add("GetLogicalName", new GetLogicalNameDispatcher())

</IF DEFINED_ENABLE_BRIDGE_SAMPLE_DISPATCHERS>
            ;;Declare dispatcher classes for the '<INTERFACE_NAME>' interface methods
            <METHOD_LOOP>
            mDispatchStubs.Add("<METHOD_NAME>", new <METHOD_NAME>_Dispatcher())
            </METHOD_LOOP>
<IF DEFINED_ENABLE_BRIDGE_INIT>
            ;;Initialize all data object metadata
            this.initMetaData()
</IF DEFINED_ENABLE_BRIDGE_INIT>
        endmethod

    endclass

endnamespace