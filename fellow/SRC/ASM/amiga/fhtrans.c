#include <stdio.h>

FILE *I,*O;

void main(void) {
      int j;
        I=fopen("d:\\temp\\fhfile.raw","rb");
        O=fopen("d:\\temp\\out.c","wb");

        for (j=0; j < 198; j += 2) {
          fprintf(O,"memoryDmemSetByte(0x%.2X); ",fgetc(I));
          fprintf(O,"memoryDmemSetByte(0x%.2X);\n",fgetc(I));
	}
       fclose(O);
       fclose(I);
}
