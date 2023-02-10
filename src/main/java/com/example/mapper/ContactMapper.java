package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.dto.contact.ContactDetailDto;
import com.example.vo.contact.Contact;
import com.example.vo.contact.ContactTag;
import com.example.vo.contact.ContactTel;

@Mapper
public interface ContactMapper {
	
	void insertContact(Contact contact);	
	void updateContact(Contact contact);
	void deleteContact(Contact contact);
	
	void insertContactTel(ContactTel contactTel);
	List<ContactTel> getContactTelsByNo(int contactNo);
	void deleteContactTel(ContactTel contactTel);
	
	void insertContactTag(ContactTag contactTag);
	List<ContactTag> getContactTagsByNo(int contactNo);
	void deleteContactTag(ContactTag contactTag);
	
	int getPublicRows();
	int getPrivateRows();
	
	Contact getContactByNo(int contactNo);
	Contact getContactByEmail(String email);
	Contact getContactByName(String name);
	
	ContactDetailDto getContactDetailDtoByNo(int contactNo);
	
	List<Contact> getPublicContact(String share);
	List<Contact> getPrivateContact(String share);
	
	List<ContactTag> getTagsByNo(int contactNo);

}
