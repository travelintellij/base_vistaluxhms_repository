package com.vistaluxhms.base;

import com.vistaluxhms.model.CentralConfigEntityDTO;
import com.vistaluxhms.model.ratecard.MealPlanRate;
import com.vistaluxhms.model.ratecard.RateCard;
import com.vistaluxhms.model.ratecard.RoomCategory;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.junit.jupiter.api.Test;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import java.util.*;

class BaseApplicationTests {

	@Test
	void testSalesPartnerRateShareTemplate() throws Exception {
		Configuration freemarkerConfig = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
		freemarkerConfig.setClassForTemplateLoading(this.getClass(), "/templates");

		Map<String, Object> model = new HashMap<>();
		model.put("salesPartnerName", "Test Partner");
		model.put("serviceAdvisorMobile", "9876543210");

		CentralConfigEntityDTO centralConfig = new CentralConfigEntityDTO();
		centralConfig.setHotelName("VanChhavi Resort");
		centralConfig.setHotelAddress("Jim Corbett");
		centralConfig.setCentralNumber("9876543210");
		centralConfig.setCentralizedEmail("reservations@vanchhavi.in");
		centralConfig.setGstNumber("05AAAAA0000A1Z5");
		centralConfig.setLogoPath("https://mcusercontent.com/test.png");
		centralConfig.setWebsite("https://vanchhavi.in");
		model.put("centralConfig", centralConfig);
		model.put("logoUrl", "https://mcusercontent.com/test.png");

		List<RateCard> rateCards = new ArrayList<>();
		RateCard rc = new RateCard();
		rc.setSessionId(1);
		rc.setSeasonName("Summer Season");
		rc.setSeasonStartDate("01-04-2026");
		rc.setSeasonEndDate("30-06-2026");
		rc.setApplicableDates(Arrays.asList("01-04-2026 to 30-06-2026"));

		RoomCategory cat = new RoomCategory();
		cat.setName("Deluxe Room");
		cat.setStandardOccupancy(2);
		cat.setMaxOccupancy(3);
		cat.setExtraBed(1);

		List<MealPlanRate> mealPlans = new ArrayList<>();
		for (int m = 1; m <= 4; m++) {
			MealPlanRate mp = new MealPlanRate();
			mp.setMealPlanId(m);
			Map<String, Integer> rates = new HashMap<>();
			rates.put("1", 5000 + m * 500);
			rates.put("2", 6000 + m * 500);
			mp.setPersonWiseRates(rates);
			mealPlans.add(mp);
		}
		cat.setMealPlans(mealPlans);
		rc.setRoomCategories(Collections.singletonList(cat));
		rateCards.add(rc);

		model.put("rateCardList", rateCards);

		Template template = freemarkerConfig.getTemplate("sales_partner_rate_share.ftl");
		String html = FreeMarkerTemplateUtils.processTemplateIntoString(template, model);
		org.junit.jupiter.api.Assertions.assertNotNull(html);
		org.junit.jupiter.api.Assertions.assertTrue(html.contains("TEST PARTNER"));
		org.junit.jupiter.api.Assertions.assertTrue(html.contains("https://mcusercontent.com/test.png"));
	}

}


