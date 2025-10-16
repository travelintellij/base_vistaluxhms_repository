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


    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER','ASSET_ALLOWED')")
    @GetMapping("/view_assets_list")
    public ModelAndView viewAssetsList(
            @RequestParam(required = false) String assetCode,
            @RequestParam(required = false) String assetName,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Integer ownerId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(defaultValue = "assetId") String sortBy) {

        ModelAndView modelView = new ModelAndView("others/viewAssets");


        UserDetailsObj user = getLoggedInUser();

        boolean isAdmin = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN") || a.getAuthority().equals("ROLE_ASSET_MANAGER"));

        boolean isAssetAllowed = user.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ASSET_ALLOWED"));


        if (assetCode != null && assetCode.trim().isEmpty()) assetCode = null;
        if (assetName != null && assetName.trim().isEmpty()) assetName = null;
        if (category != null && category.trim().isEmpty()) category = null;
        if (ownerId != null && ownerId == 0) ownerId = null;


        if (isAssetAllowed && !isAdmin) {
            ownerId = user.getUserId();
            assetCode = null;
            assetName = null;
            category = null;
        }


        Page<AssetEntity> filteredAssetsPage = assetService.filterAssets(
                assetCode, assetName, category, ownerId, page, pageSize, sortBy);
        List<AssetDTO> filteredAssetsList = assetService.convertToDTO(filteredAssetsPage.getContent());


        Map<Integer, String> ashokaTeamMap = assetService.getAllAshokaTeamMembers().stream()
                .collect(Collectors.toMap(e -> e.getUserId(), e -> e.getName()));
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
        modelView.addObject("selectedCategory", category);
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
        Map<Integer, String> ashokaTeamMap = assetService.getAllAshokaTeamMembers().stream()
                .collect(Collectors.toMap(AshokaTeam::getUserId, AshokaTeam::getName));
        modelAndView.addObject("ashokaTeams", ashokaTeamMap);
        List<Category> categories = categoryRepository.findAll();
        modelAndView.addObject("categories", categories);
        return modelAndView;
    }


    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/save_asset")
    public ModelAndView saveAsset(@ModelAttribute("assetDTO") AssetDTO assetDTO,
                                  BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            ModelAndView mv = new ModelAndView("others/addAsset");
            mv.addObject("ashokaTeams", assetService.getAllAshokaTeamMembers());
            return mv;
        }

        try {
            assetService.saveAsset(assetDTO);
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mv = new ModelAndView("others/addAsset");
            mv.addObject("error", "Failed to save asset. Please try again.");
            mv.addObject("ashokaTeams", assetService.getAllAshokaTeamMembers());
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

        TransferDTO transferDTO = new TransferDTO();
        transferDTO.setAssetId(assetId);

        Integer currentOwnerId = asset.getOwnerId();
        AshokaTeam currentOwner = currentOwnerId != null ? userRepository.findById(currentOwnerId).orElse(null) : null;

        transferDTO.setFromAshokaTeamId(currentOwnerId != null ? currentOwnerId : 0);
        String previousOwnerName = currentOwner != null ? currentOwner.getName() : "N/A";

        Map<Integer, String> ownerMap = new LinkedHashMap<>();
        assetService.getAllAshokaTeamMembers().forEach(ashokaTeam -> {
            if (currentOwnerId == null || ashokaTeam.getUserId() != currentOwnerId) {
                ownerMap.put(ashokaTeam.getUserId(), ashokaTeam.getName());
            }
        });

        modelView.addObject("transferDTO", transferDTO);
        modelView.addObject("asset", asset);
        modelView.addObject("previousOwnerName", previousOwnerName);
        modelView.addObject("ownerMap", ownerMap);
        modelView.addObject("transferDate", LocalDate.now());

        return modelView;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/assets_transfer")
    public ModelAndView handleTransfer(@ModelAttribute("transferDTO") TransferDTO transferDTO,
                                       BindingResult bindingResult) {


        if (bindingResult.hasErrors()) {

            return new ModelAndView("redirect:/assets_transfer_form/" + transferDTO.getAssetId());
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
        List<Category> categories = categoryRepository.findAll();
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
            modelView.addObject("categories", categoryRepository.findAll());
            return modelView;
        }

        AssetEntity existingAsset = assetRepository.findById(asset.getAssetId())
                .orElseThrow(() -> new RuntimeException("Asset not found"));

        existingAsset.setAssetName(asset.getAssetName());
        existingAsset.setAssetCost(asset.getAssetCost());


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
    public ModelAndView listCategories() {
        ModelAndView mv = new ModelAndView("others/manageCategories");
        mv.addObject("categories", categoryRepository.findAll());
        return mv;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ASSET_MANAGER')")
    @PostMapping("/categories_delete/{id}")
    public ModelAndView deleteCategory(@PathVariable Integer id) {
        categoryRepository.deleteById(id);
        return new ModelAndView("redirect:/categories_manage");
    }


}


