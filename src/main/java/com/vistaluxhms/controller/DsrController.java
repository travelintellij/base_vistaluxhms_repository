package com.vistaluxhms.controller; // package for REST endpoints

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import com.vistaluxhms.entity.Dsr;
import com.vistaluxhms.services.DsrService;

@RestController // marks this class as REST API controller
@RequestMapping("/api/dsr") // base URL for all endpoints
@CrossOrigin(origins = "*") // allow frontend access
public class DsrController {

    @Autowired // inject service
    private DsrService dsrService;

    // Create new DSR
    @PostMapping("/create")
    public Dsr createDsr(@RequestBody Dsr dsr) {
        return dsrService.createDsr(dsr); // call service method to save
    }

    // Get all DSRs
    @GetMapping("/all")
    public List<Dsr> getAllDsrs() {
        return dsrService.getAllDsrs(); // return list of all DSRs
    }

    // Get DSR by ID
    @GetMapping("/{id}")
    public Dsr getDsrById(@PathVariable Long id) {
        return dsrService.getDsrById(id); // return DSR by its ID
    }

    // Delete DSR by ID
    @DeleteMapping("/{id}")
    public String deleteDsr(@PathVariable Long id) {
        dsrService.deleteDsr(id); // call service to delete
        return "DSR deleted successfully with ID: " + id; // confirmation message
    }
}
