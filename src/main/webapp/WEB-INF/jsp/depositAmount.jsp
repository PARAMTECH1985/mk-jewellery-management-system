<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deposit Amount</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background: linear-gradient(135deg, #FFF8E1, #F5E6C8);
        font-family: 'Segoe UI', sans-serif;
    }

    .gold-card {
        background: #ffffff;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        padding: 25px;
        border-top: 5px solid #D4AF37;
    }

    .gold-title {
        color: #B8962E;
        font-weight: 700;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
    }

    table {
        border-radius: 12px;
        overflow: hidden;
    }

    th {
        background: #1c1c1c;
        color: #D4AF37;
        width: 30%;
        vertical-align: middle;
    }

    td {
        background: #FFFDF5;
    }

    .form-control {
        border-radius: 8px;
        border: 1px solid #D4AF37;
    }

    .form-control:focus {
        box-shadow: 0 0 6px #D4AF37;
        border-color: #B8962E;
    }

    .list-group-item {
        background: #FFF8E1;
        border-left: 5px solid #D4AF37;
        font-weight: 500;
    }

    .btn-gold {
        background: linear-gradient(135deg, #D4AF37, #B8962E);
        color: #1c1c1c;
        font-weight: bold;
        border-radius: 25px;
        padding: 10px 28px;
        border: none;
    }

    .btn-gold:hover {
        background: linear-gradient(135deg, #B8962E, #D4AF37);
        color: #fff;
    }

    .btn-dark-outline {
        border: 2px solid #1c1c1c;
        color: #1c1c1c;
        border-radius: 25px;
        padding: 10px 28px;
    }

    .btn-dark-outline:hover {
        background: #1c1c1c;
        color: #D4AF37;
    }
</style>
</head>
<body>

<div class="container mt-5">
    <div class="gold-card mx-auto w-75">

        <h3 class="text-center gold-title mb-4">
            💎 Deposit Amount – Bill No: ${bill.billNo}
        </h3>

    <input type="hidden" id="previousTotal" value="${totalPreviousDeposit}" />

    <form action="${pageContext.request.contextPath}/saveDeposit/${bill.id}" method="post">

        <table class="table table-bordered w-75 mx-auto">
            <tbody>

                <tr>
                    <th>Customer Name</th>
                    <td>
                        <input class="form-control w-50" value="${bill.customerName}" readonly />
                    </td>
                </tr>

                <tr>
                    <th>Final Amount</th>
					
                    <td>
                        <input id="finalAmount" class="form-control w-50"
                               value="${bill.finalAmount}" readonly />
                    </td>
                </tr>

                <tr>
                    <th>Previous Deposits</th>
					<td>
					        <c:if test="${not empty previousDeposits}">
					            <ul class="list-group w-50" id="depositList">
					                <c:forEach var="dep" items="${previousDeposits}">
					                    <li class="list-group-item d-flex justify-content-between"
					                        data-amount="${dep.amount}">
					                        <span>${dep.amount}</span>
											<span>${dep.depositDate}</span>
					                    </li>
					                </c:forEach>
					            </ul>

					           
					        </c:if>

					        <c:if test="${empty previousDeposits}">
					            No deposits yet
					        </c:if>
                </tr>

                <tr>
                    <th>Deposit Amount</th>
                    <td>
						<input type="text"
						       class="form-control w-50"
						       id="depositAmount"
						       name="depositAmount"
						       inputmode="decimal"
							   maximum="9"
						       oninput="limitToNineDigits(this); calculatePending();"
						       required />
                    </td>
                </tr>

                <tr>
                    <th>Pending Amount</th>
                    <td>
						<input type="number" step="0.01"
						       class="form-control w-50"
						       id="pendingAmount"
						       name="pendingAmount"
						       oninput="calculatePendingAmount()" 
						       required />
                    </td>
                </tr>

            </tbody>
        </table>

		<div class="text-center mt-4">
		               <button class="btn btn-gold">💰 Submit Deposit</button>
		               <a href="${pageContext.request.contextPath}/RemaingAmtAllCustomer"
		                  class="btn btn-dark-outline ms-3">⬅ Back</a>
		           </div>

    </form>
</div>
</body>
</html>
<!--<input type="hidden" id="totalPreviousDeposit" value="0">-->
<c:set var="totalPrev" value="0" />
<c:forEach var="dep" items="${previousDeposits}">
    <c:set var="totalPrev" value="${totalPrev + dep.amount}" />
</c:forEach>



<script>
function calculatePendingAmount() {

    let finalAmount =
        parseFloat(document.getElementById("finalAmount").value) || 0;

    let previousTotal = parseFloat(document.getElementById("previousTotal").value) || 0;

    let depositAmt = parseFloat(document.getElementById("depositAmount").value) || 0;

    let totalPaid = previousTotal + depositAmt;

    // Validation
    if (totalPaid > finalAmount) {
        alert("Total deposit cannot exceed Final Amount");
        depositAmt = finalAmount - totalPaid;
		alert(depositAmt);
        if (depositAmt < 0) depositAmt = 0;
        document.getElementById("depositAmount").value =
            depositAmt.toFixed(2);
        totalPaid = previousTotal + depositAmt;
    }

    let pending = finalAmount - totalPaid;
    if (pending < 0) pending = 0;

    document.getElementById("pendingAmount").value =
        pending.toFixed(2);
}

// ✅ Page load par pending show ho
document.addEventListener("DOMContentLoaded", function () {
    calculatePendingAmount();
});
</script>

<script>
	
	function showTotalDeposits() {

	    let total = 0;

	    // Final Amount
	    let finalAmount =
	        parseFloat(document.getElementById("finalAmount")?.value) || 0;

	    // Add all previous deposits
	    document.querySelectorAll("#depositList li").forEach(function (item) {
	        let amt = parseFloat(item.getAttribute("data-amount")) || 0;
	        total += amt;
	    });

	   
	    let pendingFinal = finalAmount - total;
	   
	    // Show in textbox
	    let pendingInput = document.getElementById("pendingAmount");
	    if (pendingInput) {
	        pendingInput.value = pendingFinal.toFixed(2);
	    }
	}

	document.addEventListener("DOMContentLoaded", showTotalDeposits);
	</script>
	
	<script>
	function limitToNineDigits(input) {
	    let value = input.value;

	    // Allow only numbers and one dot
	    value = value.replace(/[^0-9.]/g, '');

	    // Split integer and decimal
	    let parts = value.split('.');

	    // Limit integer part to 9 digits
	    if (parts[0].length > 9) {
	        parts[0] = parts[0].slice(0, 9);
	    }

	    // Allow only one decimal part
	    if (parts.length > 2) {
	        parts = [parts[0], parts[1]];
	    }

	    input.value = parts.join('.');
	}
	</script>

	<script>
	function calculatePending() {
	    let pending = parseFloat(document.getElementById("pendingAmount").value) || 0;
	    let deposit = parseFloat(document.getElementById("depositAmount").value) || 0;

	    if (deposit > pending) {
			
			document.getElementById("depositAmount").classList.add("is-invalid");
			
	        alert("Deposit Amount cannot be greater than Pending Amount");

	        // value reset
	        document.getElementById("depositAmount").value = "";
	        document.getElementById("depositAmount").focus();
	        return false; // operation destroy
	    }
		else
		{
			document.getElementById("depositAmount").classList.remove("is-invalid");
		}

	    // yahan aap aage ka calculation likh sakte ho
	}
	</script>
