import { createElement } from "lwc";
import HealthCheck from "c/healthCheck";
import { registerLdsTestWireAdapter } from "@salesforce/sfdx-lwc-jest";
import { getRecord } from "lightning/uiRecordApi";

const getRecordWireAdapter = registerLdsTestWireAdapter(getRecord);
const mockGetHealthCheckViewModel = require("./data/getHealthCheckViewModel.json");

describe("c-health-check", () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it("Proper values should be passed to Health Check Run", () => {
        const element = createElement("c-health-check", {
            is: HealthCheck,
        });
        document.body.appendChild(element);
        getRecordWireAdapter.emit(mockGetHealthCheckViewModel);

        return Promise.resolve().then(() => {
            //const childElem = element.shadowRoot.querySelector('c-health-check-run');
            expect(mockGetHealthCheckViewModel.lastRunDate).toBe("2021-07-06");
            expect(mockGetHealthCheckViewModel.healthCheckDefinitionsToDisplayList[0].className).toBe("Test Class 1");
        });
    });
});
