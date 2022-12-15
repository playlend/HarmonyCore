<CODEGEN_FILENAME><StructureNoplural>.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.8.5</REQUIRES_CODEGEN_VERSION>
;//****************************************************************************
;//
;// Title:       ODataModel.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to define structure based Data Object with CLR types
;//
;// Copyright (c) 2012, Synergex International, Inc. All rights reserved.
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
;; Description: Data model representing data defined by the repository
;;              structure <STRUCTURE_NOALIAS><IF STRUCTURE_FILES> and from the data file <FILE_NAME></IF STRUCTURE_FILES>.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import System
import System.Collections.Generic
import System.ComponentModel.DataAnnotations
import System.Text
import Harmony.Core
import Harmony.Core.Converters
<IF DEFINED_ENABLE_FIELD_SECURITY>
import Harmony.OData
</IF DEFINED_ENABLE_FIELD_SECURITY>
import Harmony.Core.Context
import Harmony.Core.FileIO
import Microsoft.Extensions.DependencyInjection

namespace <NAMESPACE>

    <IF DEFINED_ENABLE_NEWTONSOFT>
    {Newtonsoft.Json.JsonObject(Newtonsoft.Json.MemberSerialization.OptIn)}
    </IF>
    public partial class <StructureNoplural> extends DataObjectBase

        ;;make the record available and a copy
        private mSynergyData, str<StructureNoplural>
        private mOriginalSynergyData, str<StructureNoplural>
        protected mGlobalRFA  ,a10

        private static sMetadata, @<StructureNoplural>Metadata

.region "Constructors"

        static method <StructureNoplural>
        proc
            sMetadata = new <StructureNoplural>Metadata()
            DataObjectMetadataBase.MetadataLookup.TryAdd(^typeof(<StructureNoplural>), sMetadata)
        endmethod

        ;;; <summary>
        ;;;  Constructor, initialise the base fields
        ;;; </summary>
        public method <StructureNoplural>
            parent()
        proc
            init mSynergyData, mOriginalSynergyData
        endmethod

        ;;; <summary>
        ;;;  Alternate Constructor, accepts the structured data
        ;;; </summary>
        public method <StructureNoplural>
            required in inData, a
            required in inGrfa, a
            parent()
        proc
            mSynergyData = mOriginalSynergyData = inData
            mGlobalRFA = inGrfa
        endmethod

.endregion

.region "Attributes of this entity"

<IF STRUCTURE_RELATIVE>
        ;;; <summary>
        ;;; Record number
        ;;; </summary>
        public readwrite property RecordNumber, int

</IF STRUCTURE_RELATIVE>
<COUNTER_1_RESET>
<FIELD_LOOP>
    <IF CUSTOM_NOT_HARMONY_EXCLUDE>
        ;;; <summary>
        ;;; <FIELD_DESC_DOUBLE>
        ;;; </summary>
;//
;// Field property attributes
;//
      <IF ONLY_PKSEGMENT>
        {Key}
      </IF ONLY_PKSEGMENT>
      <IF REQUIRED>
        {Required(ErrorMessage="<FIELD_DESC_DOUBLE> is required. ")}
      </IF REQUIRED>
      <IF HARMONYCORE_CUSTOM_FIELD_DATATYPE>
;//We can't add validation attributes for fields with custom data types!!!
      <ELSE>
        <IF ALPHA>
        {StringLength(<FIELD_SIZE>, ErrorMessage="<FIELD_DESC_DOUBLE> cannot exceed <FIELD_SIZE> characters. ")}
        </IF ALPHA>
        <IF DECIMAL>
          <IF CUSTOM_NOT_HARMONY_AS_STRING>
        {Range(<FIELD_MINVALUE>,<FIELD_MAXVALUE>, ErrorMessage="<FIELD_DESC_DOUBLE> must be between <FIELD_MINVALUE> and <FIELD_MAXVALUE>. ")}
          </IF CUSTOM_NOT_HARMONY_AS_STRING>
        </IF DECIMAL>
        <IF INTEGER>
        {Range(<FIELD_MINVALUE>,<FIELD_MAXVALUE>, ErrorMessage="<FIELD_DESC_DOUBLE> must be between <FIELD_MINVALUE> and <FIELD_MAXVALUE>. ")}
        </IF INTEGER>
      </IF HARMONYCORE_CUSTOM_FIELD_DATATYPE>
;//
;// Field property
;//
      <IF DEFINED_ENABLE_NEWTONSOFT>
        {Newtonsoft.Json.JsonProperty}
      </IF>
      <IF DEFINED_ENABLE_FIELD_SECURITY>
        <IF CUSTOM_HARMONY_AUTHENTICATE>
        {AuthorizeField}
        </IF CUSTOM_HARMONY_AUTHENTICATE>
        <IF HARMONY_ROLES>
        {AuthorizeField("<HARMONY_ROLES>")}
        </IF HARMONY_ROLES>
      </IF DEFINED_ENABLE_FIELD_SECURITY>
      <COUNTER_1_INCREMENT>
      <IF CUSTOM_HARMONY_AS_STRING>
        public property <FieldSqlname>, String
      <ELSE>
        public property <FieldSqlname>, <HARMONYCORE_FIELD_DATATYPE>
      </IF CUSTOM_HARMONY_AS_STRING>
;//
;// Field property get method
;//
            method get
            proc
      <IF HARMONYCORE_CUSTOM_FIELD>
                mreturn <HARMONYCORE_CUSTOM_FIELD_TYPE>Converter.Convert(mSynergyData.<field_original_name_modified>)
      <ELSE ALPHA OR USER>
                mreturn (<FIELD_SNTYPE>)SynergyAlphaConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, ^null, ^null)
      <ELSE DATE>
        <IF CUSTOM_HARMONY_AS_STRING>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XXXX-XX-XX")
        <ELSE DATE_YYYYPP>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XXXX/XX")
        <ELSE DATE_YYPP>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XX/XX")
        <ELSE>
                mreturn (<FIELD_SNTYPE>)SynergyDecimalDateConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, "<FIELD_CLASS>", ^null)
        </IF>
      <ELSE TIME_HHMM>
        <IF CUSTOM_HARMONY_AS_STRING>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XX:XX")
        <ELSE>
                mreturn Convert.ToDateTime(%string(mSynergyData.<field_original_name_modified>,"XX:XX"))
        </IF CUSTOM_HARMONY_AS_STRING>
      <ELSE TIME_HHMMSS>
        <IF CUSTOM_HARMONY_AS_STRING>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XX:XX:XX")
        <ELSE>
                mreturn Convert.ToDateTime(%string(mSynergyData.<field_original_name_modified>,"XX:XX:XX"))
        </IF CUSTOM_HARMONY_AS_STRING>
      <ELSE DECIMAL>
        <IF CUSTOM_HARMONY_AS_STRING>
          <IF PRECISION>
                mreturn %string(SynergyImpliedDecimalConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, "DECIMALPLACES#<FIELD_PRECISION>", ^null),"<FIELD_FORMATSTRING>")
          <ELSE>
                mreturn %string(mSynergyData.<field_original_name_modified>,"<FIELD_FORMATSTRING>")
          </IF PRECISION>
        <ELSE>
          <IF PRECISION>
                mreturn (<FIELD_SNTYPE>)SynergyImpliedDecimalConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, "DECIMALPLACES#<FIELD_PRECISION>", ^null)
          <ELSE>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
          </IF PRECISION>
        </IF CUSTOM_HARMONY_AS_STRING>
      <ELSE INTEGER OR ENUM>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
      <ELSE BOOLEAN>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
      <ELSE AUTO_SEQUENCE>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
      <ELSE AUTO_TIMESTAMP>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
      <ELSE STRUCTFIELD>
                mreturn (String)mSynergyData.<field_original_name_modified>
      <ELSE BINARY>
                mreturn Convert.ToBase64String(([#]byte)mSynergyData.<field_original_name_modified>)
      </IF>
            endmethod
;//
;// Field property set method
;//
            method set
            proc
      <IF DEFINED_ENABLE_READ_ONLY_PROPERTIES AND READONLY>
                throw new ApplicationException("Property <FieldSqlname> is read only!")
      </IF>
      <IF HARMONYCORE_CUSTOM_FIELD>
                mSynergyData.<field_original_name_modified> = <HARMONYCORE_CUSTOM_FIELD_TYPE>Converter.ConvertBack(value)
      <ELSE ALPHA OR USER>
                mSynergyData.<field_original_name_modified> = (<FIELD_TYPE>)SynergyAlphaConverter.ConvertBack(value<IF UPPERCASE>.ToUpper()</IF UPPERCASE>, ^null, ^null, ^null)
      <ELSE DATE>
        <IF CUSTOM_HARMONY_AS_STRING>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XXXX-XX-XX")
        <ELSE DATE_YYYYPP>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XXXX/XX")
        <ELSE DATE_YYPP>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XX/XX")
        <ELSE>
            SynergyConverter.ConvertBack(value, mSynergyData.<field_original_name_modified>, "<FIELD_CLASS>", ^null)
        </IF>
      <ELSE TIME_HHMM>
        <IF CUSTOM_HARMONY_AS_STRING>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XX:XX")
        <ELSE>
                SynergyConverter.ConvertBack(value, mSynergyData.<field_original_name_modified>, "<FIELD_CLASS>", ^null)
        </IF>
      <ELSE TIME_HHMMSS>
        <IF CUSTOM_HARMONY_AS_STRING>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XX:XX:XX")
        <ELSE>
                SynergyConverter.ConvertBack(value, mSynergyData.<field_original_name_modified>, "<FIELD_CLASS>", ^null)
        </IF>
      <ELSE DECIMAL>
        <IF CUSTOM_HARMONY_AS_STRING>
          <IF PRECISION>
                mSynergyData.<field_original_name_modified> = SynergyImpliedDecimalConverter.ConvertBack(value,"<FIELD_FORMATSTRING>")
          <ELSE>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"<FIELD_FORMATSTRING>")
          </IF>
        <ELSE>
                mSynergyData.<field_original_name_modified> = value
        </IF>
      <ELSE INTEGER OR ENUM>
                mSynergyData.<field_original_name_modified> = <IF ENUM>(<NAMESPACE>.<FIELD_TYPE>)</IF>value
      <ELSE BOOLEAN>
                mSynergyData.<field_original_name_modified> = value
      <ELSE AUTO_SEQUENCE>
                mSynergyData.<field_original_name_modified> = value
      <ELSE AUTO_TIMESTAMP>
                mSynergyData.<field_original_name_modified> = value
      <ELSE STRUCTFIELD>
                mSynergyData.<field_original_name_modified> = value
      <ELSE BINARY>
                mSynergyData.<field_original_name_modified> = (a)Convert.FromBase64String(value)
      </IF>
            endmethod
;//
;// End of field property
;//
        endproperty

    </IF CUSTOM_NOT_HARMONY_EXCLUDE>
</FIELD_LOOP>
.endregion
;//
;//
;//

.region "Other attributes"

        ;;; <summary>
        ;;; Expose the complete synergy record
        ;;; </summary>
        public override property SynergyRecord, a
            method get
            proc
                mreturn mSynergyData
            endmethod
        endproperty

        ;;; <summary>
        ;;; Expose the complete original synergy record
        ;;; </summary>
        public override property OriginalSynergyRecord, a
            method get
            proc
                mreturn mOriginalSynergyData
            endmethod
        endproperty

        ;;; <summary>
        ;;; Metadata describing the public field properties
        ;;; </summary>
        public override property Metadata, @DataObjectMetadataBase
            method get
            proc
                mreturn sMetadata
            endmethod
        endproperty

        public override property GlobalRFA, [#]byte
            method get
            proc
                mreturn mGlobalRFA
            endmethod
            method set
            proc
                mGlobalRFA = value
            endmethod
        endproperty

.endregion

.region "Public methods"

        ;;; <summary>
        ;;;
        ;;; </summary>
        public override method InternalSynergyRecord, void
            targetMethod, @AlphaAction
        proc
            targetMethod(mSynergyData, mGlobalRFA)
        endmethod

        ;;; <summary>
        ;;;
        ;;; </summary>
        public override method InternalGetValues, [#]@object
        proc
            ;;TODO: This should be returning boxed values for each of our fields
            mreturn new Object[<COUNTER_1_VALUE>]
        endmethod

.endregion
;//
;// Relations
;//
<IF DEFINED_ENABLE_RELATIONS>
  <IF STRUCTURE_RELATIONS>

.region "Relationships to other entities"

    <RELATION_LOOP_RESTRICTED>
      <COUNTER_1_INCREMENT>
      <IF DEFINED_ENABLE_NEWTONSOFT>
        {Newtonsoft.Json.JsonProperty(DefaultValueHandling=DefaultValueHandling.Ignore)}
      </IF>
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
.endregion
;//
;// ==========================================================================================
;// DATA VALIDATION
;//

.region "Data validation"

<IF DEFINED_ENABLE_RELATIONS AND STRUCTURE_RELATIONS AND DEFINED_ENABLE_RELATIONS_VALIDATION>
;//=========================================
;// VALIDATION IF RELATIONS ARE ENABLED
;//=========================================
        ;;; <summary>
        ;;; Validate data for relations
        ;;; </summary>
        ;;; <param name="type">Validation type (create, update or delete)</param>
        ;;; <param name="sp">Serices provider</param>
        public override method Validate, void
            required in vType, ValidationType
            required in sp, @IServiceProvider
  <RELATION_LOOP_RESTRICTED>
    <IF VALIDATION_VALUE_PRESENT OR VALIDATION_ALWAYS>
            ;;From key for <HARMONYCORE_RELATION_NAME>
            record rel<RELATION_NUMBER>FromKey
      <COUNTER_1_RESET>
      <FROM_KEY_SEGMENT_LOOP>
        <IF SEG_TYPE_FIELD>
              <segment_name>, <segment_spec>
        <ELSE SEG_TYPE_LITERAL>
          <COUNTER_1_INCREMENT>
              litseg<COUNTER_1_VALUE>, a*, "<SEGMENT_LITVAL>"
        </IF SEG_TYPE_FIELD>
      </FROM_KEY_SEGMENT_LOOP>
            endrecord

            ;;From key for <HARMONYCORE_RELATION_NAME> (no tags)
            record rel<RELATION_NUMBER>FromKeyNoTag
      <COUNTER_1_RESET>
      <FROM_KEY_SEGMENT_LOOP>
        <IF SEG_TYPE_FIELD>
              <segment_name>, <segment_spec>
        </IF SEG_TYPE_FIELD>
      </FROM_KEY_SEGMENT_LOOP>
            endrecord
    </IF VALIDATION_VALUE_PRESENT>
  </RELATION_LOOP_RESTRICTED>
        proc
            ;;No relation validation if the record is being deleted
            if (vType == ValidationType.Delete)
                mreturn

            ;;Get an instance of IDataObjectProvider
            data dataObjectProvider, @IDataObjectProvider, sp.GetService<IDataObjectProvider>()

  <RELATION_LOOP_RESTRICTED>
            ;;--------------------------------------------------------------------------------
            ;;Validate data for relation <RELATION_NUMBER> (<HARMONYCORE_RELATION_NAME>)
    <IF VALIDATION_NONE>

            ;;Validation mode: None
    <ELSE VALIDATION_VALUE_PRESENT>

            ;;Validation mode: ValuePresent

            ;;Populate from key values
      <COUNTER_1_RESET>
      <FROM_KEY_SEGMENT_LOOP>
        <IF SEG_TYPE_FIELD>
            rel<RELATION_NUMBER>FromKey.<segment_name> = mSynergyData.<segment_name>
            rel<RELATION_NUMBER>FromKeyNoTag.<segment_name> = mSynergyData.<segment_name>
        <ELSE SEG_TYPE_LITERAL>
          <COUNTER_1_INCREMENT>
            rel<RELATION_NUMBER>FromKey.litseg<COUNTER_1_VALUE> = "<SEGMENT_LITVAL>"
        </IF SEG_TYPE_FIELD>
      </FROM_KEY_SEGMENT_LOOP>

            ;;Move the key value, excluding tag literals, into a string so we can use String.Replace()
            data rel<RELATION_NUMBER>FromKeyValue, string, rel<RELATION_NUMBER>FromKeyNoTag

            ;;After replacing "0" with " ", is there anything remaining?
            if (!String.IsNullOrWhiteSpace(rel<RELATION_NUMBER>FromKeyValue.Replace("0"," ")))
            begin
                ;;Get a file I/O object for type "<RelationTostructureNoplural>".
                disposable data rel<RELATION_NUMBER>FileIO = dataObjectProvider.GetFileIO<<RelationTostructureNoplural>>()

                ;;And use it to attempt to read the record in the other file.
                if (rel<RELATION_NUMBER>FileIO.FindRecord(<TO_KEY_NUMBER>,rel<RELATION_NUMBER>FromKey) != FileAccessResults.Success)
                begin
                    throw new ValidationException("Invalid data for relation <HARMONYCORE_RELATION_NAME>")
                end
            end
    <ELSE VALIDATION_ALWAYS>
            ;;Validation mode: Always

            ;;Populate from key values
      <COUNTER_1_RESET>
      <FROM_KEY_SEGMENT_LOOP>
        <IF SEG_TYPE_FIELD>
            rel<RELATION_NUMBER>FromKey.<segment_name> = mSynergyData.<segment_name>
        <ELSE SEG_TYPE_LITERAL>
          <COUNTER_1_INCREMENT>
            rel<RELATION_NUMBER>FromKey.litseg<COUNTER_1_VALUE> = "<SEGMENT_LITVAL>"
        </IF SEG_TYPE_FIELD>
      </FROM_KEY_SEGMENT_LOOP>

            ;;Get a file I/O object for type "<RelationTostructureNoplural>".
            disposable data rel<RELATION_NUMBER>FileIO = dataObjectProvider.GetFileIO<<RelationTostructureNoplural>>()

            ;;And use it to attempt to read the record in the other file.
            if (rel<RELATION_NUMBER>FileIO.FindRecord(<TO_KEY_NUMBER>,rel<RELATION_NUMBER>FromKey) != FileAccessResults.Success)
            begin
                throw new ValidationException("Invalid data for relation <HARMONYCORE_RELATION_NAME>")
            end
    <ELSE VALIDATION_CUSTOM_CODE>
            ;;Validation mode: Custom code

            ;TODO: The mechanism for custom code validation has not yet been defined
    </IF VALIDATION_NONE>

  </RELATION_LOOP_RESTRICTED>
            ;;--------------------------------------------------------------------------------
            ;;If we have a ValidateCustom method, call it

            ValidateCustom(vType,sp)

        endmethod
<ELSE>
;//=========================================
;// VALIDATION IF RELATIONS ARE NOT ENABLED
;//=========================================
        ;;; <summary>
        ;;; Validate data
        ;;; </summary>
        ;;; <param name="type">Validation type (create, update or delete)</param>
        ;;; <param name="sp">Serices provider</param>
        public override method Validate, void
            required in vType, ValidationType
            required in sp, @IServiceProvider
        proc
            ;;If we have a ValidateCustom method, call it
            ValidateCustom(vType,sp)

        endmethod
</IF>

        private partial method ValidateCustom, void
            required in vType, ValidationType
            required in sp, @IServiceProvider
        endmethod

;//=========================================
;// END OF VALIDATION
;//=========================================
.endregion
;//
;// ==========================================================================================
;//
    <COUNTER_2_RESET>
    <RELATION_LOOP_RESTRICTED>
      <COUNTER_1_RESET>
      <FROM_KEY_SEGMENT_LOOP>
        <IF SEG_TYPE_LITERAL>
          <COUNTER_2_INCREMENT>
            <IF COUNTER_2_EQ_1>

.region "Properties to represent literal key segments"

            </IF COUNTER_2_EQ_1>
        ;;; <summary>
        ;;;
        ;;; </summary>
        public readonly property <RelationFromkey>Literal<COUNTER_1_INCREMENT><COUNTER_1_VALUE>, <LITERAL_SEGMENT_SNTYPE>, <LITERAL_SEGMENT_VALUE>
        private _<RelationFromkey>Literal<COUNTER_1_VALUE>, <LITERAL_SEGMENT_SNTYPE>, <LITERAL_SEGMENT_VALUE>
        </IF SEG_TYPE_LITERAL>
      </FROM_KEY_SEGMENT_LOOP>
    </RELATION_LOOP_RESTRICTED>
    <IF COUNTER_2_GT_0>

.endregion

    </IF COUNTER_2_GT_0>
  </IF STRUCTURE_RELATIONS>
</IF DEFINED_ENABLE_RELATIONS>

<IF STRUCTURE_FILES AND STRUCTURE_ISAM AND STRUCTURE_HAS_UNIQUE_KEY>
.region "Properties to represent keys"

        ;;Access keys

  <KEY_LOOP_UNIQUE>
        private _KEY_<KEY_NAME>, string, ""
        public readonly property KEY_<KEY_NAME>, string, ""

  </KEY_LOOP_UNIQUE>
  <FOREIGN_KEY_LOOP>
    <IF FIRST>
        ;;Foreign keys

    </IF FIRST>
        private _KEY_<KEY_NAME>, string, ""
        public readonly property KEY_<KEY_NAME>, string, ""

  </FOREIGN_KEY_LOOP>
.endregion

</IF STRUCTURE_FILES>
    endclass

endnamespace
