package com.example.demo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.itextpdf.text.pdf.PdfPCell;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Bean_Bill {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	private List<Double> value;

    // Getter
    public List<Double> getValue() {
        return value;
    }

    // Setter
    public void setValue(List<Double> value) {
        this.value = value;
    }
	
	
	// private double makingpercent;
	private String customerName;
    private String item;
    private List<Double> weight;

    // Getter
    public List<Double> getWeight() {
        return weight;
    }

    // Setter
    public void setWeight(List<Double> weight) {
        this.weight = weight;
    }
    private List<Double> rate;

    public List<Double> getRate() {
        return rate;
    }

    public void setRate(List<Double> rate) {
        this.rate = rate;
    }

    @Column(nullable = false, unique = true)
    private String billNo;
    private double discount;     
    private double cgst;         
    private double sgst;         
    private double totalAmount;  
    private double roundOff;
    private String unit;
    
    public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}


	private String paymentMode;
    private String  finalAmountword;
    private double finalAmount;
    public double getFinalAmount() {
		return finalAmount;
	}
	public void setFinalAmount(double finalAmount) {
		this.finalAmount = finalAmount;
	}
	public String getFinalAmountword() {
		return finalAmountword;
	}
	public void setFinalAmountword(String finalAmountword) {
		this.finalAmountword = finalAmountword;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date date;
    public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

	private String description;
   
    private String type;
   // private double makingpercent;
   
    
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}


	private String hsncode;
    public String getHsncode() {
		return hsncode;
	}
	public void setHsncode(String hsncode) {
		this.hsncode = hsncode;
	}
	public String getHuid() {
		return huid;
	}
	public void setHuid(String huid) {
		this.huid = huid;
	}

	private String huid;
    
	private String making;

	
	
	
	public String getMaking() {
		return making;
	}
	public void setMaking(String making) {
		this.making = making;
	}
	public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getItem() {
        return item;
    }
    public void setItem(String item) {
        this.item = item;
    }

	/*
	 * public double getWeight() { return weight; } public void setWeight(double
	 * weight) { this.weight = weight; }
	 */


    private List<Double> amount;

    // Getter
    public List<Double> getAmount() {
        return amount;
    }

    // Setter
    public void setAmount(List<Double> amount) {
        this.amount = amount;
    }


    public double getDiscount() {
        return discount;
    }
    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getCgst() {
        return cgst;
    }
    public void setCgst(double cgst) {
        this.cgst = cgst;
    }

    public double getSgst() {
        return sgst;
    }
    public void setSgst(double sgst) {
        this.sgst = sgst;
    }

    public double getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getRoundOff() {
        return roundOff;
    }
    public void setRoundOff(double roundOff) {
        this.roundOff = roundOff;
    }

    public String getPaymentMode() {
        return paymentMode;
    }
    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }
    
    public String getBillNo() {
        return billNo;
    }
    public void setBillNo(String billNo) {
        this.billNo = billNo;
    }

    // -------------------- toString() --------------------

    @Override
	public String toString() {
		return "Bean_Bill [id=" + id + ", value=" + value + ", customerName=" + customerName + ", item=" + item
				+ ", weight=" + weight + ", rate=" + rate + ", billNo=" + billNo + ", discount=" + discount + ", cgst="
				+ cgst + ", sgst=" + sgst + ", totalAmount=" + totalAmount + ", roundOff=" + roundOff + ", unit=" + unit
				+ ", paymentMode=" + paymentMode + ", finalAmountword=" + finalAmountword + ", finalAmount="
				+ finalAmount + ", date=" + date + ", description=" + description + ", type=" + type + ", hsncode="
				+ hsncode + ", huid=" + huid + ", making=" + making + ", amount=" + amount + "]";
	}
}
 