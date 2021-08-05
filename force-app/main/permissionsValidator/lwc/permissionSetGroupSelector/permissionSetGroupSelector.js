import { LightningElement, track, wire } from "lwc";
import { formatApexErrorsForDisplay, formatApexErrorsForToast } from "c/errorFormatter";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import getViewModel from "@salesforce/apex/PermissionSetGroupSelectorController.getViewModel";

import dualListboxAvailable from "@salesforce/label/c.duallistboxavailable";
import dualListboxSelected from "@salesforce/label/c.duallistboxselected";
import errorPermissionSetGroupSelector from "@salesforce/label/c.errorPermissionSetGroupSelector";
import permissionSetGroupSelectorPrompt from "@salesforce/label/c.permissionsetgroupselectorprompt";
import permissionSetGroupSelectorFieldLevelHelp from "@salesforce/label/c.permissionsetgroupselectorfieldlevelhelp";
export default class PermissionSetGroupSelector extends LightningElement {
    @track viewModel;
    @track error;

    labelReference = {
        listBoxLabel: permissionSetGroupSelectorPrompt,
        listboxSourceLabel: dualListboxAvailable,
        loadError: errorPermissionSetGroupSelector,
        selectedLabel: dualListboxSelected,
        fieldLevelHelpLabel: permissionSetGroupSelectorFieldLevelHelp,
    };

    @wire(getViewModel)
    wiredViewModel({ error, data }) {
        if (data) {
            this.error = undefined;
            this.viewModel = data;
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

        return this.viewModel.permissionSetGroupViewModelList;
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
        let permissionSetGroupArray = e.detail.value;

        const detail = {
            permissionSetGroupArray: permissionSetGroupArray,
        };

        const permissionSetGroupSelectedEvent = new CustomEvent("permissionsetgroupselected", {
            detail: detail,
            bubbles: true,
            composed: true,
        });

        this.dispatchEvent(permissionSetGroupSelectedEvent);
    }
}
