import { LightningElement, track, wire } from "lwc";
import { formatApexErrorsForDisplay, formatApexErrorsForToast } from "c/errorFormatter";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import getViewModel from "@salesforce/apex/PermissionSetSelectorController.getViewModel";

import dualListboxAvailable from "@salesforce/label/c.dualListboxAvailable";
import dualListboxSelected from "@salesforce/label/c.dualListboxSelected";
import errorPermissionSetSelector from "@salesforce/label/c.errorPermissionSetSelector";
import permissionSetSelectorPrompt from "@salesforce/label/c.permissionSetSelectorPrompt";
import permissionSetSelectorFieldLevelHelp from "@salesforce/label/c.permissionSetSelectorFieldLevelHelp";
export default class PermissionSetSelector extends LightningElement {
    @track viewModel;
    @track error;

    labelReference = {
        fieldLevelHelpLabel: permissionSetSelectorFieldLevelHelp,
        loadError: errorPermissionSetSelector,
        listBoxLabel: permissionSetSelectorPrompt,
        listBoxSourceLabel: dualListboxAvailable,
        selectedLabel: dualListboxSelected,
    };

    @wire(getViewModel)
    wiredViewModel({ error, data }) {
        if (data) {
            this.viewModel = data;
            this.error = undefined;
        } else if (error) {
            this.viewModel = undefined;
            this.error = formatApexErrorsForDisplay(error, this.labelReference.loadError);

            const toastFormattedError = formatApexErrorsForToast(error, this.labelReference.loadError);
            const event = new ShowToastEvent(toastFormattedError);
            this.dispatchEvent(event);
        }
    }

    get showError() {
        return !this.viewModel && !!this.error;
    }

    get options() {
        if (!this.viewModel) {
            return [];
        }

        return this.viewModel.permissionSetViewModelList;
    }

    get showActivityIndicator() {
        if (!this.viewModel) {
            return true;
        }

        return undefined;
    }

    get size() {
        return 10;
    }

    handleChange(e) {
        let permissionSetArray = e.detail.value;

        const detail = {
            permissionSetArray: permissionSetArray,
        };

        const permissionSetSelectedEvent = new CustomEvent("permissionsetselected", {
            detail: detail,
            bubbles: true,
            composed: true,
        });

        this.dispatchEvent(permissionSetSelectedEvent);
    }
}
