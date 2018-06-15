<CODEGEN_FILENAME><StructureNoplural>MetaData.dbl</CODEGEN_FILENAME>
;//****************************************************************************
;//
;// Title:       DataObjectMetaData.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to define meta data associated with a data object
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
;; Title:       <StructureNoplural>MetaData.dbl
;;
;; Type:        Class
;;
;; Description: Defines meta data associated with a data object <StructureNoplural>.
;;
;;*****************************************************************************
;; WARNING
;;
;; This file was code generated. Avoid editing this file, as any changes that
;; you make will be lost of the file is re-generated.
;;
;;*****************************************************************************
;;
;; Copyright (c) 2012, Synergex International, Inc.
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; * Redistributions of source code must retain the above copyright notice,
;;   this list of conditions and the following disclaimer.
;;
;; * Redistributions in binary form must reproduce the above copyright notice,
;;   this list of conditions and the following disclaimer in the documentation
;;   and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;; POSSIBILITY OF SUCH DAMAGE.
;;
;;*****************************************************************************

import System
import System.Collections.Generic
import System.Text
import Harmony.Core
import Harmony.Core.Converters

namespace <NAMESPACE>

	;;; <summary>
	;;; 
	;;; </summary>
	public partial class <StructureNoplural>Metadata extends DataObjectMetadataBase
		
		;;; <summary>
		;;; 
		;;; </summary>
		public method <StructureNoplural>Metadata
		proc
			RPSStructureName = "<STRUCTURE_NOALIAS>"
			RPSStructureSize = ^size(str<StructureNoplural>)
			<FIELD_LOOP>
			<IF CUSTOM_NOT_SYMPHONY_ARRAY_FIELD>
			AddFieldInfo("<FieldSqlname>", "<FIELD_TYPE_NAME>", <FIELD_SIZE>, <FIELD_POSITION>, 0<FIELD_PRECISION>, false)
			</IF>
            </FIELD_LOOP>
		endmethod
	
		;;; <summary>
		;;; 
		;;; </summary>
		public override method MakeNew, @DataObjectBase
			dataArea, a
			grfa, a
		proc
			mreturn new <StructureNoplural>((str<StructureNoplural>)dataArea) { GlobalRFA = grfa }
		endmethod

		;;; <summary>
		;;; 
		;;; </summary>
		public override method MakeNew, @DataObjectBase
			dataArea, a
			grfa, a
			joinedObjects, [#]KeyValuePair<string, Object>
		proc
			data c = new <StructureNoplural>((str<StructureNoplural>)dataArea) { GlobalRFA = grfa }
			<IF STRUCTURE_RELATIONS>
			data jo, KeyValuePair<string, Object>
			foreach jo in joinedObjects
			begin
				using jo.Key select
				<RELATION_LOOP>
				<IF TWO_WAY_ONE_TO_ONE>
				("REL_<RelationFromkey>"), 
					c.REL_<RelationFromkey> = (@<RelationTostructureNoplural>)jo.Value
				</IF TWO_WAY_ONE_TO_ONE>
				<IF ONE_WAY_ONE_TO_ONE>
				("REL_<RelationFromkey>"),
					c.REL_<RelationFromkey> = (@<RelationTostructureNoplural>)jo.Value
				</IF ONE_WAY_ONE_TO_ONE>
				<IF TWO_WAY_ONE_TO_MANY>
				("REL_<RelationTostructurePlural>"), 
					c.REL_<RelationTostructurePlural> = (@ICollection<<RelationTostructureNoplural>>)jo.Value
				</IF TWO_WAY_ONE_TO_MANY>
				<IF ONE_WAY_ONE_TO_MANY>
				("REL_<RelationTostructurePlural>"),
					c.REL_<RelationTostructurePlural> = (@ICollection<<RelationTostructureNoplural>>)jo.Value
				</IF ONE_WAY_ONE_TO_MANY>
				</RELATION_LOOP>
				endusing
			end
			</IF STRUCTURE_RELATIONS>

			mreturn c

		endmethod

	endclass

endnamespace

