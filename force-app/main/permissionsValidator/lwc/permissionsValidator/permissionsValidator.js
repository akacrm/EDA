import { LightningElement, track } from "lwc";
import { formatApexErrorsForDisplay, formatApexErrorsForToast } from "c/errorFormatter";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import errorPermissionDefinitions from "@salesforce/label/c.errorPermissionDefinitions";
import permissionsValidator from "@salesforce/label/c.permissionsValidator";
import validatorActionMenuAllAccess from "@salesforce/label/c.validatorActionMenuAllAccess";
import validatorActionMenuMissingAccessOnly from "@salesforce/label/c.validatorActionMenuMissingAccessOnly";
import validatorActionMenuTitle from "@salesforce/label/c.validatorActionMenuTitle";
import validatorDescription from "@salesforce/label/c.validatorDescription";
import validatorDescriptionAll from "@salesforce/label/c.validatorDescriptionAll";
import validatorDescriptionMissingOnly from "@salesforce/label/c.validatorDescriptionMissingOnly";
import validatorRunButton from "@salesforce/label/c.validatorRunButton";
import validatorRunButtonTitle from "@salesforce/label/c.validatorRunButtonTitle";
import validatorRunCompleteTitle from "@salesforce/label/c.validatorRunCompleteTitle";
import validatorRunCompleteDescription from "@salesforce/label/c.validatorRunCompleteDescription";

import getFeatureNames from "@salesforce/apex/PermissionsValidatorController.getFeatureNames";
export default class PermissionsValidator extends LightningElement {
    @track iteratorViewModel;
    @track featureValidationsLoaded = 0;
    @track error;
    @track displayMode = "onlyMissingAccess";

    labelReference = {
        actionMenuTitle: validatorActionMenuTitle,
        actionMenuOptionAllMode: validatorActionMenuMissingAccessOnly,
        actionMenuOptionMissingMode: validatorActionMenuAllAccess,
        cardTitle: permissionsValidator,
        cardDescription: validatorDescription,
        displayAllDescription: validatorDescriptionAll,
        displayMissingOnlyDescription: validatorDescriptionMissingOnly,
        loadError: errorPermissionDefinitions,
        runButtonLabel: validatorRunButton,
        runButtonTitle: validatorRunButtonTitle,
        runCompleteTitle: validatorRunCompleteTitle,
        runCompleteDescription: validatorRunCompleteDescription,
    };

    featureNames;
    selectedProfileId = "";
    selectedPermissionSetIdArray = [];
    selectedPermissionSetGroupIdArray = [];

    get showError() {
        return !this.viewModel && !!this.error;
    }

    get showResultsIterator() {
        if (!this.iteratorViewModel) {
            return false;
        }
        return true;
    }

    get runButtonDisabled() {
        if (
            !this.selectedProfileId &&
            this.selectedPermissionSetIdArray.length === 0 &&
            this.selectedPermissionSetGroupIdArray.length === 0
        ) {
            return true;
        }

        return undefined;
    }

    get runModeDescription() {
        if (!this.showOnlyMissingAccess) {
            return this.labelReference.displayAllDescription;
        }

        return this.labelReference.displayMissingOnlyDescription;
    }

    get showOnlyMissingAccess() {
        if (this.displayMode !== "onlyMissingAccess") {
            return undefined;
        }

        return true;
    }

    get showAllAccess() {
        if (this.displayMode !== "allAccess") {
            return undefined;
        }

        return true;
    }

    handleActionMenuSelect(event) {
        switch (event.detail.value) {
            case "onlyMissingAccess":
                this.resetFeatureRun();
                this.displayMode = "onlyMissingAccess";
                break;
            case "allAccess":
                this.resetFeatureRun();
                this.displayMode = "allAccess";
                break;
            case "runPermissionsValidator":
                this.loadFeatureNames(this.featureNames);
                break;
        }
    }

    handleRunClick(event) {
        this.loadFeatureNames(this.featureNames);
    }

    resetFeatureRun() {
        this.featureValidationsLoaded = 0;
        this.iteratorViewModel = undefined;
    }

    loadFeatureNames() {
        this.resetFeatureRun();

        getFeatureNames()
            .then((result) => {
                this.error = undefined;
                this.iteratorViewModel = {
                    featureNames: result,
                    displayMode: this.displayMode,
                    profileId: this.selectedProfileId,
                    permissionSetIdArray: this.selectedPermissionSetIdArray,
                    permissionSetGroupIdArray: this.selectedPermissionSetGroupIdArray,
                };
            })
            .catch((error) => {
                this.viewModel = undefined;
                this.error = formatApexErrorsForDisplay(error, this.labelReference.loadError);

                const toastFormattedError = formatApexErrorsForToast(error, this.labelReference.loadError);
                const event = new ShowToastEvent(toastFormattedError);
                this.dispatchEvent(event);
            });
    }

    resultDataLoadedHandler(event) {
        event.stopPropagation();
        this.featureValidationsLoaded++;

        if (this.featureValidationsLoaded === this.iteratorViewModel.featureNames.length) {
            const event = new ShowToastEvent({
                title: this.labelReference.runCompleteTitle,
                message: this.labelReference.runCompleteDescription,
                variant: "success",
            });
            this.dispatchEvent(event);
        }
    }

    handleProfileSelected(event) {
        event.stopPropagation();
        this.selectedProfileId = event.detail.profileId;
    }

    handlePermissionSetSelected(event) {
        event.stopPropagation();
        this.selectedPermissionSetIdArray = event.detail.permissionSetArray;
    }

    handlePermissionSetGroupSelected(event) {
        event.stopPropagation();
        this.selectedPermissionSetGroupIdArray = event.detail.permissionSetGroupArray;
    }
}
