<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<c:set var="now" value="<%= new java.util.Date() %>" />

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 13px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 6px;
        text-align: center;
    }
    th {
        background: #f2f2f2;
    }
    .edit {
        background: #4CAF50;
        color: white;
        padding: 4px 8px;
        text-decoration: none;
        border-radius: 4px;
    }
    .delete {
        background: #f44336;
        color: white;
        padding: 4px 8px;
        text-decoration: none;
        border-radius: 4px;
    }
</style>

<c:set var="totalPreviousDeposit" value="0" />
<c:forEach var="dep" items="${previousDeposits}">
    <c:set var="totalPreviousDeposit" value="${totalPreviousDeposit + dep}" />
</c:forEach>

<input type="hidden" id="previousTotal" value="${totalPreviousDeposit}">

</div>

<div class="container mt-4">
    <h3>Deposit Amount - Bill No: ${bill.billNo}</h3>
	
	<div class="row mb-3">
	    <div class="col-md-6">
	        <label class="form-label"><b>Customer Name</b></label>
	        <input type="text"
	               name="customerName"
	               id="customerName"
	               class="form-control"
	               value="${bill.customerName}"
	               readonly>
	    </div>

		<div class="col-md-6">
		    <label class="form-label"><b>Date</b></label>
		    <input type="date"
		           name="date"
		           class="form-control"
		           max="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
		           required>
		</div>

	
    <!-- Final Amount -->
    <div class="mb-3">
        <label><b>Final Amount</b></label>
        <input type="number" class="form-control" id="finalAmount" 
               value="${bill.finalAmount}" readonly>
    </div>

    <!-- Previous Deposits -->
    <div class="mb-3">
        <label><b>Previous Deposits</b></label>
        <ul class="list-group">
            <c:forEach var="dep" items="${previousDeposits}">
                <li class="list-group-item text-success">
                    ${dep}
                </li>
            </c:forEach>
            <c:if test="${empty previousDeposits}">
                <li class="list-group-item text-danger">No deposits yet</li>
            </c:if>
        </ul>
    </div>

    <!-- Deposit Form -->
    <form action="${pageContext.request.contextPath}/saveDeposit/${bill.id}" method="post">
        <div class="mb-3">
            <label><b>Deposit Amount</b></label>
            <input type="number" step="0.01" min="0" class="form-control" id="depositAmount"
                   name="depositAmount" oninput="calculatePending()" required>
        </div>

        <div class="mb-3">
            <label><b>Pending Amount</b></label>
            <input type="number" step="0.01" class="form-control" id="pendingAmount" readonly>
        </div>

        <button type="submit" class="btn btn-primary">Submit Deposit</button>
        <a href="${pageContext.request.contextPath}/RemaingAmtAllCustomer" class="btn btn-secondary">Back</a>
    </form>
</div>

<script>
function calculatePending() {
    let finalAmt = parseFloat(document.getElementById("finalAmount").value) || 0;
    let depositAmt = parseFloat(document.getElementById("depositAmount").value) || 0;

    if (depositAmt > finalAmt) {
        alert("Deposit cannot exceed Final Amount");
        document.getElementById("depositAmount").value = finalAmt.toFixed(2);
        depositAmt = finalAmt;
    }

    let pendingAmt = finalAmt - depositAmt;
    document.getElementById("pendingAmount").value = pendingAmt.toFixed(2);
}

// Initialize pending on load
window.onload = function() {
    document.getElementById("pendingAmount").value = 
        parseFloat(document.getElementById("finalAmount").value).toFixed(2);
};
</script>
<script>
function calculatePending() {
    let finalAmt = parseFloat(document.getElementById("finalAmount").value) || 0;
    let prevTotal = parseFloat(document.getElementById("previousTotal").value) || 0;
    let depositAmt = parseFloat(document.getElementById("depositAmount").value) || 0;

    let totalPaid = prevTotal + depositAmt;

    if (totalPaid > finalAmt) {
        alert("Total deposit cannot exceed Final Amount");
        depositAmt = finalAmt - prevTotal;
        if (depositAmt < 0) depositAmt = 0;
        document.getElementById("depositAmount").value = depositAmt.toFixed(2);
        totalPaid = prevTotal + depositAmt;
    }

    let pendingAmt = finalAmt - totalPaid;
    document.getElementById("pendingAmount").value = pendingAmt.toFixed(2);
}

// On page load – pending without new deposit
window.onload = function() {
    let finalAmt = parseFloat(document.getElementById("finalAmount").value) || 0;
    let prevTotal = parseFloat(document.getElementById("previousTotal").value) || 0;

    let pendingAmt = finalAmt - prevTotal;
    document.getElementById("pendingAmount").value = pendingAmt.toFixed(2);
};
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const today = new Date().toISOString().split('T')[0];
    document.querySelector('input[type="date"]').setAttribute('max', today);
});
</script>