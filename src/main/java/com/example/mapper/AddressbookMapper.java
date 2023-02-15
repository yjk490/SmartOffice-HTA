package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.contact.Addressbook;

@Mapper
public interface AddressbookMapper {
	
	void insertAddressbook(Addressbook addressbook);
	void updateAddressbook(Addressbook addressbook);
	
	int getPublicRows();
	int getPrivateRows();
	
	Addressbook getAddressbookByNo(int addressNo);
	Addressbook getAddressbookByName(String type, String addressbookName);
	
	List<Addressbook> getAddressbooks(String type);

}
