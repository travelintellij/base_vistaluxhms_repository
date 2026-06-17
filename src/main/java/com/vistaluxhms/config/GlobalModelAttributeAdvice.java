package com.vistaluxhms.config;

import com.vistaluxhms.model.CentralConfigEntityDTO;
import com.vistaluxhms.services.SettingsAndOtherServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalModelAttributeAdvice {

    @Autowired
    private SettingsAndOtherServicesImpl settingService;

    @ModelAttribute("centralConfig")
    public CentralConfigEntityDTO globalCentralConfig() {
        return settingService.getCentralConfig();
    }
}
