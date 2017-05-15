Group 18 - Assignment 2 - Buffer Manager | Version 1.0 | 10/06/2015





Description

---------------------------------------------------------


Implement a buffer manager that manages a buffer of blocks in memory including reading/flushing to disk and block replacement.





How to run

-----------------------------------------------------------


1. Open terminal and Clone from BitBucket to the required location.

2. Navigate to assign2 folder.

3. Use make command to execute FIFO and LRU page replacement strategies,
 
	$ make

4. Use make command to execute CLOCK page replacement strategy,
 
	$ make test_case_clock
5. To clean,
	$ make clean






Solution Description

-----------------------------------------------------------



Buffer Pool Functions

---------------------


initBufferPool-->

	Performs the following operations:

1. openPageFile() - opens the already existing page file. This definition of this method is in storage_mgr.c file.

2. createPageFrame() - this method is called to create empty page frame in the buffer pool.

3. Initialization of buffer pool values like numPages, pageFileName, strategy and mgmtData.

4. mgmtData value is a structure of information like
 	  i. head, tail - frame pointers of buffer pool

	 ii. occupiedCount - capacity of buffer pool

	iii. startData - strategy information to be used

	 iv. numRead, numwrite - number of page reads and page writes performed on pageFile.

5. closePageFile() - closes the pageFile. This definition of this method is in storage_mgr.c file.




shutdownBufferPool-->
1. This method frees all the memory allocated for page frames.
2. Calls forceFlushPool() to write all the dirty pages to the pageFile before freeing up the memory.




forceFlushPool-->

	causes all dirty pages (with fix count 0) from the buffer pool to be written to pageFile.




Page Management Functions

-------------------------


pinPage-->

	switch case to call the following functions:

1. pinPageFIFO - it implements circular queue for page replacement using First In First Out strategy.

2. pinPageLRU - it implements circular queue for page replacement using Least Recently Used strategy.

3. pinPageCLOCK - it implements circular queue for page replacement using Clock strategy.


	Functionality of pinPage is as follows:

1. calls the openPageFile() to open the page file.

2. if occupiedCount is less than buffer pool size then pin the page in the pool, else use one of the page replacement strategy.

3. if need to replace page, check if the page is dirty and call writeBlock() to write the page to pageFile.

4. calls readBlock() pins a page identified by pageNum in the buffer pool.

5. fixCount is incremented denoting that the client is using the page.

6. change the capacity of buffer pool.

7. calls closePageFile() to close the page file.




unpinPage()-->

	unpins the page page.

1. The pageNum field of page should be used to figure out which page to unpin.

2. fixCount is decremented denoting that the client is not using the page.




markDirty()-->

	sets a page as dirty identified by pageNum of the frame in the buffer pool.




forcePage()-->

1. calls writeBlock() to write the current content of the page back to the page file on disk.

2. resets a page as dirty(not dirty) identified by pageNum of the frame in the buffer pool.




Statistics Functions

--------------------


getFrameContents()-->
 
	returns an array of PageNumbers (of size numPages) where the ith element is the number of the page stored in  the ith page frame. An empty page frame is represented using the constant NO_PAGE.



getDirtyFlags()-->

	returns an array of bools (of size numPages) where the ith element is TRUE if the page stored in the ith page frame is dirty. Empty page frames are considered as clean.



getFixCounts()-->

	returns an array of ints (of size numPages) where the ith element is the fix count of the page stored in the ith page frame. Return 0 for empty page frames.



getNumReadIO()-->

	returns the number of pages that have been read from disk since a buffer pool has been initialized. You code is responsible to initializing this statistic at pool creating time and update whenever a page is read from the page file into a page frame.



getNumWriteIO()-->

	returns the number of pages written to the page file since the buffer pool has been initialized.





Test Cases

-----------------------------------------------------------

Files: test_assign2_1.c(FIFO & LRU) and test_assign2_1.c(CLOCK)



1. The program verifies all the test cases that are mentioned in the test file i.e test_assign2_1 and ensures that there are no errors.

2. Along with the default test case given, there is an additional test case prepared i.e test_assign2_2 which tests all the methods that have been implemented, and runs successfully. Furthermore, in the implementation design we have taken steps to avoid memory leaks.




To Run the additional Test Case

-----------------------------------------------------------

In terminal,

1. Type
	
	$ make test_case_clock

2. To clean, type

	$ make clean





Team Members: - Group 18

-----------------------------------------------------------

Loy Mascarenhas

Pranitha Nagavelli

Shalin Chopra