package com.vistaluxhms.entity;

import java.io.Serializable;

public class Leads_User_Map_Id implements Serializable {



	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private Long leadId;
	  
	
	private int userId;


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + userId;
		result = prime * result + ((leadId == null) ? 0 : leadId .hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Leads_User_Map_Id other = (Leads_User_Map_Id) obj;
		if (userId != other.userId)
			return false;
		if (leadId== null) {
			if (other.leadId != null)
				return false;
		} else if (!leadId.equals(other.leadId))
			return false;
		return true;
	}
	
	
}
