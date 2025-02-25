/*
    Copyright (c) 2015, Salesforce.org
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
 * @date 2015
 * @group Affiliations
 * @group-content ../../ApexDocContent/Affiliations.htm
 * @description Tests specific to Affiliation Management when an Account that
 * is part of one or more Affiliation changes.
 */
@isTest
public with sharing class AFFL_AccRecordType_TEST {
    private static ID orgRecTypeID;
    private static ID householdRecTypeID;

    private static void setup() {
        UTIL_CustomSettings_API.getSettingsForTests(
            new Hierarchy_Settings__c(Account_Processor__c = UTIL_Describe.getHhAccRecTypeID())
        );

        STG_InstallScript.insertMappings();
        RecordType univ = [SELECT Id, Name FROM RecordType WHERE DeveloperName = 'University_Department'];
        System.assertNotEquals(null, univ, 'University_Department Record Type was not found');

        orgRecTypeID = UTIL_Describe_API.getBizAccRecTypeID();
        householdRecTypeID = UTIL_Describe.getHhAccRecTypeID();
    }

    @isTest
    private static void changePrimaryAffiliationRecordType() {
        AFFL_AccRecordType_TEST.setup();

        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Verify default household account has been created for the contact
        contact = [SELECT AccountId, Primary_Household__c FROM Contact WHERE Id = :contact.Id];
        System.assertNotEquals(null, contact.AccountId);
        System.assertEquals(null, contact.Primary_Household__c);

        //Manually create an Affiliation to the household, since we are not automatically doing so any more.
        insert new Affiliation__c(Contact__c = contact.Id, Account__c = contact.AccountId, Primary__c = true);

        //Verify the primary household field was populated
        contact = [SELECT AccountId, Primary_Household__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(contact.AccountId, contact.Primary_Household__c);

        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_afflMadePrimary,
            false
        );
        Account acc = [SELECT RecordTypeId FROM Account WHERE Id = :contact.AccountId];
        //Change the account record type to Business Organization
        acc.RecordTypeId = orgRecTypeID;
        Test.startTest();
        update acc;
        Test.stopTest();

        contact = [SELECT Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        //Verify primary household field has been cleared
        System.assertEquals(null, contact.Primary_Household__c);
        //Verify primary business organization field has been populated
        System.assertEquals(acc.Id, contact.Primary_Organization__c);

        //Verify no duplicate affiliations are created
        List<Affiliation__c> allAffiliationList = [
            SELECT Id, Name, Primary__c
            FROM Affiliation__c
            WHERE Contact__c = :contact.Id AND Account__c = :acc.Id
        ];
        System.assertEquals(1, allAffiliationList.size());
        System.assertEquals(true, allAffiliationList[0].Primary__c);
    }

    @isTest
    private static void changePrimaryAffiliationRecordTypeReentrancyCheck() {
        AFFL_AccRecordType_TEST.setup();

        // Install Default HEDA TDTM Configuration
        List<TDTM_Global_API.TdtmToken> defaultTokens = TDTM_Global_API.getDefaultTdtmConfig();
        TDTM_Global_API.setTdtmConfig(defaultTokens, 'hed');

        // Add the Test TDTM for the Contact object. This Test TDTM will simply update the account that caused the contact to be updated.
        // So the flow would be: Account updated -> contact updated -> account updated again
        Trigger_Handler__c newTDTM = new Trigger_Handler__c(
            Active__c = true,
            Asynchronous__c = false,
            Class__c = 'UTIL_UnitTestData_TEST.Test_TDTM',
            Load_Order__c = 1,
            Object__c = 'Contact',
            Owned_by_Namespace__c = 'hed',
            Trigger_Action__c = 'AfterInsert;AfterUpdate'
        );
        insert newTDTM;

        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Manually create an Affiliation to the household, since we are not automatically doing so any more.
        contact = [SELECT AccountId, Primary_Household__c FROM Contact WHERE Id = :contact.Id];
        insert new Affiliation__c(Contact__c = contact.Id, Account__c = contact.AccountId, Primary__c = true);

        //Verify the primary household field was populated
        contact = [SELECT AccountId, Primary_Household__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(contact.AccountId, contact.Primary_Household__c);

        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_afflMadePrimary,
            false
        );

        //Change the account record type to Business Organization
        Account acc = new Account(Id = contact.AccountId, RecordTypeId = orgRecTypeID);

        // Ensure that the account gets updated recursively
        UTIL_UnitTestData_TEST.sObjectsToUpdate = new List<SObject>{ acc };

        Test.startTest();
        update acc;
        Test.stopTest();

        contact = [SELECT Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        //Verify primary household field has been cleared
        System.assertEquals(null, contact.Primary_Household__c);
        //Verify primary business organization field has been populated
        System.assertEquals(acc.Id, contact.Primary_Organization__c);

        System.assert(
            AFFL_AccRecordType_TDTM.reentrancyPrevented == true,
            'Expected the reentrancy check to have prevented the AFFL_AccRecordType_TDTM trigger from processing again.'
        );
    }

    @isTest
    private static void changePrimaryAffiliationRecordTypeTwoAccs() {
        AFFL_AccRecordType_TEST.setup();

        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Verify default household account has been created for the contact
        contact = [SELECT AccountId, Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        System.assertNotEquals(null, contact.AccountId);
        System.assertEquals(null, contact.Primary_Household__c);

        //Manually create an Affiliation to the household, since we are not automatically doing so any more.
        insert new Affiliation__c(Contact__c = contact.Id, Account__c = contact.AccountId, Primary__c = true);

        //Verify the primary household field was populated
        contact = [SELECT AccountId, Primary_Household__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(contact.AccountId, contact.Primary_Household__c);

        //Create primary Affl to a Business Organization
        Account bizOrg = UTIL_UnitTestData_API.getMultipleTestAccounts(1, orgRecTypeID)[0];
        insert bizOrg;
        Affiliation__c bizAffl = new Affiliation__c(Contact__c = contact.Id, Account__c = bizOrg.Id, Primary__c = true);
        insert bizAffl;

        //Verify the primary business organization field was populated
        contact = [SELECT AccountId, Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(bizOrg.Id, contact.Primary_Organization__c);

        Account household = [SELECT RecordTypeId FROM Account WHERE Id = :contact.AccountId];
        //Change the account record type of the household to Business Organization, and of the biz org to Household
        household.RecordTypeId = orgRecTypeID;
        bizOrg.RecordTypeId = householdRecTypeID;
        Test.startTest();
        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_afflMadePrimary,
            false
        );
        update new List<Account>{ household, bizOrg };
        Test.stopTest();

        contact = [SELECT Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        //Verify primary household field has changed to the biz org
        System.assertEquals(bizOrg.Id, contact.Primary_Household__c);
        //Verify primary business organization field has changed to the household
        System.assertEquals(household.Id, contact.Primary_Organization__c);
    }

    @isTest
    private static void otherPrimaryNotPrimary() {
        AFFL_AccRecordType_TEST.setup();

        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Verify default household account has been created for the contact
        contact = [SELECT AccountId, Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        System.assertNotEquals(null, contact.AccountId);
        System.assertEquals(null, contact.Primary_Household__c);

        //Manually create an Affiliation to the household, since we are not automatically doing so any more
        insert new Affiliation__c(Contact__c = contact.Id, Account__c = contact.AccountId, Primary__c = true);

        //Verify the primary household field was populated
        contact = [SELECT AccountId, Primary_Household__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(contact.AccountId, contact.Primary_Household__c);

        //Create primary Affl to a Business Organization
        Account bizOrg = UTIL_UnitTestData_API.getMultipleTestAccounts(1, orgRecTypeID)[0];
        insert bizOrg;
        UTIL_Debug.debug('****Biz org ID: ' + bizOrg.Id);
        Affiliation__c bizAffl = new Affiliation__c(Contact__c = contact.Id, Account__c = bizOrg.Id, Primary__c = true);
        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_Before_Insert,
            false
        );
        insert bizAffl;

        //Verify the primary business organization field was populated
        contact = [SELECT AccountId, Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(bizOrg.Id, contact.Primary_Organization__c);

        Account household = [SELECT RecordTypeId FROM Account WHERE Id = :contact.AccountId];
        UTIL_Debug.debug('****Household ID: ' + household.Id);
        //Change the account record type of parent Household to Business Organization
        household.RecordTypeId = orgRecTypeID;
        Test.startTest();
        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_afflMadePrimary,
            false
        );
        update household;
        Test.stopTest();

        contact = [SELECT Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        //Verify primary household field has been cleared
        System.assertEquals(null, contact.Primary_Household__c);
        //Verify primary business organization field has changed to the household
        System.assertEquals(household.Id, contact.Primary_Organization__c);

        //Verify the old primary business affiliation is not primary now
        bizAffl = [SELECT Primary__c FROM Affiliation__c WHERE ID = :bizAffl.Id];
        System.assertEquals(false, bizAffl.Primary__c);
    }

    @isTest
    private static void addRecordTypeToAcc() {
        AFFL_AccRecordType_TEST.setup();

        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Create primary Affl to Account without record type - since the account created will have the record type assigned
        //to the profile running the tests as default, we assign a different type to it. Profiles cannot be created in tests.
        Account acc = UTIL_UnitTestData_API.getMultipleTestAccounts(1, UTIL_Describe.getCustomAdminAccRecTypeID())[0];
        insert acc;
        Affiliation__c affl = new Affiliation__c(Contact__c = contact.Id, Account__c = acc.Id, Primary__c = true);
        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_Before_Insert,
            false
        );
        insert affl;

        //Verify Primary Business Organization field was not populated
        contact = [SELECT Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(null, contact.Primary_Organization__c);

        //Give record type to that Account
        acc.RecordTypeId = orgRecTypeID;
        Test.startTest();
        update acc;
        Test.stopTest();

        //Verify Primary Business Organization field was populated
        contact = [SELECT Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(acc.Id, contact.Primary_Organization__c);
    }

    @isTest
    private static void updateAdminAccRecordTypeBulk() {
        AFFL_AccRecordType_TEST.setup();

        //Create some Accounts with Admin record type
        List<Account> adminAccList = UTIL_UnitTestData_API.getMultipleTestAccounts(
            10,
            UTIL_Describe.getCustomAdminAccRecTypeID()
        );
        insert adminAccList;

        List<Account> theAccs = [
            SELECT Id
            FROM Account
            WHERE RecordTypeId = :UTIL_Describe.getCustomAdminAccRecTypeID()
        ];
        System.assertEquals(10, theAccs.size());

        //Change the record type of the Accounts to Biz type and HH type
        for (Integer i = 0; i < 10; i++) {
            if (i < 5) {
                theAccs[i].RecordTypeId = orgRecTypeID;
            } else {
                theAccs[i].RecordTypeId = householdRecTypeID;
            }
        }

        //Update Accounts in bulk. It shouldn't throw any error
        Test.startTest();
        update theAccs;
        Test.stopTest();

        List<Account> orgAccounts = [SELECT Id FROM Account WHERE RecordTypeId = :orgRecTypeID];
        System.assertEquals(5, orgAccounts.size());

        List<Account> hhAccounts = [SELECT Id FROM Account WHERE RecordTypeId = :householdRecTypeID];
        System.assertEquals(5, hhAccounts.size());
    }

    @isTest
    private static void fillInPrimaryFieldForContacts() {
        AFFL_AccRecordType_TEST.setup();

        //Create Contacts
        Contact john = UTIL_UnitTestData_API.getContact();
        Contact mark = UTIL_UnitTestData_API.getContact();
        List<Contact> contacts = new List<Contact>{ john, mark };
        insert contacts;

        //Create Accounts with Admin Record Type
        Account company = UTIL_UnitTestData_API.getMultipleTestAccounts(
            1,
            UTIL_Describe.getCustomAdminAccRecTypeID()
        )[0];
        Account hh = UTIL_UnitTestData_API.getMultipleTestAccounts(1, UTIL_Describe.getCustomAdminAccRecTypeID())[0];
        List<Account> accs = new List<Account>{ company, hh };
        insert accs;

        //Create Affiliations
        Affiliation__c companyAffl = new Affiliation__c(
            Contact__c = john.Id,
            Account__c = company.Id,
            Primary__c = true
        );
        Affiliation__c hhAffl = new Affiliation__c(Contact__c = mark.Id, Account__c = hh.Id, Primary__c = true);
        List<Affiliation__c> affls = new List<Affiliation__c>{ companyAffl, hhAffl };
        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_Before_Insert,
            false
        );
        insert affls;

        //Now Update the Account Record Type
        Account companyWithCorrectType = new Account(Id = company.Id, RecordTypeId = orgRecTypeID);
        Account hhWithCorrectType = new Account(Id = hh.Id, RecordTypeId = householdRecTypeID);
        List<Account> accsForUpdate = new List<Account>{ companyWithCorrectType, hhWithCorrectType };

        Test.startTest();
        update accsForUpdate;
        Test.stopTest();

        //Verify that the Primary Fields on Contacts get populated correctly
        Contact johnUpdated = [SELECT Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :john.Id];
        System.assertEquals(null, johnUpdated.Primary_Household__c);
        System.assertEquals(company.Id, johnUpdated.Primary_Organization__c);

        Contact markUpdated = [SELECT Primary_Household__c, Primary_Organization__c FROM Contact WHERE Id = :mark.Id];
        System.assertEquals(hh.Id, markUpdated.Primary_Household__c);
        System.assertEquals(null, markUpdated.Primary_Organization__c);
    }

    @isTest
    private static void duplicateAffiliationCheck() {
        AFFL_AccRecordType_TEST.setup();

        // Insert a business account
        Account bizAcc = UTIL_UnitTestData_API.getMultipleTestAccounts(1, orgRecTypeID)[0];
        insert bizAcc;

        // Insert a contact with business account as Primary business organization
        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        contact = [SELECT AccountId, Primary_Organization__c FROM Contact WHERE Id = :contact.Id];
        contact.Primary_Organization__c = bizAcc.id;
        update contact;

        //Verify 1 affiliation is created
        List<Affiliation__c> affiliationList = [
            SELECT Id, Name, Primary__c
            FROM Affiliation__c
            WHERE Contact__c = :contact.Id AND Account__c = :bizAcc.Id
        ];
        System.assertEquals(1, affiliationList.size());
        System.assertEquals(true, affiliationList[0].Primary__c);

        // Update account recordtype
        Test.startTest();

        Account acc = [SELECT Id, RecordTypeId FROM Account WHERE id = :bizAcc.Id];
        acc.RecordTypeId = householdRecTypeID;
        update acc;

        Test.stopTest();

        //Verify no duplicate affiliations are created
        List<Affiliation__c> allAffiliationList = [
            SELECT Id, Name, Primary__c
            FROM Affiliation__c
            WHERE Contact__c = :contact.Id AND Account__c = :bizAcc.Id
        ];
        System.assertEquals(1, allAffiliationList.size());
        System.assertEquals(true, allAffiliationList[0].Primary__c);
    }

    @isTest
    private static void checkNPE() {
        AFFL_AccRecordType_TEST.setup();

        //delete an affiliation mapping
        delete [SELECT Id FROM Affl_Mappings__c WHERE Name = 'Household Account'];

        // Insert a business account
        Account bizAcc = UTIL_UnitTestData_API.getMultipleTestAccounts(1, orgRecTypeID)[0];
        insert bizAcc;

        // Insert a contact with business account as Primary business organization
        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Insert an affiliation
        Affiliation__c affl = new Affiliation__c(Contact__c = contact.Id, Account__c = bizAcc.Id, Primary__c = true);
        TDTM_ProcessControl.setRecursionFlag(
            TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_Before_Insert,
            false
        );
        insert affl;

        //Verify 1 affiliation is created
        List<Affiliation__c> affiliationList = [
            SELECT Id, Name, Primary__c
            FROM Affiliation__c
            WHERE Contact__c = :contact.Id AND Account__c = :bizAcc.Id
        ];
        System.assertEquals(1, affiliationList.size());
        System.assertEquals(true, affiliationList[0].Primary__c);

        // Update the record type of the account
        Test.startTest();

        Account acc = [SELECT Id, RecordTypeId FROM Account WHERE id = :bizAcc.Id];
        acc.RecordTypeId = householdRecTypeID;
        update acc;

        Test.stopTest();

        //Verify no duplicate affiliations are created and no NPE
        List<Affiliation__c> allAffiliationList = [
            SELECT Id, Name, Primary__c
            FROM Affiliation__c
            WHERE Contact__c = :contact.Id AND Account__c = :bizAcc.Id
        ];

        //Verify Primary Organization is Null
        Contact updatedContact = [
            SELECT id, Primary_Organization__c, Primary_Household__c
            FROM contact
            WHERE id = :contact.Id
        ];

        System.assertEquals(null, updatedContact.Primary_Organization__c);
        System.assertEquals(1, allAffiliationList.size());
        System.assertEquals(true, allAffiliationList[0].Primary__c);
    }

    /* Test to ensure an error is thrown when an affiliation is inserted with an Account whose record
     type is not a part of Affiliation Mappings when Affiliation Record Type Enforced is Enabled */

    @isTest
    private static void insertAfflWAccRecTypeEnforced() {
        AFFL_AccRecordType_TEST.setup();

        UTIL_CustomSettings_API.getSettingsForTests(
            new Hierarchy_Settings__c(
                Account_Processor__c = UTIL_Describe.getHhAccRecTypeID(),
                Affiliation_Record_Type_Enforced__c = true
            )
        );

        Contact contact = UTIL_UnitTestData_API.getContact();
        insert contact;

        //Create a Primary Affiliation to an Account with Admin record type
        Account acc = UTIL_UnitTestData_API.getMultipleTestAccounts(1, UTIL_Describe.getCustomAdminAccRecTypeID())[0];
        insert acc;

        try {
            Test.startTest();
            Affiliation__c affl = new Affiliation__c(Contact__c = contact.Id, Account__c = acc.Id, Primary__c = true);
            TDTM_ProcessControl.setRecursionFlag(
                TDTM_ProcessControl.registeredTrigger.AFFL_MultiRecordType_TDTM_Before_Insert,
                false
            );
            insert affl;
            Test.stopTest();
            System.assert(
                false,
                'Always throw an exception when Account record type is not a part of Affiliation Mappings and when Affiliation Record Type is Enforced.'
            );
        } catch (System.DmlException error) {
            System.assert(error.getMessage().contains(Label.afflAccoutMappingError));
        }
    }
}
