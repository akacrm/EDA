import { LightningElement, track, wire } from "lwc";
import { formatApexErrorsForDisplay, formatApexErrorsForToast } from "c/errorFormatter";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import getViewModel from "@salesforce/apex/ProfileSelectorController.getViewModel";

import dualListboxAvailable from "@salesforce/label/c.duallistboxavailable";
import dualListboxSelected from "@salesforce/label/c.duallistboxselected";
import errorProfileSelector from "@salesforce/label/c.errorProfileSelector";
import profileSelectorPrompt from "@salesforce/label/c.profileselectorprompt";
import profileSelectorFieldLevelHelp from "@salesforce/label/c.profileselectorfieldlevelhelp";
export default class ProfileSelector extends LightningElement {
    @track viewModel;

    labelReference = {
        listBoxLabel: profileSelectorPrompt,
        listboxSourceLabel: dualListboxAvailable,
        loadError: errorProfileSelector,
        selectedLabel: dualListboxSelected,
        fieldLevelHelpLabel: profileSelectorFieldLevelHelp,
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

        return this.viewModel.profileViewModelList;
    }

    get showActivityIndicator() {
        if (!this.viewModel) {
            return true;
        }

        return undefined;
    }

    get min() {
        return 0;
    }

    get max() {
        return 1;
    }

    get size() {
        return 10;
    }

    handleChange(e) {
        let profileId;

        if (e.detail.value.length > 0) {
            profileId = e.detail.value[0];
        } else {
            profileId = "";
        }

        const detail = {
            profileId: profileId,
        };

        const profileSelectedEvent = new CustomEvent("profileselected", {
            detail: detail,
            bubbles: true,
            composed: true,
        });

        this.dispatchEvent(profileSelectedEvent);
    }
}
