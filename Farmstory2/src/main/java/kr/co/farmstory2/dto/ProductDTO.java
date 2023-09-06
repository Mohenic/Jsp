package kr.co.farmstory2.dto;

import java.io.File;
import java.util.UUID;

public class ProductDTO {
	private int pNo;
	private int cate;
	private String pName;
	private int price;
	private int delivery;
	private int stock;
	private int sold;
	private String thumb1;
	private String thumb2;
	private String thumb3;
	private String seller;
	private String etc;
	private String rdate;
	private String path;
	
	public ProductDTO() {
		
	}
	
	public ProductDTO(String path) {
		this.path = path;
	}
	
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	
	public int getCate() {
		return cate;
	}
	public void setCate(int cate) {
		this.cate = cate;
	}
	public void setCate(String cate) {
		this.cate = Integer.parseInt(cate);
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public void setPrice(String price) {
		this.price = Integer.parseInt(price);
	}
	public int getDelivery() {
		return delivery;
	}
	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = Integer.parseInt(delivery);
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public void setStock(String stock) {
		this.stock = Integer.parseInt(stock);
	}
	public int getSold() {
		return sold;
	}
	public void setSold(int sold) {
		this.sold = sold;
	}
	public String getThumb1() {
		return thumb1;
	}
	public void setThumb1(String thumb1) {
		this.thumb1 = thumb1;
	}
	public void setThumb1ForRename(String thumb1) {
		this.thumb1 = fileRename(thumb1);
	}
	public String getThumb2() {
		return thumb2;
	}
	public void setThumb2(String thumb2) {
		this.thumb2 = thumb2;
	}
	public void setThumb2ForRename(String thumb2) {
		this.thumb2 = fileRename(thumb2);
	}
	public String getThumb3() {
		return thumb3;
	}
	public void setThumb3(String thumb3) {
		this.thumb3 = thumb3;
	}
	public void setThumb3ForRename(String thumb3) {
		this.thumb3 = fileRename(thumb3);
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	
	public String fileRename(String thumb) {
		int i = thumb.lastIndexOf(".");
		String ext = thumb.substring(i);
		
		String uuid = UUID.randomUUID().toString();
		String sName = uuid + ext;
		
		File f1 = new File(path + "/" + thumb);
		File f2 = new File(path + "/" + sName);
		f1.renameTo(f2);
		
		return sName;
	}

	@Override
	public String toString() {
		return "ProductDTO [pNo=" + pNo + ", cate=" + cate + ", cate=" + cate + ", pName=" + pName + ", price=" + price
				+ ", delivery=" + delivery + ", stock=" + stock + ", sold=" + sold + ", thumb1=" + thumb1 + ", thumb2="
				+ thumb2 + ", thumb3=" + thumb3 + ", seller=" + seller + ", etc=" + etc + ", rdate=" + rdate + ", path="
				+ path + "]";
	}
	
	
}
