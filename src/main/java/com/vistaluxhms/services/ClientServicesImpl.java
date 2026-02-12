package com.vistaluxhms.services;
import com.itextpdf.text.Font;
import com.vistaluxhms.entity.City_Entity;
import com.vistaluxhms.entity.ClientEntity;
import com.vistaluxhms.entity.RateTypeEntity;
import com.vistaluxhms.entity.SalesPartnerEntity;
import com.vistaluxhms.model.ClientEntityDTO;
import com.vistaluxhms.model.SalesPartnerEntityDto;
import com.vistaluxhms.repository.ClientEntityRepository;
import com.vistaluxhms.repository.RateTypeRepository;
import com.vistaluxhms.repository.SalesPartnerEntityRepository;
import com.vistaluxhms.repository.Vlx_City_Master_Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import java.io.OutputStream;
import java.io.IOException;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Service
public class ClientServicesImpl {
    @Autowired
    Vlx_City_Master_Repository cityRepository;

    @Autowired
    ClientEntityRepository clientRepository;

    public void saveClient(ClientEntity clientEntity) {
        clientRepository.save(clientEntity);
    }


    /*	public List<ClientEntity> filterClients(ClientEntityDTO searchClientObj) {
		return clientRepository.findAll(new Specification<ClientEntity>() {
			private static final long serialVersionUID = 1L;

			@Override
			public Predicate toPredicate(Root<ClientEntity> clientRootEntity, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
				List<Predicate> predicates = new ArrayList<>();

				// Join with CityEntity
				Join<ClientEntity, City_Entity> cityJoin = clientRootEntity.join("city", JoinType.LEFT);

				// Join with SalesPartnerEntity
				Join<ClientEntity, SalesPartnerEntity> salesPartnerJoin = clientRootEntity.join("salesPartner", JoinType.LEFT);

				// Filter by Client ID
				if (searchClientObj.getClientId() != null && searchClientObj.getClientId() != 0) {
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("clientId"), searchClientObj.getClientId()));
				}

				if(searchClientObj.getB2b()!=null){
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("b2b"), searchClientObj.getB2b()));
				}
				// Filter by Active Status
				if (searchClientObj.getActive() != null) {
					predicates.add(criteriaBuilder.equal(clientRootEntity.get("active"), searchClientObj.getActive()));
				}

				// Filter by Client Name
				if (searchClientObj.getClientName() != null && !searchClientObj.getClientName().trim().isEmpty()) {
					predicates.add(criteriaBuilder.like(
							criteriaBuilder.lower(clientRootEntity.get("clientName")),
							"%" + searchClientObj.getClientName().toLowerCase() + "%"
					));
				}

				// Filter by Destination ID in CityEntity
				if (searchClientObj.getCity()!=null && String.valueOf(searchClientObj.getCity().getDestinationId()).trim().length()!=0 && searchClientObj.getCity().getDestinationId() != 0) {
					predicates.add(criteriaBuilder.equal(cityJoin.get("destinationId"), searchClientObj.getCity().getDestinationId()));
				}

				// Filter by Sales Partner ID in SalesPartnerEntity
				if (searchClientObj.getSalesPartner()!=null && searchClientObj.getSalesPartner().getSalesPartnerId() != null && searchClientObj.getSalesPartner().getSalesPartnerId() != 0) {
					predicates.add(criteriaBuilder.equal(salesPartnerJoin.get("salesPartnerId"), searchClientObj.getSalesPartner().getSalesPartnerId()));
				}



				return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
			}
		});
	}
*/
    public Page<ClientEntity> filterClients(ClientEntityDTO searchClientObj, Pageable pageable) {
        //Pageable pageable = PageRequest.of(pageable., pageSize);

        return clientRepository.findAll(new Specification<ClientEntity>() {
            private static final long serialVersionUID = 1L;

            @Override
            public Predicate toPredicate(Root<ClientEntity> clientRootEntity, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                // Join with CityEntity
                Join<ClientEntity, City_Entity> cityJoin = clientRootEntity.join("city", JoinType.LEFT);

                // Join with SalesPartnerEntity
                Join<ClientEntity, SalesPartnerEntity> salesPartnerJoin = clientRootEntity.join("salesPartner", JoinType.LEFT);

                // Filter by Client ID
                if (searchClientObj.getClientId() != null && searchClientObj.getClientId() != 0) {
                    predicates.add(criteriaBuilder.equal(clientRootEntity.get("clientId"), searchClientObj.getClientId()));
                }

                if (searchClientObj.getB2b() != null) {
                    predicates.add(criteriaBuilder.equal(clientRootEntity.get("b2b"), searchClientObj.getB2b()));
                }

                // Filter by Active Status
                if (searchClientObj.getActive() != null) {
                    predicates.add(criteriaBuilder.equal(clientRootEntity.get("active"), searchClientObj.getActive()));
                }

                // Filter by Client Name
                if (searchClientObj.getClientName() != null && !searchClientObj.getClientName().trim().isEmpty()) {
                    predicates.add(criteriaBuilder.like(
                            criteriaBuilder.lower(clientRootEntity.get("clientName")),
                            "%" + searchClientObj.getClientName().toLowerCase() + "%"
                    ));
                }
                // Filter by Destination ID in CityEntity
                if (searchClientObj.getCity() != null && String.valueOf(searchClientObj.getCity().getDestinationId()).trim().length() != 0 && searchClientObj.getCity().getDestinationId() != 0) {
                    predicates.add(criteriaBuilder.equal(cityJoin.get("destinationId"), searchClientObj.getCity().getDestinationId()));
                }

                // Filter by Sales Partner ID in SalesPartnerEntity
                if (searchClientObj.getSalesPartner() != null && searchClientObj.getSalesPartner().getSalesPartnerId() != null && searchClientObj.getSalesPartner().getSalesPartnerId() != 0) {
                    predicates.add(criteriaBuilder.equal(salesPartnerJoin.get("salesPartnerId"), searchClientObj.getSalesPartner().getSalesPartnerId()));
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
            }
        }, pageable);
    }

    public ClientEntity findClientById(Long clientId) {
        return clientRepository.findById(clientId).get();
    }

    public List<ClientEntity> listAllActiveClients() {
        List<ClientEntity> listClients = clientRepository.findAllActiveClients();
        return listClients;
    }

    public boolean existsByClientIdAndClientName(long clientId, String clientName) {
        return clientRepository.existsByclientIdAndClientName(clientId, clientName);
    }

    public ClientEntity findClientEntityForSalesPartnerId(Long salesPartnerId) {
        return clientRepository.findFirstBySalesPartner_salesPartnerIdAndSalesPartnerFlag(salesPartnerId, true);
    }

    public boolean isMobileExists(Long mobile) {
        return clientRepository.existsByMobile(mobile);
    }
    public List<ClientEntity> filterClientsForExport(ClientEntityDTO searchClientObj) {

        Specification<ClientEntity> spec = new Specification<ClientEntity>() {

            @Override
            public Predicate toPredicate(Root<ClientEntity> clientRootEntity,
                                         CriteriaQuery<?> query,
                                         CriteriaBuilder criteriaBuilder) {

                List<Predicate> predicates = new ArrayList<>();

                Join<ClientEntity, City_Entity> cityJoin =
                        clientRootEntity.join("city", JoinType.LEFT);

                Join<ClientEntity, SalesPartnerEntity> salesPartnerJoin =
                        clientRootEntity.join("salesPartner", JoinType.LEFT);

                // Client ID
                if (searchClientObj.getClientId() != null &&
                        searchClientObj.getClientId() != 0) {

                    predicates.add(
                            criteriaBuilder.equal(
                                    clientRootEntity.get("clientId"),
                                    searchClientObj.getClientId()
                            )
                    );
                }

                // B2B
                if (searchClientObj.getB2b() != null) {
                    predicates.add(
                            criteriaBuilder.equal(
                                    clientRootEntity.get("b2b"),
                                    searchClientObj.getB2b()
                            )
                    );
                }

                // Active
                if (searchClientObj.getActive() != null) {
                    predicates.add(
                            criteriaBuilder.equal(
                                    clientRootEntity.get("active"),
                                    searchClientObj.getActive()
                            )
                    );
                }

                // Client Name
                if (searchClientObj.getClientName() != null &&
                        !searchClientObj.getClientName().trim().isEmpty()) {

                    predicates.add(
                            criteriaBuilder.like(
                                    criteriaBuilder.lower(
                                            clientRootEntity.get("clientName")
                                    ),
                                    "%" + searchClientObj.getClientName().toLowerCase() + "%"
                            )
                    );
                }

                // City
                if (searchClientObj.getCity() != null &&
                        searchClientObj.getCity().getDestinationId() != 0) {

                    predicates.add(
                            criteriaBuilder.equal(
                                    cityJoin.get("destinationId"),
                                    searchClientObj.getCity().getDestinationId()
                            )
                    );
                }

                // Sales Partner
                if (searchClientObj.getSalesPartner() != null &&
                        searchClientObj.getSalesPartner().getSalesPartnerId() != null &&
                        searchClientObj.getSalesPartner().getSalesPartnerId() != 0) {

                    predicates.add(
                            criteriaBuilder.equal(
                                    salesPartnerJoin.get("salesPartnerId"),
                                    searchClientObj.getSalesPartner().getSalesPartnerId()
                            )
                    );
                }

                return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
            }
        };

        return clientRepository.findAll(spec);
    }

    public void exportClientsToExcel(List<ClientEntity> list,
                                     OutputStream out) throws IOException {

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Clients");

        // Header
        Row header = sheet.createRow(0);

        String[] columns = {
                "Client ID", "Name", "City",
                "Mobile", "Email",
                "Sales Partner", "Active", "B2B"
        };

        for (int i = 0; i < columns.length; i++) {
            Cell cell = header.createCell(i);
            cell.setCellValue(columns[i]);
        }

        // Data
        int rowNum = 1;

        for (ClientEntity c : list) {

            Row row = sheet.createRow(rowNum++);

            row.createCell(0).setCellValue(c.getClientId());
            row.createCell(1).setCellValue(c.getClientName());

            row.createCell(2).setCellValue(
                    c.getCity() != null ?
                            c.getCity().getCityName() : ""
            );

            row.createCell(3).setCellValue(
                    c.getMobile() != null ?
                            c.getMobile() : 0
            );

            row.createCell(4).setCellValue(
                    c.getEmailId() != null ?
                            c.getEmailId() : ""
            );

            row.createCell(5).setCellValue(
                    c.getSalesPartner() != null ?
                            c.getSalesPartner().getSalesPartnerShortName() : ""
            );

            row.createCell(6).setCellValue(
                    Boolean.TRUE.equals(c.getActive()) ? "Yes" : "No"
            );

            row.createCell(7).setCellValue(
                    Boolean.TRUE.equals(c.getB2b()) ? "Yes" : "No"
            );
        }

        // Auto size
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        workbook.write(out);
        workbook.close();
    }

    public void exportClientsToPdf(List<ClientEntity> list,
                                   OutputStream out) {

        try {

            Document document = new Document(PageSize.A4.rotate());
            PdfWriter.getInstance(document, out);

            document.open();

            Font titleFont = FontFactory.getFont(
                    FontFactory.HELVETICA_BOLD, 16);

            Paragraph title =
                    new Paragraph("Client Report", titleFont);

            title.setAlignment(Element.ALIGN_CENTER);

            document.add(title);
            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(8);
            table.setWidthPercentage(100);

            // Headers
            String[] headers = {
                    "ID", "Name", "City",
                    "Mobile", "Email",
                    "Sales Partner", "Active", "B2B"
            };

            for (String h : headers) {

                PdfPCell cell = new PdfPCell(
                        new Phrase(h));

                cell.setBackgroundColor(BaseColor.LIGHT_GRAY);

                table.addCell(cell);
            }

            // Data
            for (ClientEntity c : list) {

                table.addCell(String.valueOf(c.getClientId()));
                table.addCell(c.getClientName());

                table.addCell(
                        c.getCity() != null ?
                                c.getCity().getCityName() : ""
                );

                table.addCell(
                        c.getMobile() != null ?
                                String.valueOf(c.getMobile()) : ""
                );

                table.addCell(
                        c.getEmailId() != null ?
                                c.getEmailId() : ""
                );

                table.addCell(
                        c.getSalesPartner() != null ?
                                c.getSalesPartner().getSalesPartnerShortName() : ""
                );

                table.addCell(
                        Boolean.TRUE.equals(c.getActive()) ?
                                "Yes" : "No"
                );

                table.addCell(
                        Boolean.TRUE.equals(c.getB2b()) ?
                                "Yes" : "No"
                );
            }

            document.add(table);
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // For Excel Export
    public List<ClientEntity> getClientsForExcel(ClientEntityDTO filter) {
        return filterClientsForExport(filter);
    }

    // For PDF Export
    public List<ClientEntity> getClientsForPdf(ClientEntityDTO filter) {
        return filterClientsForExport(filter);
    }

}
