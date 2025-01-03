package com.vistaluxhms.repository;

import java.util.List;

import com.vistaluxhms.entity.City_Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


@Repository
public interface Vlx_City_Master_Repository extends JpaRepository<City_Entity,Integer>,JpaSpecificationExecutor{

	@Query("FROM City_Entity a WHERE a.active=true")
	List <City_Entity>findAllActiveUdnDestinations();

	@Query("FROM City_Entity a WHERE a.cityName=a.countryName AND a.active=true")
	List <City_Entity>findAllActiveUdnCountries();

	public List<City_Entity> findCountryNameDistinctBy();
	
	public List<City_Entity>  findDistinctByCountryNameContainsAllIgnoreCase(String countryName);
	
	@Query("FROM City_Entity a WHERE a.cityName=a.countryName AND a.countryCode=?1 AND a.active=true")
	public City_Entity findDestinationByCountryCode(String countryCode);
	
	@Query("FROM City_Entity a WHERE a.cityName!=a.countryName AND a.countryCode=?1 AND a.active=true")
	public List<City_Entity> find_CountryCityList(String countryCode);
	
	boolean existsByCountryCodeAndCountryName(String countryCode, String countryName);
	
	boolean existsByDestinationIdAndCityName(int destinationId, String cityNabyme);
	
	boolean existsByDestinationIdAndCountryName(int destinationId, String countryName);
	
	@Query("FROM City_Entity a WHERE a.active=true GROUP BY countryCode order by countryName")
	//public List<Udn_Destinations_Entity> findDistinctActiveDestinations();
	public List<City_Entity> findDistinctRecordsByCountryCode();
	
	//public String findDistinctByCountryCode(String countryCode);
	
	boolean existsByCityNameAndCountryCodeIgnoreCase(String cityName, String countryCode);

	@Query("FROM City_Entity a WHERE a.destinationId=?1")
	City_Entity findDestinationById(int destinationId);

	@Query("SELECT CONCAT(c.cityName, ' (', c.countryName, ')') FROM City_Entity c WHERE LOWER(c.cityName) LIKE LOWER(:query)")
	List<String> findCitiesByQuery(String query);
}