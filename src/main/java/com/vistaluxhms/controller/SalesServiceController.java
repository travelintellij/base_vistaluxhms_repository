package com.vistaluxhms.controller;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.model.RateType_Obj;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
public class SalesServiceController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    SalesRelatesServicesImpl salesService;

    private UserDetailsObj getLoggedInUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails)principal).getUsername();
        } else {
            username = principal.toString();
        }
        UserDetailsObj userObj = (UserDetailsObj) userDetailsService.loadUserByUsername(username);

        return userObj;
    }
    @RequestMapping("view_add_rate_type_form")
    public ModelAndView view_add_rate_type_form(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result ) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/Admin_Add_RateType");
        return modelView;
    }

    @PostMapping(value="create_edit_rate_type")
    public ModelAndView create_create_rate_type(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView();
        //cityMgmtValidator.validate(cityObj, result);
        if(result.hasErrors()) {
            modelView = view_add_rate_type_form(rateTypeObj,result );
        } else {
            RateTypeEntity rateTypeEntity = new RateTypeEntity(rateTypeObj);
            salesService.saveRateType(rateTypeEntity);
            redirectAttrib.addFlashAttribute("Success", "Rate Type Record is updated Successfully..");
            modelView.setViewName("redirect:view_rate_type_list");
        }
        return modelView;
    }

    @RequestMapping("view_rate_type_list")
    public ModelAndView view_rate_type_listing(@ModelAttribute("RATE_TYPE_LIST") RateType_Obj rateTypeObj, BindingResult result ) {
        //pageSize = UdanChooConstants.DEFAULT_PAGE_SIZE;
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/viewRateTypeListing");
        //modelView.addObject("userRole", userObj.getRoles());
        UserDetailsObj user = getLoggedInUser();
        //TODO Check if some one changes the url manually then it should lead to an error page. not to a server error.
        List<RateTypeEntity> listRateType= salesService.findAllRateTypeList();
        List<RateType_Obj> rateTypeObjList = generateRateTypeObj(listRateType);
        modelView.addObject("RATE_TYPE_LIST", rateTypeObjList);
        return modelView;
    }
    private List<RateType_Obj> generateRateTypeObj(List<RateTypeEntity> listRateTypeEntity) {
        List<RateType_Obj> listRateTypeObj = new ArrayList<RateType_Obj>();
        Iterator<RateTypeEntity> itrRateTypeEntity = listRateTypeEntity.iterator();
        while(itrRateTypeEntity.hasNext()) {
            RateTypeEntity rateTypeEntity = (RateTypeEntity) itrRateTypeEntity.next();
            RateType_Obj rateTypeObj;
            try {
                rateTypeObj= new RateType_Obj(rateTypeEntity);
                listRateTypeObj.add(rateTypeObj);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return listRateTypeObj;
    }

    @PostMapping("view_edit_rate_type_form")
    public ModelAndView view_edit_rate_type_form(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result ) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/Admin_Edit_RateType");
        RateTypeEntity rateTypeEntity = salesService.findById(rateTypeObj.getRateTypeId());
        rateTypeObj.updateRateTypeVOFromEntity(rateTypeEntity);
        return modelView;
    }

    /*
    @PostMapping(value="edit_edit_rate_type")
    public ModelAndView edit_edit_rate_type(@ModelAttribute("RATE_TYPE_OBJ") RateType_Obj rateTypeObj, BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView();
        //cityMgmtValidator.validate(cityObj, result);
        if(result.hasErrors()) {
            modelView = view_edit_city_form(cityObj,result );
        }
        else {
            RateTypeEntity rateTypeEntity = new RateTypeEntity(rateTypeObj);
            salesService.saveRateType(rateTypeEntity);
            redirectAttrib.addFlashAttribute("Success", "Rate Type Record is updated Successfully..");
            modelView.setViewName("redirect:view_search_city_form?destinationId="+cityEntity.getDestinationId()+"&countryCode="+cityEntity.getCountryCode());
        }
        return modelView;
    }

     */
    @PostMapping(value="create_edit_sales_partner")
    public ModelAndView createEditSalesPartner(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_add_sales_partner_form(salesPartnerDto, result);
        } else {
            // Convert DTO to Entity
            SalesPartnerEntity salesPartnerEntity = new SalesPartnerEntity(salesPartnerDto);
            // Save or update the SalesPartner record
            salesService.saveSalesPartner(salesPartnerEntity);
            // Add success message for redirection
            redirectAttrib.addFlashAttribute("Success", "Sales Partner record updated successfully.");
            // Redirect to the Sales Partner list view
            modelView.setViewName("redirect:view_sales_partner_list");
        }

        return modelView;
    }

    @RequestMapping("view_add_sales_partner_form")
    public ModelAndView view_add_sales_partner_form(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/Admin_Add_SalesPartner");
        return modelView;
    }
}
