<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Old Item Exchange / Buyback</title>
<style>
/* =============================
   Premium UI Theme (CSS Only)
   Logic/JS untouched ✅
============================= */

:root{
    --bg1:#0f2027;
    --bg2:#203a43;
    --bg3:#2c5364;
    --card:#ffffff;
    --muted:#6b7280;
    --text:#0f172a;
    --border:#e6e8ee;
    --shadow: 0 12px 28px rgba(2, 12, 27, 0.10);
    --shadow2: 0 18px 45px rgba(2, 12, 27, 0.14);
    --gold1:#c9a24d;
    --gold2:#f4d03f;
    --green:#22c55e;
    --green2:#16a34a;
    --focus: rgba(201,162,77,0.25);
}

*{
    box-sizing:border-box;
}

body{
    margin:0;
    font-family: "Segoe UI", Arial, sans-serif;
    color:var(--text);
    background: radial-gradient(circle at 15% 15%, #ffffff0d, transparent 35%),
                radial-gradient(circle at 85% 25%, #ffffff10, transparent 30%),
                linear-gradient(135deg,var(--bg1),var(--bg2),var(--bg3));
}

/* ===== Container ===== */
.container{
    width: 92%;
    max-width: 1280px;
    margin: 28px auto;
    background: rgba(255,255,255,0.94);
    padding: 26px 26px 22px;
    border-radius: 18px;
    box-shadow: var(--shadow2);
    border: 1px solid rgba(255,255,255,0.45);
    backdrop-filter: blur(8px);
}

/* ===== Title ===== */
h2{
    margin: 0 0 18px;
    font-size: 24px;
    font-weight: 800;
    color:#0b1220;
    letter-spacing:.2px;
    display:flex;
    align-items:center;
    gap:10px;
    padding-bottom: 14px;
    border-bottom: 1px solid rgba(15,23,42,0.08);
    position:relative;
}

h2:before{
    content:"";
    width: 10px;
    height: 28px;
    border-radius: 6px;
    background: linear-gradient(180deg, var(--gold2), var(--gold1));
    box-shadow: 0 6px 18px rgba(201,162,77,.35);
}

h2:after{
    content:"";
    position:absolute;
    left:0;
    bottom:-1px;
    width: 190px;
    height: 3px;
    border-radius: 4px;
    background: linear-gradient(90deg, var(--gold1), var(--gold2));
}

/* ===== Card ===== */
.card{
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 18px 18px 14px;
    margin-bottom: 18px;
    background: var(--card);
    box-shadow: var(--shadow);
    position:relative;
    overflow:hidden;
}

.card.old{
    background: linear-gradient(180deg,#ffffff,#f7f8fb);
}

.card.new{
    background: linear-gradient(180deg,#ffffff,#fbfffd);
    border-left: 6px solid var(--green);
}

.card:before{
    content:"";
    position:absolute;
    top:-40px;
    right:-40px;
    width:120px;
    height:120px;
    border-radius:50%;
    background: radial-gradient(circle, rgba(201,162,77,.20), transparent 60%);
}

/* ===== Card Title ===== */
.card-title{
    font-weight: 800;
    margin-bottom: 14px;
    font-size: 15px;
    color:#111827;
    display:flex;
    align-items:center;
    justify-content:space-between;
}

.card-title:after{
    content:"";
    display:block;
    height:1px;
    flex:1;
    margin-left: 12px;
    background: linear-gradient(90deg, rgba(201,162,77,.35), transparent);
}

/* ===== Form Layout ===== */
.form-row{
    display:flex;
    flex-wrap:wrap;
    gap: 14px 14px; /* elegant spacing */
}

.form-group{
    width: 20%;
    min-width: 190px;
    margin: 0; /* remove old spacing */
}

.form-group label{
    display:block;
    font-size: 12px;
    font-weight: 800;
    letter-spacing:.2px;
    margin-bottom: 6px;
    color: #334155;
}

/* ===== Inputs ===== */
.form-group input,
.form-group select{
    width:100%;
    padding: 10px 11px;
    font-size: 13.5px;
    border: 1px solid rgba(15,23,42,0.12);
    border-radius: 10px;
    background:#ffffff;
    outline:none;
    transition: .22s ease;
    box-shadow: 0 1px 0 rgba(255,255,255,0.8) inset;
}

.form-group input:hover,
.form-group select:hover{
    border-color: rgba(201,162,77,0.55);
}

.form-group input:focus,
.form-group select:focus{
    border-color: var(--gold1);
    box-shadow: 0 0 0 3px var(--focus);
}

/* readonly premium */
input[readonly]{
    background: linear-gradient(180deg,#f8fafc,#eef2f6);
    color:#0f172a;
    font-weight: 700;
    border-color: rgba(15,23,42,0.10);
}

/* Dropdown arrow style */
select{
    appearance:none;
    background-image:
      linear-gradient(45deg, transparent 50%, #64748b 50%),
      linear-gradient(135deg, #64748b 50%, transparent 50%),
      linear-gradient(to right, transparent, transparent);
    background-position:
      calc(100% - 18px) calc(50% - 2px),
      calc(100% - 12px) calc(50% - 2px),
      calc(100% - 2.2em) 0.5em;
    background-size:6px 6px, 6px 6px, 1px 1.8em;
    background-repeat:no-repeat;
    padding-right: 38px;
}

/* ===== Final calc emphasis ===== */
.card:last-of-type{
    border: 1px solid rgba(201,162,77,0.38);
    background: linear-gradient(180deg,#ffffff,#fffaf0);
}

/* ===== Button ===== */
button{
    margin-top: 8px;
    padding: 12px 30px;
    border:none;
    border-radius: 999px;
    color:#fff;
    font-size: 14px;
    font-weight: 900;
    letter-spacing:.35px;
    cursor:pointer;
    background: linear-gradient(135deg, #1abc9c, #1f4fd8);
    box-shadow: 0 14px 30px rgba(31,79,216,0.22);
    transition: .25s ease;
}

button:hover{
    transform: translateY(-2px);
    box-shadow: 0 18px 40px rgba(31,79,216,0.28);
}

button:active{
    transform: translateY(0);
}

/* ===== Responsive ===== */
@media (max-width: 1050px){
    .form-group{ width: 32%; min-width: 220px; }
}
@media (max-width: 760px){
    .container{ width: 95%; padding: 18px; }
    .form-group{ width: 100%; min-width: unset; }
    h2{ font-size: 20px; }
}


/* ============================
   PREMIUM ADD-ON (DESIGN ONLY)
   JS / LOGIC NO CHANGE ✅
============================ */

/* ===== Better Card Headings ===== */
.card-title{
    position:relative;
    padding-left: 34px;
    font-size: 15.5px;
}

.card.old .card-title:before{
    
    position:absolute;
    left:0;
    top:-2px;
    font-size:18px;
}

.card.new .card-title:before{

    position:absolute;
    left:0;
    top:-2px;
    font-size:18px;
}

.card:last-of-type .card-title:before{
 
    position:absolute;
    left:0;
    top:-2px;
    font-size:18px;
}

/* ===== Input polish ===== */
.form-group input,
.form-group select{
    transition: .25s ease;
}

.form-group input:hover,
.form-group select:hover{
    box-shadow: 0 8px 16px rgba(2, 12, 27, 0.06);
}

/* ===== Final Calculation Premium Highlight ===== */
.card:last-of-type{
    border: 1px solid rgba(201,162,77,0.55) !important;
    box-shadow: 0 16px 38px rgba(201,162,77,0.14) !important;
}

.card:last-of-type:before{
    background: radial-gradient(circle, rgba(201,162,77,.28), transparent 60%) !important;
}

/* ===== Save Exchange button premium ===== */
button{
    display:block;
    margin: 16px auto 0;
    width: 240px;
    padding: 14px 0;
    border-radius: 999px;
    font-size: 15px;
    font-weight: 900;
    letter-spacing:.5px;
    background: linear-gradient(135deg, #22c55e, #1f4fd8);
    box-shadow: 0 16px 35px rgba(34,197,94,0.20),
                0 16px 35px rgba(31,79,216,0.18);
    position:relative;
    overflow:hidden;
}

button:before{
    content:"";
    position:absolute;
    top:-40%;
    left:-60%;
    width: 60%;
    height: 200%;
    background: rgba(255,255,255,0.22);
    transform: rotate(25deg);
    transition:.45s ease;
}

button:hover:before{
    left: 120%;
}

button:hover{
    transform: translateY(-3px) scale(1.02);
}

button:active{
    transform: translateY(0px) scale(0.99);
}



/* ==============================
   PREMIUM DROPDOWN (PILL STYLE)
   ONLY CSS ✅ No JS change
============================== */

/* Transaction type row spacing */
.form-row:first-of-type{
    padding: 10px 12px 16px;
    border-radius: 14px;
    background: rgba(15,23,42,0.03);
    border: 1px solid rgba(15,23,42,0.06);
    margin-bottom: 14px;
}

/* Dropdown premium look */
#exchangeType{
    border-radius: 999px !important;
    padding: 11px 44px 11px 14px !important;
    font-weight: 800;
    color:#0f172a;
    border: 1px solid rgba(201,162,77,0.45) !important;
    background:
      linear-gradient(180deg,#ffffff,#f7f9fc) !important;
    box-shadow: 0 10px 22px rgba(2, 12, 27, 0.06);
    cursor:pointer;
}

/* Hover */
#exchangeType:hover{
    border-color: rgba(201,162,77,0.75) !important;
}

/* Focus */
#exchangeType:focus{
    box-shadow: 0 0 0 3px rgba(201,162,77,0.22),
                0 12px 26px rgba(201,162,77,0.12) !important;
}

/* Premium arrow */
#exchangeType{
    appearance:none;
    background-image:
      linear-gradient(45deg, transparent 50%, #c9a24d 50%),
      linear-gradient(135deg, #c9a24d 50%, transparent 50%),
      linear-gradient(to right, transparent, transparent) !important;
    background-position:
      calc(100% - 20px) calc(50% - 2px),
      calc(100% - 14px) calc(50% - 2px),
      calc(100% - 2.4em) 0.5em !important;
    background-size:6px 6px, 6px 6px, 1px 1.8em !important;
    background-repeat:no-repeat !important;
}

/* Make label look premium */
.form-row:first-of-type .form-group label{
    color:#1f2937;
    font-size: 12px;
    font-weight: 900;
    letter-spacing: .25px;
}


</style>

</head>

<body>

<div class="container">

<h2>Old Item Exchange / Buyback</h2>

<form action="${pageContext.request.contextPath}/saveExchange" method="post">

<input type="hidden" name="billId" value="${exchange.billId}"/>

<div class="form-row">
    <div class="form-group">
        <label>Date</label>
        <input type="date" name="exchangeDate"
               value="${exchange.exchangeDate}" readonly>
    </div>

    <div class="form-group">
        <label>Transaction Type</label>
        <select name="exchangeType" id="exchangeType"
                onchange="toggleNewItem();calculateExchange()">
            <option value="EXCHANGE"
                ${exchange.exchangeType == 'EXCHANGE' ? 'selected' : ''}>
                Exchange
            </option>
            <option value="BUYBACK"
                ${exchange.exchangeType == 'BUYBACK' ? 'selected' : ''}>
                Buyback
            </option>
        </select>
    </div>
</div>

<!-- ================= OLD ITEM ================= -->
<div class="card old">
    <div class="card-title">Old Item (Given by Customer)</div>

    <div class="form-row">
        <div class="form-group">
            <label>Description</label>
            <input type="text" name="oldDescription"
                   value="${exchange.oldDescription}" readonly>
        </div>

        <div class="form-group">
            <label>Weight (gm)</label>
            <input type="number" step="0.001" name="oldWeight"
                   value="${exchange.oldWeight}" readonly>
        </div>
        <div class="form-group">
    <label>Weight (mg)</label>
    <input type="number" name="oldWeightMg" readonly>
</div>
        

        <div class="form-group">
            <label>Purity</label>
            <input type="text" name="oldPurity"
                   value="${exchange.oldPurity}" readonly>
        </div>

        <div class="form-group">
            <label>Rate</label>
           <input type="number" step="0.01" name="oldRate"
       value="${exchange.oldRate}"
       oninput="calculateOldValue();calculateExchange()">

        </div>

        <div class="form-group">
            <label>Value</label>
            <input type="number" step="0.01" name="oldValue"
                   value="${exchange.oldValue}" readonly>
        </div>
    </div>
</div>

<!-- ================= NEW ITEM ================= -->
<div id="newItemSection" class="card new">
    <div class="card-title">New Item (Given to Customer)</div>



    <div class="form-row">
        <div class="form-group">
            <label>Description</label>
            <input type="text" name="newDescription">
        </div>

        <div class="form-group">
            <label>Weight (gm)</label>
            <input type="number" step="0.001" name="newWeight"
                   oninput="updateWeightInMg();calculateExchange()">
        </div>
        
        <div class="form-group">
    <label>Weight (mg)</label>
    <input type="number" name="newWeightMg" readonly>
</div>
        

	<div class="form-group">
    <label>Purity</label>
  <select name="newPurity" id="newPurity" onchange="calculateExchange()">
    <option value="">Select</option>
    <option value="20K">20K</option>
    <option value="22K">22K</option>
    <option value="24K">24K</option>
    <option value="Silver 925">Silver 925</option>
</select>

</div>
	

        <div class="form-group">
            <label>Rate</label>
            <input type="number" step="0.01" name="newRate"
                   oninput="updateWeightInMg();calculateExchange()">
        </div>

        <div class="form-group">
            <label>Value</label>
            <input type="number" step="0.01" name="newValue" readonly>
        </div>
    </div>
</div>

<!-- ================= FINAL CALC ================= -->
<div class="card">
    <div class="card-title">Final Calculation</div>

    <div class="form-row">
        <div class="form-group">
            <label>Balance Amount</label>
            <input type="number" name="balanceAmount"
                   id="balanceAmount" readonly>
        </div>

        <div class="form-group">
            <label>Rounded Amount</label>
            <input type="number" id="roundedAmount" readonly>
        </div>

        <div class="form-group" style="width:40%">
            <label>Amount in Words</label>
            <input type="text" id="amountWords" readonly>
        </div>
    </div>
</div>

<button type="submit">Save Exchange</button>

</form>
</div>

<!-- ================= JS ================= -->
<script>
function toggleNewItem() {
    var type = document.getElementById("exchangeType").value;
    var newItem = document.getElementById("newItemSection");

    if (type === "BUYBACK") {
        newItem.style.display = "none";
        document.getElementsByName("newDescription")[0].value = "";
        document.getElementsByName("newWeight")[0].value = "";
        document.getElementsByName("newWeightMg")[0].value = "";

        
        document.getElementsByName("newRate")[0].value = "";
        document.getElementsByName("newValue")[0].value = "";
        
        updateWeightInMg();
        calculateExchange();

    } else {
        newItem.style.display = "block";
    }
    
}

function calculateExchange() {

    let oldValue = parseFloat(document.querySelector('[name="oldValue"]').value) || 0;
    let newWeight = parseFloat(document.querySelector('[name="newWeight"]').value) || 0;
    let newRate = parseFloat(document.querySelector('[name="newRate"]').value) || 0;
    let type = document.getElementById("exchangeType").value;

    let newValue = Math.round(newWeight * newRate);
    document.querySelector('[name="newValue"]').value = newValue;

    let balance = (type === "EXCHANGE") ? (newValue - oldValue) : oldValue;
    let rounded = Math.round(balance);

    document.getElementById("balanceAmount").value = rounded;
    document.getElementById("roundedAmount").value = rounded;
    document.getElementById("amountWords").value =
        numberToWords(Math.abs(rounded)) + " Rupees Only";
}

function numberToWords(num) {
    const a = ["","One","Two","Three","Four","Five","Six","Seven","Eight","Nine",
               "Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen",
               "Seventeen","Eighteen","Nineteen"];
    const b = ["","","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"];

    if (num === 0) return "Zero";
    if (num < 20) return a[num];
    if (num < 100) return b[Math.floor(num/10)] + (num%10 ? " " + a[num%10] : "");
    if (num < 1000) return a[Math.floor(num/100)] + " Hundred " + numberToWords(num%100);
    if (num < 100000) return numberToWords(Math.floor(num/1000)) + " Thousand " + numberToWords(num%1000);
    if (num < 10000000) return numberToWords(Math.floor(num/100000)) + " Lakh " + numberToWords(num%100000);
    return numberToWords(Math.floor(num/10000000)) + " Crore " + numberToWords(num%10000000);
}

window.onload = function () {
    toggleNewItem();
    updateWeightInMg();
    calculateExchange();
};



function updateWeightInMg() {
    let oldW = parseFloat(document.querySelector('[name="oldWeight"]').value) || 0;
    let newW = parseFloat(document.querySelector('[name="newWeight"]').value) || 0;

    document.querySelector('[name="oldWeightMg"]').value = Math.round(oldW * 1000);
    document.querySelector('[name="newWeightMg"]').value = Math.round(newW * 1000);
}

</script>

<script>
function calculateOldValue() {
    let weight = parseFloat(document.querySelector('[name="oldWeight"]').value) || 0;
    let rate   = parseFloat(document.querySelector('[name="oldRate"]').value) || 0;

    let value = Math.round(weight * rate);
    document.querySelector('[name="oldValue"]').value = value;
}
</script>


</body>



</html>
