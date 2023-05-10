package tests;

import com.intuit.karate.junit5.Karate;
import java.io.*;
import java.lang.Thread;

public class TestRunner {
//	@BeforeClass
//	public static void before() {
//		System.setProperty("karate.env", "qa");
//	}	
//	@Karate.Test
//	Karate createBoard() {
//		return Karate.run("CreateBoard").relativeTo(getClass());
//		
//	}
	
	
//	@Karate.Test 
//	Karate archiveLists() throws InterruptedException {
////		Thread.sleep(3000);
//		return Karate.run("ArchiveLists").relativeTo(getClass());
//	}
//	
//	@Karate.Test
//	Karate createList() {
//		return Karate.run("CreateList").relativeTo(getClass());
//	}
//	
//	@Karate.Test
//	Karate createCard() {
//		return Karate.run("CreateCard").relativeTo(getClass());
//	}
//	
//	@Karate.Test
//	Karate moveCard() {
//		return Karate.run("MoveCard").relativeTo(getClass());
//	}
	
	@Karate.Test
	Karate allinOne() {
		return Karate.run("AllinOne").relativeTo(getClass());
	}
	
}
	
