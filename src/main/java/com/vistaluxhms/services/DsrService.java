package com.vistaluxhms.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory; // package for service logic

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import com.vistaluxhms.entity.Dsr;
import com.vistaluxhms.repository.DsrRepository;

@Service // marks this as a Spring service class
public class DsrService {


    private static final Logger logger = LoggerFactory.getLogger(DsrService.class);
    @Autowired // inject the repository automatically
    private DsrRepository dsrRepository;

    // save a new DSR record
    public Dsr createDsr(Dsr dsr) {
        return dsrRepository.save(dsr); // insert or update DSR record
    }

    // fetch all DSR records
    public List<Dsr> getAllDsrs() {
        return dsrRepository.findAll(); // retrieve all records
    }

    // fetch a specific DSR by ID
    public Dsr getDsrById(Long id) {
        return dsrRepository.findById(id).orElse(null); // return null if not found
    }

    // delete a DSR by ID
    public void deleteDsr(Long id) {
        dsrRepository.deleteById(id); // remove record from DB
    }
}
