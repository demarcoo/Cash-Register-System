.model small
.stack 100h
.data
        uname    db 10, 'Username: $'
        pwd      db 10, 'Password: $'
        fsec    db 10, '01010101010' 
                db 10, '01010101010'
                db 10, '010'             
                db 10, '010             01010101    101010    101010              01010101     01010101'
                db 10, '01010101010    101         10    01  10                  101          101'
                db 10, '01010101010     1010101    10101010  10      10101010     1010101      1010101'
                db 10, '010                  101   10        10                        101          101'
                db 10, '010            10101010     1010101   101010             10101010     10101010'
                db 10, '010'
                db 10, '010'
                db 10, '$'
        welcome db 10, 'Welcome to HACKTIVITIES Registration System'
                db 10, '| 1 | Register'
                db 10, '| 2 | Exit$'
        choice1 db 10, 'Enter choice: $'
        tpnum db 10, 'Enter TP Number: $'
        msg1 db 10, ''
            db 32,32, 'APU FORENSIC SECURITY RESEARCH CENTRE - STUDENT SECTION'
            db 10, '-----------------------------------------------------------'
            db 10,9,9,32,32,32,32, '  W O R K S H O P'                                    
            db 10, '-----------------------------------------------------------'
            db 10, '| 1 | Introduction to Binary Exploitation          [ RM10 ]'
            db 10, '| 2 | Reverse Engineering                          [ RM10 ]'
            db 10, '| 3 | Cross-Site Scripting                         [ RM15 ]'
            db 10, '| 4 | SQL Injection                                [ RM15 ]'
            db 10, '-----------------------------------------------------------'
            db 10,9,9,32,32,32,32, 'C H A L L E N G E S'
            db 10, '-----------------------------------------------------------'
            db 10, '| 5 | Cryptography                                 [ RM20 ]'
            db 10, '| 6 | Scripting Battle                             [ RM20 ]'
            db 10, '| 7 | Mock Battle of Hackers                       [ FREE ]'
            db 10, '-----------------------------------------------------------'
            db 10,9,9,32,32,32,32, '  S E M I N A R S'
            db 10, '-----------------------------------------------------------'
            db 10, '| 8 | Is Anti-Virus Enough?                        [ RM25 ]'
            db 10, '| 9 | P@SSW0RD as Password?!                       [ RM30 ]'
            db 10, '-----------------------------------------------------------$'
        choice2 db 10, 'Enter your choice (1-9): $'
        msg2 db 10, 'Do you want to continue (Y/N)? $',10
        book db 10, 'Your choice is successfully booked!$'
        msg3 db 10, 'Total: RM$'
        hello db 10,13, 'Hi $'
        errormsg db 10, 'Invalid Input!$'
        price dw 100 dup(0)
        exitmsg db 10,10, '<!>COMING SOON:BATTLE OF HACKERS 2021<!>COMING SOON:BATTLE OF HACKERS 2021<!>'
                db 10,10, 'Thank you for your participation! See you in the event!'
                db 10, 'Do not forget to join the upcoming APU Battle of Hackers 2021 in December :)!',10,10
                db 10, 'Regards,'
                db 10, ''
                db 10, 'APU FSec-SS Committee',10
                db '$'
        pause db 10,10, 'Press any key to continue...$'
        member1 db 'TP056778'
        member2 db 'TP112233'
        member3 db 'TP123456'
        username db 100 dup(0)
        password db 100 dup(0)
        credentials db 'admin'
        badCred db 10,10, 'Invalid Username/Password!$'
        buffer db 100 dup(0)
        bye db 10, 'kthxbye.',10
            db '$'

.code
        ;list of Macros
echo Macro string       ;Macro to print string
        mov ah, 9h
        lea dx, string
        int 21h
endm

getchar Macro           ;Macro to read char input
        mov ah, 1
        int 21h
endm

getstring Macro array   ;Macro to read string input
        mov ah, 0Ah
        lea dx, array
        int 21h
endm

clearscreen Macro       ;Macro to clear screen
        mov ah, 0h
        mov al, 03h
        int 10h
endm
        
MAIN PROC
        ;import data from data segment
        mov ax, @data  
        mov ds, ax
        mov es, ax

start:  clearscreen

        ;to set background layer
        mov ah, 6
        mov al, 0
        mov bh, 02h ;set background to black and foreground color to green
        mov cx, 0
        mov dl, 150  ;set the length of background layer
        mov dh, 200  ;set the height of background layer
        int 10h

        ;set the position of displayed string
        mov ah, 2
        mov bh, 0
        mov dl, 0
        mov dh, 0
        int 10h

        echo fsec

getUname:
        echo uname

        ;get username input
        mov username[0], 21
        getstring username   

        xor bx, bx      ;initialize bx or empty bx
        mov bl, username[1]
        mov username[bx+2], '$'

getpwd:
        echo pwd

        ;get password input
        mov password[0], 21
        getstring password

        xor bx, bx
        mov bl, password[1]
        mov password[bx+2], '$'

checkUname: mov cx, 5    ;check whether the username matches
            cld          ;clear direction flag, string pointers auto increment
            lea si, credentials
            lea di, username[2]          
        repe cmpsb       ; compare every bytes  
            jcxz checkpwd  ;if yes, check whether the password matches

checkpwd:   mov cx, 5    ; check if password matches
            cld
            lea si, credentials
            lea di, password[2]
        repe cmpsb
            jcxz home    ; if credentials matched, display welcome page
            echo badCred ; else, display invalid login message
            echo pause   
            getchar
            jmp start

home:   clearscreen

        ;set background and foreground
        mov ah, 6
        mov al, 0
        mov bh, 02h
        mov cx, 0
        mov dl, 150
        mov dh, 200
        int 10h

        ;set text position
        mov ah, 2
        mov bh, 0
        mov dl, 0
        mov dh, 0
        int 10h

        xor bx, bx
        mov price, 0
        
        echo fsec       ;display fsec logo
        echo welcome    ;display welcome page
        echo choice1    ;prompts user to select choice
        getchar

        ;check the input value
        cmp al, '1'     
        je regist
        cmp al, '2'
        je callexit
        echo errormsg   ;input validation
        jmp start

regist:
        ;prompts user to enter the TP number
        echo tpnum

        mov buffer[0], 21
        getstring buffer

        xor bx, bx
        mov bl, buffer[1]
        mov buffer[bx+2], '$'

        jmp menu

checkopt:
          ;check input value for price
          cmp cl, '1'
          je RM_TEN
          cmp cl, '2'
          je RM_TEN
          cmp cl, '3'
          je RM_FIFTEEN
          cmp cl, '4'
          je RM_FIFTEEN
          cmp cl, '5'
          je RM_TWENTY
          cmp cl, '6'
          je RM_TWENTY
          cmp cl, '7'
          je FREE
          cmp cl, '8'
          je RM_TWENTYFIVE
          cmp cl, '9'
          je RM_THIRTY
          jmp displayerror      ;input validation

callexit: jmp exit      ;checkpoint for jumping to exit function

menu:   clearscreen 

        ;set background and foreground
        mov ah, 6
        mov al, 0
        mov bh, 02h
        mov cx, 0
        mov dl, 150
        mov dh, 200
        int 10h

        ;set text position
        mov ah, 2
        mov bh, 0
        mov dl, 0
        mov dh, 0
        int 10h

        echo msg1       ;display menu

input:
        ;prompts user to select the activities
        echo choice2
        getchar                                                                                                                                                                                         
        mov cl, al      ;store input value
        jmp checkopt

FREE:   xor bx, bx
        mov bx, 0

RM_TEN:         
                mov bx, 10      ;add 10
                jmp calculate
RM_FIFTEEN:     
                mov bx, 15      ;add 15
                jmp calculate

RM_TWENTY:      
                mov bx, 20      ;add 20
                jmp calculate

RM_TWENTYFIVE:  
                mov bx, 25      ;add 25
                jmp calculate

RM_THIRTY:      
                mov bx, 30      ;add 30
                jmp calculate

cont:
         ;ask for continue
         echo book
         echo msg2
         getchar  
         mov dl, al
         cmp dl, 'N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
         je displayuser ;if no, checkout
         cmp dl, 'n'
         je displayuser
         cmp dl, 'Y'    ;if yes, display menu again
         je menu
         cmp dl, 'y'
         je menu
         echo errormsg  ;input validation
         jmp cont

calculate: add price, bx  ;add the calculated fee
           jmp cont

callerror: jmp displayerror ;checkpoint to jump to displayerror
callhome: jmp home          ;checkpoint to jump to home function

displayuser:
             mov ah, 6
             mov al, 0
             mov bh, 02h
             mov cx, 0
             mov dl, 100
             mov dh, 150
             int 10h

             mov ah, 2
             mov bh, 0
             mov dl, 0
             mov dh, 5
             int 10h

             ;load the tp number and display
             echo hello
             mov ah, 9
             lea dx, buffer
             add dx, 2
             int 21h


        ;compare whether the inserted TP number matches any member TP number
checktp1:  mov cx, 8    ;tp number is in 8 byte or its string length is 8
           cld
           lea si, member1      ;load value of member1
           lea di, buffer[2]    ;load value of inputted tp number      
repe cmpsb                      ;compare every byte
           jcxz memberfee       ;if equal, give discount
           
checktp2:  mov cx, 8
           cld
           lea si, member2
           lea di, buffer[2]
repe cmpsb
           jcxz memberfee

checktp3:  mov cx, 8
           cld
           lea si, member3
           lea di, buffer[2]
repe cmpsb
           jcxz memberfee
           jne normalfee

memberfee:  echo msg3
            mov ax, price       ;load the price value
            shr ax, 1           ;shift register to the right to divide by 2
            adc ax, 0           ;add with carry
            mov bx, 10          ;move the value 10 to bx to ease division
            xor cx, cx          ;empty cx
            xor dx, dx          ;empty dx
            jmp loop1
        
normalfee:  echo msg3
            mov ax, price       ;load the price value
            mov bx, 10
            xor cx, cx
            xor dx, dx

loop1:      xor dx, dx
            div bx              ; divide the price with bx which is 10
            push dx             ; push the remainder to dx
            inc cx              ; increment cx
            cmp ax, 0           ; check whether the quotient is 0 or not
            jne loop1           ; if not, repeat until the quotient is 0

loop2:      pop dx              ; pop the top value of dx to display the price
            add dx, 30h         ; add with 30h for ascii format
            mov ah, 2           ; function to display
            int 21h
            loop loop2          ; do this until no more value in dx

            jmp displayexit

displayerror: echo errormsg     ;display error message
              jmp input

displayexit: echo exitmsg       ;display exit message
             echo pause
             getchar
             jmp callhome

exit :  ;terminate program function
        echo bye  
        mov ah, 4ch
        int 21h
MAIN ENDP
END MAIN
        
