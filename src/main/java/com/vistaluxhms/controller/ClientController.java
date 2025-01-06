package com.vistaluxhms.controller;

import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.RateType_Obj;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.model.UserDetailsObj;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
public class ClientController {

    @Autowired
    UserDetailsServiceImpl userDetailsService;

    @Autowired
    ClientServicesImpl clientService;

    @Autowired
    Vlx_City_Master_Repository cityRepository;

    @Autowired
    VlxCommonServicesImpl commonService;

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

    @RequestMapping("view_add_client_form")
    public ModelAndView view_add_client_form(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/client/Admin_Add_Client");
        return modelView;
    }
    @PostMapping(value="create_create_client")
    public ModelAndView create_create_client(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_add_client_form(clientEntityDto, result);
        } else {
            ClientEntity clientEntity = new ClientEntity(clientEntityDto);
            clientService.saveClient(clientEntity);
            redirectAttrib.addFlashAttribute("Success", "Sales Partner record updated successfully.");
            modelView.setViewName("redirect:view_clients_list");
        }

        return modelView;
    }



    @RequestMapping("view_clients_list")
    public ModelAndView view_clients_list(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/client/viewClientListing");
        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());
        // Filtering sales partners based on the search criteria
        List<ClientEntity> clientFilteredList = clientService.filterClients(clientEntityDto);
        List<ClientEntityDTO> clientDTOFilteredList = generateClientObj(clientFilteredList);
        modelView.addObject("CLIENT_FILTERED_LIST", clientDTOFilteredList);
        return modelView;
    }

    private List<ClientEntityDTO> generateClientObj(List<ClientEntity> listSalesPartner) {
        List<ClientEntityDTO> salesPartnerVoList = new ArrayList<ClientEntityDTO>();
        Iterator<ClientEntity> itrClientEntity = listSalesPartner.iterator();
        while(itrClientEntity.hasNext()) {
            ClientEntity clientEntity = (ClientEntity) itrClientEntity.next();
            ClientEntityDTO clientEntityDto;
            try {
                clientEntityDto= new ClientEntityDTO();
                clientEntityDto.updateClientVoFromEntity(clientEntity);
                clientEntityDto.setCityName(commonService.findDestinationById(clientEntity.getCity().getDestinationId()).getCityName());
                salesPartnerVoList.add(clientEntityDto);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return salesPartnerVoList;
    }

    /*
    @PostMapping("view_sales_partner_details")
    public ModelAndView view_sales_partner_details(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto searchSalesPartnerObj, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/Admin_View_SalesPartner");
        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());
        // Filtering sales partners based on the search criteria
        SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(searchSalesPartnerObj.getSalesPartnerId());
        searchSalesPartnerObj.updateSalesPartnerVoFromEntity(salesPartnerEntity);
        searchSalesPartnerObj.setCityName(commonService.findDestinationById(salesPartnerEntity.getCityId()).getCityName());
        return modelView;
    }

    @RequestMapping("view_edit_sales_partner_form")
    public ModelAndView view_edit_sales_partner_form(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/salespartner/Admin_Edit_SalesPartner");
        SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(salesPartnerEntityDto.getSalesPartnerId());
        salesPartnerEntityDto.updateSalesPartnerVoFromEntity(salesPartnerEntity);
        salesPartnerEntityDto.setCityName(commonService.findDestinationById(salesPartnerEntity.getCityId()).getCityName());
        return modelView;
    }

    @PostMapping(value="edit_edit_sales_partner")
    public ModelAndView edit_edit_sales_partner(@ModelAttribute("SALES_PARTNER_OBJ") SalesPartnerEntityDto salesPartnerDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if(!commonService.existsByDestinationIdAndCityName(salesPartnerDto.getCityId(), salesPartnerDto.getCityName())) {
            result.rejectValue("cityName", "city.error");
        }
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_edit_sales_partner_form(salesPartnerDto, result);
        } else {
            SalesPartnerEntity salesPartnerEntity = new SalesPartnerEntity(salesPartnerDto);
            salesPartnerEntity.setSalesPartnerId(salesPartnerDto.getSalesPartnerId());
            salesService.saveSalesPartner(salesPartnerEntity);
            redirectAttrib.addFlashAttribute("Success", "Sales Partner record updated successfully.");
            modelView.setViewName("redirect:view_sales_partner_list");
        }

        return modelView;
    }
    */
}