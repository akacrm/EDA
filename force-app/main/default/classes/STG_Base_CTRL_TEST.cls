/*
    Copyright (c) 2017, Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
 * @author Salesforce.org
 * @date 2017
 * @group Settings
 * @group-content ../../ApexDocContent/Settings.htm
 * @description Tests for STG_Base_CTRL.
 */
@isTest
private class STG_Base_CTRL_TEST {
    private static ID orgRecTypeID;
    private static ID householdRecTypeID;
    private static ID adminRecTypeID;

    public static void recTypesSetup() {
        orgRecTypeID = UTIL_Describe_API.getBizAccRecTypeID();
        householdRecTypeID = UTIL_Describe.getHhAccRecTypeID();
        adminRecTypeID = UTIL_Describe.getCustomAdminAccRecTypeID();
    }

    /*** Affiliate Mappings ***/

    @isTest
    public static void getAfflMappings() {
        insert new Affl_Mappings__c(
            Name = 'edu',
            Account_Record_Type__c = 'educational institution',
            Primary_Affl_Field__c = 'primary educational institution',
            Auto_Program_Enrollment__c = true,
            Auto_Program_Enrollment_Role__c = 'student',
            Auto_Program_Enrollment_Status__c = 'current'
        );

        Test.startTest();
        List<Affl_Mappings__c> mappings = STG_Base_CTRL.getAfflMappings();
        Test.stopTest();

        System.assertEquals(1, mappings.size());
    }

    @isTest
    public static void saveAfflMappings() {
        List<Affl_Mappings__c> afflMappings = new List<Affl_Mappings__c>();
        afflMappings.add(
            new Affl_Mappings__c(
                Name = 'edu',
                Account_Record_Type__c = 'educational institution',
                Primary_Affl_Field__c = 'primary educational institution',
                Auto_Program_Enrollment__c = true,
                Auto_Program_Enrollment_Role__c = 'student',
                Auto_Program_Enrollment_Status__c = 'current'
            )
        );

        Test.startTest();
        STG_Base_CTRL.saveAfflMappings(afflMappings);
        Test.stopTest();

        afflMappings = [
            SELECT Account_Record_Type__c
            FROM Affl_Mappings__c
            WHERE Primary_Affl_Field__c = 'primary educational institution'
        ];
        System.assertEquals(1, afflMappings.size());
        System.assertEquals('educational institution', afflMappings[0].Account_Record_Type__c);
    }

    @isTest
    public static void newAfflMappings() {
        Test.startTest();
        STG_Base_CTRL.newAfflMpg(
            'Educational Institution',
            'Primary Educational Institution',
            true,
            'student',
            'current'
        );
        Test.stopTest();

        List<Affl_Mappings__c> afflMappings = [
            SELECT Account_Record_Type__c
            FROM Affl_Mappings__c
            WHERE Primary_Affl_Field__c = 'Primary Educational Institution'
        ];
        System.assertEquals(1, afflMappings.size());
        System.assertEquals('Educational Institution', afflMappings[0].Account_Record_Type__c);
    }

    @isTest
    public static void deleteAfflMappings() {
        STG_Base_CTRL.newAfflMpg(
            'Educational Institution',
            'Primary Educational Institution',
            true,
            'student',
            'current'
        );
        List<Affl_Mappings__c> afflMappings = [
            SELECT Account_Record_Type__c
            FROM Affl_Mappings__c
            WHERE Primary_Affl_Field__c = 'Primary Educational Institution'
        ];

        Test.startTest();
        STG_Base_CTRL.deleteAfflMappingRecord(afflMappings[0].Id);
        Test.stopTest();

        afflMappings = [
            SELECT Account_Record_Type__c
            FROM Affl_Mappings__c
            WHERE Primary_Affl_Field__c = 'Primary Educational Institution'
        ];
        System.assertEquals(0, afflMappings.size());
    }

    /*** Reciprocal Settings ***/

    @isTest
    public static void getReciprocalSettings() {
        insert new Relationship_Lookup__c(
            Name = 'test' + system.now(),
            Active__c = true,
            Female__c = 'wife',
            Male__c = 'husband',
            Neutral__c = 'spouse'
        );

        Test.startTest();
        List<Relationship_Lookup__c> settings = STG_Base_CTRL.getReciprocalSettings();
        Test.stopTest();

        System.assertEquals(1, settings.size());
    }

    @isTest
    public static void saveReciprocalSettings() {
        List<Relationship_Lookup__c> reciprocalSettings = new List<Relationship_Lookup__c>();
        reciprocalSettings.add(
            new Relationship_Lookup__c(
                Name = 'LookupType',
                Male__c = 'MaleType',
                Female__c = 'FemaleType',
                Neutral__c = 'NeutralType'
            )
        );
        reciprocalSettings.add(
            new Relationship_Lookup__c(
                Name = 'LookupType2',
                Male__c = 'MaleType2',
                Female__c = 'FemaleType2',
                Neutral__c = 'NeutralType2'
            )
        );

        Test.startTest();
        STG_Base_CTRL.saveReciprocalSettings(reciprocalSettings);
        Test.stopTest();

        reciprocalSettings = [SELECT ID FROM Relationship_Lookup__c];
        System.assertEquals(2, reciprocalSettings.size());
    }

    @isTest
    public static void newDeleteReciprocalSetting() {
        Test.startTest();
        STG_Base_CTRL.newReciprocalSetting('test' + system.now(), 'husband', 'wife', 'spouse', true);
        Test.stopTest();

        List<Relationship_Lookup__c> settings = [
            SELECT Male__c, Female__c
            FROM Relationship_Lookup__c
            WHERE Neutral__c = 'spouse'
        ];
        System.assertEquals(1, settings.size());
        System.assertEquals('husband', settings[0].Male__c);
        System.assertEquals('wife', settings[0].Female__c);

        STG_Base_CTRL.deleteRecSettingRecord(settings[0].Id);
        settings = [SELECT Id FROM Relationship_Lookup__c WHERE Id = :settings[0].Id];
        System.assertEquals(0, settings.size());
    }

    /*** Auto Create Settings ***/

    @isTest
    public static void getAutoCreateSettings() {
        insert new Relationship_Auto_Create__c(
            Name = 'test' + system.now(),
            Object__c = 'Contact',
            Field__c = 'coworker__c',
            Relationship_Type__c = 'coworker',
            Campaign_Types__c = 'fun event'
        );

        Test.startTest();
        List<Relationship_Auto_Create__c> settings = STG_Base_CTRL.getAutoCreateSettings();
        Test.stopTest();

        System.assertEquals(1, settings.size());
    }

    @isTest
    public static void saveAutoCreateSettings() {
        List<Relationship_Auto_Create__c> autoCreateSettings = new List<Relationship_Auto_Create__c>();
        autoCreateSettings.add(
            new Relationship_Auto_Create__c(
                Name = 'test' + system.now(),
                Object__c = 'Contact',
                Field__c = 'coworker__c',
                Relationship_Type__c = 'coworker',
                Campaign_Types__c = 'fun event'
            )
        );

        Test.startTest();
        STG_Base_CTRL.saveAutoCreateSettings(autoCreateSettings);
        Test.stopTest();

        autoCreateSettings = [SELECT Field__c FROM Relationship_Auto_Create__c WHERE Relationship_Type__c = 'coworker'];
        System.assertEquals(1, autoCreateSettings.size());
        System.assertEquals('coworker__c', autoCreateSettings[0].Field__c);
    }

    @isTest
    public static void newDeleteAutoCreateSetting() {
        Test.startTest();
        STG_Base_CTRL.newAutoCreateSetting('Contact', 'coworker__c', 'coworker', '');
        Test.stopTest();

        List<Relationship_Auto_Create__c> settings = [
            SELECT Object__c, Field__c
            FROM Relationship_Auto_Create__c
            WHERE Relationship_Type__c = 'coworker'
        ];
        System.assertEquals(1, settings.size());
        System.assertEquals('Contact', settings[0].Object__c);
        System.assertEquals('coworker__c', settings[0].Field__c);

        STG_Base_CTRL.deleteAutoCreateRecord(settings[0].Id);
        settings = [SELECT Id FROM Relationship_Auto_Create__c WHERE Id = :settings[0].Id];
        System.assertEquals(0, settings.size());
    }

    /*** Hierarchy Settings ***/

    @isTest
    public static void saveHierarchySettings() {
        recTypesSetup();
        Hierarchy_Settings__c hs = new Hierarchy_Settings__c();
        hs.Account_Processor__c = 'Administrative';
        hs.Accounts_Addresses_Enabled__c = orgRecTypeID + ';';

        Test.startTest();
        STG_Base_CTRL.saveHierarchySettings(hs);
        Test.stopTest();

        List<Hierarchy_Settings__c> hss = [
            SELECT Accounts_Addresses_Enabled__c
            FROM Hierarchy_Settings__c
            WHERE Account_Processor__c = 'Administrative'
        ];
        System.assertEquals(1, hss.size());
        System.assertEquals(true, hss[0].Accounts_Addresses_Enabled__c.contains(orgRecTypeID));
    }

    /*** Ethnicity Race batch ***/
    @isTest
    public static void executeEthnicityRaceBatch() {
        Test.startTest();
        Id batchId = STG_Base_CTRL.executeEthnicityRaceBatch();
        Test.stopTest();

        // Make sure an Apex Job Id is returned.
        System.assertEquals('AsyncApexJob', String.valueOf(batchId.getSobjectType()));
    }

    /*** Ethnicity Race batch ***/
    @isTest
    public static void executePreferredEmailCleanUpBatch() {
        Test.startTest();
        Id batchId = STG_Base_CTRL.executePreferredEmailCleanUpBatch();
        Test.stopTest();

        // Make sure an Apex Job Id is returned.
        System.assertEquals('AsyncApexJob', String.valueOf(batchId.getSobjectType()));
    }

    /*********************************************************************************************************
     * @description Tests if refresh Household Account name batch class is successfully run.
     */
    @isTest
    public static void checkRefreshHouseholdAccountBatch() {
        Hierarchy_Settings__c hs = UTIL_CustomSettingsFacade.getSettingsForTests(
            new Hierarchy_Settings__c(
                Account_Processor__c = UTIL_Describe.getHhAccRecTypeID(),
                Household_Account_Naming_Format__c = '{!LastName} Household'
            )
        );
        insert hs;

        Id apexJobId = STG_Base_CTRL.executeRefreshHouseholdAccountBatch();
        System.assertNotEquals(null, apexJobId);

        Boolean automaticHHNameEnabled = UTIL_CustomSettingsFacade.getSettingsForTests(hs)
            .Automatic_Household_Naming__c;
        System.assertEquals(true, automaticHHNameEnabled);
    }

    /*********************************************************************************************************
     * @description Tests if refresh Administrative Account name batch class is successfully run.
     */
    @isTest
    public static void checkRefreshAdministrativeAccountBatch() {
        UTIL_CustomSettingsFacade.getSettingsForTests(
            new Hierarchy_Settings__c(
                Account_Processor__c = UTIL_Describe.getCustomAdminAccRecTypeID(),
                Admin_Account_Naming_Format__c = '{!LastName} Administrative'
            )
        );
        Id apexJobId = STG_Base_CTRL.executeRefreshAdminAccountBatch();
        System.assertNotEquals(null, apexJobId);
    }
}
