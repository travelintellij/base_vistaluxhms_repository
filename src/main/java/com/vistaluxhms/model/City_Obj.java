package com.vistaluxhms.model;

import com.vistaluxhms.entity.City_Entity;

import java.util.Map;



public class City_Obj extends City_Entity {
	

	Map cityKeyValue;
	
	public City_Obj() {
		
	}
	
	public City_Obj(City_Entity udnDestinationsEntity) {
		this.destinationId = udnDestinationsEntity.getDestinationId();
		this.cityName = udnDestinationsEntity.getCityName();
		this.countryCode=udnDestinationsEntity.getCountryCode();
		this.countryName=udnDestinationsEntity.getCountryName();
		this.active = udnDestinationsEntity.isActive();
	}
	
	public void updateCityVOFromEntity(City_Entity cityEntity) {
		this.destinationId = cityEntity.getDestinationId();
		this.cityName = cityEntity.getCityName();
		this.countryCode=cityEntity.getCountryCode();
		this.countryName=cityEntity.getCountryName();
		this.active = cityEntity.isActive();
	}

	public String toString() {
		String attrib = "destination Id -> " + destinationId + "\n";
		attrib = attrib + " City Name -> " + cityName + "\n";
		attrib = attrib + " Country Code-> " + countryCode + "\n";
		attrib = attrib + " Country Name-> " + countryName + "\n";
		attrib = attrib + " City Active -> " + active + "\n";
		return attrib;
	}
	
	 @Override
	 public boolean equals(Object obj) {
		 if(countryName.equalsIgnoreCase(((City_Obj)obj).getCountryName())){
			 return true;
		 }
		 return false;
	 }

	public Map getCityKeyValue() {
		return cityKeyValue;
	}

	public void setCityKeyValue(Map cityKeyValue) {
		this.cityKeyValue = cityKeyValue;
	}

		 
	 

}