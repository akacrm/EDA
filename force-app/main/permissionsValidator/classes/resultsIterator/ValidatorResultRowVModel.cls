public with sharing class ValidatorResultRowVModel implements Comparable {
    ValidatorRequirementState createState;
    ValidatorRequirementState readState;
    ValidatorRequirementState updateState;
    ValidatorRequirementState deleteState;

    @AuraEnabled
    public String description;

    public ValidatorResultRowVModel(
        String id,
        String metadatatype,
        String apiname,
        String description,
        ValidatorRequirementState createState,
        ValidatorRequirementState readState,
        ValidatorRequirementState updateState,
        ValidatorRequirementState deleteState
    ) {
        this.id = id;
        this.metadatatype = metadatatype;
        this.apiname = apiname;
        this.description = description;
        this.createState = createState;
        this.readState = readState;
        this.updateState = updateState;
        this.deleteState = deleteState;
    }

    @AuraEnabled
    public String id { get; private set; }

    @AuraEnabled
    public String metadatatype { get; private set; }

    @AuraEnabled
    public String apiname { get; private set; }

    @AuraEnabled
    public Boolean passed {
        get {
            return this.readState != ValidatorRequirementState.MISSING &&
                this.createState != ValidatorRequirementState.MISSING &&
                this.updateState != ValidatorRequirementState.MISSING &&
                this.deleteState != ValidatorRequirementState.MISSING;
        }
    }

    @AuraEnabled
    public String readClass {
        get {
            return this.getClassFromStatus(this.readState);
        }
    }

    @AuraEnabled
    public String readAccess {
        get {
            return this.getAccessFromStatus(this.readState);
        }
    }

    @AuraEnabled
    public String createClass {
        get {
            return this.getClassFromStatus(this.createState);
        }
    }

    @AuraEnabled
    public String createAccess {
        get {
            return this.getAccessFromStatus(this.createState);
        }
    }

    @AuraEnabled
    public String editClass {
        get {
            return this.getClassFromStatus(this.updateState);
        }
    }

    @AuraEnabled
    public String editAccess {
        get {
            return this.getAccessFromStatus(this.updateState);
        }
    }

    @AuraEnabled
    public String deleteClass {
        get {
            return this.getClassFromStatus(this.deleteState);
        }
    }

    @AuraEnabled
    public String deleteAccess {
        get {
            return this.getAccessFromStatus(this.deleteState);
        }
    }

    @TestVisible
    private String getClassFromStatus(ValidatorRequirementState state) {
        switch on state {
            when MISSING {
                return 'slds-text-color_error';
            }
            when FOUND {
                return 'slds-text-color_success';
            }
            when else {
                return '';
            }
        }
    }

    @TestVisible
    private String getAccessFromStatus(ValidatorRequirementState state) {
        switch on state {
            when MISSING {
                return Label.missingAccess;
            }
            when FOUND {
                return Label.foundAccess;
            }
            when else {
                return '';
            }
        }
    }

    public Integer CompareTo(Object compareTo) {
        if (!(compareTo instanceof ValidatorResultRowVModel)) {
            return 0;
        }

        ValidatorResultRowVModel model = (ValidatorResultRowVModel) compareTo;
        Integer metadataTypeCompare = this.metadatatype.compareTo(model.metadatatype);

        if (metadataTypeCompare != 0) {
            return metadataTypeCompare;
        }

        return this.apiname.compareTo(model.apiname);
    }
}
