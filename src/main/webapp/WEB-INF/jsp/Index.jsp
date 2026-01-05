<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<title>Manohar Jewels Bill Entry</title>

<style>
    body {
        width: 750px;
        margin: auto;
        font-family: Arial, sans-serif;
        border: 1px solid #ccc;
        padding: 15px;
    }

    h2 { text-align: center; margin: 0; padding: 0; }
    .sub { text-align: center; font-size: 13px; margin-bottom: 10px; }

    table { width: 100%; border-collapse: collapse; font-size: 14px; }
    th, td { border: 1px solid #555; padding: 6px; }
    .no-border td { border: none !important; }

    input[type=text], input[type=number], input[type=date] {
        width: 100%;
        padding: 4px;
        font-size: 14px;
        box-sizing: border-box;
    }

    .right { text-align: right; }
    .logo {
        width: 80px;
        height: auto;
        display: block;
        margin: 0 auto;
    }
    .btn {
        padding:8px 20px; border:none; cursor:pointer; border-radius:4px;
    }
    .btn-add { background: #28a745; color: #fff; }
    .btn-remove { background: #d9534f; color: #fff; }
    .btn-print { background: #2196F3; color: #fff; }


	select {
	    height: 40px;
	    padding: 8px 12px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	.error-msg {
	    color: red;
	    text-align: right;
	    display: block;
	}
	</style>

</style>

</head>


<a href="<c:url value='/bill-list'/>">Bill List</a>

<a href="<c:url value='/RemaingAmtAllCustomer'/>">Remaining Amount Customer</a>
<body>

	<c:if test="${not empty msg}">
	    <script>
	        Swal.fire({
	            icon: 'success',
	            title: '${msg}',
	            showConfirmButton: true,
	            timer: 9000
	        });
	    </script>
	</c:if>
	<table>
	       <tr>
	           <td style="width: 20%;">
	               <img src="${pageContext.request.contextPath}/images/logo.jfif" class="logo" alt="logo">
	           </td>
	           <td style="text-align: center;">
	              <!-- <div class="heading">मनोहर ज्वेलर्स</div>-->
	               <div class="sub-head">शुद्ध सोने व चांदी के आधुनिक आभूषणों के विक्रेता व निर्माता</div>
	               <div class="sub-head">प्रो. हरीशकुमार, मनीषकुमार सोनी, इन्द्रा पार्क, अशोकनगर</div>
	           </td>
	       </tr>
	   </table>
	   <br>

<form action="saveBill" onsubmit="return validateForm()" method="post">

<table class="no-border">
    <tr>
        <td><b>Customer Name:</b><br>
			<input type="text" name="customerName" id="customerName" oninput="validateName()" require>

        </td>
        <td class="right"><b>Date:</b><br>
            <input type="date" name="date">
        </td>
    </tr>
    <tr>
        <td><b>Bill No:</b><br>
            <input type="text" name="billNo" onsubmit="return checkBillNo()"  maxlength="4" oninput="validateBillNo(this)"require>
        </td>
		<td>
		        <b>HSN</b><br>
		        <input type="text" name="hsncode" id="hsncode" onsubmit="return checkBillNo()"maxlength="4" oninput="validateBillNo(this)" style="width:100px;" require>
		    </td>

		    <td>
		        <b>HUID:</b><br>
		        <input type="text" name="huid" id="huid" maxlength="6" style="width:120px;">
		    </td>
    </tr>
</table>

<br>

<!-- Item Table -->
<table id="billTable">
    <thead>
        <tr>
            
            <th>Type</th>
			<th>Particular</th>
            <th>Net Wgt</th>
            <th>Rate</th>
            <th>Value</th>
            <th>Making %</th>
            <th>Amount</th>
           <!--<th>Action</th-->
        </tr>
    </thead>

    <tbody>
        <tr>
			
			<!--<td>
			    <select id="description" name="description"  onchange="changeJewellery1(this)";changeJewellery1();" required>
			        <option value="">Select</option>
			        <option value="Gold">Gold</option>
			        <option value="Silver">Silver</option>
			    </select>
			</td>-->
			
			<td>
							       <select name="description[]" class="description"
							               onchange="changeJewellery1(this);calcwr(this)" required>
							           <option value="">Select</option>
							           <option value="Gold">Gold</option>
							           <option value="Silver">Silver</option>
							       </select>
							   </td>


							   <td>
							   			       <select name="type[]" class="type" required>
							   			           <option value="">Types</option>
							   			       </select>
							   			   </td>
		   
			<td>
			    <div style="display: flex; align-items: center; gap: 1px;">
			        <input type="number"
			               step="0.001"
			               class="weight"
			               name="weight[]"
			               required
			               style="width: 60px;">

						   <input type="text"
						          class="unit"
						          name="unit[]"
						          required
						          readonly
						          style="border: none; outline: none; width: 35px;">			    </div>
			</td>
			
            <td><input type="number" step="0.01" class="rate" name="rate[]" oninput="calwrv(this)" required></td>

            <td><input type="number" step="0.01" name="value[]" class="value" ></td>

            <td><input type="text" step="0.01" name="making[]" class="making" oninput="calc(this) ; validateMaking(this)" require></td>

            <td><input type="number" step="0.01" name="amount[]" class="amount" readonly></td>

            <!--<td>
                <button type="button" class="removeRow btn btn-remove">X</button>
            </td>-->
        </tr>
    </tbody>
</table>

<br>

<button type="button" id="addRowBtn" class="btn btn-add">+ Add Row</button>  <button type="button" class="removeRow btn btn-remove">X Remove Row</button>

<br><br>

<!-- Summary -->
<table>
   <!-- <tr>
        <td><b>Discount</b></td>
        <td><input type="number" step="0.01" name="discount" class="right" id="discount" value=0 oninput="recalculateAll()"></td>
    </tr>-->
    <tr>
        <td><b>CGST 1.5%</b></td>
        <td><input type="number" step="0.01" name="cgst" id="cgst" class="left" readonly></td>
    </tr>
    <tr>
        <td><b>SGST 1.5%</b></td>
        <td><input type="number" step="0.01" name="sgst" id="sgst" class="left" readonly></td>
    </tr>
	<tr>
		       <td><b>Total Amount</b></td>
		       <td><input type="text" step="0.01" name="totalAmount" id="totalAmount" class="left" readonly></td>
		   </tr>
		   <tr>
		       <td><b>Round Off</b></td>
		     
			   
			   <td>
			       <input type="text"
			              step="0.01"
			              name="roundOff"
			              class="left"
			              id="roundOff"
			              min="-10"
			              max="10"
			              oninput="validateRoundOff(this);calculateFinalAmount();">
						  
						 <!--validateRoundOff(this);calculateFinalAmount();limitDigits(this)"-->
			   </td>
			   
		   </tr>

		   <tr>
		       <td><b>Final Amount</b></td>
		       <td>
		           <input type="number" step="0.01" name="finalAmount" id="finalAmount"
		                  class="left" readonly>
		       </td>
		   </tr>

		   <tr>
		       <td><b>Deposit Amount</b></td>
		       <td>
		           <input type="number" step="0.01" name="depositAmount" id="depositAmount"
		                  class="left" oninput="calculatePending()">
		       </td>
		   </tr>

		   <tr>
		       <td><b>Pending Amount</b></td>
		       <td>
		           <input type="number" step="0.01" name="pendingAmount" id="pendingAmount"
		                  class="left" readonly>
		       </td>
		   </tr>

		   
		   
		   <tr>
		   		       <td><b>Final Amount in Words</b></td>
		   		       <td>
		   		           <input type="text" step="0.01" name="finalAmountword" id="finalAmountword"
		   		                  class="left" readonly>
		   		       </td>
		   		   </tr>
    <tr>
        <td><b>Receipt / Cash</b></td>
        <td><input type="text" name="paymentMode" class="left" id="paymentMode"></td>
    </tr>
</table>

<br><br>

<!-- Submit Button -->
<div style="text-align:center;">
    <button type="submit" style="padding:10px 25px; font-size:16px; cursor:pointer;">Submit Bill</button>
</div>

</form>

<!-- Right-side Bill Search + Print Section -->
<table class="no-border" style="float: right; width: 280px; margin-bottom: 20px;">
    <tr>
        <td><b>Enter Bill No:</b></td>
    </tr>
    <tr>
        <td>
			<form action="bills" onsubmit="return checkBillNo()" method="get">
			    <input type="text" id="billNo" name="billNo" placeholder="Enter Bill No"
			           maxlength="4" oninput="validateBillNo(this)" required>
			    <br><br>
			    <button type="submit" class="btn btn-print">Download Bill</button>
			</form>
        </td>
    </tr>
</table>
<c:if test="${param.msg == 'success'}">
    <span style="color: green;">Bill found successfully</span>
</c:if>


<c:if test="${param.msg == 'notfound'}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Oops!',
            text: 'Bill Number not found ',
            timer: 9000,
            showConfirmButton: true
        });
    </script>
</c:if>

<div style="clear: both;"></div>
<!-- ============ SCRIPTS ============ -->
<script>
	
	
	
document.addEventListener('DOMContentLoaded', function() {

    // Add row button
    document.getElementById("addRowBtn").addEventListener("click", function () {
        let tableBody = document.querySelector("#billTable tbody");

        let newRow = `
            <tr>
				<td>
				       <select name="description[]" class="description"
				               onchange="changeJewellery1(this);calcwr(this)" required>
				           <option value="">Select</option>
				           <option value="Gold">Gold</option>
				           <option value="Silver">Silver</option>
				       </select>
				   </td>

				   <td>
				       <select name="type[]" class="type" required>
				           <option value="">Types</option>
				       </select>
				   </td>
				   <td>
				   			    <div style="display: flex; align-items: center; gap: 1px;">
									<input type="number"
									                         step="0.001"
									                         class="weight"
									                         name="weight[]"
									                         required
									                         style="width:60px;">
				   						   <input type="text"
				   						          class="unit"
				   						          name="unit[]"
				   						          required
				   						          readonly
				   						          style="border: none; outline: none; width: 35px;">			    </div>
				   			</td>

				   
							<td>
							            <input type="number" step="0.01" class="rate"
							                   name="rate[]" oninput="calwrv(this)" required>
							        </td>
									
									

							        <td>
							            <input type="number" step="0.01" class="value"
							                   name="value[]" readonly>
							        </td>
									
									
                <td><input type="number" step="0.01" name="making[]" class="making" oninput="calc(this)"></td>

                <td><input type="number" step="0.01" name="amount[]" class="amount" readonly></td>

               <!-- <td>
                    <button type="button" class="removeRow btn btn-remove">x</button>
                </td>-->
            </tr>
        `;

        tableBody.insertAdjacentHTML("beforeend", newRow);
    });

    // Remove row (event delegation)
    document.querySelector("#billTable tbody").addEventListener("click", function(e) {
        if (e.target && e.target.classList.contains('removeRow')) {
            e.target.closest('tr').remove();
            recalculateAll();
        }
    });

}); // DOMContentLoaded

// Calculate single row amount and then totals
function calc(elem) {
    let row = elem.closest('tr');

    let value  = parseFloat(row.querySelector(".value").value)  || 0;
    let making = parseFloat(row.querySelector(".making").value) || 0;

    // amount = value * (1 + making/100)
    let amount = value * (1 + (making / 100));
    row.querySelector(".amount").value = amount.toFixed(2);

    recalculateAll();
}

// Recalculate total, gst etc.
function recalculateAll() {
    // sum of all row amounts
    let amountEls = document.querySelectorAll(".amount");
    let sum = 0;
    amountEls.forEach(function(el) {
        sum += parseFloat(el.value) || 0;
    });

    // apply discount if any
  //  let discount = parseFloat(document.getElementById('discount').value) || 0;
     let discount=0;
    let subtotal = Math.max(0, sum - discount);

    // GST 1.5% each
    let cgst = subtotal * 1.5 / 100;
    let sgst = subtotal * 1.5 / 100;

    let total = subtotal + cgst + sgst;

    document.getElementById('totalAmount').value = total.toFixed(2);
    document.getElementById('cgst').value = cgst.toFixed(2);
    document.getElementById('sgst').value = sgst.toFixed(2);
}

// alias to recalc when user changes discount manually
function recalculateAllOnInput() {
    recalculateAll();
}

// optional: per-row gst calc (if you want to calculate cgst per-row)
function calcgst(elem) {
    let row = elem.closest('tr');
    let amount = parseFloat(row.querySelector('.amount').value) || 0;
    let cgstRow = amount * 1.5 / 100;
    // if you have a per-row cgst input, set it here
    // row.querySelector('.cgst').value = cgstRow.toFixed(2);
    return cgstRow;
}
</script>

<script>
function validateBillNo(input) {
    // Remove any non-digit character
    input.value = input.value.replace(/\D/g, '');

    // Limit to 4 digits only
    if (input.value.length > 4) {
        input.value = input.value.slice(0, 4);
    }
}
</script>

<script>

function validateBillNo(input) {
    // remove non-digits
    input.value = input.value.replace(/\D/g, '');

    // remove leading zero
    input.value = input.value.replace(/^0+/, '');

    // limit to max 4 digits
    if (input.value.length > 4) {
        input.value = input.value.slice(0, 4);
    }
}

// Check on form submit
function checkBillNo() {
    let billNo = document.getElementById("billNo").value;

    if (billNo.length >=5) {
        alert("Please Enter Correct Digit Bill Number.");
        return false; // Stop submission
    }

    return true; // allow form submit
}
</script>

<script>
	
	function copyRoundOff() {
	    let value = document.getElementById("roundOff").value;
	    document.getElementById("finalAmount").value = value;
	}
	
	function limitDigits(input) {
	    // Allow only digits and decimal point
	    input.value = input.value.replace(/[^0-9.]/g, "");

	    let parts = input.value.split(".");

	    // Limit BEFORE decimal: max 8 digits
	    if (parts[0].length > 2) {
	        parts[0] = parts[0].slice(0, 2);
	    }

	    // Limit AFTER decimal: max 2 digits
	    if (parts[1]) {
	        parts[1] = parts[1].slice(0, 2);
	    }

	    input.value = parts.join(".");
	}

	</script>
	
		<script>
		function copyRoundOff() {
		    let value = document.getElementById("roundOff").value;
		    document.getElementById("finalAmount").value = value;
		    convertToWords();  // convert auto
		}

		function convertToWords() {
		    let num = document.getElementById("finalAmount").value;
		    document.getElementById("finalAmountword").value = numberToWords(num);
		}

		function numberToWords(num) {
		    num = parseFloat(num);
		    if (isNaN(num)) return "";

		    let ones = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"];
		    let tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
		    let teens = ["Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];

		    // Convert 1-999
		    function convert(n) {
		        if (n < 10) return ones[n];
		        if (n < 20) return teens[n - 10];
		        if (n < 100) return tens[Math.floor(n / 10)] + (n % 10 ? " " + ones[n % 10] : "");
		        if (n < 1000) return ones[Math.floor(n / 100)] + " Hundred" + (n % 100 ? " " + convert(n % 100) : "");
		        return "";
		    }

		    // Split Rupees and Paise
		    let integerPart = Math.floor(num);
		    let decimalPart = Math.round((num - integerPart) * 100);

		    if (integerPart === 0) return "Zero Rupees";

		    let output = "";

		    // Crore
		    let crore = Math.floor(integerPart / 10000000);
		    if (crore > 0) output += convert(crore) + " Crore ";
		    integerPart %= 10000000;

		    // Lakh
		    let lakh = Math.floor(integerPart / 100000);
		    if (lakh > 0) output += convert(lakh) + " Lakh ";
		    integerPart %= 100000;

		    // Thousand
		    let thousand = Math.floor(integerPart / 1000);
		    if (thousand > 0) output += convert(thousand) + " Thousand ";
		    integerPart %= 1000;

		    // Remaining 1-999
		    if (integerPart > 0) output += convert(integerPart);

		    output = output.trim() + " Rupees";

		    // Add paise if exists
		    if (decimalPart > 0) {
		        output += " and " + convert(decimalPart) + " Paise";
		    }

		    return output;
		}

		</script>
		
		<script>
			
		function validateName()
		 {
			let input = document.getElementById("customerName");
			    let value = input.value;

			    // Allow only letters and spaces
			    value = value.replace(/[^A-Za-z ]/g, "");

			    // Capitalize first letter and letters after space
			    value = value.replace(/\b\w/g, function(char) {
			        return char.toUpperCase();
			    });

			    input.value = value;
					}
					
					function validateMaking(input)
					 {
					    // Remove any character that is not a digit or a dot
					    let value = input.value;

					    // Allow only numbers and one decimal point
					    value = value.replace(/[^0-9.]/g, '');       // Remove non-numeric chars
					    const parts = value.split('.');
					    if(parts.length > 2) {
					        // More than one decimal point, keep first only
					        value = parts[0] + '.' + parts[1];
					    }

					    input.value = value;

					    // Call your calculation function
					    calc(input);
					}
		</script>
	
		
			
		<script>
			
		function validateName() 
		{
		    let input = document.getElementById("customerName");
		    let value = input.value;

		    // Allow only letters and spaces
		    value = value.replace(/[^A-Za-z ]/g, "");

		    // Capitalize first letter and letters after space
		    value = value.replace(/\b\w/g, function(char) {
		        return char.toUpperCase();
		    });

		    input.value = value;
		}

		// Form validation on submit
		function validateForm()
		 {
		    let customerName = document.getElementById("customerName").value.trim();

		    if (customerName.length < 3) {
		        alert("Customer Name must be at least 3 characters!");
		        return false; // Stop form submission
		    }

		    return true; // Allow form submission
		}
		</script>
		
		<script>
			
			function calwrv(e2)
			{
				let row = e2.closest('tr');
				let type = row.querySelector(".description").value;
				let weight = parseFloat(row.querySelector(".weight").value) || 0;
			    let rate   = parseFloat(row.querySelector(".rate").value) || 0;
				let value = weight * rate;
						if(type==="Gold")
						{
						let value1=value/10;
					    row.querySelector(".value").value = value1.toFixed(2);
			
						}
						if(type==="Silver")
						{
							let value1=value/1000;
							row.querySelector(".value").value = value1.toFixed(2);
						
						}



			}
			
		</script>
		
		<script>
		function calcwr(el) {
			
		
		  let row = el.closest('tr');
		 
		  // let type = document.getElementById("description").value;  //Gold/Silver
		  // let item = document.getElementById("type");
		  
		  let type = row.querySelector(".description").value;

		     let weight = parseFloat(row.querySelector(".weight").value) || 0;
		     let rate   = parseFloat(row.querySelector(".rate").value) || 0;


		   // let weight = parseFloat(row.querySelector(".weight").value) || 0;
		    //let rate   = parseFloat(row.querySelector(".rate").value) || 0;

		    let value = weight * rate;
			if(type==="Gold")
			{
			let value1=value/10;
		    row.querySelector(".value").value = value1.toFixed(2);
			row.querySelector(".unit").value = "mg";
			}
			if(type==="Silver")
			{
				let value1=value/1000;
				row.querySelector(".value").value = value1.toFixed(2);
				row.querySelector(".unit").value="g";
			}

		    
		}	
		</script>

		
	
			<script>
		function changeJewellery1(descSelect) {
		//alert("Good");
		    // current row
		    let row = descSelect.closest("tr");

		    // type dropdown of same row
		    let item = row.querySelector(".type");

		    // clear old options
		    item.innerHTML = '<option value="">Select Jewellery</option>';

		    if (descSelect.value === "Gold") {
		        item.innerHTML += `
		            <option value="20K">20K JEWELLERY</option>
		            <option value="22K">22K JEWELLERY</option>
		            <option value="MIX">MIX JEWELLERY</option>
		        `;
		    } 
		    else if (descSelect.value === "Silver") {
		        item.innerHTML += `
		            <option value="Jewellery">Jewellery</option>
		            <option value="Mix">Mix Jewellery</option>
		            <option value="925">925 Silver Jewellery</option>
		            <option value="Vartem">Vartem Jewellery</option>
		        `;
		    }
		}
		</script>
		
		

		<script>
			
			function validateRoundOff(input) {
			    let value = input.value;

			    // allow empty & typing "-"
			    if (value === "" || value === "-") return;

			    // allow only number with optional decimal & negative
			    if (!/^-?\d*\.?\d*$/.test(value)) {
			        input.value = value.slice(0, -1);
			        return;
			    }

			    let num = Number(value);

			    // range check
			    if (num < -10 || num > 10) {
			        input.value = value.slice(0, -1);
			    }
			}

		function calculateFinalAmount() {
		    let total = parseFloat(document.getElementById("totalAmount").value) || 0;
		    let roundOff = parseFloat(document.getElementById("roundOff").value) || 0;

		    let finalAmount = total + roundOff;

		    document.getElementById("finalAmount").value = finalAmount.toFixed(2);

		    // call words converter if needed
		    if (typeof convertToWords === "function") {
		        convertToWords();
		    }
		}
		</script>
		
		<script>
		function changeJewellery() {
		    const type = document.getElementById("description").value;
		    const unitInput = document.querySelector(".unit");

		    if (type === "Gold") {
		        unitInput.value = "mg";
		    } else if (type === "Silver") {
		        unitInput.value = "g";
		    } else {
		        unitInput.value = "";
		    }
		}
		</script>
		
		<script>
		function calculatePending() {

		    let finalAmt = parseFloat(document.getElementById("finalAmount").value) || 0;
		    let depositAmt = parseFloat(document.getElementById("depositAmount").value) || 0;

		    // ❌ Deposit > Final
		    if (depositAmt > finalAmt) {
		        alert("Deposit Amount cannot be greater than Final Amount");
		        document.getElementById("depositAmount").value = finalAmt.toFixed(2);
		        depositAmt = finalAmt;
		    }

		    // Pending = Final - Deposit
		    let pendingAmt = finalAmt - depositAmt;

		    document.getElementById("pendingAmount").value = pendingAmt.toFixed(2);
		}
		</script>


</body>
</html>
