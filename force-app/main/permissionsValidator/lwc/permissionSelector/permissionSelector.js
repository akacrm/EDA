import { LightningElement } from "lwc";

import validatorTabPermissionSetGroups from "@salesforce/label/c.validatorTabPermissionSetGroups";
import validatorTabPermissionSets from "@salesforce/label/c.validatorTabPermissionSets";
import validatorTabProfile from "@salesforce/label/c.validatorTabProfile";

export default class PermissionSelector extends LightningElement {
    labelReference = {
        permissionSetGroupsTab: validatorTabPermissionSetGroups,
        permissionSetTab: validatorTabPermissionSets,
        profileTab: validatorTabProfile,
    };

    get disableLookup() {
        return undefined;
    }

    handleSearch(event) {
        const options = this.getOptions(event.detail.inputValue);
        this.template.querySelector("c-single-lookup").setOptions(options);
    }

    getOptions(detail) {
        if (detail.startsWith("test")) {
            return [
                {
                    label: "test 1",
                    value: "000000000000000000",
                    icon: "utility:error",
                    meta: "I am meta 1!",
                    alternativeText: "Alternative 1",
                },
                {
                    label: "test 2",
                    value: "000000000000000002",
                    icon: "utility:error",
                    meta: "I am meta 2!",
                    alternativeText: "Alternative 2",
                },
                {
                    label: "test 3",
                    value: "000000000000000003",
                    icon: "utility:error",
                    meta: "I am meta 3!",
                    alternativeText: "Alternative 3",
                },
                {
                    label: "test 4",
                    value: "000000000000000004",
                    icon: "utility:error",
                    meta: "I am meta 4!",
                    alternativeText: "Alternative 4",
                },
            ];
        }

        if (detail.startsWith("t")) {
            return [
                {
                    label: "ta",
                    value: "00000000000000000t",
                    icon: "utility:error",
                    meta: "I am meta ta!",
                    alternativeText: "Alternative ta",
                },
                {
                    label: "test 1",
                    value: "000000000000000000",
                    icon: "utility:error",
                    meta: "I am meta 1!",
                    alternativeText: "Alternative 1",
                },
                {
                    label: "test 2",
                    value: "000000000000000002",
                    icon: "utility:error",
                    meta: "I am meta 2!",
                    alternativeText: "Alternative 2",
                },
                {
                    label: "test 3",
                    value: "000000000000000003",
                    icon: "utility:error",
                    meta: "I am meta 3!",
                    alternativeText: "Alternative 3",
                },
                {
                    label: "test 4",
                    value: "000000000000000004",
                    icon: "utility:error",
                    meta: "I am meta 4!",
                    alternativeText: "Alternative 4",
                },
            ];
        }

        if (detail.startsWith("a")) {
            return [
                {
                    label: "a",
                    value: "00000000000000000a",
                    icon: "utility:error",
                    meta: "I am meta a!",
                    alternativeText: "Alternative a",
                },
            ];
        }

        return undefined;
    }

    handleInputChange(event) {
        console.log("detail changed to: " + event.detail.value);
    }
}
