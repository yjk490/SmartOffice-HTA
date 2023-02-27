package com.example.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.dto.contact.ContactDetailDto;
import com.example.dto.contact.ContactListDto;
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
	
	int getPublicRows(@Param("keyword") String keyword, @Param("initial") String initial, @Param("tag") String tag);
	int getPrivateRows(@Param("keyword") String keyword, @Param("initial") String initial, @Param("tag") String tag);
	
	Contact getContactByNo(int contactNo);
	Contact getContactByEmail(String email);
	Contact getContactByName(String name);
	
	ContactDetailDto getContactDetailDtoByNo(int contactNo);
	
	List<Contact> getPublicContact(String share);
	List<Contact> getPrivateContact(String share);
	
	List<ContactTag> getTagsByNo(int contactNo);
	List<ContactListDto> getContacts(@Param("begin") int beginPage, @Param("end") int endPage, @Param("sort") String sort, @Param("type") String type, @Param("keyword") String keyword);

}
