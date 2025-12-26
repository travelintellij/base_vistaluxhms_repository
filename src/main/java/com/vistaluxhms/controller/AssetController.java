package com.vistaluxhms.controller;

import org.springframework.data.domain.Page;
import com.vistaluxhms.entity.*;
import com.vistaluxhms.model.*;
import com.vistaluxhms.repository.*;
import com.vistaluxhms.services.AssetServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.access.prepost.PreAuthorize;

import javax.validation.Valid;
import java.beans.PropertyEditorSupport;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class AssetController {

    @Autowired
    private AssetServiceImpl assetService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AssetTransferHistoryRepository assetTransferHistoryRepository;

    @Autowired
    private AssetRepository assetRepository;

    @Autowired
    private AssetAllocationRepository assetAllocationRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private DocumentCategoryMasterRepository documentCategoryMasterRepository;

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER','ASSET_ALLOWED')")
    @GetMapping("/view_assets_list")
    public ModelAndView viewAssetsList(
            @RequestParam(required = false) String assetCode,
            @RequestParam(required = false) String assetName,
            @RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) Integer ownerId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(defaultValue = "assetId") String sortBy,
        @RequestParam(required = false, defaultValue = "Active") String status) {

        ModelAndView modelView = new ModelAndView("others/viewAssets");


        UserDetailsObj user = getLoggedInUser();

        boolean isAdmin = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN") || a.getAuthority().equals("ROLE_ASSET_MANAGER"));

        boolean isAssetAllowed = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ASSET_ALLOWED"));


        if (assetCode != null && assetCode.trim().isEmpty()) assetCode = null;
        if (assetName != null && assetName.trim().isEmpty()) assetName = null;
        if (categoryId != null && categoryId == 0) categoryId = null;
        if (ownerId != null && ownerId == 0) ownerId = null;


        if (isAssetAllowed && !isAdmin) {
            ownerId = user.getUserId();
        }
        boolean showActive = status.equalsIgnoreCase("Active");


        Page<AssetEntity> filteredAssetsPage = assetService.filterAssetsByStatus(
                assetCode, assetName, categoryId, ownerId, showActive, page, pageSize, sortBy);
        List<AssetDTO> filteredAssetsList = assetService.convertToDTO(filteredAssetsPage.getContent());

        Map<Integer, String> ashokaTeamMap = assetService.getAllAshokaTeamMembers().stream()
                .collect(Collectors.toMap(
                        e -> e.getUserId(),
                        e -> e.getName() + " (" + e.getUsername() + ")"
                ));
        modelView.addObject("ashokaTeamMap", ashokaTeamMap);
        modelView.addObject("categories", assetService.getAllCategories());


        modelView.addObject("ASSETS_LIST", filteredAssetsList);
        modelView.addObject("currentPage", page);
        modelView.addObject("totalPages", filteredAssetsPage.getTotalPages());
        modelView.addObject("totalAssets", filteredAssetsPage.getTotalElements());
        modelView.addObject("pageSize", pageSize);
        modelView.addObject("sortBy", sortBy);


        modelView.addObject("selectedAssetCode", assetCode);
        modelView.addObject("selectedAssetName", assetName);
        modelView.addObject("selectedCategory", categoryId);
        modelView.addObject("selectedOwnerId", ownerId);

        return modelView;
    }


    private UserDetailsObj getLoggedInUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {
            Object principal = auth.getPrincipal();
            if (principal instanceof UserDetailsObj) {
                return (UserDetailsObj) principal;
            }
        }
        throw new RuntimeException("Logged-in user not found");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/add_asset")
    public ModelAndView addAssetForm() {
        ModelAndView modelAndView = new ModelAndView("others/addAsset");
        AssetDTO assetDTO = new AssetDTO();
        assetDTO.setCreationDate(LocalDate.now());
        modelAndView.addObject("assetDTO", assetDTO);

        List<AshokaTeam> ashokaTeams = assetService.getAllAshokaTeamMembers();
        modelAndView.addObject("ashokaTeams", ashokaTeams);

        List<Category> categories = categoryRepository.findActiveCategories();
        modelAndView.addObject("categories", categories);
        return modelAndView;
    }


    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/save_asset")
    public ModelAndView saveAsset(@ModelAttribute("assetDTO") AssetDTO assetDTO,
                                  BindingResult bindingResult) {

        ModelAndView mv = new ModelAndView("others/addAsset");

        mv.addObject("ashokaTeams", assetService.getAllAshokaTeamMembers());
        mv.addObject("categories", categoryRepository.findActiveCategories());

        if (assetDTO.getCategoryId() == null) {
            mv.addObject("error", "Please select a category before saving!");
            return mv;
        }

        if (assetDTO.getAssetCost() == null || assetDTO.getAssetCost().compareTo(BigDecimal.ZERO) <= 0) {
            mv.addObject("costError", "Asset cost must be greater than 0");
            return mv;
        }

        try {
            Category category = categoryRepository.findById(assetDTO.getCategoryId())
                    .orElseThrow(() -> new RuntimeException("Invalid category selected"));

            if (assetDTO.getAllocatedDate() == null) {
                assetDTO.setAllocatedDate(new java.util.Date());
            }

            if (assetDTO.getAssetOwnerId() == null || assetDTO.getAssetOwnerId() == 0) {
                assetDTO.setAssetOwnerId(
                        userRepository.findByUsername("INI").get().getUserId()
                );
            }

            assetDTO.setActive(true);
            assetService.saveAsset(assetDTO);

        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "Failed to save asset. Please try again.");
            return mv;
        }



        return new ModelAndView("redirect:/view_assets_list");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/allocate_asset_form")
    public ModelAndView showAllocationForm() {
        ModelAndView mv = new ModelAndView("others/allocateAsset");
        mv.addObject("assets", assetService.getAllAssets());
        mv.addObject("ashokaTeams", assetService.getAllAshokaTeamMembers());
        return mv;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/allocate_asset")
    public ModelAndView allocateAsset(@ModelAttribute("assetDTO") AssetDTO assetDTO,
                                      BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            ModelAndView mv = new ModelAndView("others/allocateAsset");
            mv.addObject("assets", assetService.getAllAssets());
            mv.addObject("ashokaTeams", assetService.getAllAshokaTeamMembers());
            return mv;
        }
        assetService.allocateAsset(assetDTO.getAssetId(), assetDTO.getAssetOwnerId());
        return new ModelAndView("redirect:/view_assets_list");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/assets_transfer_form/{assetId}")
    public ModelAndView showTransferForm(@PathVariable int assetId) {
        ModelAndView modelView = new ModelAndView("others/transferAsset");

        AssetEntity asset = assetService.getAssetById(assetId);
        if (asset == null) {
            modelView.addObject("errorMessage", "Asset not found!");
            return modelView;
        }
        AssetDTO assetDTO = assetService.convertToDTO(Collections.singletonList(asset)).get(0);

        TransferDTO transferDTO = new TransferDTO();
        transferDTO.setAssetId(assetId);
        transferDTO.setFromAshokaTeamId(asset.getOwnerId());

        Integer currentOwnerId = asset.getOwnerId();
        AshokaTeam currentOwner = currentOwnerId != null ? userRepository.findById(currentOwnerId).orElse(null) : null;

        transferDTO.setFromAshokaTeamId(currentOwnerId != null ? currentOwnerId : 0);
        String previousOwnerName = "Unallocated";
        if (currentOwner != null) {
            previousOwnerName = currentOwner.getName() + " (" + currentOwner.getUsername() + ")";
        }

        Map<Integer, String> ownerMap = new LinkedHashMap<>();
        assetService.getAllAshokaTeamMembers().forEach(ashokaTeam -> {
            if (currentOwnerId == null || ashokaTeam.getUserId() != currentOwnerId) {
                String displayName = ashokaTeam.getName() + " (" + ashokaTeam.getUsername() + ")";
                ownerMap.put(ashokaTeam.getUserId(), displayName);
            }
        });

        modelView.addObject("transferDTO", transferDTO);
        modelView.addObject("asset", assetDTO);
        modelView.addObject("previousOwnerName", previousOwnerName);
        modelView.addObject("ownerMap", ownerMap);
        modelView.addObject("transferDate", LocalDate.now());
        modelView.addObject("previousOwnerId",asset.getOwnerId());
        modelView.addObject("categoryName", asset.getCategory() != null ? asset.getCategory().getCategoryName() : "No Category");

        return modelView;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/assets_transfer")
    public ModelAndView handleTransfer(  @Valid @ModelAttribute("transferDTO") TransferDTO transferDTO,
                                       BindingResult bindingResult) {


        if (bindingResult.hasErrors()) {
            ModelAndView mv = new ModelAndView("others/transferAsset");

            AssetEntity asset = assetService.getAssetById(transferDTO.getAssetId());
            AssetDTO assetDTO = assetService.convertToDTO(Collections.singletonList(asset)).get(0);

            mv.addObject("transferDTO", transferDTO);
            mv.addObject("asset", assetDTO);
            mv.addObject("previousOwnerId", asset.getOwnerId());
            mv.addObject("categoryName", asset.getCategory() != null ? asset.getCategory().getCategoryName() : "No Category");

            // rebuild owner map
            Map<Integer, String> ownerMap = new LinkedHashMap<>();
            assetService.getAllAshokaTeamMembers().forEach(ashokaTeam -> {
                //
                if (ashokaTeam.getUserId() != asset.getOwnerId()
) {
                    ownerMap.put(ashokaTeam.getUserId(), ashokaTeam.getName() + " (" + ashokaTeam.getUsername() + ")");
                }
            });
            mv.addObject("ownerMap", ownerMap);

            String previousOwnerName = "Unallocated";
            AshokaTeam currentOwner = userRepository.findById(asset.getOwnerId()).orElse(null);
            if (currentOwner != null) {
                previousOwnerName = currentOwner.getName() + " (" + currentOwner.getUsername() + ")";
            }

            mv.addObject("previousOwnerName", previousOwnerName);

            return mv;
        }


        assetService.transferAsset(transferDTO);

        String redirectUrl = "/assets_transfer_history/" + transferDTO.getAssetId();


        return new ModelAndView("redirect:" + redirectUrl);
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/delete_asset/{assetId}")
    public ModelAndView deleteAsset(
            @PathVariable int assetId,
            RedirectAttributes redirectAttributes) {

        assetService.softDeleteAsset(assetId);
        redirectAttributes.addFlashAttribute("successMessage", "Asset deleted successfully.");

        return new ModelAndView("redirect:/view_assets_list");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER','ASSET_ALLOWED')")
    @GetMapping("/assets_transfer_history/{assetId}")
    public ModelAndView viewTransferHistory(@PathVariable int assetId) {
        ModelAndView modelView = new ModelAndView("others/transferHistory");
        List<AssetTransferHistory> historyList =
                assetTransferHistoryRepository.findByAsset_AssetIdOrderByTransferDateDesc(assetId);

        List<Map<String, Object>> formattedHistory = new ArrayList<>();
        for (AssetTransferHistory history : historyList) {
            Map<String, Object> map = new HashMap<>();

            map.put("fromUser", history.getFromAshokaTeam() != null
                    ? history.getFromAshokaTeam().getName() + " (" + history.getFromAshokaTeam().getUsername() + ")"
                    : "N/A");

            map.put("toUser", history.getToAshokaTeam() != null
                    ? history.getToAshokaTeam().getName() + " (" + history.getToAshokaTeam().getUsername() + ")"
                    : "N/A");

            map.put("transferDate", history.getTransferDate());
            map.put("remarks", history.getRemarks());
            formattedHistory.add(map);
        }

        AssetEntity asset = assetRepository.findById(assetId)
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        UserDetailsObj user = getLoggedInUser();
        boolean isAssetAllowed = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ASSET_ALLOWED"));

        if (isAssetAllowed && !assetService.isOwnedByUser(assetId, user.getUserId())) {
            throw new AccessDeniedException("You are not authorized to view this asset history");
        }
        modelView.addObject("historyList", historyList);
        modelView.addObject("assetId", assetId);
        modelView.addObject("asset", asset);
        return modelView;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/asset_history_code/{assetCode}")
    public ModelAndView getHistoryByCode(@PathVariable String assetCode) {
        ModelAndView mv = new ModelAndView("others/transferHistory");

        Optional<AssetEntity> optionalAsset = assetService.findByAssetCode(assetCode);
        if (!optionalAsset.isPresent()) {
            mv.addObject("error", "No asset found for code: " + assetCode);
            return mv;
        }

        AssetEntity asset = optionalAsset.get();
        List<AssetTransferHistory> historyList =
                assetTransferHistoryRepository.findByAsset_AssetIdOrderByTransferDateDesc(asset.getAssetId());

        mv.addObject("historyList", historyList);
        mv.addObject("assetCode", assetCode);
        return mv;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                if (text == null || text.isEmpty()) {
                    setValue(null);
                } else {
                    setValue(LocalDate.parse(text, dateFormatter));
                }
            }
        });
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/edit_asset/{assetId}")
    public ModelAndView showEditAssetForm(@PathVariable int assetId) {
        ModelAndView modelView = new ModelAndView("others/editAsset");

        AssetEntity asset = assetRepository.findById(assetId)

                .orElseThrow(() -> new RuntimeException("Asset not found"));
        List<Category> categories = categoryRepository.findActiveCategories();
        modelView.addObject("categories", categories);
        modelView.addObject("asset", asset);
        return modelView;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/update_asset")
    public ModelAndView updateAsset(
            @Valid @ModelAttribute("asset") AssetEntity asset,
            BindingResult bindingResult) {

        ModelAndView modelView = new ModelAndView();

        if (bindingResult.hasErrors()) {
            modelView.setViewName("others/editAsset");
            modelView.addObject("asset", asset);
            modelView.addObject("categories", categoryRepository.findActiveCategories());
            return modelView;
        }

        if (asset.getAssetCost() == null || asset.getAssetCost().compareTo(BigDecimal.ZERO) <= 0) {
            modelView.setViewName("others/editAsset");
            modelView.addObject("asset", asset);
            modelView.addObject("categories", categoryRepository.findActiveCategories());
            modelView.addObject("costError", "Asset cost must be greater than 0");
            return modelView;
        }

        AssetEntity existingAsset = assetRepository.findById(asset.getAssetId())
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        existingAsset.setAssetName(asset.getAssetName());
        existingAsset.setAssetCost(asset.getAssetCost());
        existingAsset.setDescription(asset.getDescription());


        if (asset.getCategory() != null && !asset.getCategory().isEmpty()) {
            existingAsset.setCategory(asset.getCategory());
        }


        if (asset.getOwnerId() != null) {
            existingAsset.setOwnerId(asset.getOwnerId());
        }

        assetRepository.save(existingAsset);

        modelView.setViewName("redirect:/view_assets_list");
        return modelView;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/categories_add")
    public ModelAndView showAddCategoryForm() {
        ModelAndView mv = new ModelAndView("others/addCategory");
        ModelAndView modelAndView = mv.addObject("category", new Category());
        return mv;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/categories_save")
    public ModelAndView saveCategory(
            @Valid @ModelAttribute("category") Category category,
            BindingResult bindingResult) {

        ModelAndView mv = new ModelAndView("others/addCategory");

        if (bindingResult.hasErrors()) {
            return mv;
        }

        categoryRepository.save(category);
        return new ModelAndView("redirect:/categories_manage");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @GetMapping("/categories_manage")
    public ModelAndView listCategories(@RequestParam(value = "status", required = false) String status) {
        ModelAndView mv = new ModelAndView("others/manageCategories");

        List<Category> categories;
        if (status == null || status.isEmpty()) {
            categories = categoryRepository.findByStatus("Active");
            status = "Active";
        } else {
            categories = categoryRepository.findByStatus(status);
        }

        mv.addObject("categories", categories);
        mv.addObject("selectedStatus", status);
        return mv;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/categories_deactivate/{id}")
    public ModelAndView deactivateCategory(@PathVariable Integer id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        category.setStatus("Inactive");
        categoryRepository.save(category);
        return new ModelAndView("redirect:/categories_manage");
    }


    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/categories_activate/{id}")
    public ModelAndView activateCategory(@PathVariable Integer id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
        category.setStatus("Active");
        categoryRepository.save(category);
        return new ModelAndView("redirect:/categories_manage");
    }



    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/assets_deactivate/{assetId}")
    public ModelAndView deactivateAsset(@PathVariable Integer assetId) {
        assetService.deactivateAsset(assetId);
        return new ModelAndView("redirect:/view_assets_list?status=Active");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/assets_activate/{assetId}")
    public ModelAndView activateAsset(@PathVariable Integer assetId) {
        assetService.activateAsset(assetId);
        return new ModelAndView("redirect:/view_assets_list?status=Deactivated");
    }
}


