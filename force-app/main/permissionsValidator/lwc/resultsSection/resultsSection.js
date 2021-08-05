import { LightningElement, api, track, wire } from "lwc";
import { formatApexErrorsForDisplay, formatApexErrorsForToast } from "c/errorFormatter";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import accessMetDescription from "@salesforce/label/c.accessMetDescription";
import dataTableHeadingAPIName from "@salesforce/label/c.dataTableHeadingAPIName";
import dataTableHeadingCreate from "@salesforce/label/c.dataTableHeadingCreate";
import dataTableHeadingDelete from "@salesforce/label/c.dataTableHeadingDelete";
import dataTableHeadingEdit from "@salesforce/label/c.dataTableHeadingEdit";
import dataTableHeadingMetadataType from "@salesforce/label/c.dataTableHeadingMetadataType";
import dataTableHeadingRead from "@salesforce/label/c.dataTableHeadingRead";
import errorFeatureValidatorResults from "@salesforce/label/c.errorFeatureValidatorResults";
import missingAccessTableDescription from "@salesforce/label/c.missingAccessTableDescription";

import getViewModel from "@salesforce/apex/ResultsIteratorController.getViewModel";
import TickerSymbol from "@salesforce/schema/Account.TickerSymbol";
export default class ResultsSection extends LightningElement {
    @api featureName;
    @api displayMode;
    @api selectedProfileId;
    @api selectedPermissionSetIdArray;
    @api selectedPermissionSetGroupIdArray;
    @track viewModel;

    refreshApexHack;
    minColumnWidth = 90;

    labelReference = {
        accessMetDescription: accessMetDescription,
        accessMissingDescription: missingAccessTableDescription,
        columnAPIName: dataTableHeadingAPIName,
        columnCreate: dataTableHeadingCreate,
        columnDelete: dataTableHeadingDelete,
        columnEdit: dataTableHeadingEdit,
        columnMetadataType: dataTableHeadingMetadataType,
        columnRead: dataTableHeadingRead,
        loadError: errorFeatureValidatorResults,
    };

    columns = [
        {
            label: this.labelReference.columnMetadataType,
            fieldName: "metadatatype",
        },
        {
            label: this.labelReference.columnAPIName,
            fieldName: "apiname",
        },
        {
            label: this.labelReference.columnRead,
            fieldName: "readAccess",
            cellAttributes: {
                class: { fieldName: "readClass" },
            },
        },
        {
            label: this.labelReference.columnCreate,
            fieldName: "createAccess",
            cellAttributes: {
                class: { fieldName: "createClass" },
            },
        },
        {
            label: this.labelReference.columnEdit,
            fieldName: "editAccess",
            cellAttributes: {
                class: { fieldName: "editClass" },
            },
        },
        {
            label: this.labelReference.columnDelete,
            fieldName: "deleteAccess",
            cellAttributes: {
                class: { fieldName: "deleteClass" },
            },
        },
    ];

    @wire(getViewModel, {
        featureName: "$featureName",
        showAll: "$showAllAccess",
        profileId: "$selectedProfileId",
        permissionSetIdList: "$selectedPermissionSetIdArray",
        permissionSetGroupIdList: "$selectedPermissionSetGroupIdArray",
    })
    viewModelResult(result) {
        this.refreshApexHack = result;
        const { error, data } = result;
        if (data) {
            this.error = undefined;
            this.viewModel = data;
            this.dispatchLoadedEvent();
        } else if (error) {
            this.viewModel = undefined;
            this.error = formatApexErrorsForDisplay(error, this.labelReference.loadError);

            const toastFormattedError = formatApexErrorsForToast(error, this.labelReference.loadError);
            const event = new ShowToastEvent(toastFormattedError);
            this.dispatchEvent(event);
            this.dispatchLoadedEvent();
        }
    }

    dispatchLoadedEvent() {
        const resultDataLoadedEvent = new CustomEvent("resultdataloaded", {
            bubbles: true,
            composed: true,
        });

        this.dispatchEvent(resultDataLoadedEvent);
    }

    get showAllAccess() {
        if (this.displayMode === "allAccess") {
            return true;
        }

        return false;
    }

    get cardIcon() {
        if (!!this.error) {
            return "utility:error";
        }

        if (!this.viewModel) {
            return "standard:generic_loading";
        }

        return this.viewModel.icon;
    }

    get cardTitleA11yText() {
        if (!this.viewModel) {
            return "";
        }

        return this.viewModel.statusLabel;
    }

    get showError() {
        return !this.viewModel && !!this.error;
    }

    get dataLoaded() {
        if (!this.viewModel) {
            return false;
        }

        return true;
    }

    get accessMissing() {
        if (!this.viewModel || this.viewModel.status === "Pass") {
            return false;
        }

        return true;
    }

    get showTable() {
        if (!this.viewModel || !this.viewModel.tableData || this.viewModel.tableData.length === 0) {
            return false;
        }

        return true;
    }
}
