package com.vistaluxhms.controller;

import com.vistaluxhms.entity.CampaignFormEntity;
import com.vistaluxhms.model.CampaignFormDTO;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.repository.CampaignFormRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class CampaignController {

    @Autowired
    private CampaignFormRepository campaignFormRepository;

    private UserDetailsObj getLoggedInUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDetailsObj userObj = new UserDetailsObj();
        if (principal instanceof UserDetails) {
            userObj.setUsername(((UserDetails) principal).getUsername());
        }
        return userObj;
    }

    // ===================== META FORM ID =====================

    /**
     * Display the 'Add Meta Form' page.
     * Used for registering new Meta/Facebook Lead Gen forms into the system.
     */
    @RequestMapping("view_add_meta_form")
    public ModelAndView viewAddMetaForm(@ModelAttribute("CAMPAIGN_FORM_OBJ") CampaignFormDTO campaignFormDTO,
            BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/campaign/Admin_Add_MetaForm");
        modelView.addObject("userName", userObj.getUsername());
        return modelView;
    }

    @PostMapping("create_meta_form")
    public ModelAndView createMetaForm(@ModelAttribute("CAMPAIGN_FORM_OBJ") CampaignFormDTO campaignFormDTO,
            BindingResult result, final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView();

        if (campaignFormDTO.getFormName() == null || campaignFormDTO.getFormName().trim().isEmpty()) {
            result.rejectValue("formName", "form.error", "Form Name is required");
        }
        if (campaignFormDTO.getFormId() == null || campaignFormDTO.getFormId().trim().isEmpty()) {
            result.rejectValue("formId", "form.error", "Meta Form ID is required");
        }

        if (result.hasErrors()) {
            modelView = viewAddMetaForm(campaignFormDTO, result);
        } else {
            CampaignFormEntity entity = new CampaignFormEntity();
            entity.setFormName(campaignFormDTO.getFormName());
            entity.setFormType("META");
            entity.setFormId(campaignFormDTO.getFormId());
            entity.setCampaignName(campaignFormDTO.getCampaignName());
            entity.setDescription(campaignFormDTO.getDescription());
            entity.setActive(campaignFormDTO.getActive() != null ? campaignFormDTO.getActive() : true);
            campaignFormRepository.save(entity);
            redirectAttrib.addFlashAttribute("Success", "Meta Form ID saved successfully.");
            modelView.setViewName("redirect:view_campaign_list");
        }
        return modelView;
    }

    // ===================== CAMPAIGN LIST =====================

    /**
     * Display the list of all registered Meta Campaign Forms.
     * Provides options to edit, toggle status, and delete forms.
     */
    @RequestMapping("view_campaign_list")
    public ModelAndView viewCampaignList() {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/campaign/viewCampaignListing");
        modelView.addObject("userName", userObj.getUsername());
        List<CampaignFormEntity> allForms = campaignFormRepository.findAllByOrderByCreatedAtDesc();
        modelView.addObject("CAMPAIGN_FORM_LIST", allForms);
        return modelView;
    }

    // ===================== EDIT =====================

    @RequestMapping("view_edit_campaign_form")
    public ModelAndView viewEditCampaignForm(@RequestParam("campaignFormId") Long campaignFormId) {
        UserDetailsObj userObj = getLoggedInUser();
        CampaignFormEntity entity = campaignFormRepository.findById(campaignFormId).orElse(null);
        if (entity == null) {
            return new ModelAndView("redirect:view_campaign_list");
        }
        CampaignFormDTO dto = new CampaignFormDTO();
        dto.updateFromEntity(entity);

        String viewName = "admin/campaign/Admin_Edit_MetaForm";

        ModelAndView modelView = new ModelAndView(viewName);
        modelView.addObject("CAMPAIGN_FORM_OBJ", dto);
        modelView.addObject("userName", userObj.getUsername());
        return modelView;
    }

    @PostMapping("edit_campaign_form")
    public ModelAndView editCampaignForm(@ModelAttribute("CAMPAIGN_FORM_OBJ") CampaignFormDTO campaignFormDTO,
            BindingResult result, final RedirectAttributes redirectAttrib) {
        ModelAndView modelView = new ModelAndView();

        CampaignFormEntity entity = campaignFormRepository.findById(campaignFormDTO.getCampaignFormId()).orElse(null);
        if (entity == null) {
            redirectAttrib.addFlashAttribute("Error", "Campaign form not found.");
            modelView.setViewName("redirect:view_campaign_list");
            return modelView;
        }

        entity.setFormName(campaignFormDTO.getFormName());
        entity.setFormId(campaignFormDTO.getFormId());
        entity.setCampaignName(campaignFormDTO.getCampaignName());
        entity.setDescription(campaignFormDTO.getDescription());
        entity.setActive(campaignFormDTO.getActive() != null ? campaignFormDTO.getActive() : true);
        campaignFormRepository.save(entity);

        redirectAttrib.addFlashAttribute("Success", "Campaign form updated successfully.");
        modelView.setViewName("redirect:view_campaign_list");
        return modelView;
    }

    // ===================== TOGGLE STATUS =====================

    /**
     * Toggle the active/inactive status of a campaign form.
     * Inactive forms won't be visible in the sync dropdowns.
     */
    @GetMapping("toggle_campaign_form_status")
    public String toggleCampaignFormStatus(@RequestParam("campaignFormId") Long campaignFormId,
            final RedirectAttributes redirectAttrib) {
        CampaignFormEntity entity = campaignFormRepository.findById(campaignFormId).orElse(null);
        if (entity != null) {
            entity.setActive(!entity.getActive());
            campaignFormRepository.save(entity);
            String status = entity.getActive() ? "activated" : "deactivated";
            redirectAttrib.addFlashAttribute("Success",
                    "Form \"" + entity.getFormName() + "\" " + status + " successfully.");
        }
        return "redirect:view_campaign_list";
    }

    // ===================== DELETE =====================

    @GetMapping("delete_campaign_form")
    public String deleteCampaignForm(@RequestParam("campaignFormId") Long campaignFormId,
            final RedirectAttributes redirectAttrib) {
        CampaignFormEntity entity = campaignFormRepository.findById(campaignFormId).orElse(null);
        if (entity != null) {
            campaignFormRepository.delete(entity);
            redirectAttrib.addFlashAttribute("Success", "Form \"" + entity.getFormName() + "\" deleted successfully.");
        }
        return "redirect:view_campaign_list";
    }
}
