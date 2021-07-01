import { createElement } from "lwc";
import HealthCheckRun from "c/healthCheckRun";

describe("c-health-check-run", () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it("Health Check Run Card should display proper title", () => {
        const element = createElement("c-health-check-run", {
            is: HealthCheckRun,
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const healthCheckRunCardEl = element.shadowRoot.querySelector(
                'lightning-card[data-id="healthCheckRunCard"]'
            );
            expect(healthCheckRunCardEl.title).toBe("c.stgHealthCheckTitle");
        });
    });

    it("Health Check Run Card should display proper descripton", () => {
        const element = createElement("c-health-check-run", {
            is: HealthCheckRun,
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const healthCheckRunDescriptionEl = element.shadowRoot.querySelector(
                '[data-id="healthCheckRunDescription"]'
            );
            expect(healthCheckRunDescriptionEl.textContent).toBe("c.stgHealthCheckDescription");
        });
    });

    it("Health Check Run Card should display last run date if last run date not empty", () => {
        const element = createElement("c-health-check-run", {
            is: HealthCheckRun,
        });
        document.body.appendChild(element);

        element.runDate = "test run date";

        return Promise.resolve().then(() => {
            const healthCheckRunLastRunDateEl = element.shadowRoot.querySelector(
                '[data-id="healthCheckRunLastRunDate"]'
            );
            expect(healthCheckRunLastRunDateEl.textContent).toBe("c.stgHealthCheckLastRun");
        });
    });

    it("Health Check Run Card should not display last run date if last run date empty", () => {
        const element = createElement("c-health-check-run", {
            is: HealthCheckRun,
        });
        document.body.appendChild(element);

        element.runDate = undefined;

        return Promise.resolve().then(() => {
            const healthCheckRunLastRunDateEl = element.shadowRoot.querySelector(
                '[data-id="healthCheckRunLastRunDate"]'
            );
            expect(healthCheckRunLastRunDateEl.toBeFalsy);
        });
    });

    it("Health Check Run Button should display properly", () => {
        const element = createElement("c-health-check-run", {
            is: HealthCheckRun,
        });
        document.body.appendChild(element);

        return Promise.resolve().then(() => {
            const healthCheckRunButtonEl = element.shadowRoot.querySelector('[data-id="healthCheckRunButton"]');
            expect(healthCheckRunButtonEl.title).toBe("c.stgHealthCheckRunButton");
            expect(healthCheckRunButtonEl.title).toBe("c.stgHealthCheckRunButton");
        });
    });

    it("Health Check Run Button should dispatch event properly", () => {
        const element = createElement("c-health-check-run", {
            is: HealthCheckRun,
        });
        document.body.appendChild(element);

        // Mock handler for toast event
        const handler = jest.fn();
        // Add event listener to catch toast event
        element.addEventListener("runhealthcheck", handler);

        const healthCheckRunButtonEl = element.shadowRoot.querySelector('[data-id="healthCheckRunButton"]');
        healthCheckRunButtonEl.click();

        expect(handler).toHaveBeenCalled();
    });
});
