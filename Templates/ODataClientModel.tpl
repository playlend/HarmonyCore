<CODEGEN_FILENAME><StructureNoplural>.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.6</REQUIRES_CODEGEN_VERSION>
<REQUIRES_OPTION>TF</REQUIRES_OPTION>
<CODEGEN_FOLDER>Models</CODEGEN_FOLDER>
;//****************************************************************************
;//
;// Title:       ODataClientModel.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Creates model classes suitable for use in OData clients.
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
;; Title:       <StructureNoplural>.dbl
;;
;; Description: OData model class representing data defined by the repository
;;              structure <STRUCTURE_NOALIAS> and from the data file <FILE_NAME>.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import Newtonsoft.Json
import System.Collections.Generic

namespace <NAMESPACE>

    {JsonObject(ItemNullValueHandling = NullValueHandling.Ignore)}
    public partial class <StructureNoplural>

<FIELD_LOOP>
  <IF CUSTOM_NOT_HARMONY_EXCLUDE>
        ;;; <summary>
        ;;; <FIELD_DESC>
        ;;; </summary>
    <IF CUSTOM_HARMONY_AS_STRING>
        public readwrite property <FieldSqlname>, String
    <ELSE>
        public readwrite property <FieldSqlname>, <HARMONYCORE_FIELD_DATATYPE>
    </IF CUSTOM_HARMONY_AS_STRING>

  </IF CUSTOM_NOT_HARMONY_EXCLUDE>
</FIELD_LOOP>

.region "Relationships to other entities"

<IF STRUCTURE_RELATIONS>
  <RELATION_LOOP_RESTRICTED>
    <COUNTER_1_INCREMENT>
;//
;//
;//
    <IF MANY_TO_ONE_TO_MANY>
        ;;; <summary>
        ;;; Relationship (Type A)
        ;;; <STRUCTURE_NOPLURAL>.<RELATION_FROMKEY> (one) --> (one) --> (many) <RELATION_TOSTRUCTURE_NOPLURAL>.<RELATION_TOKEY>
        ;;; </summary>
        public readwrite property <HARMONYCORE_RELATION_NAME>, @<RelationTostructureNoplural>
    </IF MANY_TO_ONE_TO_MANY>
;//
;//
;//
    <IF ONE_TO_ONE_TO_ONE>
        ;;; <summary>
        ;;; Relationship (Type B)
        ;;; <STRUCTURE_NOPLURAL>.<RELATION_FROMKEY> (one) --> (one) --> (one) <RELATION_TOSTRUCTURE_NOPLURAL>.<RELATION_TOKEY>
        ;;; </summary>
        public readwrite property <HARMONYCORE_RELATION_NAME>, @<RelationTostructureNoplural>
    </IF ONE_TO_ONE_TO_ONE>
;//
;//
;//
    <IF ONE_TO_ONE>
        ;;; <summary>
        ;;; Relationship (Type C)
        ;;; <STRUCTURE_NOPLURAL>.<RELATION_FROMKEY> (one) --> (one) <RELATION_TOSTRUCTURE_NOPLURAL>.<RELATION_TOKEY>
        ;;; </summary>
        public readwrite property <HARMONYCORE_RELATION_NAME>, @<RelationTostructureNoplural>
    </IF ONE_TO_ONE>
;//
;//
;//
    <IF ONE_TO_MANY_TO_ONE>
        ;;; <summary>
        ;;; Relationship (Type D)
        ;;; <STRUCTURE_NOPLURAL>.<RELATION_FROMKEY> (one) <-> (many) <RELATION_TOSTRUCTURE_NOPLURAL>.<RELATION_TOKEY>
        ;;; </summary>
        public readwrite property <HARMONYCORE_RELATION_NAME>, @ICollection<<RelationTostructureNoplural>>
    </IF ONE_TO_MANY_TO_ONE>
;//
;//
;//
    <IF ONE_TO_MANY>
        ;;; <summary>
        ;;; Relationship (Type E)
        ;;; <STRUCTURE_NOPLURAL>.<RELATION_FROMKEY> (one) --> (many) <RELATION_TOSTRUCTURE_NOPLURAL>.<RELATION_TOKEY>
        ;;; </summary>
        public readwrite property <HARMONYCORE_RELATION_NAME>, @ICollection<<RelationTostructureNoplural>>
    </IF ONE_TO_MANY>

  </RELATION_LOOP_RESTRICTED>
</IF STRUCTURE_RELATIONS>
.endregion

    endclass

    public class OData<StructureNoplural>Single
        
        {JsonProperty("odata.metadata")}
        public readwrite property Metadata, string

        {JsonProperty("value")}
        public readwrite property Value, <IF STRUCTURE_HAS_UNIQUE_KEY>@<StructureNoplural><ELSE>@List<<StructureNoplural>></IF>

    endclass

    public class OData<StructurePlural>Multiple
        
        {JsonProperty("odata.metadata")}
        public readwrite property Metadata, string

        {JsonProperty("value")}
        public readwrite property Value, @List<<StructureNoplural>>

    endclass

endnamespace
