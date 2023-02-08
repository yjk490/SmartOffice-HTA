package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.vo.Addressbook;

@Mapper
public interface AddressbookMapper {
	
	void insertAddressbook(Addressbook addressbook);
	void updateAddressbook(Addressbook addressbook);
	
	int getPublicRows();
	int getPrivateRows();
	
	Addressbook getAddressbookByNo(int addressNo);
	Addressbook getAddressbookByName(String addressname);
	
	List<Addressbook> getPublicAddressbook(String type);
	List<Addressbook> getPrivateAddressbook(String type);

}
