package com.vistaluxhms.controller;

import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import com.vistaluxhms.services.ClientServicesImpl;
import com.vistaluxhms.services.SalesRelatesServicesImpl;
import com.vistaluxhms.services.UserDetailsServiceImpl;
import com.vistaluxhms.services.VlxCommonServicesImpl;
import com.vistaluxhms.util.VistaluxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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

    @RequestMapping("view_add_client_form")
    public ModelAndView view_add_client_form(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/client/Admin_Add_Client");
        Map<Long, String> mapSalesPartner =  salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        return modelView;
    }
    @PostMapping(value="create_create_client")
    public ModelAndView create_create_client(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if (!commonService.existsByDestinationIdAndCityName(clientEntityDto.getCity().getDestinationId(), clientEntityDto.getCityName())) {
            result.rejectValue("cityName", "city.error");
        }
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_add_client_form(clientEntityDto, result);
        } else {
            City_Entity cityEntity = cityRepository.findDestinationById(clientEntityDto.getCity().getDestinationId());
            SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(clientEntityDto.getSalesPartner().getSalesPartnerId());
            ClientEntity clientEntity = new ClientEntity(clientEntityDto);
            clientEntity.setCity(cityEntity);
            clientEntity.setSalesPartner(salesPartnerEntity);
            clientEntity.setSalesPartnerFlag(false);
            clientService.saveClient(clientEntity);
            redirectAttrib.addFlashAttribute("Success", "Client record is updated successfully.");
            modelView.setViewName("redirect:view_clients_list");
        }

        return modelView;
    }


/*
    @RequestMapping("view_clients_list")
    public ModelAndView view_clients_list(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/client/viewClientListing");
        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject("Id", userObj.getUserId());
        // Filtering sales partners based on the search criteria

        if(clientEntityDto.getCity()!=null && String.valueOf(clientEntityDto.getCity().getDestinationId()).trim().length()!=0 && clientEntityDto.getCity().getDestinationId()!=0) {
            if (!commonService.existsByDestinationIdAndCityName(clientEntityDto.getCity().getDestinationId(), clientEntityDto.getCityName())) {
                result.rejectValue("cityName", "city.error");
            }
        }
        if (result.hasErrors()) {
            for (FieldError fieldError : result.getFieldErrors()) {
                System.out.println("Field Error: " + fieldError.getField() + " - " + fieldError.getDefaultMessage());
            }
            // Log all global errors (not tied to specific fields)
            for (ObjectError globalError : result.getGlobalErrors()) {
                System.out.println("Global Error: " + globalError.getDefaultMessage());
            }
            // If there are validation errors, return the form view with errors
            return modelView;
        }else {
            List<ClientEntity> clientFilteredList = clientService.filterClients(clientEntityDto);
            List<ClientEntityDTO> clientDTOFilteredList = generateClientObj(clientFilteredList);
            modelView.addObject("CLIENT_FILTERED_LIST", clientDTOFilteredList);
            Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
            modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        }
        return modelView;
    }
*/
@RequestMapping("view_clients_list")
public ModelAndView view_clients_list(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto,BindingResult result,@RequestParam(value = "page", defaultValue = "0") int page,
                                      @RequestParam(value = "size", defaultValue = VistaluxConstants.DEFAULT_PAGE_SIZE) int pageSize) {

    UserDetailsObj userObj = getLoggedInUser();
    ModelAndView modelView = new ModelAndView("admin/client/viewClientListing");

    // Adding user details to the model
    modelView.addObject("userName", userObj.getUsername());
    modelView.addObject("Id", userObj.getUserId());

    // Validating if the city exists
    if(clientEntityDto.getCity() != null && String.valueOf(clientEntityDto.getCity().getDestinationId()).trim().length() != 0
            && clientEntityDto.getCity().getDestinationId() != 0) {
        if (!commonService.existsByDestinationIdAndCityName(clientEntityDto.getCity().getDestinationId(), clientEntityDto.getCityName())) {
            result.rejectValue("cityName", "city.error");
        }
    }

    if (result.hasErrors()) {
        // Logging the errors
        for (FieldError fieldError : result.getFieldErrors()) {
            System.out.println("Field Error: " + fieldError.getField() + " - " + fieldError.getDefaultMessage());
        }
        // Return the form view with errors
        return modelView;
    } else {
        // Create PageRequest with pagination
        Pageable pageable = PageRequest.of(page, pageSize);

        // Get the paginated list of filtered clients
        Page<ClientEntity> clientFilteredPage = clientService.filterClients(clientEntityDto, pageable);

        // Convert the filtered list to DTOs
        List<ClientEntityDTO> clientDTOFilteredList = generateClientObj(clientFilteredPage.getContent());

        // Adding filtered clients and pagination details to the model
        modelView.addObject("CLIENT_FILTERED_LIST", clientDTOFilteredList);
        modelView.addObject("currentPage", page);
        modelView.addObject("totalPages", clientFilteredPage.getTotalPages());
        modelView.addObject("totalClients", clientFilteredPage.getTotalElements());
        modelView.addObject("pageSize", pageSize);

        modelView.addObject("maxPages", clientFilteredPage.getTotalPages());
        modelView.addObject("page", page);
        //modelView.addObject("sortBy", sortBy);

       // modelView.addObject("cityId", searchClientObj.getCityId());
        //modelView.addObject("active", searchClientObj.isActive());

        // Sales Partner Map for the filter
        Map<Long, String> mapSalesPartner = salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        modelView.addObject("CLIENT_OBJ", clientEntityDto);
    }

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
                if(clientEntity.getCity()!=null) {
                    clientEntityDto.setCityName(commonService.findDestinationById(clientEntity.getCity().getDestinationId()).getCityName());
                }
                salesPartnerVoList.add(clientEntityDto);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return salesPartnerVoList;
    }

    @RequestMapping("view_edit_client_form")
    public ModelAndView view_edit_client_form(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ClientEntity clientEntity = clientService.findClientById(clientEntityDto.getClientId());
        clientEntityDto.updateClientVoFromEntity(clientEntity);
        clientEntityDto.setCityName(commonService.findDestinationById(clientEntity.getCity().getDestinationId()).getCityName());
        ModelAndView modelView = new ModelAndView("admin/client/Admin_Edit_Client");
        Map<Long, String> mapSalesPartner =  salesService.getActiveSalesPartnerMap(true);
        modelView.addObject("SALES_PARTNER_MAP", mapSalesPartner);
        return modelView;
    }

    @PostMapping(value="edit_edit_client")
    public ModelAndView edit_edit_client(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto,BindingResult result,final RedirectAttributes redirectAttrib) {
        UserDetailsObj userObj = getLoggedInUser(); // Retrieve logged-in user details
        ModelAndView modelView = new ModelAndView();
        if (!commonService.existsByDestinationIdAndCityName(clientEntityDto.getCity().getDestinationId(), clientEntityDto.getCityName())) {
            result.rejectValue("cityName", "city.error");
        }
        if (result.hasErrors()) {
            // If there are validation errors, return the form view with errors
            modelView = view_edit_client_form(clientEntityDto, result);
        } else {
            City_Entity cityEntity = cityRepository.findDestinationById(clientEntityDto.getCity().getDestinationId());
            SalesPartnerEntity salesPartnerEntity = salesService.findSalesPartnerById(clientEntityDto.getSalesPartner().getSalesPartnerId());
            ClientEntity clientEntity = new ClientEntity(clientEntityDto);
            clientEntity.setClientId(clientEntityDto.getClientId());
            clientEntity.setCity(cityEntity);
            clientEntity.setSalesPartner(salesPartnerEntity);
            clientService.saveClient(clientEntity);


            redirectAttrib.addFlashAttribute("Success", "Client record is updated successfully.");
            modelView.setViewName("redirect:view_clients_list");
        }

        return modelView;
    }

    @PostMapping("view_client_details")
    public ModelAndView view_client_details(@ModelAttribute("CLIENT_OBJ") ClientEntityDTO clientEntityDto, BindingResult result) {
        UserDetailsObj userObj = getLoggedInUser();
        ModelAndView modelView = new ModelAndView("admin/client/Admin_View_Client");
        // Adding user details to the model
        modelView.addObject("userName", userObj.getUsername());
        modelView.addObject(
                "Id", userObj.getUserId());
        // Filtering sales partners based on the search criteria
        ClientEntity clientEntity = clientService.findClientById(clientEntityDto.getClientId());
        clientEntityDto.updateClientVoFromEntity(clientEntity);
        clientEntityDto.setCityName(commonService.findDestinationById(clientEntity.getCity().getDestinationId()).getCityName());
        clientEntityDto.setSalesPartnerName(salesService.findSalesPartnerById(clientEntity.getSalesPartner().getSalesPartnerId()).getSalesPartnerShortName());
        return modelView;
    }

    @RequestMapping(value = "/getClientList", method= {RequestMethod.GET,RequestMethod.POST})
    public @ResponseBody
    List<ClientEntityDTO> getTags(@RequestParam String clientName) {
        List<ClientEntityDTO> result = new ArrayList<ClientEntityDTO>();
        List <ClientEntity> entityList = clientService.listAllActiveClients();
        // iterate a list and filter by tagName
        for (ClientEntity entity : entityList) {
            if (entity.getClientName().toLowerCase().contains(clientName.toLowerCase())) {
                ClientEntityDTO clientEntityDTO = new ClientEntityDTO(entity);
                clientEntityDTO.setSalesPartnerName(salesService.findSalesPartnerById(entity.getSalesPartner().getSalesPartnerId()).getSalesPartnerShortName());
                result.add(clientEntityDTO);
            }
        }

        return result;
    }


}
