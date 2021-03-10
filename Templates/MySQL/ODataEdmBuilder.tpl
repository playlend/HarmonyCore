<CODEGEN_FILENAME>EdmBuilder.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.5.3</REQUIRES_CODEGEN_VERSION>
<REQUIRES_USERTOKEN>MODELS_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataEdmBuilder.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Used to create OData EDM builder class in a Harmony Core environment
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
;; Title:       EdmBuilder.dbl
;;
;; Description: Builds a Harmony Core Enterprise Data Model (EDM)
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import Harmony.Core
import Harmony.Core.Context
import Harmony.OData
import Microsoft.EntityFrameworkCore
import Microsoft.OData.Edm
import Microsoft.AspNet.OData.Builder
import Microsoft.AspNetCore.Mvc
import Microsoft.AspNetCore.Mvc.Versioning.Conventions
import System.Collections.Generic
import <MODELS_NAMESPACE>

namespace <NAMESPACE>

    ;;; <summary>
    ;;; Builds an entity framework entity data model.
    ;;; </summary>
    public partial class EdmBuilder implements IEdmBuilder

        private mServiceProvider, @IServiceProvider
        private static mEdmModels, @Dictionary<int, IEdmModel>, new Dictionary<int, IEdmModel>()
        private static mEdmVersions, @List<int>, new List<int>()

        ;;; <summary>
        ;;; Constructor
        ;;; </summary>
        static method EdmBuilder
        proc
            CustomStaticEdmInit()

            if(mEdmVersions.Count == 0)
                mEdmVersions.Add(1)
        endmethod

        ;;; <summary>
        ;;; Constructor
        ;;; </summary>
        public method EdmBuilder
            serviceProvider, @IServiceProvider
        proc
            mServiceProvider = serviceProvider
        endmethod

        ;;; <summary>
        ;;; 
        ;;; </summary>
        ;;; <param name="modelBuilder"></param>
        ;;; <returns></returns>
        public virtual method BuildModel, @IEdmModel
            modelBuilder, @ODataModelBuilder 
            endparams
        proc
            mreturn GetEdmModel(modelBuilder, mServiceProvider)
        endmethod

        ;;; <summary>
        ;;; 
        ;;; </summary>
        ;;; <param name="serviceProvider"></param>
        ;;; <param name="versionNumber"></param>
        ;;; <returns></returns>
        public static method GetEdmModel, @IEdmModel
            required in serviceProvider, @IServiceProvider
            required in versionNumber, int
        proc
            if(!mEdmModels.ContainsKey(versionNumber))
            begin
                FillVersionedEdmModels(serviceProvider, versionNumber)

                if(!mEdmModels.ContainsKey(versionNumber))
                begin
                    data madeModel = GetEdmModel(new ODataConventionModelBuilder(serviceProvider), serviceProvider)
                    madeModel.SetAnnotationValue(madeModel, new ApiVersionAnnotation(ApiVersion.Parse(versionNumber.ToString())))
                    mEdmModels.Add(versionNumber, madeModel)
                end
            end
            mreturn mEdmModels[versionNumber]
        endmethod

        ;;; <summary>
        ;;; 
        ;;; </summary>
        public static property EdmVersions, @IEnumerable<int>
            method get
            proc
                mreturn mEdmVersions
            endmethod
        endproperty

        ;;; <summary>
        ;;; 
        ;;; </summary>
        ;;; <param name="serviceProvider"></param>
        ;;; <param name="versionNumber"></param>
        private static partial method FillVersionedEdmModels, void
            required in serviceProvider, @IServiceProvider
            required in versionNumber, int
        endmethod

        ;;; <summary>
        ;;; 
        ;;; </summary>
        private static partial method CustomStaticEdmInit, void
        
        endmethod

        ;;; <summary>
        ;;; Gets the entity data model.
        ;;; </summary>
        private static method GetEdmModel, @IEdmModel
            required in builder, @ODataModelBuilder
            required in serviceProvider, @IServiceProvider
        proc
            ;;Declare entities
 
 <STRUCTURE_LOOP>
            builder.EntitySet<<StructureNoplural>>("<StructurePlural>")
  </STRUCTURE_LOOP>
 
<IF NOT DEFINED_EF_PROVIDER_MYSQL>
            ;;Entities with a single primary key segment have the key declared to EF via a
            ;;{Key} attribute on the appropriate property in the data model, but only one {key}
            ;;attribute can be used in a class, so keys with multiple segments are defined
            ;;using the "Fluent API" here.
  <STRUCTURE_LOOP>
    <IF STRUCTURE_ISAM>
      <PRIMARY_KEY>
        <IF MULTIPLE_SEGMENTS>
          <SEGMENT_LOOP>
            <IF NOT SEG_TAG_EQUAL>
              <IF CUSTOM_HARMONY_AS_STRING>
            builder.EntityType<<StructureNoplural>>().HasKey<<StructureNoplural>,string>("<FieldSqlname>")
              <ELSE>
            builder.EntityType<<StructureNoplural>>().HasKey<<StructureNoplural>,<HARMONYCORE_SEGMENT_DATATYPE>>("<FieldSqlname>")
              </IF CUSTOM_HARMONY_AS_STRING>
            </IF SEG_TAG_EQUAL>
          </SEGMENT_LOOP>
        </IF MULTIPLE_SEGMENTS>
      </PRIMARY_KEY>
    </IF STRUCTURE_ISAM>
    <IF STRUCTURE_RELATIVE>
            builder.EntityType<<StructureNoplural>>().HasKey<<StructureNoplural>,int>("RecordNumber")
    </IF STRUCTURE_RELATIVE>
  </STRUCTURE_LOOP>
</IF>
 
            ;;-----------------------------------------------
            ;;If we have a GetEdmModelCustom method, call it 

            GetEdmModelCustom(serviceProvider, builder)

            data tempModel = (@EdmModel)builder.GetEdmModel()

<IF NOT DEFINED_EF_PROVIDER_MYSQL>
            ;;-----------------------------------------------
            ;;Declare alternate keys

  <STRUCTURE_LOOP>
    <COUNTER_1_RESET>
    <IF STRUCTURE_ISAM>
      <ALTERNATE_KEY_LOOP_UNIQUE>
        <SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE><COUNTER_1_INCREMENT></IF SEG_TAG_EQUAL></SEGMENT_LOOP>
      </ALTERNATE_KEY_LOOP_UNIQUE>
    </IF STRUCTURE_ISAM>

            data <structureNoplural>Type = (@EdmEntityType)tempModel.FindDeclaredType("<MODELS_NAMESPACE>.<StructureNoplural>")
    <IF STRUCTURE_ISAM>
      <ALTERNATE_KEY_LOOP_UNIQUE>
        <IF COUNTER_1>
            tempModel.AddAlternateKeyAnnotation(<structureNoplural>Type, new Dictionary<string, IEdmProperty>() {<SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE>{"<FieldSqlName>",<structureNoplural>Type.FindProperty("<FieldSqlName>")}<,></IF SEG_TAG_EQUAL></SEGMENT_LOOP>})
        </IF>
      </ALTERNATE_KEY_LOOP_UNIQUE>
    </IF STRUCTURE_ISAM>
  </STRUCTURE_LOOP>

<ELSE>
;//
;// When working with MySQL (at FCL at least) we don't have access to the actual primary key, because the corresponding
;// field is not defined in the repository. The first key defined in repository actually refers to an alternate index
;// as far as MySQL and EF are concerned. So we need to code generate it as a primary key, but declare it the way we
;// generally declare alternate keys.
;//
            ;;-----------------------------------------------
            ;;Declare primary keys

  <STRUCTURE_LOOP>

            data <structureNoplural>Type = (@EdmEntityType)tempModel.FindDeclaredType("<MODELS_NAMESPACE>.<StructureNoplural>")
    <IF STRUCTURE_ISAM>
      <PRIMARY_KEY>
            tempModel.AddAlternateKeyAnnotation(<structureNoplural>Type, new Dictionary<string, IEdmProperty>() {{"Companyext",<structureNoplural>Type.FindProperty("Companyext")},<SEGMENT_LOOP><IF SEG_TAG_EQUAL><ELSE>{"<FieldSqlName>",<structureNoplural>Type.FindProperty("<FieldSqlName>")}<,></IF SEG_TAG_EQUAL></SEGMENT_LOOP>})
      </PRIMARY_KEY>
    </IF STRUCTURE_ISAM>
  </STRUCTURE_LOOP>

</IF>
            ;;-----------------------------------------------
            ;;If we have a PostEdmModelCustom method, call it 

            PostEdmModelCustom(serviceProvider, tempModel)

            ;;-----------------------------------------------

            mreturn tempModel

        endmethod

        ;;; <summary>
        ;;; Declare the GetEdmModelCustom partial method
        ;;; This method can be implemented in a partial class to provide custom EDM configuration code
        ;;; </summary>
        ;;; <param name="serviceProvider"></param>
        ;;; <param name="builder"></param>
        partial static method GetEdmModelCustom, void
            required in serviceProvider, @IServiceProvider
            required in builder, @ODataModelBuilder
        endmethod

        ;;; <summary>
        ;;; Declare the PostEdmModelCustom partial method
        ;;; This method can be implemented in a partial class to provide custom EDM configuration code
        ;;; </summary>
        ;;; <param name="serviceProvider"></param>
        ;;; <param name="model"></param>
        partial static method PostEdmModelCustom, void
            required in serviceProvider, @IServiceProvider
            required in model, @EdmModel
        endmethod

    endclass

endnamespace