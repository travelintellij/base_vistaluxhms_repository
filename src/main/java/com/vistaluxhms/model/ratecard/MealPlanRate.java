package com.vistaluxhms.model.ratecard;

import java.util.Map;

public class MealPlanRate {
    private Integer mealPlanId; // e.g., "EPAI", "CPAI"
    private Map<String, Integer> personWiseRates; // Key: person number (1 to 6), Value: rate

    // Getters and Setters

    public Integer getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(Integer mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    public Map<String, Integer> getPersonWiseRates() {
        return personWiseRates;
    }

    public void setPersonWiseRates(Map<String, Integer> personWiseRates) {
        this.personWiseRates = personWiseRates;
    }
}
