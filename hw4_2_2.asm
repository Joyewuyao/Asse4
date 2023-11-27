assume ds:data, es:table, cs:code
public year;申明year是其他模块要调用的
public store;申明store是其他模块要调用的
public output;申明output是其他模块要调用的
public blank;申明blank是其他模块要调用的
data segment

      mem  db 7 dup(?)      ;作为中间存储单元存放收入、雇员人数以及平均收入

data ends

code segment
             
      start: 
             

             mov  ax,4c00h          ;结束程序
             int  21h
      ;year子程序，用于输出年份
      year:  mov  dl,es:[si]
             mov  ah,2
             int  21h
             mov  dl,es:[si+1]
             mov  ah,2
             int  21h
             mov  dl,es:[si+2]
             mov  ah,2
             int  21h
             mov  dl,es:[si+3]
             mov  ah,2
             int  21h
             mov  dl,9
             mov  ah,2
             int  21h               ;输出一个tab键
             mov  dl,9
             mov  ah,2
             int  21h               ;输出一个tab键
             ret

      ;store子程序，将数据中的每位数存储在num中
      store: 
             mov  bx,10             ;把各个位转换为数值，如ax中的81，转换为 8,1存在内存中
             div  bx                ;ax除以10，得到商在ax中，余数在dx中
             mov  [mem+di],dl       ;将得到的数存储到[result]中
             mov  dx,0
             dec  di
             cmp  ax,0              ;商是否为0，为0算法结束
             ja   store
             ret

      ;output子程序，输出存储在num中的数据
      output:inc  di
             mov  dh,0
             mov  dl,[mem+di]
             add  dl,30h            ;转为ascii
             mov  ah,2
             int  21h               ;输出
             cmp  di,6
             jb   output
             ret

      ;blank子程序，输出空格，空格个数由cx决定
      blank: mov  dl,32
             mov  ah,2
             int  21h
             loop blank
             ret

code ends
end start