/*
    Copyright (c) 2013, Salesforce.org
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
* @date 2014
* @group TDTM
* @group-content ../../ApexDocContent/TDTM.htm
* @description Stores the default TDTM configuration.
**/
public without sharing class TDTM_DefaultConfig {

    /*******************************************************************************************************
    * @description Returns the default TDTM configuration.
    * @return List<Trigger_Handler__c> a list of trigger handler records with the default values. The records
    *         have not yet been inserted in the database. You can manipulate them, if necessary, and insert
    *         them. If no Trigger_Handler__c records exist, the application will insert the defaults when any
    *         of the triggers run.
    */
    public static List<Trigger_Handler__c> getDefaultRecords() {
        List<Trigger_Handler__c> handlers = new List<Trigger_Handler__c>();

        // Account Management on Contact
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'ACCT_IndividualAccounts_TDTM', Load_Order__c = 1.00, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate;AfterDelete'));

        // Account Naming on Lead
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'RenameLeadConvertedAccounts_TDTM', Load_Order__c = 1.00, Object__c = 'Lead',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterUpdate'));

        //Supports changing or deleting Account in existing Affiliation
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'AFFL_AccChange_TDTM', Load_Order__c = 2, Object__c = 'Affiliation__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterUpdate'));

        //Supports changing or deleting Contact in existing Affiliation
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'AFFL_ContactChange_TDTM', Load_Order__c = 2, Object__c = 'Affiliation__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterUpdate'));

        //Multi-Affiliation Type support on Affiliations - populates primary affl fields
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'AFFL_MultiRecordType_TDTM', Load_Order__c = 3, Object__c = 'Affiliation__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;AfterInsert;AfterUpdate;AfterDelete'));

        //Multi-Affiliation Type support on Account - supports account record type change
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'AFFL_AccRecordType_TDTM', Load_Order__c = 1, Object__c = 'Account',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterUpdate'));

        // Relationships on CampaignMember
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'REL_Relationships_Cm_TDTM', Load_Order__c = 1, Object__c = 'CampaignMember',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate'));

        // Relationships on Contact
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'REL_Relationships_Con_TDTM', Load_Order__c = 3, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate;AfterDelete'));

        // Relationships on Relationship__c
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'REL_Relationships_TDTM', Load_Order__c = 1, Object__c = 'Relationship__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate;AfterDelete'));

        // Addresses on Address object - copies address from Address__c to Contact and Account
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'ADDR_Addresses_TDTM', Load_Order__c = 1, Object__c = 'Address__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate;AfterInsert;AfterUpdate;AfterDelete'));

        // Addresses on Contact object - creates Address__c record from Contact
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'ADDR_Contact_TDTM', Load_Order__c = 2, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate;AfterInsert;AfterUpdate'));

        // Addresses on Account object - creates Address__c record from Account
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'ADDR_Account_TDTM', Load_Order__c = 1, Object__c = 'Account',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate;AfterInsert;AfterUpdate'));

        // Do Not Contact and related operations on Contact object
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CON_DoNotContact_TDTM', Load_Order__c = 2, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        // Preferred fields operations on Contact object
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CON_Preferred_TDTM', Load_Order__c = 3, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        // Preferred Phone fields operations on Contact object
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CON_PreferredPhone_TDTM', Load_Order__c = 4, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        // Primary Affiliation fields operations on Contact object
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CON_PrimaryAffls_TDTM', Load_Order__c = 4, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate'));

        // Affiliation management on Program Enrollment record creation
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'PREN_Affiliation_TDTM', Load_Order__c = 1, Object__c = 'Program_Enrollment__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;AfterDelete'));

        // Affiliation and Date management on Course Offering record creation
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'COFF_Affiliation_TDTM', Load_Order__c = 1, Object__c = 'Course_Offering__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate;BeforeDelete'));

        // Validation on Trigger Handler record manipulation
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'THAN_Filter_TDTM', Load_Order__c = 1, Object__c = 'Trigger_Handler__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        // Clear the TDTM cache on Trigger Handler record manipulation
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'THAN_ClearCache_TDTM', Load_Order__c = 2, Object__c = 'Trigger_Handler__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate;AfterDelete'));

        // Default dates from Term to Course Offerings
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'TERM_CourseOff_TDTM', Load_Order__c = 1, Object__c = 'Term__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterUpdate'));

        // Stops a Contact from being deleted if it has any Affiliation, Program Enrollment or Course Enrollment children
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CON_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Contact',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Stops a Account from being deleted if it has any Affiliation, Program Enrollment, Course Enrollment children or Program Plan
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'ACCT_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Account',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Stops an Address from being deleted if it has any Account or Contact children
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'ADDR_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Address__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Automatically populates the Academic Program field in a Course Enrollment
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CENR_AcademicProgram_TDTM', Load_Order__c = 1, Object__c = 'Course_Enrollment__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        // Course Connections Faculty Management on Course Enrollment object
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
              Class__c = 'CCON_Faculty_TDTM', Load_Order__c = 1, Object__c = 'Course_Enrollment__c',
              Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;AfterInsert;AfterUpdate;AfterDelete'));

        // Set other Program Plan as non-primary when one Plan is marked as Primary
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'PPlan_Primary_TDTM', Load_Order__c = 1, Object__c = 'Program_Plan__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate'));

        // Stops a Program Plan from being deleted if it has any Plan Requirement
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'PPlan_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Program_Plan__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Stops a Plan Requirement from being deleted if it has any child Plan Requirement
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'PReq_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Plan_Requirement__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Handles Program Enrollment and Program Plan
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'PREN_ProgramPlan_TDTM', Load_Order__c = 1, Object__c = 'Program_Enrollment__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert'));

        // Handles Primary Language functionality
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'CLAN_PrimaryLanguage_TDTM', Load_Order__c = 1, Object__c = 'Contact_Language__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate;AfterDelete'));

        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'CON_PrimaryLanguage_TDTM', Load_Order__c = 5, Object__c = 'Contact',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate'));

        // Start Time and End Time functionality on the Course Offering Schedule
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'COS_StartEndTime_TDTM', Load_Order__c = 1, Object__c = 'Course_Offering_Schedule__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'TB_StartEndTime_TDTM', Load_Order__c = 1, Object__c = 'Time_Block__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterUpdate'));

        //Handle unique Program Plan for plan requirements
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'PREQ_PreventPPlanParent_TDTM', Load_Order__c = 1, Object__c = 'Plan_Requirement__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate'));

        // Makes sure that linked course connection's contact matches contact lookup field
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'ATTD_CourseConnectionContact_TDTM', Load_Order__c = 1, Object__c = 'Attendance_Event__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'AfterInsert;AfterUpdate'));

        // Makes sure that the chosen Course Connection matches the chosen Contact and Course Offering
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'TGRD_ValidateData_TDTM', Load_Order__c = 1, Object__c = 'Term_Grade__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        // Prevents deletion of Terms when the records are associated with Term Grades
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'TERM_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Term__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents deletion of Affiliations when the records are associated with Course Connections
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'AFFL_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Affiliation__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents deletion of Tests when the records are associated with Test Scores
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'TST_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Test__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents changes to a Contact or Course Offering on a Course Connection when a Term Grade or an Attendance Event is present on the Course Connection.
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'CCON_PreventUpdate_TDTM', Load_Order__c = 1, Object__c = 'Course_Enrollment__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeUpdate'));

        // Prevents deletion of Course Offering when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'COFF_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Course_Offering__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents deletion of Course Connection when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'CCON_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Course_Enrollment__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents deletion of Case when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'CASE_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Case',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));
      
        // Prevents deletion of Behavior Involvement when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'BEH_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Behavior_Involvement__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));
                
        // Prevents deletion of Behavior Involvement when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'FACI_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Facility__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));
        
        // Prevents deletion of Program Enrollment when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'PREN_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Program_Enrollment__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));
                
        // Prevents deletion of Course when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'COUR_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Course__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents deletion of Time Block when the records have associated child records
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
                Class__c = 'TB_CannotDelete_TDTM', Load_Order__c = 1, Object__c = 'Time_Block__c',
                Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeDelete'));

        // Prevents creation/changes of applications with a due date prior to the open date
        handlers.add(new Trigger_Handler__c(Active__c = true, Asynchronous__c = false,
               Class__c = 'Application_TDTM', Load_Order__c = 1, Object__c = 'Application__c',
               Owned_by_Namespace__c = 'hed', Trigger_Action__c = 'BeforeInsert;BeforeUpdate'));

        return handlers;
    }
}