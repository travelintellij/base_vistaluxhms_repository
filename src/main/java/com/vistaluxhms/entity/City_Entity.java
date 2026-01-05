package com.vistaluxhms.entity;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.vistaluxhms.model.City_Obj;
import com.vistaluxhms.util.VistaluxConstants;


@Entity
@Table(name = "cities")
public class City_Entity{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	protected int destinationId=0;

	protected String cityName;
	protected String countryCode= VistaluxConstants.DEFAULT_DESTINATION_INDIA_CTRY_CODE;
	protected String countryName=VistaluxConstants.DEFAULT_DESTINATION_INDIA_CTRY_NAME;
	protected boolean active=true;


	/*
	@ManyToMany(targetEntity = Tg_Supplier_Master_Entity.class,fetch = FetchType.LAZY)
    Set<Tg_Supplier_Master_Entity> suppliers = new HashSet<>();
	 */
	
	public String getCityName() {
		return cityName;
	}


	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public int getDestinationId() {
		return destinationId;
	}


	public void setDestinationId(int destinationId) {
		this.destinationId = destinationId;
	}


	public String getCountryCode() {
		return countryCode;
	}


	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}


	public String getCountryName() {
		return countryName;
	}


	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}


	public boolean isActive() {
		return active;
	}


	public void setActive(boolean active) {
		this.active = active;
	}



	public City_Entity() {
		
	}
	
	public City_Entity(City_Obj cityObj) {
		this.active=cityObj.isActive();
		this.cityName=cityObj.getCityName();
		this.countryCode=cityObj.getCountryCode();
		this.countryName=cityObj.getCountryName();
	}


	public String toString() {
		String attrib = "destination Id -> " + destinationId + "\n";
		attrib = attrib + " City Name -> " + cityName + "\n";
		attrib = attrib + " Country Code-> " + countryCode + "\n";
		attrib = attrib + " Country Name-> " + countryName + "\n";
		attrib = attrib + " City Active -> " + active + "\n";
		return attrib;
	}

}