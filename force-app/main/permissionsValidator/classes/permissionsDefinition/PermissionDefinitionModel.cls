public abstract with sharing class PermissionDefinitionModel {
    public String featureName;
    public String apiName;
    public String apiSubName;
    public Boolean createAccessRequired = false;
    public Boolean deleteAccessRequired = true;
    public Boolean readAccessRequired = true;
    public Boolean updateAccessRequired = true;

    public PermissionDefinitionModel() {
    }

    public abstract String getMetadataType();

    public abstract String getRequiredAccess(
        Boolean createAccess,
        Boolean readAccess,
        Boolean updateAccess,
        Boolean deleteAccess
    );

    public AccessCheck hasRequiredAccess(
        Boolean createAccess,
        Boolean readAccess,
        Boolean updateAccess,
        Boolean deleteAccess
    ) {
        return new AccessCheck(
            this.getValidatorRequirementState(this.createAccessRequired, createAccess),
            this.getValidatorRequirementState(this.readAccessRequired, readAccess),
            this.getValidatorRequirementState(this.updateAccessRequired, updateAccess),
            this.getValidatorRequirementState(this.deleteAccessRequired, deleteAccess)
        );
    }

    @TestVisible
    private ValidatorRequirementState getValidatorRequirementState(Boolean accessRequired, Boolean accessExists) {
        if (accessRequired == false) {
            return ValidatorRequirementState.NOT_REQUIRED;
        }

        if (accessExists == false) {
            return ValidatorRequirementState.MISSING;
        }

        return ValidatorRequirementState.FOUND;
    }

    public virtual String getQualifiedName() {
        return this.apiName;
    }

    public virtual String getQualifiedSubName() {
        return this.apiSubName;
    }

    public virtual String getQualifiedFullName() {
        if (String.isBlank(this.apiSubName)) {
            return this.getQualifiedName();
        }

        return this.getQualifiedName() + '.' + this.getQualifiedSubName();
    }

    public class AccessCheck {
        public ValidatorRequirementState createState;
        public ValidatorRequirementState readState;
        public ValidatorRequirementState updateState;
        public ValidatorRequirementState deleteState;

        public AccessCheck(
            ValidatorRequirementState createState,
            ValidatorRequirementState readState,
            ValidatorRequirementState updateState,
            ValidatorRequirementState deleteState
        ) {
            this.createState = createState;
            this.readState = readState;
            this.updateState = updateState;
            this.deleteState = deleteState;
        }

        public Boolean passed {
            get {
                return this.createState != ValidatorRequirementState.MISSING &&
                    this.readState != ValidatorRequirementState.MISSING &&
                    this.updateState != ValidatorRequirementState.MISSING &&
                    this.deleteState != ValidatorRequirementState.MISSING;
            }
        }
    }
}
