#include <stdio.h>
#include <stdlib.h>
extern int memoryAddressCalculator(int pageSize, int frameNumber);
extern int pageNumberCalculator(int virtualAddress, int pageSize);
extern int segmentationFault(int pageNumber, int proccessSize, int pageSize);
int main() {
    
    while(1){
        system("clear");
        printf("Welcome to this calculator of physic direction in memory\n");
        printf("We need some information of the logic direction\n");
        printf("What kind of memory management scheme do you use?\n");
        printf("1: Memory paging\n");
        printf("2: Block allocation \n");
        printf("Other: Exit\n");

        printf("Please enter the number of the option: ");
        int option;
        scanf("%d", &option);

        switch(option){
            case 1:
                system("clear");
                printf("You have selected memory paging\n");
                int pageSize=-1;
                int virtualAddress=-1;
                int frameNumber=-1;
                int proccessSize=-1;
                //Asking for the page size and the virtual address and validating the input
                do {
                    printf("Please enter the page size in byte (B): ");
                    scanf("%d", &pageSize);
                    if(pageSize<0){
                        printf("\nInvalid page size number, type it again!\n\n");
                        continue;
                    }   
                    printf("Please enter the virtual address: ");
                    scanf("%d", &virtualAddress);
                    if(virtualAddress<0){
                            printf("\nInvalid virtual address number, type it again!\n\n");
                        }
                    printf("Please enter the proccess size in byte (B): ");
                    scanf("%d", &proccessSize);
                    if(proccessSize<0){
                        printf("\nInvalid proccess size number, type it again!\n\n");
                        continue;
                    }
               
                }while (pageSize<0 || virtualAddress<0 || proccessSize<0);
                //Calculating the page number
                int pageNumber = pageNumberCalculator(virtualAddress, pageSize);
                printf("\nThe page number is: %d\n", pageNumber);

                //Calculating the segmentation fault
                int segmentation = segmentationFault(pageNumber, proccessSize, pageSize);
                if(segmentation==0){
                    printf("\n\nThe program isn't able to calculate this direcction\nError: Segmentation fault\n\n");
                    system("read -p 'Press Enter to continue...' var");//Waiting for the user to press enter
                    break;
                }else if(segmentation==-1){
                    printf("\n\nThe program isn't able to calculate this direcction\nError: Result cannot be represented by 32 bits\n\n");
                    system("read -p 'Press Enter to continue...' var");//Waiting for the user to press enter
                    break;
                }

                //Asking for the frame number and validating the input
                do
                {
                    
                    printf("Now, look at your table and find the frame number:");
                    scanf("%d", &frameNumber);
                    if(frameNumber<0)
                        printf("\nInvalid frame number, type it again!\n\n");
                } while (frameNumber<0);
                
                
                //Calculating the physic address
                int physicAddress = memoryAddressCalculator(pageSize,  frameNumber);
                if(physicAddress!=-1)//-1 as result means that  the buffer overflow because the number is too big of 32 bits
                    printf("\nThe physic address is: %d\n", physicAddress);
                else
                    printf("\n\nThe program isn't able to calculate this direcction\nError: Result cannot be represented by 32 bits\n\n");

                system("read -p 'Press Enter to continue...' var");//Waiting for the user to press enter
                break;
            case 2:
                printf("You have selected block allocation\n");
                break;
            default:
                system("clear");
                return 0;
        }
        

    }
}
