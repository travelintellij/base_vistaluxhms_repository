<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h2>Lead Details</h2>
<table class="table table-bordered">
    <tr><th>Lead ID</th><td>${LEAD_OBJ.client.clientId}</td></tr>
    <tr><th>Client Name</th><td>${LEAD_OBJ.clientName}</td></tr>
    <tr><th>Lead Owner</th><td>${LEAD_OBJ.leadOwner}</td></tr>
    <tr><th>Status</th><td>${LEAD_OBJ.leadStatus}</td></tr>
    <tr><th>Check-In Date</th><td>${LEAD_OBJ.checkInDate}</td></tr>
    <tr><th>Check-Out Date</th><td>${LEAD_OBJ.checkOutDate}</td></tr>
    <tr><th>Adults</th><td>${LEAD_OBJ.adults}</td></tr>
    <tr><th>Child With Bed</th><td>${LEAD_OBJ.cwb}</td></tr>
    <tr><th>Child No Bed</th><td>${LEAD_OBJ.cnb}</td></tr>
    <tr><th>Qualified</th><td>${LEAD_OBJ.qualified ? "Yes" : "No"}</td></tr>
    <tr><th>Flagged</th><td>${LEAD_OBJ.flagged ? "Yes" : "No"}</td></tr>
</table>

<!-- Close Button -->
<div class="text-center">
    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
</div>
