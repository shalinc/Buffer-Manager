all:
	gcc -w dberror.c storage_mgr.c buffer_mgr.c buffer_mgr_stat.c test_assign2_1.c -o test_assign2_1
	./test_assign2_1

test_case_clock:
	gcc -w dberror.c buffer_mgr_stat.c storage_mgr.c buffer_mgr.c test_assign2_2.c -o test_assign2_2
	./test_assign2_2

clean:
	$(RM) test_assign2_1
	$(RM) test_assign2_2
