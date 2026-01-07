package com.example.demo;

import java.io.IOException;

import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itextpdf.awt.geom.Rectangle;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequestMapping("/")
public class MainController {

	@Autowired
	private ExchangeRepository exchangeRepo;

	private final BillService service;
	@Autowired
	private BillServiceImpl bsi;

	public MainController(BillService service) {
		this.service = service;
	}

	@GetMapping("/")
	public String billForm() {
		return "Index"; // JSP name
	}

	@PostMapping("/saveBill")
	public String saveBill(@ModelAttribute Bean_Bill bill, RedirectAttributes redirectAttributes) {

		// 🔥 EDIT CASE
		if (bill.getId() != null) {

			Bean_Bill old = service.getBillById(bill.getId());

			// ---- BASIC FIELDS UPDATE ----
			old.setCustomerName(bill.getCustomerName());
			old.setBillNo(bill.getBillNo());
			old.setDate(bill.getDate());
			old.setHsncode(bill.getHsncode());
			old.setHuid(bill.getHuid());
			old.setPaymentMode(bill.getPaymentMode());
			old.setRoundOff(bill.getRoundOff());
			old.setFinalAmount(bill.getFinalAmount());
			old.setFinalAmountword(bill.getFinalAmountword());
			old.setCgst(bill.getCgst());
			old.setSgst(bill.getSgst());
			old.setTotalAmount(bill.getTotalAmount());

			// ITEM DATA KO TOUCH HI NAHI KAR RAHE
			// description, type, weight, rate, value, amount safe rahenge

			service.saveBill(old);

			redirectAttributes.addFlashAttribute("msg", "Bill Updated Successfully");

		}
		// NEW SAVE CASE
		else {
			service.saveBill(bill);
			redirectAttributes.addFlashAttribute("msg", "Bill Saved Successfully");
		}

		return "redirect:/bill-list";
	}

	// List all bills
	/*
	 * @GetMapping("/bills") public String billList(Model model) {
	 * model.addAttribute("bills", service.getAllBills()); return "bill-list"; //
	 * JSP name }
	 */

	
	
	@GetMapping("/bills")
	public String billList(@RequestParam String billNo, HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) throws MalformedURLException, IOException, DocumentException {

		List<Bean_Bill> bills = bsi.findByBillNo(billNo);

		if (bills.isEmpty()) {
			redirectAttributes.addAttribute("msg", "notfound");
			return "redirect:/";
		} else {
			// PDF headers
			response.setContentType("application/pdf");
			response.setHeader("Content-Disposition", "inline; filename=bill_report.pdf");

			Document pdf = new Document();
			PdfWriter.getInstance(pdf, response.getOutputStream());
			pdf.open();

			URL logoUrl = getClass().getResource("/logo7.jpg");
			System.out.println("Logo URL = " + logoUrl);

			Image headerImage = Image.getInstance(logoUrl);

			headerImage.scaleToFit(500, 150);
			headerImage.setAlignment(Element.ALIGN_CENTER);

			pdf.add(headerImage);

			// ----- RIGHT SIDE NAME + ADDRESS IMAGE -----

			// ---------------------- LOOP ALL BILLS ----------------------
			for (Bean_Bill b : bills) {

				// -------- CUSTOMER INFO ----------
				PdfPTable info = new PdfPTable(2);
				info.setWidthPercentage(100);

				info.addCell(getCell("Customer Name: " + b.getCustomerName(), PdfPCell.ALIGN_LEFT));
				info.addCell(getCell("Date: " + b.getDate(), PdfPCell.ALIGN_RIGHT));

				info.addCell(getCell("Bill No: " + b.getBillNo(), PdfPCell.ALIGN_LEFT));
				info.addCell(getCell("", PdfPCell.ALIGN_RIGHT));

				pdf.add(info);
				pdf.add(new Paragraph("\n"));

				// -------- ITEMS TABLE ----------
				PdfPTable table = new PdfPTable(9);
				table.setWidthPercentage(100);

				table.setWidths(new float[] { 15f, // Description
						15f, // Type
						11f, // Hsn
						12f, // huid
						16f, // Weight
						19f, // Rate
						16f, // Value
						16f, // makin %
						20f // amount
				});

				table.addCell("Type");
				table.addCell("Particular");

				table.addCell("HSCN");
				table.addCell("HUID");
				table.addCell("Weight");
				table.addCell("Rate");
				table.addCell("Value");
				table.addCell("Making %");
				table.addCell("Amount");

				// table.addCell(b.getDescription());
				String[] items = b.getDescription().split(",");

				StringBuilder sb = new StringBuilder();

				for (int i = 0; i < items.length; i++) {
					sb.append(i + 1).append(". ").append(items[i].trim()); // Gold

					if (i < items.length - 1) {
						sb.append("\n"); // new line in same cell
					}
				}

				PdfPCell cell = new PdfPCell(new Phrase(sb.toString()));
				cell.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell.setPadding(5f);

				table.addCell(cell);

				// table.addCell(b.getType());

				String[] types = b.getType().split(",");

				StringBuilder sb1 = new StringBuilder();
				for (int i = 0; i < types.length; i++) {
					sb1.append(types[i].trim());

					if (i < types.length - 1) {
						sb1.append("\n"); // next line in same cell
					}
				}

				PdfPCell cell3 = new PdfPCell(new Phrase(sb1.toString()));
				cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell3.setPadding(5f);

				table.addCell(cell3);

				table.addCell(b.getHsncode());
				table.addCell(b.getHuid());
				// table.addCell(String.valueOf(b.getWeight())+" "+b.getUnit());

				List<Double> weights = b.getWeight(); // [1.9, 2.5, 3.0]

				String unitStr = b.getUnit();

				// take only first unit
				String unit = unitStr.split(",")[0].trim();

				Phrase phrase5 = new Phrase();
				phrase5.setLeading(14f);

				for (Double w : weights) {
					phrase5.add(String.format("%.3f %s", w, unit));
					phrase5.add(Chunk.NEWLINE);
				}

				PdfPCell cell5 = new PdfPCell(phrase5);
				cell5.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell5.setPadding(5f);
				cell5.setNoWrap(true);

				table.addCell(cell5);

				// table.addCell(String.valueOf(b.getRate()));

				List<Double> rates = b.getRate();

				Phrase phrase1 = new Phrase();
				phrase1.setLeading(14f); // proper line spacing

				for (Double r : rates) {
					phrase1.add(String.format("%.2f", r)); // always 2 decimals
					phrase1.add(Chunk.NEWLINE); // next rate new line
				}

				PdfPCell cell0 = new PdfPCell(phrase1);
				cell0.setHorizontalAlignment(Element.ALIGN_RIGHT);
				cell0.setPadding(6f);
				cell0.setNoWrap(true); // 🔴 IMPORTANT: number split nahi hoga

				table.addCell(cell0);

				List<Double> values = b.getValue();

				Phrase phrase = new Phrase();
				phrase.setLeading(14f); // proper line height

				for (Double v : values) {
					phrase.add(String.format("%.2f", v)); // ✅ always 2 decimals
					phrase.add(Chunk.NEWLINE); // next value new line
				}

				PdfPCell cell1 = new PdfPCell(phrase);
				cell1.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell1.setPadding(6f);

				// 🔴 VERY IMPORTANT: wrapping fix
				cell1.setNoWrap(true);

				table.addCell(cell1);

				// table.addCell(b.getValue());

				// table.addCell(String.format("%.2f", b.getMaking()));
				// table.addCell(String.valueOf(b.getMaking()));

				String makingStr = String.valueOf(b.getMaking()); // "Gold,Gold,Gold"

				// comma ke baad new line
				String formatted = makingStr.replace(",", "\n");

				PdfPCell cell8 = new PdfPCell(new Phrase(formatted));
				cell8.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell8.setPadding(5f);

				table.addCell(cell8);

				// table.addCell(String.valueOf(b.getAmount()));

				List<Double> amounts = b.getAmount(); // List<Double>

				Phrase phrase9 = new Phrase();
				phrase9.setLeading(14f); // line spacing

				for (Double a : amounts) {
					phrase9.add(String.format("%.2f", a)); // always 2 decimals
					phrase9.add(Chunk.NEWLINE); // next value in new line
				}

				PdfPCell cell9 = new PdfPCell(phrase9);
				cell9.setHorizontalAlignment(Element.ALIGN_LEFT);
				cell9.setPadding(5f);

				// ❌ REMOVE setNoWrap(true) if using multi-line
				// cell9.setNoWrap(true);

				table.addCell(cell9);

				pdf.add(table);

				// -------- TOTALS TABLE ----------
				PdfPTable totals = new PdfPTable(2);
				totals.setWidthPercentage(100);

				// totals.addCell("Discount");
				// totals.addCell(String.valueOf(b.getDiscount()));

				totals.addCell("CGST 1.5%");
				totals.addCell(String.valueOf(b.getCgst()));

				totals.addCell("SGST 1.5%");
				totals.addCell(String.valueOf(b.getSgst()));

				totals.addCell("Total Amount");
				totals.addCell(String.valueOf(b.getTotalAmount()));

				totals.addCell("Round Off");
				totals.addCell(String.valueOf(b.getRoundOff()));

				totals.addCell("Payment Mode");
				totals.addCell(b.getPaymentMode());

				totals.addCell("Final Amount");
				totals.addCell(String.valueOf(b.getFinalAmount()));

				totals.addCell("Final Amount in Words");
				totals.addCell(String.valueOf(b.getFinalAmountword()));

				pdf.add(totals);
				pdf.add(new Paragraph("\n Term & Conditions"));

				Paragraph terms = new Paragraph();
				terms.setAlignment(Element.ALIGN_LEFT);
				terms.setSpacingBefore(10); // add some space above

				terms.add(" * REFUND: 91.6%, 83.3% & 75% HALLMARK (DEDUCT STONE & MEENA).\n");
				terms.add(" * H.M / HUID CHARGES ARE INCLUDED IN MAKING CHARGES.\n");
				terms.add(" * ALL SUBJECT TO ASHOK NAGAR JURISDICTION.\n");

				pdf.add(terms);
			}

			pdf.close();

			// model.addAttribute("bills", bills);
			redirectAttributes.addAttribute("msg", "success");
			return "redirect:/";
		}
	}

	// ================= HELPER CELL METHOD ==================
	private PdfPCell getCell(String text, int alignment) {
		PdfPCell cell = new PdfPCell(new Phrase(text));
		cell.setPadding(5);
		cell.setHorizontalAlignment(alignment);
		cell.setBorder(PdfPCell.NO_BORDER);
		return cell;
	}

	@GetMapping("/bill-list")
	public String showBills(Model model) {
		List<Bean_Bill> bills = service.getAllBills();
		model.addAttribute("bills", bills);

		// 🔥 EXCHANGE MAP
		Map<Long, List<ExchangeTransaction>> exchangeMap = new HashMap<>();

		for (Bean_Bill b : bills) {
			exchangeMap.put(b.getId(), exchangeRepo.findByBillId(b.getId()));
		}

		model.addAttribute("exchangeMap", exchangeMap);

		return "bill-list"; // JSP page
	}

	@GetMapping("/deleteBill/{id}")
	public String deleteBill(@PathVariable Long id, RedirectAttributes redirectAttributes) {
		service.deleteById(id);
		redirectAttributes.addFlashAttribute("msg", "Bill deleted successfully");
		return "redirect:/bill-list";
	}

	@GetMapping("/editBill/{id}")
	public String editBill(@PathVariable Long id, Model model) {

		Bean_Bill bill = service.getBillById(id); // DB se data

		model.addAttribute("bill", bill); // JSP ko bhejna
		return "edit-bill"; // JSP page name
	}

	// ======================================Exchange method============================================

	@GetMapping("/exchange/{billId}")
	public String exchangePage(@PathVariable Long billId, Model model) {

	    Bean_Bill bill = service.getBillById(billId);

	    ExchangeTransaction ex = new ExchangeTransaction();
	    ex.setBillId(billId);
	    ex.setExchangeType("EXCHANGE");
	    ex.setExchangeDate(LocalDate.now());

	    // 🔥 OLD ITEM FROM BILL (FIRST ITEM)
	    ex.setOldDescription(bill.getDescription().split(",")[0]);
	    ex.setOldWeight(bill.getWeight().get(0));
	    ex.setOldRate(bill.getRate().get(0));
	    ex.setOldValue(bill.getValue().get(0));
	    ex.setOldPurity(bill.getType().split(",")[0]);

	    model.addAttribute("exchange", ex);
	    model.addAttribute("bill", bill);

	    return "exchange";
	}




	/*
	 * @PostMapping("/saveExchange") public String saveExchange(@ModelAttribute
	 * ExchangeTransaction ex, RedirectAttributes ra) {
	 * 
	 * // ===== SAFETY (NULL PROTECTION) ===== if (ex.getOldValue() == null)
	 * ex.setOldValue(0.0); if (ex.getNewValue() == null) ex.setNewValue(0.0);
	 * 
	 * // ===== LOGIC ===== if ("EXCHANGE".equals(ex.getExchangeType())) { // old
	 * diya + new liya ex.setBalanceAmount(ex.getNewValue() - ex.getOldValue()); }
	 * else { // BUYBACK → sirf old item becha ex.setNewDescription(null);
	 * ex.setNewWeight(null); ex.setNewRate(null); ex.setNewValue(null);
	 * ex.setBalanceAmount(ex.getOldValue()); }
	 * 
	 * exchangeRepo.save(ex); ra.addFlashAttribute("msg",
	 * "Exchange / Buyback saved successfully");
	 * 
	 * return "redirect:/bill-list"; }
	 */
	
	
	@PostMapping("/saveExchange")
	public String saveExchange(@ModelAttribute ExchangeTransaction ex,
	                           RedirectAttributes ra) {

	    if (ex.getOldValue() == null) ex.setOldValue(0.0);
	    if (ex.getNewValue() == null) ex.setNewValue(0.0);

	    // 🔥 FINAL LOGIC
	    ex.setBalanceAmount(ex.getNewValue() - ex.getOldValue());

	    exchangeRepo.save(ex);

	    ra.addFlashAttribute("msg", "Exchange saved successfully");
	    return "redirect:/bill-list";
	}



	 @GetMapping("/depositAmount/{id}")
	    public String depositPage(@PathVariable Long id, Model model) {

	        // 1️⃣ Get bill
	        Bean_Bill bill = service.getBillById(id);

	        // 2️⃣ Previous deposits (assuming you store in List<Double>)
	        List<Deposit> previousDeposits = bill.getDepositAmounts(); // List<Double> in Bean_Bill
	        if (previousDeposits == null) {
	            previousDeposits = new ArrayList<>();
	        }

	        model.addAttribute("bill", bill);
	        model.addAttribute("previousDeposits", previousDeposits);

	        return "depositAmount"; // JSP page
	    }
	    
	 @GetMapping("/RemaingAmtAllCustomer")
	    public String billList(Model model) {

	        List<Bean_Bill> bills = service.getAllBills();

	        for (Bean_Bill bill : bills) {

	            double sum = 0;

	            if (bill.getDepositAmounts() != null) {
	                for (Deposit dep : bill.getDepositAmounts()) {
	                    if (dep.getAmount() != null) {
	                        sum += dep.getAmount();
	                    }
	                }
	            }

	            // store total deposit in bill (transient field)
	            bill.setTotalDeposit(sum);

	            // update remaining amount if needed
	            bill.setRemainAmt(bill.getFinalAmount() - sum);
	        }

	        model.addAttribute("bills", bills);
	        return "RemaingAmtAllCustomer";
	    }

	 
	    @PostMapping("/saveDeposit/{id}")
	    public String saveDeposit(@PathVariable Long id,
	                              @RequestParam("depositAmount") double depositAmount) {

	        Bean_Bill bill = service.getBillById(id);

	        if (bill.getDepositAmounts() == null) {
	            bill.setDepositAmounts(new ArrayList<>());
	        }

	        // ✅ Create Deposit object
	        Deposit deposit = new Deposit();
	        deposit.setAmount(depositAmount);
	        deposit.setDepositDate(LocalDate.now());

	        // ✅ Add Deposit object (NOT double)
	        bill.getDepositAmounts().add(deposit);

	        // ✅ Calculate total deposit
	        double totalDeposits = bill.getDepositAmounts()
	                .stream()
	                .mapToDouble(Deposit::getAmount)
	                .sum();

	        bill.setRemainAmt(bill.getFinalAmount() - totalDeposits);

	        service.saveBill(bill);

	        return "redirect:/depositAmount/" + id;
	    }





	 

}

