package com.project.myticket.dao;

import org.springframework.stereotype.Repository;

import com.project.myticket.dto.BookDTO;
import com.project.myticket.dto.ItemDTO;

@Repository
public interface IBookDAO {

	void bookInsertProc(BookDTO bDto);

	void bookUpdateProc(BookDTO bDto);

	void MSeatUpdate(ItemDTO iDto);

	void TSeatUpdate(ItemDTO iDto);

	void CSeatUpdate(ItemDTO iDto);

	void SSeatUpdate(ItemDTO iDto);

	void LSeatUpdate(ItemDTO iDto);


}
