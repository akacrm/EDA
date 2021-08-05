import { LightningElement, track, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

//Column Header Labels
import stgColProducts from "@salesforce/label/c.stgColProducts";
import stgColResources from "@salesforce/label/c.stgColResources";
import stgColTools from "@salesforce/label/c.stgColTools";

//EDA Labels
import stgEDAAppDesc from "@salesforce/label/c.stgEDAAppDesc";
import stgEDAAppTitle from "@salesforce/label/c.stgEDAAppTitle";
import stgEDAAppInitials from "@salesforce/label/c.stgEDAAppInitials";

//EDA Services Labels
import stgHealthCheckTitle from "@salesforce/label/c.stgHealthCheckTitle";
import stgEDCSettingsHealthCheckDescription from "@salesforce/label/c.stgEDCSettingsHealthCheckDescription";
import stgBtnHealthCheck from "@salesforce/label/c.stgBtnHealthCheck";
import stgHealthCheckA11y from "@salesforce/label/c.stgHealthCheckA11y";

//EDA Resources Labels
import stgTrailheadTitle from "@salesforce/label/c.stgTrailheadTitle";
import stgBtnEDCTrailhead from "@salesforce/label/c.stgBtnEDCTrailhead";
import stgBtnEDCTrailheadActionA11y from "@salesforce/label/c.stgBtnEDCTrailheadActionA11y";
import stgCommunityTitle from "@salesforce/label/c.stgCommunityTitle";
import stgBtnCommunity from "@salesforce/label/c.stgBtnCommunity";
import stgBtnCommunityActionA11y from "@salesforce/label/c.stgBtnCommunityActionA11y";
import stgVideosTitle from "@salesforce/label/c.stgVideosTitle";
import stgBtnVideos from "@salesforce/label/c.stgBtnVideos";
import stgBtnVideosActionA11y from "@salesforce/label/c.stgBtnVideosActionA11y";

import namespacedEDAField from "@salesforce/schema/Course_Offering_Schedule__c.Course_Offering__c";

import getEDCSettingsProductVModel from "@salesforce/apex/EducationCloudSettingsController.getEDCSettingsProductVModel";
import getProductRegistrySettingsProductInformationVModels from "@salesforce/apex/EducationCloudSettingsController.getProductRegistrySettingsProductInformationVModels";

import SystemModstamp from "@salesforce/schema/Account.SystemModstamp";

const HealthCheckContainerComponentName = "HealthCheckContainer";
const ReleaseManagementContainerComponentName = "releaseManagementContainer";
const PermissionsValidatorComponentName = "permissionsValidatorContainer";

const EDADocumentationUrl = "https://powerofus.force.com/s/article/EDA-Documentation";
const EDATrailheadUrl = "https://trailhead.salesforce.com/en/content/learn/trails/highered_heda";

const EDCTrailheadUrl = "https://trailhead.salesforce.com/en/users/sfdo/trailmixes/get-started-with-education-cloud";
const TrailblazerCommunityUrl = "https://trailblazers.salesforce.com/successHome";
const YoutubeUrl = "https://www.youtube.com/user/SalesforceFoundation";

export default class EducationCloudSettings extends NavigationMixin(LightningElement) {
    @track
    edcProductModels = [];

    labelReference = {
        productsTitle: stgColProducts,
        resourcesTitle: stgColResources,
        toolsTitle: stgColTools,
    };

    get edaComponentNavigationPrefix() {
        const apiName = namespacedEDAField.fieldApiName;
        const navigationPrefix = apiName.replace("Course_Offering__c", "");

        if (navigationPrefix === "") {
            return "c__";
        }

        return navigationPrefix;
    }

    get healthCheckContainerComponentNavigation() {
        return this.edaComponentNavigationPrefix + HealthCheckContainerComponentName;
    }

    get permissionsValidatorComponentNavigation() {
        return this.edaComponentNavigationPrefix + PermissionsValidatorComponentName;
    }

    get releaseManagementContainerComponentNavigation() {
        return this.edaComponentNavigationPrefix + ReleaseManagementContainerComponentName;
    }

    @wire(getProductRegistrySettingsProductInformationVModels)
    edcSettingsProductModels({ error, data }) {
        let tempProductModels = [];
        if (data) {
            //For each product registry 'product information' call the API to get the Product Information
            data.forEach((prodRegistry) => {
                let prodRegistrySerialized = JSON.stringify(prodRegistry);
                getEDCSettingsProductVModel({ productRegistry: prodRegistrySerialized })
                    .then((result) => {
                        if (result) {
                            this.edcProductModels.push(result);
                            this.edcProductModels.sort(this.sortByNameAsc);
                        }
                    })
                    .catch((error) => {
                        this.showErrorToast(error);
                    });
            });
        } else if (error) {
            this.showErrorToast(error);
        }
    }

    @track edcToolModels = [
        {
            title: stgHealthCheckTitle,
            description: stgEDCSettingsHealthCheckDescription,
            iconName: "custom:custom94",
            buttonLabel: stgBtnHealthCheck,
            buttonTitle: stgHealthCheckA11y,
            navigationType: "standard__component",
            navigationTarget: this.healthCheckContainerComponentNavigation,
        },
        {
            title: "Permissions Validator",
            description: "Validates permissions for SObject, SObject Field, and Apex Class access.",
            iconName: "custom:custom94",
            buttonLabel: "Go to Permissions Validator",
            buttonTitle: stgHealthCheckA11y,
            navigationType: "standard__component",
            navigationTarget: this.permissionsValidatorComponentNavigation,
        },
    ];

    @track edcResourceModels = [
        {
            title: stgTrailheadTitle,
            buttonLabel: stgBtnEDCTrailhead,
            buttonTitle: stgBtnEDCTrailheadActionA11y,
            navigationType: "standard__webPage",
            navigationTarget: EDCTrailheadUrl,
        },
        {
            title: stgCommunityTitle,
            buttonLabel: stgBtnCommunity,
            buttonTitle: stgBtnCommunityActionA11y,
            navigationType: "standard__webPage",
            navigationTarget: TrailblazerCommunityUrl,
        },
        {
            title: stgVideosTitle,
            buttonLabel: stgBtnVideos,
            buttonTitle: stgBtnVideosActionA11y,
            navigationType: "standard__webPage",
            navigationTarget: YoutubeUrl,
        },
    ];

    showErrorToast(error) {
        let errorMessage = "Unknown error";
        if (Array.isArray(error.body)) {
            errorMessage = error.body.map((e) => e.message).join(", ");
        } else {
            if (error.body && typeof error.body.message === "string") {
                errorMessage = error.body.message;
            } else {
                errorMessage = error.message;
            }
        }

        const evt = new ShowToastEvent({
            title: "Error",
            message: errorMessage,
            variant: "error",
            mode: "sticky",
        });
        this.dispatchEvent(evt);
    }

    sortByNameAsc(a, b) {
        if (a.name > b.name) {
            return 1;
        }
        if (a.name === b.name) {
            return 0;
        }
        return -1;
    }
}
