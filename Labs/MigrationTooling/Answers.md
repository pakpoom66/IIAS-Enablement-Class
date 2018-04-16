

If you found the CHAR_TEST table having the following:

~~~
bad #: input row #(byte offset to last char examined) [field #, declaration] diagnostic, "text consumed"[last char examined]
-----------------------------------------------------------------------------
1: 129(0)[1, CHAR(1)] text field too long for column, ""[�]
~~~

Then run the migrate-table.sh which has -multiByteChars yes set.  This will enable to the table to handle multibyte characters.   Go in and adjust the migrate-table.sh script
