/*
Write a character to console
param {unsigned char} c: character to be written
return {void} : Nothing
*/
void putc(unsigned char c);

/*
Read a character from a console.
return {unsigned char} : Character from console.
*/
unsigned char getc();

/*
Write a string to console.
param {unsigned char*} str: string to write to console
return {void}: Nothing
*/
void puts(unsigned char* str);

/*
Read a string from console into a variable.
param {unsigned char*} str: memory into which data is to be written
param {int} length: length Maximum length of data that can be read. Inclusive of final '\0' bit.
return {void}: nothing
*/
void gets(unsigned char* str, int length);

