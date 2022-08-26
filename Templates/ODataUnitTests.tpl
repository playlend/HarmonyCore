<CODEGEN_FILENAME><StructureNoplural>Tests.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.7.5</REQUIRES_CODEGEN_VERSION>
<REQUIRES_OPTION>TF</REQUIRES_OPTION>
<CODEGEN_FOLDER>UnitTests</CODEGEN_FOLDER>
<REQUIRES_USERTOKEN>CLIENT_MODELS_NAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>SERVICES_NAMESPACE</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       ODataUnitTests.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Generates unit tests for Web API / OData controllers in a
;//              Harmony Core environment.
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
;; Title:       <StructureNoplural>Tests.dbl
;;
;; Description: Unit tests for the operations defined in <StructurePlural>Controller.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import Microsoft.AspNetCore.JsonPatch
import Microsoft.VisualStudio.TestTools.UnitTesting
import Newtonsoft.Json
import System.Collections.Generic
import System.Net
import System.Net.Http
<IF DEFINED_ENABLE_AUTHENTICATION>
import System.Net.Http.Headers
</IF DEFINED_ENABLE_AUTHENTICATION>
import <SERVICES_NAMESPACE>
import <CLIENT_MODELS_NAMESPACE>
import System.Linq

namespace <NAMESPACE>

    {TestClass}
    public partial class <StructureNoplural>Tests
<IF STRUCTURE_ISAM>
;//
;//----------------------------------------------------------------------------------------------------
;// ISAM FILE TESTS
;//
;//
;// If ENABLE_GET_ALL is enabled
;//
  <IF DEFINED_ENABLE_GET_ALL AND GET_ALL_ENDPOINT>

        ;;------------------------------------------------------------
        ;;Get all <StructurePlural>

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read All")}
        public method GetAll<StructurePlural>, void
        proc
            disposable data client = UnitTestEnvironment.Server.CreateClient()
    <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
    </IF DEFINED_ENABLE_AUTHENTICATION>
            disposable data response = client.GetAsync("/odata/v<API_VERSION>/<StructurePlural>").Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
            data <structurePlural>, @OData<StructurePlural>Multiple, JsonConvert.DeserializeObject<OData<StructurePlural>Multiple>(result)
            Assert.AreEqual(<structurePlural>.Value.Count,TestConstants.Instance.Get<StructurePlural>_Count)
        endmethod
;//
;// If ENABLE_GET_ALL and ENABLE_RELATIONS are enabled
;//
    <IF DEFINED_ENABLE_RELATIONS>
      <IF STRUCTURE_RELATIONS>
        <RELATION_LOOP_RESTRICTED>

        ;;------------------------------------------------------------
        ;;Get all <StructurePlural> and expand relation <HARMONYCORE_RELATION_NAME>

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read All")}
        public method GetAll<StructurePlural>_Expand_<HARMONYCORE_RELATION_NAME>, void
        proc
            data uri = "/odata/v<API_VERSION>/<StructurePlural>?$expand=<HARMONYCORE_RELATION_NAME>"
            disposable data client = UnitTestEnvironment.Server.CreateClient()
          <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
          </IF DEFINED_ENABLE_AUTHENTICATION>
            disposable data response = client.GetAsync(uri).Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
        endmethod
        </RELATION_LOOP_RESTRICTED>

        ;;------------------------------------------------------------
        ;;Get all <StructurePlural> and expand all relations

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read All")}
        public method GetAll<StructurePlural>_Expand_All, void
        proc
            data uri = "/odata/v<API_VERSION>/<StructurePlural>?$expand=<RELATION_LOOP_RESTRICTED><HARMONYCORE_RELATION_NAME><,></RELATION_LOOP_RESTRICTED>"
            disposable data client = UnitTestEnvironment.Server.CreateClient()
            <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
            </IF DEFINED_ENABLE_AUTHENTICATION>
            disposable data response = client.GetAsync(uri).Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
        endmethod
      </IF STRUCTURE_RELATIONS>
    </IF DEFINED_ENABLE_RELATIONS>
  </IF>
;//
;// If ENABLE_GET_ONE is enabled
;//
  <IF DEFINED_ENABLE_GET_ONE>

        ;;------------------------------------------------------------
        ;;Get a single <StructureNoplural> by primary key

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read by Primary Key")}
        public method GetOne<StructureNoplural>, void
        proc
            disposable data client = UnitTestEnvironment.Server.CreateClient()
    <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
    </IF DEFINED_ENABLE_AUTHENTICATION>
            data request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Instance.Get<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>)
            data response = client.GetAsync(request).Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
    <IF STRUCTURE_HAS_UNIQUE_PK>
            data <structureNoplural>, @OData<StructureNoplural>Single, JsonConvert.DeserializeObject<OData<StructureNoplural>Single>(result)
    <ELSE>
            data <structurePlural>, @OData<StructurePlural>Single, JsonConvert.DeserializeObject<OData<StructurePlural>Single>(result)
    </IF>
        endmethod
;//
;//
;//
    <IF DEFINED_ENABLE_RELATIONS AND STRUCTURE_RELATIONS>
      <RELATION_LOOP_RESTRICTED>

        ;;------------------------------------------------------------
        ;;Get a single <StructureNoplural> by primary key and expand relation <HARMONYCORE_RELATION_NAME>

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read by Primary Key")}
        public method GetOne<StructureNoplural>_Expand_<HARMONYCORE_RELATION_NAME>, void
        proc
            disposable data client = UnitTestEnvironment.Server.CreateClient()
        <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
        </IF DEFINED_ENABLE_AUTHENTICATION>
            data request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP></PRIMARY_KEY>)?$expand=<HARMONYCORE_RELATION_NAME>","",<PRIMARY_KEY><SEGMENT_LOOP>TestConstants.Instance.Get<StructureNoplural>_Expand_<HARMONYCORE_RELATION_NAME>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>)
            data response = client.GetAsync(request).Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
            data <structureNoplural>, @OData<StructureNoplural>Single, JsonConvert.DeserializeObject<OData<StructureNoplural>Single>(result)
        endmethod
      </RELATION_LOOP_RESTRICTED>

        ;;------------------------------------------------------------
        ;;Get a single <StructureNoplural> by primary key and expand all relations

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read by Primary Key")}
        public method GetOne<StructureNoplural>_Expand_All, void
        proc
            disposable data client = UnitTestEnvironment.Server.CreateClient()
      <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
      </IF DEFINED_ENABLE_AUTHENTICATION>
            data request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP></PRIMARY_KEY>)?$expand=<RELATION_LOOP_RESTRICTED><HARMONYCORE_RELATION_NAME><,></RELATION_LOOP_RESTRICTED>","",<PRIMARY_KEY><SEGMENT_LOOP>TestConstants.Instance.Get<StructureNoplural>_Expand_All_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>)
            data response = client.GetAsync(request).Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
            data <structureNoplural>, @OData<StructureNoplural>Single, JsonConvert.DeserializeObject<OData<StructureNoplural>Single>(result)
        endmethod
    </IF>
  </IF DEFINED_ENABLE_GET_ONE>
;//
;// If ENABLE_ALTERNATE_KEYS is enabled
;//
  <IF DEFINED_ENABLE_ALTERNATE_KEYS>
    <ALTERNATE_KEY_LOOP_UNIQUE>

      <IF DUPLICATES>
        ;;------------------------------------------------------------
        ;;Get a single <StructureNoplural> by alternate key <KEY_NUMBER> (<KeyName>)

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Read by Alternate Key")}
        public method Get<StructureNoplural>_ByAltKey_<KeyName>, void
        proc
            disposable data client = UnitTestEnvironment.Server.CreateClient()
      <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
      </IF DEFINED_ENABLE_AUTHENTICATION>
            data request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP>)", "", <SEGMENT_LOOP>TestConstants.Instance.Get<StructureNoplural>_ByAltKey_<KeyName>_<SegmentName><IF DATE>.ToString("yyyy-MM-dd")</IF DATE><IF TIME_HHMM>.ToString("hh:mm")</IF TIME_HHMM><IF TIME_HHMMSS>.ToString("hh:mm:ss")</IF TIME_HHMMSS><IF BOOLEAN>.ToString().ToLower()</IF BOOLEAN><,></SEGMENT_LOOP>)
            data response = client.GetAsync(request).Result
            data result = response.Content.ReadAsStringAsync().Result
            response.EnsureSuccessStatusCode()
            data <structurePlural>, @OData<StructurePlural>Multiple,JsonConvert.DeserializeObject<OData<StructurePlural>Multiple>(result)
        endmethod
    </IF DUPLICATES>
    </ALTERNATE_KEY_LOOP_UNIQUE>
  </IF DEFINED_ENABLE_ALTERNATE_KEYS>
;//
;// If ENABLE_POST is enabled
;//
;//  <IF DEFINED_ENABLE_POST>
;//
;//        ;;------------------------------------------------------------
;//        ;;Create a new <StructureNoplural> (auto assign key)
;//
;//        {TestMethod}
;//        {TestCategory("<StructureNoplural> Tests - Create, Update & Delete")}
;//        public method Create<StructureNoplural>, void
;//        proc
;//            disposable data client = UnitTestEnvironment.Server.CreateClient()
;//    <IF DEFINED_ENABLE_AUTHENTICATION>
;//            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
;//    </IF DEFINED_ENABLE_AUTHENTICATION>
;//            disposable data requestBody = new StringContent("")
;//            disposable data response = client.PostAsync("/odata/v<API_VERSION>/<StructurePlural>", requestBody).Result
;//            data result = response.Content.ReadAsStringAsync().Result
;//            response.EnsureSuccessStatusCode()
;//        endmethod
;//  </IF DEFINED_ENABLE_POST>
;//
;//
;// Multi-use test: read one, update the key and create a new one, read it back, update it, read it back, do a bad patch, do a good patch, read it back!
;//
<IF DEFINED_ENABLE_GET_ONE AND DEFINED_ENABLE_PUT AND DEFINED_ENABLE_PATCH AND DEFINED_ENABLE_DELETE>

        ;;------------------------------------------------------------
        ;;Create new <StructureNoplural> (client specified key)

        {TestMethod}
        {TestCategory("<StructureNoplural> Tests - Create, Update & Delete")}
        public method Update<StructureNoplural>, void
        proc
            disposable data client = UnitTestEnvironment.Server.CreateClient()
  <IF DEFINED_ENABLE_AUTHENTICATION>
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
  </IF DEFINED_ENABLE_AUTHENTICATION>

            ;;Get one <structureNoplural> from the file
            data getRequest = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Instance.Get<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>)
            data getResponse = client.GetAsync(getRequest).Result
            data getResult = getResponse.Content.ReadAsStringAsync().Result

            ;;Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode()

            ;;Deserialize the JSON into a <StructureNoplural> object
            data do<StructureNoplural>, @<StructureNoplural>, JsonConvert.DeserializeObject<<IF NOT STRUCTURE_HAS_UNIQUE_KEY>OData</IF><StructureNoplural>>(getResult)<IF NOT STRUCTURE_HAS_UNIQUE_KEY>.Value[0]</IF>

  <PRIMARY_KEY>
    <SEGMENT_LOOP>
            do<StructureNoplural>.<FieldSqlName> = TestConstants.Instance.Update<StructureNoplural>_<SegmentName>
    </SEGMENT_LOOP>
  </PRIMARY_KEY>

            ;TODO: Also need to ensure any nodups alternate keys get unique values

            ;;Create new item
            disposable data requestBody = new StringContent(JsonConvert.SerializeObject(do<StructureNoplural>),System.Text.Encoding.UTF8, "application/json")
            data request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Instance.Update<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>)
            disposable data response = client.PutAsync(request, requestBody).Result

            ;;Check that we got a successful response from the web service
            response.EnsureSuccessStatusCode()

            ;;Get the inserted record
            getResponse = client.GetAsync(request).Result
            getResult = getResponse.Content.ReadAsStringAsync().Result

            ;;Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode()

            ;;Deserialize the JSON into a <StructureNoplural> object
            <IF NOT STRUCTURE_HAS_UNIQUE_KEY>
            data results = JsonConvert.DeserializeObject<OData<StructureNoplural>Single>(getResult).Value
            data resultItem, @<StructureNoplural>
            do<StructureNoplural> = results[0]

            ;;Test that all value PKs are the same
            foreach resultItem in results
            begin
                Assert.AreEqual(do<StructureNoplural>.<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>, resultItem.<SegmentName></SEGMENT_LOOP></PRIMARY_KEY>)
            end
            <ELSE>
            do<StructureNoplural> = JsonConvert.DeserializeObject<<StructureNoplural>>(getResult)
            </IF NOT STRUCTURE_HAS_UNIQUE_KEY>

            ;;Change the first non key field to test full update
  <COUNTER_1_RESET>
  <FIELD_LOOP>
    <IF NOTKEYSEGMENT AND NOT USED_IN_RELATION>
      <COUNTER_1_INCREMENT>
      <IF COUNTER_1_EQ_1>
        <IF ALPHA>
            do<StructureNoplural>.<FieldSqlName> = "Y"
        <ELSE>
            do<StructureNoplural>.<FieldSqlName> = 8
        </IF ALPHA>
      </IF COUNTER_1_EQ_1>
    </IF>
  </FIELD_LOOP>

            ;;Update full item
            requestBody = new StringContent(JsonConvert.SerializeObject(do<StructureNoplural>),System.Text.Encoding.UTF8, "application/json")
            request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<PRIMARY_KEY><SEGMENT_LOOP><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP>)","",<SEGMENT_LOOP>TestConstants.Instance.Update<StructureNoplural>_<SegmentName><,></SEGMENT_LOOP></PRIMARY_KEY>)
            response = client.PutAsync(request, requestBody).Result

            ;;Check that we got a successful response from the web service
            response.EnsureSuccessStatusCode()

            ;;Get the inserted record
            getResponse = client.GetAsync(request).Result
            getResult = getResponse.Content.ReadAsStringAsync().Result

            ;;Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode()

            ;;Deserialize the JSON into a <StructureNoplural> object
            do<StructureNoplural> = JsonConvert.DeserializeObject<<IF NOT STRUCTURE_HAS_UNIQUE_KEY>Odata</IF><StructureNoplural>>(getResult)<IF NOT STRUCTURE_HAS_UNIQUE_KEY>.Value.FirstOrDefault(lambda (k) {k.<COUNTER_1_RESET><FIELD_LOOP><IF NOTKEYSEGMENT AND NOT USED_IN_RELATION><COUNTER_1_INCREMENT><IF COUNTER_1_EQ_1><FieldSqlName></IF COUNTER_1_EQ_1></IF></FIELD_LOOP>.Equals("Y")})</IF>

  <COUNTER_1_RESET>
  <FIELD_LOOP>
    <IF NOTKEYSEGMENT AND NOT USED_IN_RELATION>
      <COUNTER_1_INCREMENT>
      <IF COUNTER_1_EQ_1>
        <IF ALPHA>

            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, "Y")
        <ELSE>

            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, 8)
        </IF ALPHA>
      </IF COUNTER_1_EQ_1>
    </IF>
  </FIELD_LOOP>

            ;;Update one non-existant property in the customer
            data badPatchDoc = new JsonPatchDocument()
            badPatchDoc.Replace("xyzzy", "Z")

            ;;Serialize the bad patch to JSON
            data badSerializedPatch = JsonConvert.SerializeObject(badPatchDoc)

            ;;Apply the bad patch
            disposable data badPatchRequestBody = new StringContent(badSerializedPatch,System.Text.Encoding.UTF8, "application/json-patch+json")
            disposable data badPatchResponse = client.PatchAsync(request, badPatchRequestBody).Result
            ;;Check that we got a failure response from the web service
            Assert.AreEqual(badPatchResponse.StatusCode, HttpStatusCode.BadRequest)

            ;;Update one property in the <structureNoplural>
            data patchDoc = new JsonPatchDocument()
  <COUNTER_1_RESET>
  <FIELD_LOOP>
    <IF NOTKEYSEGMENT AND NOT USED_IN_RELATION>
      <COUNTER_1_INCREMENT>
      <IF COUNTER_1_EQ_1>
        <IF ALPHA>
            patchDoc.Replace("<FieldSqlName>", "Z")
        <ELSE>
            patchDoc.Replace("<FieldSqlName>", "9")
        </IF ALPHA>
      </IF COUNTER_1_EQ_1>
    </IF>
  </FIELD_LOOP>

            ;;Serialize the patch to JSON
            data serializedPatch = JsonConvert.SerializeObject(patchDoc)

            ;;Apply the patch
            disposable data patchRequestBody = new StringContent(serializedPatch,System.Text.Encoding.UTF8, "application/json-patch+json")
            disposable data patchResponse = client.PatchAsync(request, patchRequestBody).Result

            ;;Check that we got a successful response from the web service
            patchResponse.EnsureSuccessStatusCode()

            ;;Get the updated <structureNoplural> record
            getResponse = client.GetAsync(request).Result
            getResult = getResponse.Content.ReadAsStringAsync().Result

            ;;Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode()

            ;;Deserialize the JSON into a <StructureNoplural> object
            do<StructureNoplural> = JsonConvert.DeserializeObject<<IF NOT STRUCTURE_HAS_UNIQUE_KEY>Odata</IF><StructureNoplural>>(getResult)<IF NOT STRUCTURE_HAS_UNIQUE_KEY>.Value[0]</IF>

            ;;Verify that the property was changed
  <COUNTER_1_RESET>
  <FIELD_LOOP>
    <IF NOTKEYSEGMENT AND NOT USED_IN_RELATION>
      <COUNTER_1_INCREMENT>
      <IF COUNTER_1_EQ_1>
        <IF ALPHA>
            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, "Z")
        <ELSE>
            Assert.AreEqual(do<StructureNoplural>.<FieldSqlName>, 9)
        </IF ALPHA>
      </IF COUNTER_1_EQ_1>
    </IF>
  </FIELD_LOOP>

            ;;Delete It
            disposable data deleteResponse = client.DeleteAsync(request).Result

            ;;Check that we got a successful response from the web service
            getResponse.EnsureSuccessStatusCode()

            ;;Attempt to get the deleted record
            getResponse = client.GetAsync(request).Result

            ;;Check we got a fail state from the web service
            Assert.AreEqual(getResponse.IsSuccessStatusCode, <IF STRUCTURE_HAS_UNIQUE_KEY>false<ELSE>true</IF STRUCTURE_HAS_UNIQUE_KEY>)

        endmethod
</IF>
;//
;//
;//
;//<PRIMARY_KEY>
;//  <IF MULTIPLE_SEGMENTS>
;//
;//        ;;------------------------------------------------------------
;//        ;;Get multiple <StructureNoplural> by partial primary key
;//
;//        {TestMethod}
;//        {TestCategory("<StructureNoplural> Tests - Read by Primary Key")}
;//        public method Get<StructureNoplural>_ByPartialPrimaryKey, void
;//        proc
;//            disposable data client = UnitTestEnvironment.Server.CreateClient()
;//    <IF DEFINED_ENABLE_AUTHENTICATION>
;//            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer",UnitTestEnvironment.AccessToken)
;//    </IF DEFINED_ENABLE_AUTHENTICATION>
;//            data request = String.Format("/odata/v<API_VERSION>/<StructurePlural>(<SEGMENT_LOOP_FILTER><SegmentName>=<IF ALPHA>'</IF ALPHA>{<SEGMENT_NUMBER>}<IF ALPHA>'</IF ALPHA><SEGMENT_COMMA_NOT_LAST_NORMAL_FIELD></SEGMENT_LOOP_FILTER>)","",<SEGMENT_LOOP_FILTER>TestConstants.Instance.Get<StructureNoplural>_ByPartialPrimaryKey_<SegmentName><,></SEGMENT_LOOPFILTER>)
;//            data response = client.GetAsync(request).Result
;//            data result = response.Content.ReadAsStringAsync().Result
;//            response.EnsureSuccessStatusCode()
;//            data <structureNoplural>, @OData<StructureNoplural>Single, JsonConvert.DeserializeObject<OData<StructureNoplural>Single>(result)
;//        endmethod
;//  </IF MULTIPLE_SEGMENTS>
;//</PRIMARY_KEY>
</IF STRUCTURE_ISAM>
;//
;//
;//
<IF STRUCTURE_RELATIVE>
;//
;//----------------------------------------------------------------------------------------------------
;// RELATIVE FILE TESTS
;//
;// TODO: Implement unit tests for relative files!
;//
</IF STRUCTURE_RELATIVE>

    endclass

endnamespace
